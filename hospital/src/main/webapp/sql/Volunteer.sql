--게시판 글 등록
create table volunteerboard(
	board_num number,
	title varchar2(150) not null,
	content clob not null,
	hit number(9) default 0 not null,
	reg_date varchar2(150) not null,
	modify_date date,
	mem_num number not null,
	mem_id varchar2(20),
	constraint volunteerboard_pk primary key(board_num),
	constraint volunteerboard_fk1 foreign key (mem_num) references member (mem_num),
	constraint volunteerboard_fk2 foreign key (mem_id) references member (mem_id)
);
create sequence volunteerboard_seq;

CREATE TABLE volunteer(
	volun_num number,
	volun_name varchar2(100) not null,
	volun_content clob not null,
	volun_date date not null,
	volun_max number not null,
	volun_type number not null,
	
	constraint volunteer_pk primary key (volun_num)
);
CREATE sequence volunteer_seq;

CREATE TABLE appvolunteer(
	app_num number,
	app_motive varchar2(500),
	app_approve number not null,
	volun_num number not null,
	mem_num number not null,
	constraint appvolunteer_pk primary key (app_num),
	constraint appvolunteer_fk foreign key (volun_num) references volunteer (volun_num),
	constraint appvolunteer_fk foreign key (mem_num) references member (mem_num)
);
CREATE sequence appvolunteer_seq;

