package kr.review.vo;

public class RevLikeVO{
	private int rev_num;
	private int mem_num;
	
	public RevLikeVO() {}
	
	public RevLikeVO(int rev_num, int mem_num) {
		super();
		this.rev_num = rev_num;
		this.mem_num = mem_num;
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
