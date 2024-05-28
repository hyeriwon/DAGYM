--회원관리
create table member(
 mem_num number not null,
 mem_id varchar2(12) unique not null,
 mem_auth number(1) default 2 not null, --0:탈퇴,1:정지,2:일반,8:강사,9:관리자
 constraint member_pk primary key(mem_num)
);
create sequence member_seq;

--회원상세
create table member_detail(
 mem_num number not null,
 mem_name varchar2(30) not null,
 mem_pw varchar2(12) not null,
 mem_phone varchar2(15) not null,
 mem_email varchar2(50) unique not null,
 mem_gender varchar2(10) not null,
 mem_birth varchar2(30),
 mem_zipcode varchar2(5),
 mem_address1 varchar2(90),
 mem_address2 varchar2(90),
 mem_photo varchar2(400),
 mem_reg_date date default sysdate not null,
 mem_modify_date date,
 constraint member_detail_pk primary key (mem_num),  
 constraint member_detail_fk foreign key (mem_num) references member (mem_num)
);