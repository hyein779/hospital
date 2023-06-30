CREATE TABLE reservation(
	res_num number, 
	res_date varchar2(50) not null, 
	res_time varchar2(50) not null, 
	res_status number not null,
	res_select number not null,
	res_content varchar2(100),
	mem_num number not null,
	doc_num number not null,
	
	constraint reservation_pk primary key (res_num),
	constraint reservation_fk foreign key (mem_num) references member (mem_num),
	constraint reservation_fk2 foreign key (doc_num) references doc (doc_num)
);
CREATE sequence reservation_seq;

--의사
CREATE TABLE doc(
	doc_num number,
	doc_name varchar2(30) not null,
	doc_content varchar2(150) not null,
    doc_photo varchar2(100) not null,
	constraint doc_pk primary key (doc_num)
);
CREATE sequence doc_seq;

--물리치료
CREATE TABLE treat(
	treat_num number,
	treat_name varchar2(50) not null,
	constraint treat_pk primary key (treat_num)
);
CREATE sequence treat_seq;

--치료 예약
CREATE TABLE treservation(
	res_num number, 
	res_date varchar2(50) not null, 
	res_time varchar2(50) not null, 
	res_status number not null,
	res_select number not null,
	res_content varchar2(100),
	mem_num number not null,
	treat_num number not null,
	
	constraint reservation_pk primary key (res_num),
	constraint reservation_fk foreign key (mem_num) references member (mem_num),
	constraint reservation_fk2 foreign key (treat_num) references treat (treat_num)
);
CREATE sequence treservation_seq;