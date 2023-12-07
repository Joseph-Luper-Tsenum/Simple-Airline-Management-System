-- add_airport tests
select * from airport;
call magic44_reset_database_state();
drop table if exists a;
CREATE TABLE a SELECT * FROM airport;

-- AirportID exists (FAIL)
call magic44_reset_database_state();
select * from airport;
call add_airport('AMS', 'Beep Beep Airport', 'New York', 'New York', 'USA', 'port_500');
select * from airport;

-- locationID is null (should pass)
call magic44_reset_database_state();
select * from airport;
call add_airport('AAA', 'Beep Beep Airport', 'New York', 'New York', 'USA', null);
select * from airport;

-- Location exists
call magic44_reset_database_state();
select * from airport;
call add_airport('AAA', 'Beep Beep Airport', 'New York', 'New York', 'USA', 'port_11');
select * from airport;

-- City/state/country are nulls
call magic44_reset_database_state();
select * from airport;
call add_airport('AAA', 'Beep Beep Airport', null, 'New York', 'USA', 'port_500');
select * from airport;
CHECKSUM TABLE a, airport;

call magic44_reset_database_state();
call add_airport('AAA', 'Beep Beep Airport', 'New York', null, 'USA', 'port_500');
CHECKSUM TABLE a, airport;

call magic44_reset_database_state();
call add_airport('AAA', 'Beep Beep Airport', 'New York', 'New York', null, 'port_500');
CHECKSUM TABLE a, airport;

-- Default null: locationID
call magic44_reset_database_state();
call add_airport('AAA', 'Beep Beep Airport', 'New York', 'New York', 'USA', null);
CHECKSUM TABLE a, airport;


