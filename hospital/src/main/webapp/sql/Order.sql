-- 주문정보
create table order(
	mem_num number not null, --회원번호pk fk
	item_num number not null, --상품번호fk
	item_count number not null, --주문수량
	order_date date not null, --주문일자
	order_address varchar2(90) not null, --배송지
	order_way number(1) not null, --결제방식(payment)
	order_etc clob not null --기타사항
	constraint order_pk primary key (mem_num),
	constraint order_fk foreign key (mem_num) references member (mem_num),
	constraint order_fk2 foreign key (item_num) references item (item_num)
);

create sequence order_seq;

-- 주문상세정보
create table order_detail(
	detail_num number not null, --주문상세번호pk
	item_num number not null, --상품번호fk
	item_name varchar2(12) not null, --상품명fk
	item_price number not null, --상품가격fk
	item_total number not null, --결제금액
	order_quantity not null, --재고
	order_num not null, --주문번호
	constraint order_detail_pk primary key (detail_num),
	constraint order_detail_fk foreign key (item_num) references item (item_num),
	constraint order_detail_fk2 foreign key (item_name) references item (item_name),
	constraint order_detail_fk3	 foreign key (item_price) references item (item_price)
);

create sequence order_detail_seq;