package kr.member.vo;

import java.sql.Date;

public class MemberVO {
	private int mem_num; //회원번호
	private String id; //아이디
	private int auth; //회원등급
	private String passwd; //비밀번호
	private String name; //이름
	private String code; //주민번호
	private String phone; //전화번호
	private String email; //이메일
	private String zipcode; //우편번호
	private String address1; //주소
	private String address2; //상세주소
	private String photo; //프로필 사진
	private Date date; //가입일
	private Date visited; //최근진료일
	
	// 비밀번호 일치 여부 체크
	public boolean isCheckesPassword(String userPasswd) {
		// 회원등급(auth):0탈퇴회원,1정지회원,2일반회원,9관리자
		if(auth > 1 && passwd.equals(userPasswd)) {
			return true;
		}
		return false;
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

	public int getAuth() {
		return auth;
	}

	public void setAuth(int auth) {
		this.auth = auth;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Date getVisited() {
		return visited;
	}

	public void setVisited(Date visited) {
		this.visited = visited;
	}
}