-- PT 수강후기
CREATE TABLE review(
	rev_num number not null,
	mem_num number not null,
	sch_num number not null,
	rev_grade number(1) not null,--1~5점
	rev_title varchar2(150) not null,
	rev_content clob not null,
	rev_filename1 varchar2(400),
	rev_filename2 varchar2(400),
	rev_ip varchar2(40) not null,
	rev_reg_date date default sysdate not null,
	rev_modify_date date,
	rev_hit number(10) default 0 not null,
	rev_like number(10) default 0 not null,
	rev_del number default 0 not null, -- 0:등록됨,1:본인삭제함
	rev_report number default 0 not null,
	constraint rev_pk primary key (rev_num),
	constraint rev_fk1 foreign key (mem_num) references member (mem_num),
	constraint rev_fk2 foreign key (sch_num) references schedule (sch_num)
);
CREATE sequence review_seq;

-- PT 수강후기 좋아요
CREATE TABLE review_like(
	rev_num number not null,
	mem_num number not null,
	constraint revLike_fk1 foreign key (rev_num) references review (rev_num),
	constraint revLike_fk2 foreign key (mem_num) references member (mem_num)
);

-- PT 수강후기 신고
CREATE TABLE review_report(
	rev_num number not null,
	mem_num number not null, -- 신고를 한 사람
	report_content clob not null,
	constraint revReport_fk1 foreign key (rev_num) references review (rev_num),
	constraint revReport_fk2 foreign key (mem_num) references member (mem_num)
);