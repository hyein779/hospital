package kr.community.vo;

public class FavVO {
	private int fav_num; // 좋아요 번호
	private int rev_num; // 리뷰글 번호
	private int mem_num; // 회원 번호
	
	public FavVO() {}
	
	public FavVO(int rev_num, int mem_num) {
		this.rev_num = rev_num;
		this.mem_num = mem_num;
	}

	public int getFav_num() {
		return fav_num;
	}

	public void setFav_num(int fav_num) {
		this.fav_num = fav_num;
	}

	public int getRev_num() {
		return rev_num;
	}

	public void setRev_num(int rev_num) {
		this.rev_num = rev_num;
	}

	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
}
