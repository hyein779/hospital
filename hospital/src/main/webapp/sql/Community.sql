-- 커뮤니티
create table community(
 comu_num number,
 comu_auth number not null, -- 종류(1:공지사항,2:문의사항3:리뷰)
 comu_date date default sysdate not null,
 comu_modifydate date,
 comu_title varchar2(150) not null,
 comu_content clob not null,
 comu_hit number(9) default 0 not null,
 mem_num number not null,
 constraint community_pk primary key (comu_num),
 constraint community_fk foreign key (mem_num) references member (mem_num)
);
create sequence community_seq;

-- 추천
create table fav(
 fav_num number,
 comu_num number not null,
 mem_num number not null,
 constraint fav_pk primary key (fav_num),
 constraint fav_fk1 foreign key (comu_num) references community (comu_num),
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
 comu_num number not null,
 mem_num number not null,
 constraint reply_pk primary key (re_num),
 constraint reply_fk foreign key (mem_num) references member (mem_num)
);
create sequence reply_seq;