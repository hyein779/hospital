package kr.community.vo;

import java.sql.Date;

public class NoticeVO {
	private int notice_num; // 글번호
	private Date notice_date; // 등록일
	private Date notice_modifydate; // 수정일
	private String notice_title; // 글 제목
	private String notice_content; // 글 내용
	private int notice_hit; // 조회수
	
	public int getNotice_num() {
		return notice_num;
	}
	public void setNotice_num(int notice_num) {
		this.notice_num = notice_num;
	}
	public Date getNotice_date() {
		return notice_date;
	}
	public void setNotice_date(Date notice_date) {
		this.notice_date = notice_date;
	}
	public Date getNotice_modifydate() {
		return notice_modifydate;
	}
	public void setNotice_modifydate(Date notice_modifydate) {
		this.notice_modifydate = notice_modifydate;
	}
	public String getNotice_title() {
		return notice_title;
	}
	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}
	public String getNotice_content() {
		return notice_content;
	}
	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}
	public int getNotice_hit() {
		return notice_hit;
	}
	public void setNotice_hit(int notice_hit) {
		this.notice_hit = notice_hit;
	}
}
