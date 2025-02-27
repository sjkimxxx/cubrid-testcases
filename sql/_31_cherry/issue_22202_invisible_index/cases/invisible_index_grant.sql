drop class if exists test_class;
create class test_class(col1 integer, col2 varchar(10));
create user test_user;
grant index on test_class to test_user;
grant alter on test_class to test_user;   
call login ('test_user') on class db_user;
create index idx_test_class on test_class(col1);
alter index idx_test_class on test_class invisible;
call login('dba') on class db_user;
show index from test_class;
drop table if exists test_class;
drop user test_user;
