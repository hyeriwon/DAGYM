--식사 등록
create table meal (
 meal_num number not null,
 tme_num number not null,
 mem_num number not null,
 meal_kcal varchar2(30) not null,
 meal_date varchar2(30) not null,
 meal_time varchar2(20) not null,
 constraint meal_pk primary key(meal_num),
 constraint meal_fk1 foreign key(tem_num) references t_menu(tme_num),
 constraint meal_fk2 foreign key(mem_num) references member(mem_num)
 );
 create squence meal_seq;

create table t_menu(
 tme_num number not null,
 tme_name varchar2(30) not null,
 tme_content clob not null,
 tme_kcal number not null,
 


);

