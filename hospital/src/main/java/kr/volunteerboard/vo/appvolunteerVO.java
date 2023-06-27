package kr.volunteerboard.vo;

import java.sql.Date;

public class appvolunteerVO {
	private int app_num;//봉사 신청 번호
	private int board_num;//글 번호
	private String name;//신청자 이름
	private String address;//주소
	private String phone;
	private String content;//신청 내용
	private int app_quantity;//지원수
	private String reg_date;
	private int mem_num;//신청자 번호
	public int getApp_num() {
		return app_num;
	}
	public void setApp_num(int app_num) {
		this.app_num = app_num;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getApp_quantity() {
		return app_quantity;
	}
	public void setApp_quantity(int app_quantity) {
		this.app_quantity = app_quantity;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	

	
	
}
