package kr.reservation.vo;

import java.sql.Date;

public class ReservationVO {
	private int res_num; //예약 번호
	private int res_doc; //의사 식별 번호
	private Date res_date; //예약 날짜
	private Date res_time; //예약 시간
	private String res_treat; //치료 이름
	private int res_status; //예약 가능 여부(1:예약 가능 2:예약 불가능)
	private int res_select; //예약 종류 (1:진료 2:치료)
	private int mem_num; //회원번호
	
	
	
	public int getRes_num() {
		return res_num;
	}
	public void setRes_num(int res_num) {
		this.res_num = res_num;
	}
	public int getRes_doc() {
		return res_doc;
	}
	public void setRes_doc(int res_doc) {
		this.res_doc = res_doc;
	}
	public Date getRes_date() {
		return res_date;
	}
	public void setRes_date(Date res_date) {
		this.res_date = res_date;
	}
	public Date getRes_time() {
		return res_time;
	}
	public void setRes_time(Date res_time) {
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
