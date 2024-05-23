CREATE TABLE attend (
	att_num NUMBER NOT NULL,
	mem_num NUMBER NOT NULL,
	att_point NUMBER(10) NOT NULL default 100,
	att_date DATE NOT NULL default sysdate,
	CONSTRAINT attend_pk PRIMARY KEY (att_num),
	CONSTRAINT attend_fk FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);
CREATE SEQUENCE attend_seq;