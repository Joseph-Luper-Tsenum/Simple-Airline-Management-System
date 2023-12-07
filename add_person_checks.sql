-- add_person checks
select * from person;
select * from pilot;
call magic44_reset_database_state();
drop table if exists a;
CREATE TABLE a SELECT * FROM person;
drop table if exists b;
create table b select * from passenger;
drop table if exists c;
create table c select * from pilot;

-- passing case
call magic44_reset_database_state();
call add_person('p333', 'Sarayu', 'Vadyala', 'plane_1', null, null, 300, 200);
CHECKSUM TABLE a, person;
CHECKSUM TABLE b, passenger;

call magic44_reset_database_state();
call add_person('p334', 'Sarayu', 'Vadyala', 'plane_1', '555-55-5555', 20, null, null);
CHECKSUM TABLE a, person;
CHECKSUM TABLE b, passenger;
CHECKSUM TABLE c, pilot;

-- PersonID exists (F)
call magic44_reset_database_state();
call add_person('p1', 'Sarayu', 'Vadyala', 'plane_1', null, null, 300, 200);
CHECKSUM TABLE a, person;
CHECKSUM TABLE b, passenger;

-- First_name is null
call magic44_reset_database_state();
call add_person('p333', null, 'Vadyala', 'plane_1', null, null, 300, 200);
CHECKSUM TABLE a, person;
CHECKSUM TABLE b, passenger;

-- Location is null F
call magic44_reset_database_state();
call add_person('p333', 'Sarayu', 'Vadyala', null, null, null, 300, 200);
CHECKSUM TABLE a, person;
CHECKSUM TABLE b, passenger;

-- Location exists S (tested in passing case)

-- Location does not exist F
call magic44_reset_database_state();
call add_person('p333', 'Sarayu', 'Vadyala', 'plane_3333333', null, null, 300, 200);
CHECKSUM TABLE a, person;
CHECKSUM TABLE b, passenger;

-- Person has a tax id and experience and miles or funds F
call magic44_reset_database_state();
call add_person('p334', 'Sarayu', 'Vadyala', 'plane_1', '555-55-5555', 20, 200, 200);
CHECKSUM TABLE a, person;
CHECKSUM TABLE b, passenger;
CHECKSUM TABLE c, pilot;

-- Person has miles and funds and a tax id or experience ^


-- Person is a pilot (success cases ^)
-- Person is a passenger (success cases ^)
-- Default null: last_name
call magic44_reset_database_state();
call add_person('p334', 'Sarayu', null, 'plane_1', '555-55-5555', 20, null, null);
CHECKSUM TABLE a, person;
CHECKSUM TABLE b, passenger;
CHECKSUM TABLE c, pilot;

-- Default 0: miles, funds
call magic44_reset_database_state();
call add_person('p333', 'Sarayu', 'Vadyala', 'plane_1', null, null, 0, 0);
CHECKSUM TABLE a, person;
CHECKSUM TABLE b, passenger;


