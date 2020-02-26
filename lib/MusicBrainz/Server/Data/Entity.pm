package MusicBrainz::Server::Data::Entity;
use Moose;
use namespace::autoclean;

use Class::MOP;
use Data::Dumper;
use Devel::StackTrace;
use List::MoreUtils qw( part uniq );
use MusicBrainz::Server::Validation qw( is_guid is_database_row_id );
use Carp qw( confess );

with 'MusicBrainz::Server::Data::Role::Sql';
with 'MusicBrainz::Server::Data::Role::NewFromRow';
with 'MusicBrainz::Server::Data::Role::QueryToList';

sub _columns
{
    die("Not implemented");
}

sub _table
{
    die("Not implemented");
}

sub _column_mapping
{
    return {};
}

sub columns_as
{
    my ($self, $prefix) = @_;

    my $expressions = $self->_columns;
    my %replacements = map {
            my $pattern = $_ =~ s/\./\./gr;
            my $output_name = $_ =~ s/^(?:.*\.)?([^.]+)/${prefix}$1/r;
            $pattern => $output_name
        } split(/\s*,\s*/, $self->_columns);

    for my $pattern (keys %replacements)
    {
        $expressions =~ s/\b($pattern)\b/$1 AS $replacements{$pattern}/;
    }

    return $expressions;
}

sub _get_by_keys {
    my ($self, $key, @ids) = @_;

    @ids = grep { defined && $_ } @ids;
    return () unless @ids;

    my $query = "SELECT " . $self->_columns .
                " FROM " . $self->_table .
                " WHERE $key = any(?)";

    $self->query_to_list($query, [\@ids]);
}

sub get_by_id
{
    my ($self, $id) = @_;
    my @result = values %{$self->get_by_ids($id)};
    return $result[0];
}

sub get_by_id_locked {
    my ($self, $id) = @_;

    return unless $id;

    my $key = $self->_id_column;
    my $query = "SELECT " . $self->_columns .
                " FROM " . $self->_table .
                " WHERE $key = ? FOR UPDATE";

    my $rows = $self->c->sql->select_list_of_hashes($query, $id);
    $self->_new_from_row($rows->[0]);
}

sub _id_column
{
    return 'id';
}

sub is_valid_id {
    (undef, my $id) = @_;
    is_database_row_id($id)
}

sub get_by_ids {
    my ($self, @ids) = @_;

    @ids = grep { $self->is_valid_id($_) } @ids;
    return {} unless @ids;

    my %result = map { $_->id => $_ } $self->_get_by_keys($self->_id_column, uniq(@ids));
    \%result;
}

sub _warn_about_invalid_ids {
    my ($self, $ids) = @_;

    warn 'Invalid IDs: ' . Dumper($ids) . "\n" . Devel::StackTrace->new->as_string . "\n";
}

sub get_by_any_id {
    my ($self, $any_id) = @_;

    return $self->get_by_id($any_id) if $self->is_valid_id($any_id);
    return $self->get_by_gid($any_id) if is_guid($any_id);
    $self->_warn_about_invalid_ids([$any_id]);
    return;
}

sub get_by_any_ids {
    my ($self, @any_ids) = @_;

    my ($ids, $gids, $invalid) = part {
        $self->is_valid_id($_) ? 0 : (is_guid($_) ? 1 : 2)
    } @any_ids;

    my %result;
    %result = %{ $self->get_by_ids(@$ids) } if $ids && @$ids;
    %result = (%result, %{ $self->get_by_gids(@$gids) }) if $gids && @$gids;
    $self->_warn_about_invalid_ids($invalid) if $invalid && @$invalid;

    return \%result;
}

sub _get_by_key
{
    my ($self, $key, $id, %options) = @_;
    my $query = 'SELECT ' . $self->_columns .
                ' FROM ' . $self->_table;
    if (my $transform = $options{transform}) {
        $query .= " WHERE $transform($key) = $transform(?)";
    }
    else {
        $query .= " WHERE $key = ?";
    }

    return $self->_new_from_row(
        $self->sql->select_single_row_hash(
            $query, $id));
}

sub insert { confess "Not implemented" }
sub update { confess "Not implemented" }
sub delete { confess "Not implemented" }
sub merge  { confess "Not implemented" }

__PACKAGE__->meta->make_immutable;
no Moose;
1;

=head1 NAME

MusicBrainz::Server::Data::Entity

=head1 METHODS

=head2 get_by_id ($id)

Loads and returns a single Entity instance for the specified $id.

=head2 get_by_ids (@ids)

Loads and returns an id => object HASH reference of Entity instances
for the specified @ids.

=head1 COPYRIGHT

Copyright (C) 2009 Lukas Lalinsky

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

=cut
