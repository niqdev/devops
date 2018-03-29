DROP KEYSPACE IF EXISTS example;

CREATE KEYSPACE IF NOT EXISTS example WITH replication = {'class': 'SimpleStrategy', 'replication_factor' : 1};

USE example;

CREATE TABLE IF NOT EXISTS messages (
  id uuid PRIMARY KEY,
  body text,
  created_at timestamp,
  updated_at timestamp
);

ALTER TABLE messages ADD title text;

CREATE TABLE IF NOT EXISTS example.counters (
  id timeuuid PRIMARY KEY,
  total counter,
  today counter
);

CREATE TABLE IF NOT EXISTS example.users (
  first_name text PRIMARY KEY,
  last_name text,
  last_ip inet,
  any_value blob,
  enable boolean
);

ALTER TABLE example.users ADD emails set<text>;

ALTER TABLE example.users ADD phone_numbers list<text>;

ALTER TABLE example.users ADD login_sessions map<timeuuid, int>;

CREATE TYPE example.address (
  street text,
  city text,
  state text,
  zip_code int
);

-- frozen: user-defined data type is considered a collection
ALTER TABLE user ADD addresses map<text, frozen<address>>;

-- avoid secondary indexes TODP pag 76
CREATE INDEX users_last_name_idx ON example.users ( last_name );

CREATE CUSTOM INDEX user_last_name_sasi_idx ON user (last_name)
USING 'org.apache.cassandra.index.sasi.SASIIndex';

SELECT * FROM user WHERE last_name LIKE 'N%';

CREATE INDEX ON example.users ( emails );
