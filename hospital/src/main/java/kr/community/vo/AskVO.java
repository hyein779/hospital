package kr.community.vo;

import java.sql.Date;

public class AskVO { 
	private int ask_num; // 글번호
	private Date ask_date; // 등록일
	private Date ask_modifydate; // 수정일
	private String ask_title; // 글 제목
	private String ask_content; // 글 내용
	private int ask_hit; // 조회수
	private int mem_num; // 회원번호
	
	private String id; // 회원 아이디

	public int getAsk_num() {
		return ask_num;
	}

	public void setAsk_num(int ask_num) {
		this.ask_num = ask_num;
	}

	public Date getAsk_date() {
		return ask_date;
	}

	public void setAsk_date(Date ask_date) {
		this.ask_date = ask_date;
	}

	public Date getAsk_modifydate() {
		return ask_modifydate;
	}

	public void setAsk_modifydate(Date ask_modifydate) {
		this.ask_modifydate = ask_modifydate;
	}

	public String getAsk_title() {
		return ask_title;
	}

	public void setAsk_title(String ask_title) {
		this.ask_title = ask_title;
	}

	public String getAsk_content() {
		return ask_content;
	}

	public void setAsk_content(String ask_content) {
		this.ask_content = ask_content;
	}

	public int getAsk_hit() {
		return ask_hit;
	}

	public void setAsk_hit(int ask_hit) {
		this.ask_hit = ask_hit;
	}

	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
}