-- [er]create vclass attribute using  null and unique constraints

create class picture
(caption set string,
 image string);
 
 insert INTO picture VALUES ({'s'},'s');
 
 create vclass meal
class attribute (meal_type string null unique)
(menu picture);
 
 select * FROM db_attribute WHere class_name='meal'  order by 1;
 
 
 SELECT * FROM meal;
 
 
 DROP picture;
 
 DROP meal;
