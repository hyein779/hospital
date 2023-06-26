package kr.community.vo;

public class ReplyVO {
	private int re_num; // 댓글 번호
	private String re_content; // 내용
	private String re_date; // 등록일
	private String re_modifydate; // 수정일
	private int ask_num; // 부모글(문의사항) 번호
	private int mem_num; // 작성자 회원번호
	private String id; // 아이디
	
	public int getRe_num() {
		return re_num;
	}
	public void setRe_num(int re_num) {
		this.re_num = re_num;
	}
	public String getRe_content() {
		return re_content;
	}
	public void setRe_content(String re_content) {
		this.re_content = re_content;
	}
	public String getRe_date() {
		return re_date;
	}
	public void setRe_date(String re_date) {
		this.re_date = re_date;
	}
	public String getRe_modifydate() {
		return re_modifydate;
	}
	public void setRe_modifydate(String re_modifydate) {
		this.re_modifydate = re_modifydate;
	}
	public int getAsk_num() {
		return ask_num;
	}
	public void setAsk_num(int ask_num) {
		this.ask_num = ask_num;
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
