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
	constraint volunteerboard_pk primary key(board_num),
	constraint volunteerboard_fk1 foreign key (mem_num) references member (mem_num),
);
create sequence volunteerboard_seq;


-- 봉사 신청
CREATE TABLE appvolunteer(
	app_num number,
	board_num number not null,
	name varchar2(20) not null,
	address varchar2(90) not null,
	phone varchar(20) not null,
	content clob not null,
	mem_num number not null,
	constraint appvolunteer_pk primary key (app_num),
	constraint appvolunteer_fk1 foreign key (mem_num) references member (mem_num),
	constraint appvolunteer_fk2 foreign key (board_num) references volunteerboard (board_num)
);
CREATE sequence appvolunteer_seq;


