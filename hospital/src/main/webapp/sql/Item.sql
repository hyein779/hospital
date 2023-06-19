--상품
create table item(
 item_num number,
 item_name varchar2(50) not null,
 item_price number(20) not null,
 item_quantity number(10) not null,
 item_photo varchar2(34) not null,
 item_detail clob not null,
 item_status number(1) not null,
 constraint item_pk primary key (item_num)
);

create sequence item_seq;


--장바구니
create table cart(
 cart_num number not null,
 mem_num number not null,
 item_num number not null,
 item_count number not null,
 constraint cart_pk primary key (cart_num),
 constraint cart_fk foreign key (mem_num) references member (mem_num),
 constraint cart_fk2 foreign key (item_num) references item (item_num)
);

create sequence cart_seq;