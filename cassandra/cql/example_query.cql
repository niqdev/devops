INSERT INTO messages(id, body, created_at, updated_at)
VALUES(uuid(), 'message1', toTimestamp(now()), toTimestamp(now()));

INSERT INTO messages(id, body, title, created_at, updated_at)
VALUES(uuid(), 'message2', 'title2', toTimestamp(now()), toTimestamp(now()));

INSERT INTO example.news(id, ip)
VALUES(now(), '127.0.0.1');

UPDATE example.news SET emails = { 'hello@example.com' } WHERE first_name = 'Mary';

SELECT emails FROM user WHERE first_name =
'Mary';

UPDATE user SET emails = emails + {
'mary.mcdonald.AZ@gmail.com' } WHERE first_name = 'Mary';
cqlsh:my_keyspace> SELECT emails FROM user WHERE first_name =
'Mary';

SET emails = emails - {'mary@example.com'}

SET emails = {}

UPDATE user SET phone_numbers = [
'1-800-999-9999' ] WHERE first_name = 'Mary';
cqlsh:my_keyspace> SELECT phone_numbers FROM user WHERE
first_name = 'Mary';

UPDATE user SET phone_numbers =
phone_numbers + [ '480-111-1111' ] WHERE first_name = 'Mary';
cqlsh:my_keyspace> SELECT phone_numbers FROM user WHERE
first_name = 'Mary';

We could also have prepended the number to the front of the
list by reversing the order of our values: SET phone_numbers =
[‘4801234567’] + phone_numbers.

UPDATE user SET phone_numbers[1] =
'480-111-1111' WHERE first_name = 'Mary';

UPDATE user SET phone_numbers =
phone_numbers - [ '480-111-1111' ] WHERE first_name = 'Mary';

DELETE phone_numbers[0] from user WHERE
first_name = 'Mary';

UPDATE user SET login_sessions =
{ now(): 13, now(): 18} WHERE first_name = 'Mary';
cqlsh:my_keyspace> SELECT login_sessions FROM user WHERE
first_name = 'Mary';

UPDATE user SET addresses = addresses +
{'home': { street: '7712 E. Broadway', city: 'Tucson',
state: 'AZ', zip_code: 85715} } WHERE first_name = 'Mary';

SELECT * FROM user WHERE last_name = 'Nguyen';

DROP INDEX user_last_name_idx;

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
