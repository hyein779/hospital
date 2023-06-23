-- 공지사항
create table notice(
 notice_num number,
 notice_date date default sysdate not null,
 notice_modifydate date,
 notice_title varchar2(150) not null,
 notice_content clob not null,
 notice_hit number(9) default 0 not null,
 constraint notice_pk primary key (notice_num)
);
create sequence notice_seq; 

-- 문의사항
create table ask(
 ask_num number,
 ask_date date default sysdate not null,
 ask_modifydate date,
 ask_title varchar2(150) not null,
 ask_content clob not null,
 ask_hit number(9) default 0 not null,
 mem_num number not null,
 constraint ask_pk primary key (ask_num),
 constraint ask_fk foreign key (mem_num) references member (mem_num)
);
create sequence community_seq;

-- 리뷰
create table review(
 rev_num number,
 rev_date date default sysdate not null,
 rev_modifydate date,
 rev_title varchar2(150) not null,
 rev_content clob not null,
 rev_hit number(9) default 0 not null,
 rev_filename varchar2(150),
 mem_num number not null,
 constraint review_pk primary key (rev_num),
 constraint review_fk foreign key (mem_num) references member (mem_num)
);
create sequence review_seq;

-- 추천
create table fav(
 fav_num number,
 rev_num number not null,
 mem_num number not null,
 constraint fav_pk primary key (fav_num),
 constraint fav_fk1 foreign key (rev_num) references review (rev_num),
 constraint fav_fk2 foreign key (mem_num) references member (mem_num)
);
create sequence fav_seq;

-- 댓글
create table reply(
 re_num number,
 re_content varchar2(900) not null,
 re_date date default sysdate not null,
 re_modifydate date,
 re_ip varchar2(40) not null,
 ask_num number not null,
 mem_num number not null,
 constraint reply_pk primary key (re_num),
 constraint reply_fk1 foreign key (ask_num) references ask (ask_num),
 constraint reply_fk2 foreign key (mem_num) references member (mem_num)
);
create sequence reply_seq;