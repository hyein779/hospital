CREATE TABLE reservation(
	res_num number, 
	res_doc number, 
	res_date date not null, 
	res_time time not null, 
	res_treat varchar2(50), 
	res_status number not null,
	res_select number not null,
	mem_num number not null,
	
	constraint reservation_pk primary key (res_num),
	constraint reservation_fk foreign key (mem_num) references member (mem_num)
);

CREATE sequence reservation_seq;