/*
Test Case: delete & insert
Priority: 1
Reference case:
Author: Rong Xu

Test Point:
-    Insert: X_LOCK on first key OID for unique indexes.
-    Delete: X_LOCK acquired on current instance 
A begin delete
                   B begin insert which satisfy the delete condition
                   B commit
A end delete
A commit

NUM_CLIENTS = 3
C3: select * from t where id=1;
C1: delete from t where col=1 and 0 = (select sleep(1));
C2: insert into t values(1,1);
C2: select * from t where id=1; --expected 1 row selected
*/

MC: setup NUM_CLIENTS = 3;

C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level read committed;

C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level read committed;

C3: set transaction lock timeout INFINITE;
C3: set transaction isolation level read committed;

/* preparation */
C1: drop table if exists t;
C1: create table t(id int,col int);
C1: set @newincr=0;
C1: insert into t select (@newincr:=@newincr+1),(@newincr)%100 from db_class a,db_class b limit 1500;
C1: create index idx on t(col) where col=1;
C1: commit work;
MC: wait until C1 ready;

/* test case */
C3: select t.* from (select sleep(3)) x, t where id=1 using index idx(+);
C1: delete from t where col=1 and 0 = (select sleep(1));
C2: insert into t values(1,1);
MC: wait until C1 ready;
C2: commit;
MC: wait until C2 ready;
C1: commit;
MC: wait until C1 ready;
/* expected 1 row selected */
C2: select * from t where id=1 using index idx(+) order by 1,2;
C2: commit;
MC: wait until C2 ready;
C3: commit;

C3: quit;
C2: quit;
C1: quit;
