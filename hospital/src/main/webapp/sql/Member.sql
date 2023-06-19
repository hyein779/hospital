create table member(
 mem_num number,
 mem_id varchar2(12) not null,
 mem_auth number default 2 not null,
 constraint member_pk primary key (mem_num)
);

create table member_detail(
 mem_num number,
 mem_pw varchar2(20) not null,
 mem_name varchar2(30) not null,
 mem_public varchar2(14) not null,
 mem_phone varchar2(15) not null,
 mem_email varchar2(50) not null,
 mem_zipcode varchar2(5) not null,
 mem_address1 varchar2(50) not null,
 mem_address2 varchar2(50) not null,
 mem_photo varchar2(150),
 mem_date date default sysdate not null,
 mem_visited date,
 constraint member_detail_pk primary key (mem_num),
 constraint member_detail_fk foreign key(mem_num) references member(mem_num)
);

create sequence member_seq;