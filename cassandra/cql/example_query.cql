SELECT * FROM example.messages;

SELECT COUNT(*) FROM example.messages;

-- no primary key allowed
SELECT id, body, WRITETIME(body) FROM example.messages;

-- timestamp in microsecond - old timestamp are ignored
UPDATE example.messages USING TIMESTAMP 1434373756626000
SET body = 'message3' WHERE id = 'INVALID_UUID';

-- 60 seconds
UPDATE example.messages USING TTL 60
SET body = 'message4' WHERE id = 'INVALID_UUID';

SELECT id, body, TTL(body) FROM example.messages;

DELETE body from example.messages WHERE id = "INVALID_UUID";

TRUNCATE example.messages;

DROP TABLE example.messages;
