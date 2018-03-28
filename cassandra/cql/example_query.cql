SELECT * FROM example.messages;

SELECT COUNT(*) FROM example.messages;

DELETE body from example.messages WHERE id="INVALID_UUID";

TRUNCATE example.messages;

DROP TABLE example.messages;
