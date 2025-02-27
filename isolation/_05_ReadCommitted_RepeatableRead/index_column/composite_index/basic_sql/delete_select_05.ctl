/*
Test Case: delete & select
Priority: 2
Reference case: cc_basic/_01_ReadCommitted/index_column/composite_index/basic_sql/delete_select_01.ctl
Author: Lily

Test Point:
-    delete: X_LOCK acquired on current instance..
-    select: no row locks acquired but IS_LOCK for table,
             but can see rows before the queries began.
C1 delete rows, C2 select rows, overlapped.
transactions are not blocked.

NUM_CLIENTS = 2
C1: DELETE FROM tb1;
C2: select * from tb1 order by id; 
C1: rollback;
*/

MC: setup NUM_CLIENTS = 2;
C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level read committed;
C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level repeatable read;
C2: commit;
/* preparation */
C1: DROP TABLE IF EXISTS tb1;
C1: CREATE TABLE tb1( id INT, city VARCHAR(10), hire_date VARCHAR(20));
C1: INSERT INTO tb1 VALUES(1,'BJ','2003-2-1');
C1: INSERT INTO tb1 VALUES(2,'NY','2003-3-1');
C1: INSERT INTO tb1 VALUES(3,'BJ','2004-2-1');
C1: INSERT INTO tb1 VALUES(4,'WA','2003-2-1');
C1: INSERT INTO tb1 VALUES(5,'BJ','2004-2-1');
C1: CREATE INDEX idx_c_h ON tb1(city,hire_date);
C1: commit work;

/* test case */
C1: DELETE FROM tb1 WHERE city='BJ' and  hire_date>'2003-1-1';
C1: insert into tb1 VALUES(2,'BJ','2003-3-1');
MC: wait until C1 ready;
C2: SELECT * FROM tb1 WHERE city='BJ' ORDER BY id,2,3;
MC: wait until C2 ready;
C1: SELECT * FROM tb1 ORDER BY id,2,3;
C1: rollback;
MC: wait until C1 ready;
C2: SELECT * FROM tb1 ORDER BY id,2,3;
C2: commit work;
MC: wait until C2 ready;
C2: SELECT * FROM tb1 ORDER BY id,2,3;
C2: commit;
C2: quit;
C1: quit;
