/*
Test Case: delete & select
Priority: 1
Reference case:
Author: Mandy

Test Point:
Test delete YEAR() in partition table
1. Reading queries can only have a look at data committed before the queries began
2. Uncommitted data are never seen
3. The only visible uncommitted data are the effects of current transaction's dates, that is to say
   the new version is only visible to the current transaction
At the same time check delete dose not block select


NUM_CLIENTS = 2
C1: delete, commit after C2's query start
C2: select twice - before C1 commit, after C1 commit
*/


MC: setup NUM_CLIENTS = 2;

C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level read committed;

C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level read committed;


/* preparation */
C1: drop table if exists t1;
C1: create table t1(t_date date primary key, client varchar(10)) partition by list (YEAR(t_date)) (partition p1 values in (2004,2008), partition p2 values in (2001,2002,2003,2005,2006,2007,2009));
C1: insert into t1 values('2002-02-28','def'),('2004-02-29','abc'),('2005-12-31','gh'),('2008-03-15','def');
C1: commit work;
MC: wait until C1 ready;

/* test case */
C1: delete from t1 where YEAR(t_date)>=2004;
C1: select * from t1 where YEAR(t_date)>2000 order by 1,2;
MC: wait until C1 ready;
C2: select *, sleep(2) from t1 where YEAR(t_date)>2000 order by 1,2;
MC: sleep 2;
C1: commit;
MC: wait until C1 ready;
MC: wait until C2 ready;

C1: select * from t1 where YEAR(t_date)>2000 order by 1,2;
C2: select * from t1 where YEAR(t_date)>2000 order by 1,2;
C2: commit;
MC: wait until C2 ready;

C1: quit;
C2: quit;
