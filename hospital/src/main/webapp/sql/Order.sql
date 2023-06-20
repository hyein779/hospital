-- 주문정보
create table zorder(
	order_num number, --주문번호
	item_name varchar2(600) not null, --대표상품명
	order_total number(9) not null, --총구매금액
	payment number(1) not null, --결제방식
	status number(1) default 1 not null,
	receive_name varchar2(30) not null, --받는사람
	receive_post varchar2(5) not null, --우편번호
	receive_address1 varchar2(90) not null, --주소
	receive_address2 varchar2(90) not null, --상세주소
	receive_phone varchar2(15) not null, --전화번호
	reg_date date default sysdate not null, --주문일자
	modify_date date, --수정일자
	notice varchar2(4000), --세부사항
	mem_num number not null,--회원번호
	constraint order_pk primary key (order_num),
	constraint order_fk foreign key (mem_num) references member (mem_num)
);

create sequence zorder_seq;

-- 주문상세정보
create table zorder_detail(
	detail_num number, --주문상세번호pk
	item_num number not null, --상품번호fk
	item_name varchar2(12) not null, --상품명fk
	item_price number not null, --상품가격fk
	item_total number not null, --결제금액
	order_quantity number not null, --재고
	order_num not null, --주문번호
	constraint order_detail_pk primary key (detail_num),
	constraint order_detail_fk foreign key (order_num) references zorder (order_num)
);

create sequence zorder_detail_seq;