--식사 등록
create table meal (
 meal_num number not null, --식사기록 번호
 tme_num number not null,	-- 섭취 식사 메뉴 번호
 mem_num number not null,	--회원 번호
 meal_date varchar2(30) not null, -- 식사일자
 meal_time number(1) not null,  -- 식사 분류(아침:0, 점심:1, 저녁:2,간식:3)
 constraint meal_pk primary key(meal_num),
 constraint meal_fk1 foreign key(tme_num) references t_menu(tme_num),
 constraint meal_fk2 foreign key(mem_num) references member(mem_num)
 );
 create sequence meal_seq;

create table t_menu(
 tme_num number not null, --메뉴 식별 번호
 tme_name varchar2(30) not null, --메뉴 이름
 tme_content clob not null, 	--메뉴 설명
 tme_kcal number not null,		--메뉴 칼로리
 tme_protein number  not null,	--메뉴 단백질
 tme_crabs number not null,		--메뉴 탄수화물
 tme_lipid number not null,		--메뉴 지방
 tme_photo varchar2(400) not null,	--메뉴 사진
 tme_type number not null,			--메뉴 식사 분류(아침:0,점심1,저녁:2,간식:3)
 tme_recom number default 0 not null,
 constraint t_menu_pk primary key(tme_num)

);
  
create sequence tmenu_seq;

create table inbody(
 inb_num number not null,
 mem_num number not null,
 inb_hei number not null,
 inb_wei number not null,
 inb_mus number not null,
 inb_date varchar2(30) not null,
 inb_photo varchar2(400),
 constraint inb_num_pk primary key(inb_num),
 constraint mem_num_fk foreign key(mem_num) references member(mem_num)
);
 create sequence inbody_seq;
 
create table exercise(
 exe_num number not null,		--운동 번호
 mem_num number not null,		--회원번호
 exe_type varchar2(50) not null,--운동 부위 (어깨,허리 다리 등)
 exe_content varchar2(4000) not null,--운동 상세
 exe_date varchar2(30) not null, --운동 날짜
 exe_time number not null, 		-- 운동한 시간
  constraint exe_num_pk primary key(exe_num),
  constraint exercise_fk foreign key(mem_num) references member(mem_num)
);
create sequence exercise_seq;
 
 