package kr.payment.vo;

public class PaymentVO {
	private int pay_num;
	private int mem_num;
	private int pay_fee;
	private int pay_enroll;
	
	public int getPay_num() {
		return pay_num;
	}
	public void setPay_num(int pay_num) {
		this.pay_num = pay_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public int getPay_fee() {
		return pay_fee;
	}
	public void setPay_fee(int pay_fee) {
		this.pay_fee = pay_fee;
	}
	public int getPay_enroll() {
		return pay_enroll;
	}
	public void setPay_enroll(int pay_enroll) {
		this.pay_enroll = pay_enroll;
	}
}
