use strict;
use warnings;
use Test::More;
use Test::Magpie::ArgumentMatcher qw( anything hash set );
use Test::Magpie qw( mock when inspect verify );
use Test::Routine;
use Test::Routine::Util;
use MusicBrainz::Server::Test;

use aliased 'MusicBrainz::Server::Entity::ArtistSubscription';
use aliased 'MusicBrainz::Server::Entity::LabelSubscription';
use aliased 'MusicBrainz::Server::Edit';
use aliased 'MusicBrainz::Server::Entity::Editor';
use aliased 'MusicBrainz::Script::SubscriptionEmails' => 'Script';

use DateTime;
use MusicBrainz::Server::Types qw( :edit_status );

my $c = MusicBrainz::Server::Test->create_test_context(
    models => {
        Editor => mock,
        Edit => mock,
        EditorSubscriptions => mock
    }
);

has emailer => (
    is => 'ro',
    default => sub { mock },
    lazy => 1,
    clearer => 'clear_emailer'
);

has script => (
    is => 'ro',
    default => sub {
        my $test = shift;
        Script->new(
            c => $c, emailer => $test->emailer, verbose => 0, dry_run => 0
        );
    },
    lazy => 1,
    clearer => 'clear_script',
);

before run_test => sub {
    my $test = shift;
    $test->clear_emailer;
    $test->clear_script;
};

my $acid2 = Editor->new(
    name => 'aCiD2', id => 1,
    email => 'acid2@example.com',
    email_confirmation_date => DateTime->now
);

test 'Sending edits' => sub {
    my $test = shift;
    my $spor_subscription = ArtistSubscription->new( editor => $acid2 );
    my $open_edit = Edit->new(status => $STATUS_OPEN);
    my $applied_edit = Edit->new(status => $STATUS_APPLIED);

    mock_subscriptions(
        max_id => 10,
        editors => [ $acid2 ],
        subscriptions => {
            $acid2->id => [ $spor_subscription ],
        },
        edits => [
            [ $spor_subscription => [ $open_edit, $applied_edit ]]
        ]
    );

    $test->script->run;

    subtest 'sends email to aCiD2' => sub {
        my %args = inspect($test->emailer)
            ->send_subscriptions_digest(hash(to => $acid2), anything)
                ->arguments;

        ok(%args, 'sends an email to aCiD2');
        delete $args{to};
        is_deeply(\%args, {
            edits => {
                artist => [{
                    subscription => $spor_subscription,
                    open => [ $open_edit ],
                    applied => [ $applied_edit ]
                }]
            }
        }, 'notifies about 1 open edit to Spor');
    };

    subtest 'updates subscriptions' => sub {
        verify($c->model('EditorSubscriptions'))
            ->update_subscriptions(10, $acid2->id);
    };
};

test 'No edits means no email' => sub {
    my $test = shift;
    my $warp = Editor->new(
        name => 'warp', id => 2,
        email => 'warp@example.com',
        email_confirmation_date => DateTime->now
    );
    my $lady_gaga_subscription = ArtistSubscription->new( editor => $warp );

    mock_subscriptions(
        editors => [ $warp ],
        subscriptions => {
            $warp->id => [ $lady_gaga_subscription ]
        },
        edits => [ ]
    );

    $test->script->run;

    ok(!defined inspect($test->emailer)
        ->send_subscriptions_digest(anything),
        'did not send any emails');

};

test 'Handling deletes and merges' => sub {
    my $test = shift;
    my $label = LabelSubscription->new( deleted_by_edit => 1 );
    my $artist = ArtistSubscription->new( merged_by_edit => 1 );

    mock_subscriptions(
        editors => [ $acid2 ],
        subscriptions => {
            $acid2->id => [ $artist, $label ]
        }
    );

    $test->script->run;
    
    subtest 'Sent emails about merges and deletes' => sub {
        my %args = inspect($test->emailer)->send_subscriptions_digest(anything)
            ->arguments;

        is_deeply($args{merges} => {
            artist => [ $artist ],
        }, 'has information about the merged artist');
        is_deeply($args{deletes} => {
            label => [ $label ]
        }, 'has information about the deleted label')
    };

    subtest 'Deleted deleted and merged subscriptions from the database' => sub {
        verify($c->model('EditorSubscriptions'))->delete(set($artist, $label));
    }
};

run_me;
done_testing;

sub mock_subscriptions
{
    my %args = @_;

    when($c->model('Edit'))->get_max_id->then_return($args{max_id} || 1000);

    for (keys %{ $args{subscriptions} }) {
        when($c->model('EditorSubscriptions'))->get_all_subscriptions($_)
            ->then_return(@{ $args{subscriptions}->{$_} });
    }

    for (@{ $args{edits} }) {
        my ($subscription, $edits) = @{ $_ };
        when($c->model('Edit'))->find_for_subscription($subscription)
            ->then_return(@$edits);
    }

    when($c->model('Editor'))->editors_with_subscriptions
        ->then_return( @{ $args{editors} } );
}
