package kr.community.vo;

import java.sql.Date;

public class ReviewVO {
	private int rev_num; // 리뷰 글번호
	private Date rev_date; // 등록일
	private Date rev_modifydate; // 수정일
	private String rev_title; // 글 제목
	private String rev_content; // 글 내용
	private int rev_type; // 리뷰 진료 종류
	private int mem_num; // 회원번호
	
	private String mem_name; // 회원이름

	public int getRev_num() {
		return rev_num;
	}

	public void setRev_num(int rev_num) {
		this.rev_num = rev_num;
	}

	public Date getRev_date() {
		return rev_date;
	}

	public void setRev_date(Date rev_date) {
		this.rev_date = rev_date;
	}

	public Date getRev_modifydate() {
		return rev_modifydate;
	}

	public void setRev_modifydate(Date rev_modifydate) {
		this.rev_modifydate = rev_modifydate;
	}
	
	public String getRev_title() {
		return rev_title;
	}

	public void setRev_title(String rev_title) {
		this.rev_title = rev_title;
	}

	public String getRev_content() {
		return rev_content;
	}

	public void setRev_content(String rev_content) {
		this.rev_content = rev_content;
	}

	public int getRev_type() {
		return rev_type;
	}

	public void setRev_type(int rev_type) {
		this.rev_type = rev_type;
	}

	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	public String getMem_name() {
		return mem_name;
	}

	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
}
