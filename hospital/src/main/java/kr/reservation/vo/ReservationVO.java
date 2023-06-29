package kr.reservation.vo;

import java.sql.Date;

public class ReservationVO {
	private int res_num; //예약 번호
	private String res_date; //예약 날짜
	private String res_time; //예약 시간
	private String res_treat; //치료 이름
	private int res_status; //예약 가능 여부(1:예약 가능 2:예약 불가능)
	private int res_select; //예약 종류 (1:진료 2:치료)
	private String res_content; //증상 설명
	private int mem_num; //회원번호
	private int doc_num; //의사번호
	private String doc_name; //의사이름
	private String doc_content; //의사설명
	private String doc_photo;//의사 사진
	private String mem_name;//회원 이름
	private String mem_public;//주민번호
	
	
	public String getRes_content() {
		return res_content;
	}
	public void setRes_content(String res_content) {
		this.res_content = res_content;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getMem_public() {
		return mem_public;
	}
	public void setMem_public(String mem_public) {
		this.mem_public = mem_public;
	}
	public int getDoc_num() {
		return doc_num;
	}
	public void setDoc_num(int doc_num) {
		this.doc_num = doc_num;
	}
	public String getDoc_name() {
		return doc_name;
	}
	public void setDoc_name(String doc_name) {
		this.doc_name = doc_name;
	}
	public String getDoc_content() {
		return doc_content;
	}
	public void setDoc_content(String doc_content) {
		this.doc_content = doc_content;
	}
	public String getDoc_photo() {
		return doc_photo;
	}
	public void setDoc_photo(String doc_photo) {
		this.doc_photo = doc_photo;
	}
	public int getRes_num() {
		return res_num;
	}
	public void setRes_num(int res_num) {
		this.res_num = res_num;
	}
	public String getRes_date() {
		return res_date;
	}
	public void setRes_date(String res_date) {
		this.res_date = res_date;
	}
	public String getRes_time() {
		return res_time;
	}
	public void setRes_time(String res_time) {
		this.res_time = res_time;
	}
	public String getRes_treat() {
		return res_treat;
	}
	public void setRes_treat(String res_treat) {
		this.res_treat = res_treat;
	}
	public int getRes_status() {
		return res_status;
	}
	public void setRes_status(int res_status) {
		this.res_status = res_status;
	}
	public int getRes_select() {
		return res_select;
	}
	public void setRes_select(int res_select) {
		this.res_select = res_select;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
}
