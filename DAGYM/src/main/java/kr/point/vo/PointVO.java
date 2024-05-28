package kr.point.vo;

import java.sql.Date;

public class PointVO {
	
	private int poi_num;		//포인트번호
	private int mem_num;		//회원번호
	private String poi_type;	//포인트종류
	private int poi_in;			//적립포인트
	private Date poi_in_date;	//적립일자
	private int poi_out;		//사용포인트
	private Date poi_out_date;	//사용일자
	
	public int getPoi_num() {
		return poi_num;
	}
	public void setPoi_num(int poi_num) {
		this.poi_num = poi_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public String getPoi_type() {
		return poi_type;
	}
	public void setPoi_type(String poi_type) {
		this.poi_type = poi_type;
	}
	public int getPoi_in() {
		return poi_in;
	}
	public void setPoi_in(int poi_in) {
		this.poi_in = poi_in;
	}
	public Date getPoi_in_date() {
		return poi_in_date;
	}
	public void setPoi_in_date(Date poi_in_date) {
		this.poi_in_date = poi_in_date;
	}
	public int getPoi_out() {
		return poi_out;
	}
	public void setPoi_out(int poi_out) {
		this.poi_out = poi_out;
	}
	public Date getPoi_out_date() {
		return poi_out_date;
	}
	public void setPoi_out_date(Date poi_out_date) {
		this.poi_out_date = poi_out_date;
	}
}
