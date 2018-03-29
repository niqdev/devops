SELECT * FROM example.messages;
SELECT * FROM example.counters;
SELECT * FROM example.users;

SELECT COUNT(*) FROM example.messages;

INSERT INTO example.messages(id, body, created_at, updated_at)
VALUES(uuid(), 'message1', toTimestamp(now()), toTimestamp(now()));

INSERT INTO example.messages(id, body, title, created_at, updated_at)
VALUES(uuid(), 'message2', 'title2', toTimestamp(now()), toTimestamp(now()));

-- no timestamp allowed on primary key
SELECT id, body, WRITETIME(body) FROM example.messages;

INSERT INTO example.users(first_name, last_name, last_ip, any_value, enable)
VALUES('firstName1', 'lastName1', '127.0.0.1', textAsBlob('{"key1": "value1", "key2": "value2"}'), true);

INSERT INTO example.users(first_name, last_name, last_ip, any_value, enable)
VALUES('firstName2', 'lastName2', '0.0.0.0', textAsBlob('{"key": "value"}'), false);

-- value from column
SELECT blobAsText(0x7b226b6579223a202276616c7565227d) FROM example.users;

-- timestamp in microsecond - old timestamp are ignored
UPDATE example.users USING TIMESTAMP 1434373756626000
SET last_name = 'lastName2' WHERE first_name = 'firstName1';

UPDATE example.users USING TIMESTAMP 2034373756626000
SET last_name = 'lastName3' WHERE first_name = 'firstName1';

-- time to live TTL - stored on a per-column level no row
-- 60 seconds
UPDATE example.users USING TTL 60
SET last_name = 'lastName4' WHERE first_name = 'firstName2';

SELECT first_name, last_name, TTL(last_name) FROM example.users;

-- insert not allowed
UPDATE example.counters SET total = total + 2
WHERE id = now();

SELECT * FROM example.counters;

UPDATE example.users SET emails = { 'hello@example.com' }
WHERE first_name = 'firstName1';

UPDATE example.users SET emails = emails + { 'world@example.com' }
WHERE first_name = 'firstName1';

UPDATE example.users SET emails = emails - { 'world@example.com' }
WHERE first_name = 'firstName1';

UPDATE example.users SET emails = {}
WHERE first_name = 'firstName1';

UPDATE example.users SET emails = { 'hello@example.com', 'world@example.com' }
WHERE first_name = 'firstName2';

UPDATE example.users SET phone_numbers = [ '1-800-999-9999' ]
WHERE first_name = 'firstName1';

UPDATE example.users SET phone_numbers = phone_numbers + [ '480-111-1111' ]
WHERE first_name = 'firstName1';

UPDATE example.users SET phone_numbers = [ '111-222-3333' ] + phone_numbers
WHERE first_name = 'firstName1';

-- start from index 0
UPDATE example.users SET phone_numbers[1] = '000-000-0000'
WHERE first_name = 'firstName1';

UPDATE example.users SET phone_numbers = phone_numbers - [ '000-000-0000' ]
WHERE first_name = 'firstName1';

UPDATE example.users SET login_sessions = { now(): 13, now(): 18}
WHERE first_name = 'firstName2';

-- use index
SELECT * FROM example.users WHERE last_name = 'lastName3';

-- use sasi index
SELECT * FROM example.users WHERE last_name LIKE 'last%';

UPDATE example.users SET addresses = addresses +
{'home': { street: 'street1', city: 'city1', state: 'STATE', zip_code: 12345} }
WHERE first_name = 'firstName2';

DROP INDEX example.users_last_name_idx;

DELETE phone_numbers[0] FROM example.users
WHERE first_name = 'firstName1';

DELETE last_ip from example.users WHERE first_name = 'firstName2';

TRUNCATE example.messages;

DROP TABLE example.messages;
