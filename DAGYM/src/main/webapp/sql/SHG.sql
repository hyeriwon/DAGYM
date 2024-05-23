create table history(
 his_num number not null,
 mem_num number not null,
 sch_num number not null,
 tra_num number not null,
 his_status number(2) default 0 not null ,
 his_part varchar2(50) not null,
 constraint history_pk primary key (his_num),
 constraint history_fk1 foreign key (mem_num) references member (mem_num),
 constraint history_fk2 foreign key (sch_num) references schedule (sch_num),
 constraint history_fk3 foreign key (tra_num) references member(mem_num)
);
create sequence history_seq;

create table payment(
 pay_num number not null,
 mem_num number not null,
 pay_fee number(8) not null,
 pay_enroll number(5) not null,
 constraint payment_pk primary key (pay_num),
 constraint payment_fk foreign key (mem_num) references member (mem_num)
);
create sequence payment_seq;