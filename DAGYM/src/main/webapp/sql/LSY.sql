-- 출석체크
CREATE TABLE attend (
	att_num NUMBER NOT NULL,
	mem_num NUMBER NOT NULL,
	att_date DATE NOT NULL default sysdate,
	CONSTRAINT attend_pk PRIMARY KEY (att_num),
	CONSTRAINT attend_fk FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);
CREATE SEQUENCE attend_seq;

-- 포인트
CREATE TABLE point (
	poi_num NUMBER NOT NULL,
	mem_num NUMBER NOT NULL,
	poi_type VARCHAR2(50) NOT NULL,
	poi_in NUMBER(10),
	poi_in_date DATE,
	poi_out NUMBER(10),
	poi_out_date DATE,
	CONSTRAINT point_pk PRIMARY KEY (poi_num),
	CONSTRAINT point_fk FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);
CREATE SEQUENCE point_seq;