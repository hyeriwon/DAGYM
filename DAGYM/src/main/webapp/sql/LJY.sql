CREATE TABLE schedule(
	sch_num number NOT NULL, -- 스케줄번호
	mem_num number NOT NULL, -- 회원번호(트레이너)
	sch_date varchar2(30) NOT NULL, -- 수강일시
	sch_status number(2) NOT NULL, -- 스케줄상태 : 신청가능(0), 신청가능(1), 신청마감(2) 
	constraint schedule_pk primary key(sch_num),
	constraint schedule_fk foreign key(mem_num) references member(mem_num)
);
create sequence schedule_seq;