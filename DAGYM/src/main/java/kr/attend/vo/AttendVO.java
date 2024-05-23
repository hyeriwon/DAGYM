package kr.attend.vo;

import java.sql.Date;

public class AttendVO {

	private int att_num;	//출석번호
	private int mem_num;	//회원번호
	private int att_point;	//출석포인트
	private Date att_date;	//출석날짜
	
	public int getAtt_num() {
		return att_num;
	}
	public void setAtt_num(int att_num) {
		this.att_num = att_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public int getAtt_point() {
		return att_point;
	}
	public void setAtt_point(int att_point) {
		this.att_point = att_point;
	}
	public Date getAtt_date() {
		return att_date;
	}
	public void setAtt_date(Date att_date) {
		this.att_date = att_date;
	}
}
