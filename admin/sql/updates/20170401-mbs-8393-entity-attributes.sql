\set ON_ERROR_STOP 1
BEGIN;

-----------------------------------------------------------------------
-- create tables
-----------------------------------------------------------------------

CREATE TABLE area_attribute_type ( -- replicate (verbose)
    id                  SERIAL,  -- PK
    name                VARCHAR(255) NOT NULL,
    comment             VARCHAR(255) NOT NULL DEFAULT '',
    free_text           BOOLEAN NOT NULL,
    parent              INTEGER, -- references area_attribute_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 uuid NOT NULL
);

CREATE TABLE area_attribute_type_allowed_value ( -- replicate (verbose)
    id                  SERIAL,  -- PK
    area_attribute_type INTEGER NOT NULL, -- references area_attribute_type.id
    value               TEXT,
    parent              INTEGER, -- references area_attribute_type_allowed_value.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 uuid NOT NULL
);

CREATE TABLE area_attribute ( -- replicate (verbose)
    id                                  SERIAL,  -- PK
    area                                INTEGER NOT NULL, -- references area.id
    area_attribute_type                 INTEGER NOT NULL, -- references area_attribute_type.id
    area_attribute_type_allowed_value   INTEGER, -- references area_attribute_type_allowed_value.id
    area_attribute_text                 TEXT
    CHECK (
        (area_attribute_type_allowed_value IS NULL AND area_attribute_text IS NOT NULL)
        OR
        (area_attribute_type_allowed_value IS NOT NULL AND area_attribute_text IS NULL)
    )
);

CREATE TABLE artist_attribute_type ( -- replicate (verbose)
    id                  SERIAL,  -- PK
    name                VARCHAR(255) NOT NULL,
    comment             VARCHAR(255) NOT NULL DEFAULT '',
    free_text           BOOLEAN NOT NULL,
    parent              INTEGER, -- references artist_attribute_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 uuid NOT NULL
);

CREATE TABLE artist_attribute_type_allowed_value ( -- replicate (verbose)
    id                          SERIAL,  -- PK
    artist_attribute_type       INTEGER NOT NULL, -- references artist_attribute_type.id
    value                       TEXT,
    parent                      INTEGER, -- references artist_attribute_type_allowed_value.id
    child_order                 INTEGER NOT NULL DEFAULT 0,
    description                 TEXT,
    gid                         uuid NOT NULL
);

CREATE TABLE artist_attribute ( -- replicate (verbose)
    id                                  SERIAL,  -- PK
    artist                              INTEGER NOT NULL, -- references artist.id
    artist_attribute_type               INTEGER NOT NULL, -- references artist_attribute_type.id
    artist_attribute_type_allowed_value INTEGER, -- references artist_attribute_type_allowed_value.id
    artist_attribute_text               TEXT
    CHECK (
        (artist_attribute_type_allowed_value IS NULL AND artist_attribute_text IS NOT NULL)
        OR
        (artist_attribute_type_allowed_value IS NOT NULL AND artist_attribute_text IS NULL)
    )
);

CREATE TABLE event_attribute_type ( -- replicate (verbose)
    id                  SERIAL,  -- PK
    name                VARCHAR(255) NOT NULL,
    comment             VARCHAR(255) NOT NULL DEFAULT '',
    free_text           BOOLEAN NOT NULL,
    parent              INTEGER, -- references event_attribute_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 uuid NOT NULL
);

CREATE TABLE event_attribute_type_allowed_value ( -- replicate (verbose)
    id                          SERIAL,  -- PK
    event_attribute_type        INTEGER NOT NULL, -- references event_attribute_type.id
    value                       TEXT,
    parent                      INTEGER, -- references event_attribute_type_allowed_value.id
    child_order                 INTEGER NOT NULL DEFAULT 0,
    description                 TEXT,
    gid                         uuid NOT NULL
);

CREATE TABLE event_attribute ( -- replicate (verbose)
    id                                  SERIAL,  -- PK
    event                               INTEGER NOT NULL, -- references event.id
    event_attribute_type                INTEGER NOT NULL, -- references event_attribute_type.id
    event_attribute_type_allowed_value  INTEGER, -- references event_attribute_type_allowed_value.id
    event_attribute_text                TEXT
    CHECK (
        (event_attribute_type_allowed_value IS NULL AND event_attribute_text IS NOT NULL)
        OR
        (event_attribute_type_allowed_value IS NOT NULL AND event_attribute_text IS NULL)
    )
);

CREATE TABLE instrument_attribute_type ( -- replicate (verbose)
    id                  SERIAL,  -- PK
    name                VARCHAR(255) NOT NULL,
    comment             VARCHAR(255) NOT NULL DEFAULT '',
    free_text           BOOLEAN NOT NULL,
    parent              INTEGER, -- references instrument_attribute_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 uuid NOT NULL
);

CREATE TABLE instrument_attribute_type_allowed_value ( -- replicate (verbose)
    id                          SERIAL,  -- PK
    instrument_attribute_type   INTEGER NOT NULL, -- references instrument_attribute_type.id
    value                       TEXT,
    parent                      INTEGER, -- references instrument_attribute_type_allowed_value.id
    child_order                 INTEGER NOT NULL DEFAULT 0,
    description                 TEXT,
    gid                         uuid NOT NULL
);

CREATE TABLE instrument_attribute ( -- replicate (verbose)
    id                                          SERIAL,  -- PK
    instrument                                  INTEGER NOT NULL, -- references instrument.id
    instrument_attribute_type                   INTEGER NOT NULL, -- references instrument_attribute_type.id
    instrument_attribute_type_allowed_value     INTEGER, -- references instrument_attribute_type_allowed_value.id
    instrument_attribute_text                   TEXT
    CHECK (
        (instrument_attribute_type_allowed_value IS NULL AND instrument_attribute_text IS NOT NULL)
        OR
        (instrument_attribute_type_allowed_value IS NOT NULL AND instrument_attribute_text IS NULL)
    )
);

CREATE TABLE label_attribute_type ( -- replicate (verbose)
    id                  SERIAL,  -- PK
    name                VARCHAR(255) NOT NULL,
    comment             VARCHAR(255) NOT NULL DEFAULT '',
    free_text           BOOLEAN NOT NULL,
    parent              INTEGER, -- references label_attribute_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 uuid NOT NULL
);

CREATE TABLE label_attribute_type_allowed_value ( -- replicate (verbose)
    id                          SERIAL,  -- PK
    label_attribute_type        INTEGER NOT NULL, -- references label_attribute_type.id
    value                       TEXT,
    parent                      INTEGER, -- references label_attribute_type_allowed_value.id
    child_order                 INTEGER NOT NULL DEFAULT 0,
    description                 TEXT,
    gid                         uuid NOT NULL
);

CREATE TABLE label_attribute ( -- replicate (verbose)
    id                                  SERIAL,  -- PK
    label                               INTEGER NOT NULL, -- references label.id
    label_attribute_type                INTEGER NOT NULL, -- references label_attribute_type.id
    label_attribute_type_allowed_value  INTEGER, -- references label_attribute_type_allowed_value.id
    label_attribute_text                TEXT
    CHECK (
        (label_attribute_type_allowed_value IS NULL AND label_attribute_text IS NOT NULL)
        OR
        (label_attribute_type_allowed_value IS NOT NULL AND label_attribute_text IS NULL)
    )
);

CREATE TABLE medium_attribute_type ( -- replicate (verbose)
    id                  SERIAL,  -- PK
    name                VARCHAR(255) NOT NULL,
    comment             VARCHAR(255) NOT NULL DEFAULT '',
    free_text           BOOLEAN NOT NULL,
    parent              INTEGER, -- references medium_attribute_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 uuid NOT NULL
);

CREATE TABLE medium_attribute_type_allowed_format ( -- replicate (verbose)
    medium_attribute_type       INTEGER NOT NULL, -- references medium_attribute_type.id
    medium_format               INTEGER NOT NULL  -- references medium_format.id
);

CREATE TABLE medium_attribute_type_allowed_value ( -- replicate (verbose)
    id                          SERIAL,  -- PK
    medium_attribute_type       INTEGER NOT NULL, -- references medium_attribute_type.id
    value                       TEXT,
    parent                      INTEGER, -- references medium_attribute_type_allowed_value.id
    child_order                 INTEGER NOT NULL DEFAULT 0,
    description                 TEXT,
    gid                         uuid NOT NULL
);

CREATE TABLE medium_attribute_type_allowed_value_allowed_format ( -- replicate (verbose)
    medium_attribute_type_allowed_value INTEGER NOT NULL, -- references medium_attribute_type_allowed_value.id
    medium_format                       INTEGER NOT NULL  -- references medium_format.id
);

CREATE TABLE medium_attribute ( -- replicate (verbose)
    id                                  SERIAL,  -- PK
    medium                              INTEGER NOT NULL, -- references medium.id
    medium_attribute_type               INTEGER NOT NULL, -- references medium_attribute_type.id
    medium_attribute_type_allowed_value INTEGER, -- references medium_attribute_type_allowed_value.id
    medium_attribute_text               TEXT
    CHECK (
        (medium_attribute_type_allowed_value IS NULL AND medium_attribute_text IS NOT NULL)
        OR
        (medium_attribute_type_allowed_value IS NOT NULL AND medium_attribute_text IS NULL)
    )
);

CREATE TABLE place_attribute_type ( -- replicate (verbose)
    id                  SERIAL,  -- PK
    name                VARCHAR(255) NOT NULL,
    comment             VARCHAR(255) NOT NULL DEFAULT '',
    free_text           BOOLEAN NOT NULL,
    parent              INTEGER, -- references place_attribute_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 uuid NOT NULL
);

CREATE TABLE place_attribute_type_allowed_value ( -- replicate (verbose)
    id                          SERIAL,  -- PK
    place_attribute_type        INTEGER NOT NULL, -- references place_attribute_type.id
    value                       TEXT,
    parent                      INTEGER, -- references place_attribute_type_allowed_value.id
    child_order                 INTEGER NOT NULL DEFAULT 0,
    description                 TEXT,
    gid                         uuid NOT NULL
);

CREATE TABLE place_attribute ( -- replicate (verbose)
    id                                  SERIAL,  -- PK
    place                               INTEGER NOT NULL, -- references place.id
    place_attribute_type                INTEGER NOT NULL, -- references place_attribute_type.id
    place_attribute_type_allowed_value  INTEGER, -- references place_attribute_type_allowed_value.id
    place_attribute_text                TEXT
    CHECK (
        (place_attribute_type_allowed_value IS NULL AND place_attribute_text IS NOT NULL)
        OR
        (place_attribute_type_allowed_value IS NOT NULL AND place_attribute_text IS NULL)
    )
);

CREATE TABLE recording_attribute_type ( -- replicate (verbose)
    id                  SERIAL,  -- PK
    name                VARCHAR(255) NOT NULL,
    comment             VARCHAR(255) NOT NULL DEFAULT '',
    free_text           BOOLEAN NOT NULL,
    parent              INTEGER, -- references recording_attribute_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 uuid NOT NULL
);

CREATE TABLE recording_attribute_type_allowed_value ( -- replicate (verbose)
    id                          SERIAL,  -- PK
    recording_attribute_type    INTEGER NOT NULL, -- references recording_attribute_type.id
    value                       TEXT,
    parent                      INTEGER, -- references recording_attribute_type_allowed_value.id
    child_order                 INTEGER NOT NULL DEFAULT 0,
    description                 TEXT,
    gid                         uuid NOT NULL
);

CREATE TABLE recording_attribute ( -- replicate (verbose)
    id                                          SERIAL,  -- PK
    recording                                   INTEGER NOT NULL, -- references recording.id
    recording_attribute_type                    INTEGER NOT NULL, -- references recording_attribute_type.id
    recording_attribute_type_allowed_value      INTEGER, -- references recording_attribute_type_allowed_value.id
    recording_attribute_text                    TEXT
    CHECK (
        (recording_attribute_type_allowed_value IS NULL AND recording_attribute_text IS NOT NULL)
        OR
        (recording_attribute_type_allowed_value IS NOT NULL AND recording_attribute_text IS NULL)
    )
);

CREATE TABLE release_attribute_type ( -- replicate (verbose)
    id                  SERIAL,  -- PK
    name                VARCHAR(255) NOT NULL,
    comment             VARCHAR(255) NOT NULL DEFAULT '',
    free_text           BOOLEAN NOT NULL,
    parent              INTEGER, -- references release_attribute_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 uuid NOT NULL
);

CREATE TABLE release_attribute_type_allowed_value ( -- replicate (verbose)
    id                          SERIAL,  -- PK
    release_attribute_type      INTEGER NOT NULL, -- references release_attribute_type.id
    value                       TEXT,
    parent                      INTEGER, -- references release_attribute_type_allowed_value.id
    child_order                 INTEGER NOT NULL DEFAULT 0,
    description                 TEXT,
    gid                         uuid NOT NULL
);

CREATE TABLE release_attribute ( -- replicate (verbose)
    id                                          SERIAL,  -- PK
    release                                     INTEGER NOT NULL, -- references release.id
    release_attribute_type                      INTEGER NOT NULL, -- references release_attribute_type.id
    release_attribute_type_allowed_value        INTEGER, -- references release_attribute_type_allowed_value.id
    release_attribute_text                      TEXT
    CHECK (
        (release_attribute_type_allowed_value IS NULL AND release_attribute_text IS NOT NULL)
        OR
        (release_attribute_type_allowed_value IS NOT NULL AND release_attribute_text IS NULL)
    )
);

CREATE TABLE release_group_attribute_type ( -- replicate (verbose)
    id                  SERIAL,  -- PK
    name                VARCHAR(255) NOT NULL,
    comment             VARCHAR(255) NOT NULL DEFAULT '',
    free_text           BOOLEAN NOT NULL,
    parent              INTEGER, -- references release_group_attribute_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 uuid NOT NULL
);

CREATE TABLE release_group_attribute_type_allowed_value ( -- replicate (verbose)
    id                                  SERIAL,  -- PK
    release_group_attribute_type        INTEGER NOT NULL, -- references release_group_attribute_type.id
    value                               TEXT,
    parent                              INTEGER, -- references release_group_attribute_type_allowed_value.id
    child_order                         INTEGER NOT NULL DEFAULT 0,
    description                         TEXT,
    gid                                 uuid NOT NULL
);

CREATE TABLE release_group_attribute ( -- replicate (verbose)
    id                                          SERIAL,  -- PK
    release_group                               INTEGER NOT NULL, -- references release_group.id
    release_group_attribute_type                INTEGER NOT NULL, -- references release_group_attribute_type.id
    release_group_attribute_type_allowed_value  INTEGER, -- references release_group_attribute_type_allowed_value.id
    release_group_attribute_text                TEXT
    CHECK (
        (release_group_attribute_type_allowed_value IS NULL AND release_group_attribute_text IS NOT NULL)
        OR
        (release_group_attribute_type_allowed_value IS NOT NULL AND release_group_attribute_text IS NULL)
    )
);

CREATE TABLE series_attribute_type ( -- replicate (verbose)
    id                  SERIAL,  -- PK
    name                VARCHAR(255) NOT NULL,
    comment             VARCHAR(255) NOT NULL DEFAULT '',
    free_text           BOOLEAN NOT NULL,
    parent              INTEGER, -- references series_attribute_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 uuid NOT NULL
);

CREATE TABLE series_attribute_type_allowed_value ( -- replicate (verbose)
    id                          SERIAL,  -- PK
    series_attribute_type       INTEGER NOT NULL, -- references series_attribute_type.id
    value                       TEXT,
    parent                      INTEGER, -- references series_attribute_type_allowed_value.id
    child_order                 INTEGER NOT NULL DEFAULT 0,
    description                 TEXT,
    gid                         uuid NOT NULL
);

CREATE TABLE series_attribute ( -- replicate (verbose)
    id                                  SERIAL,  -- PK
    series                              INTEGER NOT NULL, -- references series.id
    series_attribute_type               INTEGER NOT NULL, -- references series_attribute_type.id
    series_attribute_type_allowed_value INTEGER, -- references series_attribute_type_allowed_value.id
    series_attribute_text               TEXT
    CHECK (
        (series_attribute_type_allowed_value IS NULL AND series_attribute_text IS NOT NULL)
        OR
        (series_attribute_type_allowed_value IS NOT NULL AND series_attribute_text IS NULL)
    )
);

-----------------------------------------------------------------------
-- add primary key constraints
-----------------------------------------------------------------------

ALTER TABLE area_attribute ADD CONSTRAINT area_attribute_pkey PRIMARY KEY (id);
ALTER TABLE area_attribute_type ADD CONSTRAINT area_attribute_type_pkey PRIMARY KEY (id);
ALTER TABLE area_attribute_type_allowed_value ADD CONSTRAINT area_attribute_type_allowed_value_pkey PRIMARY KEY (id);
ALTER TABLE artist_attribute ADD CONSTRAINT artist_attribute_pkey PRIMARY KEY (id);
ALTER TABLE artist_attribute_type ADD CONSTRAINT artist_attribute_type_pkey PRIMARY KEY (id);
ALTER TABLE artist_attribute_type_allowed_value ADD CONSTRAINT artist_attribute_type_allowed_value_pkey PRIMARY KEY (id);
ALTER TABLE event_attribute ADD CONSTRAINT event_attribute_pkey PRIMARY KEY (id);
ALTER TABLE event_attribute_type ADD CONSTRAINT event_attribute_type_pkey PRIMARY KEY (id);
ALTER TABLE event_attribute_type_allowed_value ADD CONSTRAINT event_attribute_type_allowed_value_pkey PRIMARY KEY (id);
ALTER TABLE instrument_attribute ADD CONSTRAINT instrument_attribute_pkey PRIMARY KEY (id);
ALTER TABLE instrument_attribute_type ADD CONSTRAINT instrument_attribute_type_pkey PRIMARY KEY (id);
ALTER TABLE instrument_attribute_type_allowed_value ADD CONSTRAINT instrument_attribute_type_allowed_value_pkey PRIMARY KEY (id);
ALTER TABLE label_attribute ADD CONSTRAINT label_attribute_pkey PRIMARY KEY (id);
ALTER TABLE label_attribute_type ADD CONSTRAINT label_attribute_type_pkey PRIMARY KEY (id);
ALTER TABLE label_attribute_type_allowed_value ADD CONSTRAINT label_attribute_type_allowed_value_pkey PRIMARY KEY (id);
ALTER TABLE medium_attribute ADD CONSTRAINT medium_attribute_pkey PRIMARY KEY (id);
ALTER TABLE medium_attribute_type ADD CONSTRAINT medium_attribute_type_pkey PRIMARY KEY (id);
ALTER TABLE medium_attribute_type_allowed_value ADD CONSTRAINT medium_attribute_type_allowed_value_pkey PRIMARY KEY (id);
ALTER TABLE place_attribute ADD CONSTRAINT place_attribute_pkey PRIMARY KEY (id);
ALTER TABLE place_attribute_type ADD CONSTRAINT place_attribute_type_pkey PRIMARY KEY (id);
ALTER TABLE place_attribute_type_allowed_value ADD CONSTRAINT place_attribute_type_allowed_value_pkey PRIMARY KEY (id);
ALTER TABLE recording_attribute ADD CONSTRAINT recording_attribute_pkey PRIMARY KEY (id);
ALTER TABLE recording_attribute_type ADD CONSTRAINT recording_attribute_type_pkey PRIMARY KEY (id);
ALTER TABLE recording_attribute_type_allowed_value ADD CONSTRAINT recording_attribute_type_allowed_value_pkey PRIMARY KEY (id);
ALTER TABLE release_attribute ADD CONSTRAINT release_attribute_pkey PRIMARY KEY (id);
ALTER TABLE release_attribute_type ADD CONSTRAINT release_attribute_type_pkey PRIMARY KEY (id);
ALTER TABLE release_attribute_type_allowed_value ADD CONSTRAINT release_attribute_type_allowed_value_pkey PRIMARY KEY (id);
ALTER TABLE release_group_attribute ADD CONSTRAINT release_group_attribute_pkey PRIMARY KEY (id);
ALTER TABLE release_group_attribute_type ADD CONSTRAINT release_group_attribute_type_pkey PRIMARY KEY (id);
ALTER TABLE release_group_attribute_type_allowed_value ADD CONSTRAINT release_group_attribute_type_allowed_value_pkey PRIMARY KEY (id);
ALTER TABLE series_attribute ADD CONSTRAINT series_attribute_pkey PRIMARY KEY (id);
ALTER TABLE series_attribute_type ADD CONSTRAINT series_attribute_type_pkey PRIMARY KEY (id);
ALTER TABLE series_attribute_type_allowed_value ADD CONSTRAINT series_attribute_type_allowed_value_pkey PRIMARY KEY (id);

-----------------------------------------------------------------------
-- create indexes
-----------------------------------------------------------------------

CREATE INDEX area_attribute_idx_area ON area_attribute (area);

CREATE UNIQUE INDEX area_attribute_type_idx_gid ON area_attribute_type (gid);

CREATE INDEX area_attribute_type_allowed_value_idx_name ON area_attribute_type_allowed_value (area_attribute_type);
CREATE UNIQUE INDEX area_attribute_type_allowed_value_idx_gid ON area_attribute_type_allowed_value (gid);

CREATE INDEX artist_attribute_idx_artist ON artist_attribute (artist);

CREATE UNIQUE INDEX artist_attribute_type_idx_gid ON artist_attribute_type (gid);

CREATE INDEX artist_attribute_type_allowed_value_idx_name ON artist_attribute_type_allowed_value (artist_attribute_type);
CREATE UNIQUE INDEX artist_attribute_type_allowed_value_idx_gid ON artist_attribute_type_allowed_value (gid);

CREATE INDEX event_attribute_idx_event ON event_attribute (event);

CREATE UNIQUE INDEX event_attribute_type_idx_gid ON event_attribute_type (gid);

CREATE INDEX event_attribute_type_allowed_value_idx_name ON event_attribute_type_allowed_value (event_attribute_type);
CREATE UNIQUE INDEX event_attribute_type_allowed_value_idx_gid ON event_attribute_type_allowed_value (gid);

CREATE INDEX instrument_attribute_idx_instrument ON instrument_attribute (instrument);

CREATE UNIQUE INDEX instrument_attribute_type_idx_gid ON instrument_attribute_type (gid);

CREATE INDEX instrument_attribute_type_allowed_value_idx_name ON instrument_attribute_type_allowed_value (instrument_attribute_type);
CREATE UNIQUE INDEX instrument_attribute_type_allowed_value_idx_gid ON instrument_attribute_type_allowed_value (gid);

CREATE INDEX label_attribute_idx_label ON label_attribute (label);

CREATE UNIQUE INDEX label_attribute_type_idx_gid ON label_attribute_type (gid);

CREATE INDEX label_attribute_type_allowed_value_idx_name ON label_attribute_type_allowed_value (label_attribute_type);
CREATE UNIQUE INDEX label_attribute_type_allowed_value_idx_gid ON label_attribute_type_allowed_value (gid);

CREATE INDEX medium_attribute_idx_medium ON medium_attribute (medium);

CREATE UNIQUE INDEX medium_attribute_type_idx_gid ON medium_attribute_type (gid);

CREATE INDEX medium_attribute_type_allowed_value_idx_name ON medium_attribute_type_allowed_value (medium_attribute_type);
CREATE UNIQUE INDEX medium_attribute_type_allowed_value_idx_gid ON medium_attribute_type_allowed_value (gid);

CREATE INDEX place_attribute_idx_place ON place_attribute (place);

CREATE UNIQUE INDEX place_attribute_type_idx_gid ON place_attribute_type (gid);

CREATE INDEX place_attribute_type_allowed_value_idx_name ON place_attribute_type_allowed_value (place_attribute_type);
CREATE UNIQUE INDEX place_attribute_type_allowed_value_idx_gid ON place_attribute_type_allowed_value (gid);

CREATE INDEX recording_attribute_idx_recording ON recording_attribute (recording);

CREATE UNIQUE INDEX recording_attribute_type_idx_gid ON recording_attribute_type (gid);

CREATE INDEX recording_attribute_type_allowed_value_idx_name ON recording_attribute_type_allowed_value (recording_attribute_type);
CREATE UNIQUE INDEX recording_attribute_type_allowed_value_idx_gid ON recording_attribute_type_allowed_value (gid);

CREATE INDEX release_attribute_idx_release ON release_attribute (release);

CREATE UNIQUE INDEX release_attribute_type_idx_gid ON release_attribute_type (gid);

CREATE INDEX release_attribute_type_allowed_value_idx_name ON release_attribute_type_allowed_value (release_attribute_type);
CREATE UNIQUE INDEX release_attribute_type_allowed_value_idx_gid ON release_attribute_type_allowed_value (gid);

CREATE INDEX release_group_attribute_idx_release_group ON release_group_attribute (release_group);

CREATE UNIQUE INDEX release_group_attribute_type_idx_gid ON release_group_attribute_type (gid);

CREATE INDEX release_group_attribute_type_allowed_value_idx_name ON release_group_attribute_type_allowed_value (release_group_attribute_type);
CREATE UNIQUE INDEX release_group_attribute_type_allowed_value_idx_gid ON release_group_attribute_type_allowed_value (gid);

CREATE INDEX series_attribute_idx_series ON series_attribute (series);

CREATE UNIQUE INDEX series_attribute_type_idx_gid ON series_attribute_type (gid);

CREATE INDEX series_attribute_type_allowed_value_idx_name ON series_attribute_type_allowed_value (series_attribute_type);
CREATE UNIQUE INDEX series_attribute_type_allowed_value_idx_gid ON series_attribute_type_allowed_value (gid);

-----------------------------------------------------------------------
-- create functions
-- ensure attribute type allows free text if free text is added
-----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION ensure_area_attribute_type_allows_text()
RETURNS trigger AS $$
BEGIN
    IF NEW.area_attribute_text IS NOT NULL
        AND NOT EXISTS (
            SELECT TRUE
              FROM area_attribute_type
             WHERE area_attribute_type.id = NEW.area_attribute_type
               AND free_text
    )
    THEN
        RAISE EXCEPTION 'This attribute type can not contain free text';
    ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION ensure_artist_attribute_type_allows_text()
RETURNS trigger AS $$
BEGIN
    IF NEW.artist_attribute_text IS NOT NULL
        AND NOT EXISTS (
            SELECT TRUE
              FROM artist_attribute_type
             WHERE artist_attribute_type.id = NEW.artist_attribute_type
               AND free_text
    )
    THEN
        RAISE EXCEPTION 'This attribute type can not contain free text';
    ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION ensure_event_attribute_type_allows_text()
RETURNS trigger AS $$
BEGIN
    IF NEW.event_attribute_text IS NOT NULL
        AND NOT EXISTS (
            SELECT TRUE
              FROM event_attribute_type
             WHERE event_attribute_type.id = NEW.event_attribute_type
               AND free_text
    )
    THEN
        RAISE EXCEPTION 'This attribute type can not contain free text';
    ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION ensure_instrument_attribute_type_allows_text()
RETURNS trigger AS $$
BEGIN
    IF NEW.instrument_attribute_text IS NOT NULL
        AND NOT EXISTS (
            SELECT TRUE
              FROM instrument_attribute_type
             WHERE instrument_attribute_type.id = NEW.instrument_attribute_type
               AND free_text
    )
    THEN
        RAISE EXCEPTION 'This attribute type can not contain free text';
    ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION ensure_label_attribute_type_allows_text()
RETURNS trigger AS $$
BEGIN
    IF NEW.label_attribute_text IS NOT NULL
        AND NOT EXISTS (
            SELECT TRUE
              FROM label_attribute_type
             WHERE label_attribute_type.id = NEW.label_attribute_type
               AND free_text
    )
    THEN
        RAISE EXCEPTION 'This attribute type can not contain free text';
    ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION ensure_medium_attribute_type_allows_text()
RETURNS trigger AS $$
BEGIN
    IF NEW.medium_attribute_text IS NOT NULL
        AND NOT EXISTS (
            SELECT TRUE
              FROM medium_attribute_type
             WHERE medium_attribute_type.id = NEW.medium_attribute_type
               AND free_text
    )
    THEN
        RAISE EXCEPTION 'This attribute type can not contain free text';
    ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION ensure_place_attribute_type_allows_text()
RETURNS trigger AS $$
BEGIN
    IF NEW.place_attribute_text IS NOT NULL
        AND NOT EXISTS (
            SELECT TRUE
              FROM place_attribute_type
             WHERE place_attribute_type.id = NEW.place_attribute_type
               AND free_text
    )
    THEN
        RAISE EXCEPTION 'This attribute type can not contain free text';
    ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION ensure_recording_attribute_type_allows_text()
RETURNS trigger AS $$
BEGIN
    IF NEW.recording_attribute_text IS NOT NULL
        AND NOT EXISTS (
            SELECT TRUE
              FROM recording_attribute_type
             WHERE recording_attribute_type.id = NEW.recording_attribute_type
               AND free_text
    )
    THEN
        RAISE EXCEPTION 'This attribute type can not contain free text';
    ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION ensure_release_attribute_type_allows_text()
RETURNS trigger AS $$
BEGIN
    IF NEW.release_attribute_text IS NOT NULL
        AND NOT EXISTS (
            SELECT TRUE
              FROM release_attribute_type
             WHERE release_attribute_type.id = NEW.release_attribute_type
               AND free_text
    )
    THEN
        RAISE EXCEPTION 'This attribute type can not contain free text';
    ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION ensure_release_group_attribute_type_allows_text()
RETURNS trigger AS $$
  BEGIN
    IF NEW.release_group_attribute_text IS NOT NULL
        AND NOT EXISTS (
           SELECT TRUE FROM release_group_attribute_type
        WHERE release_group_attribute_type.id = NEW.release_group_attribute_type
        AND free_text
    )
    THEN
        RAISE EXCEPTION 'This attribute type can not contain free text';
    ELSE RETURN NEW;
    END IF;
  END;
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION ensure_series_attribute_type_allows_text()
RETURNS trigger AS $$
BEGIN
    IF NEW.series_attribute_text IS NOT NULL
        AND NOT EXISTS (
            SELECT TRUE
              FROM series_attribute_type
             WHERE series_attribute_type.id = NEW.series_attribute_type
               AND free_text
    )
    THEN
        RAISE EXCEPTION 'This attribute type can not contain free text';
    ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE 'plpgsql';

COMMIT;
