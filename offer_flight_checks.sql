-- offer_flight checks
select * from flight;
select * from airplane where tail_num not in (select support_tail from flight);
call magic44_reset_database_state();
drop table if exists a;
CREATE TABLE a SELECT * FROM flight;

-- success case (all inputs valid) -- NOT ADDING ANYTHING TO FLIGHT?
call magic44_reset_database_state();
call offer_flight('am_26', 'big_europe_loop', 'American', 'n448cs', 0, '11:00:00', 200);
CHECKSUM TABLE a, flight;

call magic44_reset_database_state();
call offer_flight('un_41', 'americas_three', 'United', 'n330ss', 0, '11:30:00', 400);
CHECKSUM TABLE a, flight;

-- Flight with no assigned airplane
call magic44_reset_database_state();
call offer_flight('am_26', 'big_europe_loop', 'American', null, 0, '11:00:00', 200);
CHECKSUM TABLE a, flight;

-- Flight with assigned airplane
call magic44_reset_database_state();
call offer_flight('am_26', 'big_europe_loop', 'American', 'n448cs', 0, '11:00:00', 200);
CHECKSUM TABLE a, flight;

-- Airplane assigned to another flight
call magic44_reset_database_state();
call offer_flight('am_26', 'big_europe_loop', 'American', 'n225sb', 0, '11:00:00', 200);
CHECKSUM TABLE a, flight;

-- Route does not exist
call magic44_reset_database_state();
call offer_flight('am_26', 'beep_beep_loop', 'American', 'n448cs', 0, '11:00:00', 200);
CHECKSUM TABLE a, flight;

-- Route exists
call magic44_reset_database_state();
call offer_flight('am_26', 'big_europe_loop', 'American', 'n448cs', 0, '11:00:00', 200);
CHECKSUM TABLE a, flight;

-- Progress = end of the route
select * from route_path where routeID = 'big_europe_loop';
call magic44_reset_database_state();
call offer_flight('am_26', 'big_europe_loop', 'American', 'n448cs', 5, '11:00:00', 200);
CHECKSUM TABLE a, flight;

-- Null anything
call magic44_reset_database_state();
call offer_flight(null, 'big_europe_loop', 'American', 'n448cs', 0, '11:00:00', 200);
CHECKSUM TABLE a, flight;

call magic44_reset_database_state();
call offer_flight('am_26', 'big_europe_loop', null, 'n448cs', 0, '11:00:00', 200);
CHECKSUM TABLE a, flight;

call magic44_reset_database_state();
call offer_flight('am_26', null, 'American', 'n448cs', 0, '11:00:00', 200);
CHECKSUM TABLE a, flight;

-- do we need to make a part of the stored procedure where we default this to 0????
call magic44_reset_database_state();
call offer_flight('am_26', 'big_europe_loop', 'American', 'n448cs', 0, '11:00:00', null);
CHECKSUM TABLE a, flight;

-- Default nulls: support_airline, support_tail, progress, next_time
call magic44_reset_database_state();
call offer_flight('am_26', 'big_europe_loop', 'American', null, 0, '11:00:00', 200);
CHECKSUM TABLE a, flight;

call magic44_reset_database_state();
call offer_flight('am_26', 'big_europe_loop', 'American', 'n448cs', null, '11:00:00', 200);
CHECKSUM TABLE a, flight;

call magic44_reset_database_state();
call offer_flight('am_26', 'big_europe_loop', 'American', 'n448cs', 0, null, 200);
CHECKSUM TABLE a, flight;
