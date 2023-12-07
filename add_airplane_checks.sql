-- phase 3 testing
select * from airline;
select * from airplane;

CREATE TABLE a SELECT * FROM airplane;


-- Airplane exists (FAILURE)
call magic44_reset_database_state();
CREATE TABLE a SELECT * FROM airplane;
call add_airplane('Air France', 'n118fm', 2, 400, 'plane_244', 'prop', 0, 2, null);
SELECT CASE WHEN EXISTS (TABLE a EXCEPT TABLE airplane)
              OR EXISTS (TABLE airplane EXCEPT TABLE a)
            THEN 'different'            ELSE 'same'       END AS result ;

-- Location exists (FAILURE)
call magic44_reset_database_state();
CREATE TABLE a SELECT * FROM airplane;
call add_airplane('Air France', 'n3333a', 2, 400, 'plane_2', 'prop', 0, 2, null);
SELECT CASE WHEN EXISTS (TABLE a EXCEPT TABLE airplane)
              OR EXISTS (TABLE airplane EXCEPT TABLE a)
            THEN 'different'            ELSE 'same'       END AS result ;

-- Non-positive/null seat_capacity or speed (FAILURE)
-- seat capacity
call magic44_reset_database_state();
drop table if exists a;
CREATE TABLE a SELECT * FROM airplane;
call add_airplane('Air France', 'n333a', -2, 400, 'plane_244', 'prop', 0, 2, null);
SELECT CASE WHEN EXISTS (TABLE a EXCEPT TABLE airplane)
              OR EXISTS (TABLE airplane EXCEPT TABLE a)
            THEN 'different'            ELSE 'same'       END AS result ;

call magic44_reset_database_state();
CREATE TABLE a SELECT * FROM airplane;
call add_airplane('Air France', 'n333a', 2, -300, 'plane_244', 'prop', 0, 2, null);
SELECT CASE WHEN EXISTS (TABLE a EXCEPT TABLE airplane)
              OR EXISTS (TABLE airplane EXCEPT TABLE a)
            THEN 'different'            ELSE 'same'       END AS result ;

-- Prop with non-positive/null propellers/skids (FAILURE)
call magic44_reset_database_state();
CREATE TABLE a SELECT * FROM airplane;
call add_airplane('Air France', 'n333a', 2, 300, 'plane_244', null, 0, 2, null);
SELECT CASE WHEN EXISTS (TABLE a EXCEPT TABLE airplane)
              OR EXISTS (TABLE airplane EXCEPT TABLE a)
            THEN 'different'            ELSE 'same'       END AS result ;

-- Prop with jet engines (F)
call magic44_reset_database_state();
CREATE TABLE a SELECT * FROM airplane;
call add_airplane('Air France', 'n333a', 2, 300, 'plane_244', 'prop', 0, 2, 2);
SELECT CASE WHEN EXISTS (TABLE a EXCEPT TABLE airplane)
              OR EXISTS (TABLE airplane EXCEPT TABLE a)
            THEN 'different'            ELSE 'same'       END AS result ;

-- Jet with non-positive/null jet engines (F)
call magic44_reset_database_state();
CREATE TABLE a SELECT * FROM airplane;
call add_airplane('Air France', 'n333a', 2, 300, 'plane_244', 'jet', null, null, null);
SELECT CASE WHEN EXISTS (TABLE a EXCEPT TABLE airplane)
              OR EXISTS (TABLE airplane EXCEPT TABLE a)
            THEN 'different'            ELSE 'same'       END AS result ;

-- Jet with skids/propellers
call magic44_reset_database_state();
CREATE TABLE a SELECT * FROM airplane;
call add_airplane('Air France', 'n333a', 2, 300, 'plane_244', 'prop', 0, 2, 2);
CHECKSUM TABLE a, airplane;

-- Nulls? (LocationID will still be updated in case of nulls)
call magic44_reset_database_state();
CREATE TABLE a SELECT * FROM airplane;
call add_airplane('Air France', 'n333a', 2, 300, 'plane_244', 'prop', 0, 2, null);
CHECKSUM TABLE a, airplane;

-- Try default nulls: locationID, plane_type, skids, propellers, jet_engines
call magic44_reset_database_state();
CREATE TABLE a SELECT * FROM airplane;
call add_airplane('Air France', 'n333a', 2, 300, null, 'prop', 0, 2, null);
CHECKSUM TABLE a, airplane;

call magic44_reset_database_state();
CREATE TABLE a SELECT * FROM airplane;
call add_airplane('Air France', 'n333a', 2, 300, 'plane_244', null, 0, 2, null);
CHECKSUM TABLE a, airplane;

call magic44_reset_database_state();
call add_airplane('Air France', 'n333a', 2, 300, 'plane_244', 'prop', null, 2, null);
CHECKSUM TABLE a, airplane;

call magic44_reset_database_state();
CREATE TABLE a SELECT * FROM airplane;
call add_airplane('Air France', 'n333a', 2, 300, 'plane_244', 'prop', 0, null, null);
CHECKSUM TABLE a, airplane;

-- Null keys (airlineID, tail_num)
call magic44_reset_database_state();
call add_airplane(null, 'n333a', 2, 300, 'plane_244', 'prop', 0, 2, null);
CHECKSUM TABLE a, airplane;

call magic44_reset_database_state();
drop table if exists a;
CREATE TABLE a SELECT * FROM airplane;
call add_airplane('Air France', null, 2, 300, 'plane_244', 'prop', 0, 2, null);
CHECKSUM TABLE a, airplane;

