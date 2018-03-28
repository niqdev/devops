DROP KEYSPACE IF EXISTS example;

CREATE KEYSPACE IF NOT EXISTS example WITH replication = {'class': 'SimpleStrategy', 'replication_factor' : 1};

USE example;

CREATE TABLE IF NOT EXISTS messages (
  id uuid PRIMARY KEY,
  body text,
  created_at timestamp,
  updated_at timestamp
);

INSERT INTO messages(id, body, created_at, updated_at)
VALUES(uuid(), 'message1', toTimestamp(now()), toTimestamp(now()));

INSERT INTO messages(id, body, created_at, updated_at)
VALUES(uuid(), 'message2', toTimestamp(now()), toTimestamp(now()));
