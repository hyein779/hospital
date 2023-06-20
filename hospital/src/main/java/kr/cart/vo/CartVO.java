package kr.cart.vo;

import kr.item.vo.ItemVO;

public class CartVO {
	private int cart_num; // 장바구니 번호
	private int mem_num; // 주문자 회원번호
	private int item_num; // 상품 번호
	private int item_count; // 상품 수량
	private int sub_total; // 동일 상품 총 구매 금액
	
	private ItemVO itemVO;

	public int getCart_num() {
		return cart_num;
	}

	public void setCart_num(int cart_num) {
		this.cart_num = cart_num;
	}

	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	public int getItem_num() {
		return item_num;
	}

	public void setItem_num(int item_num) {
		this.item_num = item_num;
	}

	public int getItem_count() {
		return item_count;
	}

	public void setItem_count(int item_count) {
		this.item_count = item_count;
	}

	public int getSub_total() {
		return sub_total;
	}

	public void setSub_total(int sub_total) {
		this.sub_total = sub_total;
	}

	public ItemVO getItemVO() {
		return itemVO;
	}

	public void setItemVO(ItemVO itemVO) {
		this.itemVO = itemVO;
	} 
}
