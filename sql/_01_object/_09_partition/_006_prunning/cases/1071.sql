--create range partition table with varchar data type and  three partitions,create table,insert data to the first table with the records of the second table,select data from tables

create table range_test(id int not null  ,
				test_char char(50),
				test_varchar varchar(2000),
				test_bit bit(16),
				test_varbit bit varying(20),
				test_nchar nchar(50),
				test_nvarchar nchar varying(2000),
				test_string string,
				test_datetime timestamp,primary key(id,test_varchar))
	PARTITION BY RANGE (test_varchar) (
	PARTITION p0 VALUES LESS THAN ('ddd'),
	PARTITION p1 VALUES LESS THAN ('ggg'),
	PARTITION p2 VALUES LESS THAN ('kkk')
	);

create table range_test2(id int not null primary key ,
				test_char char(50),
				test_varchar varchar(2000),
				test_bit bit(16),
				test_varbit bit varying(20),
				test_nchar nchar(50),
				test_nvarchar nchar varying(2000),
				test_string string,
				test_datetime timestamp);
	insert into range_test2 values(1,'aaa','aaa',B'1',B'1011',N'aaa',N'aaa','aaaaaaaaaa','2007-01-01 09:00:00');
	insert into range_test2 values(2,'bbb','bbb',B'10',B'1100',N'bbb',N'bbb','bbbbbbbbbb','2007-01-01 09:00:00');
	insert into range_test2 values(3,'ccc','ccc',B'11',B'1101',N'ccc',N'ccc','cccccccccc','2007-01-01 09:00:00');
	insert into range_test2 values(4,'ddd','ddd',B'100',B'1110',N'ddd',N'ddd','dddddddddd','2007-01-01 09:00:00');
	insert into range_test2 values(5,'eee','eee',B'101',B'1111',N'eee',N'eee','eeeeeeeeee','2007-01-01 09:00:00');
	insert into range_test2 values(6,'fff','fff',B'101',B'1111',N'fff',N'eee','ffffffffff','2007-01-01 09:00:00');
	insert into range_test2 values(7,'hhh','hhh',B'101',B'1111',N'hhh',N'eee','hhhhhhhhhh','2007-01-01 09:00:00');
	insert into range_test2 values(8,'iii','iii',B'101',B'1111',N'iii',N'eee','iiiiiiiiii','2007-01-01 09:00:00');



insert into range_test select * from range_test2;
select * from range_test order by id;
select * from range_test__p__p0 order by id;
select * from range_test__p__p1 order by id;
select * from range_test__p__p2 order by id;


drop table range_test;
drop table range_test2;
