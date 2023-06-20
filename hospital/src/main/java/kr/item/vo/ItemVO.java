package kr.item.vo;

public class ItemVO {
	private int item_num; // 상품 번호
	private String item_name; // 상품명
	private int item_price; // 상품 가격
	private int item_quantity; // 상품 수량
	private String item_photo; // 상품 사진
	private String item_detail; // 상품 상세설명
	private int item_status; // 상품 상태 (1: 판매 불가, 2: 판매 가능)
	
	public int getItem_num() {
		return item_num;
	}
	public void setItem_num(int item_num) {
		this.item_num = item_num;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public int getItem_price() {
		return item_price;
	}
	public void setItem_price(int item_price) {
		this.item_price = item_price;
	}
	public int getItem_quantity() {
		return item_quantity;
	}
	public void setItem_quantity(int item_quantity) {
		this.item_quantity = item_quantity;
	}
	public String getItem_photo() {
		return item_photo;
	}
	public void setItem_photo(String item_photo) {
		this.item_photo = item_photo;
	}
	public String getItem_detail() {
		return item_detail;
	}
	public void setItem_detail(String item_detail) {
		this.item_detail = item_detail;
	}
	public int getItem_status() {
		return item_status;
	}
	public void setItem_status(int item_status) {
		this.item_status = item_status;
	}
}
