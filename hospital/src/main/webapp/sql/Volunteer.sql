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