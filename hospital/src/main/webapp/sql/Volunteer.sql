--게시판 글 등록
create table volunteerboard(
	board_num number,
	title varchar2(150) not null,
	content clob not null,
	hit number(9) default 0 not null,
	reg_date varchar2(150) not null,
	modify_date date,
	quantity number not null,
	mem_num number not null,
	mem_id varchar2(20),
	constraint volunteerboard_pk primary key(board_num),
	constraint volunteerboard_fk1 foreign key (mem_num) references member (mem_num),
	constraint volunteerboard_fk2 foreign key (mem_id) references member (mem_id)
);
create sequence volunteerboard_seq;


-- 봉사 신청
CREATE TABLE appvolunteer(
	app_num number,
	name varchar2(20) not null,
	birth Date not null,
	address varchar2(90) not null,
	phone varchar(20) not null,
	content clob not null,
	reg_date varchar(2) not null,
	mem_num number not null,
	constraint appvolunteer_pk primary key (app_num),
	constraint appvolunteer_fk1 foreign key (mem_num) references member (mem_num),
);
CREATE sequence appvolunteer_seq;

