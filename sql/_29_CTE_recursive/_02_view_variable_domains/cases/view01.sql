autocommit off;
drop table if exists foo;
drop view if exists fff;
create class foo( a int );
insert into foo values (1);
insert into foo values (2);
insert into foo values (3);
insert into foo values (4);
select * from foo order by 1;  
create view fff( b foo, c int )
as select x, y.a from foo x, foo y where x.a < y.a order by x.a , y.a;
with recursive cte as (select * from fff order by 1,2) select * from cte order by b.a,2;
with recursive cte as (select * from fff order by 1,2) select b.a, c  from cte order by 1,2;             
with recursive cte as (select * from fff order by 1 desc , 2 desc) select b.a from cte order by 1;        
with recursive cte as (select * from fff order by 1 desc , 2 desc) select c from cte order by 1;            
drop foo;
drop fff;
commit;
autocommit on;
