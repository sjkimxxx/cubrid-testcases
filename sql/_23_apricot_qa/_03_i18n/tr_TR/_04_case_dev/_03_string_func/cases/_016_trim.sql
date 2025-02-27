--+ holdcas on;
set names utf8;
CREATE TABLE test_tr ( 
  id     int    NOT NULL, 
  name      VARCHAR(20)  collate utf8_tr_cs);
insert into test_tr values (1,'Gülen');
insert into test_tr values (2,'Ğüler'); 
insert into test_tr values (3,'İzgi');
insert into test_tr values (103,'Izgi');
insert into test_tr values (203,'İzgı');
insert into test_tr values (303,'İzgı.iZZETtin');
insert into test_tr values (403,'İzgi İxxettin');
insert into test_tr values (4,'İzgü');
insert into test_tr values (104,'İzğü');
insert into test_tr values (5,'İzzettin'); 
insert into test_tr values (105,'İwwettin');
insert into test_tr values (205,'İqqettin'); 
insert into test_tr values (6,'SevINÇ');
insert into test_tr values (106,'%Sevinç'); 
insert into test_tr values (7,'Şükran');
insert into test_tr values (107,'_şÜKran');
insert into test_tr values (8,'İzğü');
insert into test_tr values (9,'İlhan');
insert into test_tr values (109,'?İlhan');
insert into test_tr values (10,'İzgÖ');
insert into test_tr values (110,'*İzgö');

select id, name, trim ('ı' from name) from test_tr order by 1;

select id, name, trim ('in' from name) from test_tr order by 1;

select id, name, trim (TRAILING 'Iz' from name) from test_tr order by 1;

select id, name, rtrim (name,'Iz') from test_tr order by 1;

select id, name, trim (LEADING 'Iz' from name) from test_tr order by 1;

select id, name, ltrim (name,'Iz') from test_tr order by 1;


drop table test_tr;
set names iso88591;
commit;
--+ holdcas off;

