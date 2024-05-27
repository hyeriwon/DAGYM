-- PT 수강후기
CREATE TABLE review(
	rev_num number not null,
	mem_num number not null,
	sch_num number not null,
	rev_grade number(1) not null,--0~5점
	rev_title varchar2(150) not null,
	rev_content clob not null,
	rev_filename1 varchar2(400),
	rev_filename2 varchar2(400),
	rev_ip varchar2(40) not null,
	rev_reg_date date default sysdate not null,
	rev_modify_date date,
	rev_hit number(10) default 0 not null,
	rev_like number(10) default 0 not null,
	constraint rev_pk primary key (rev_num),
	constraint rev_fk1 foreign key (mem_num) references member (mem_num),
	constraint rev_fk2 foreign key (sch_num) references schedule (sch_num)
);
CREATE sequence review_seq;