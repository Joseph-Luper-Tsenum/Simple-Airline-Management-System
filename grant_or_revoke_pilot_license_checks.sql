-- testing grant_or_revoke_pilot_license
select * from pilot_licenses;
call magic44_reset_database_state();
drop table if exists a;
CREATE TABLE a SELECT * FROM pilot_licenses;

-- success case (everything valid)
call magic44_reset_database_state();
call grant_or_revoke_pilot_license('p1', 'prop');
CHECKSUM TABLE a, pilot_licenses;

call magic44_reset_database_state();
call grant_or_revoke_pilot_license('p1', 'testing');
CHECKSUM TABLE a, pilot_licenses;

-- PersonID does not exist F
call magic44_reset_database_state();
call grant_or_revoke_pilot_license('p555', 'prop');
CHECKSUM TABLE a, pilot_licenses;

-- License does not exist (e.g., “none” license) F -- FIX THIS PART!!!!
call magic44_reset_database_state();
call grant_or_revoke_pilot_license('p1', 'none');
CHECKSUM TABLE a, pilot_licenses;

-- Pilot-license pair exists (should delete)
call magic44_reset_database_state();
call grant_or_revoke_pilot_license('p1', 'jet');
CHECKSUM TABLE a, pilot_licenses;

-- Pilot-license pair does not exist S
call magic44_reset_database_state();
call grant_or_revoke_pilot_license('p10', 'prop');
CHECKSUM TABLE a, pilot_licenses;

