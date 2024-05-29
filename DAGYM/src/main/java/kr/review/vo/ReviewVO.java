package kr.review.vo; 

import java.sql.Date;

public class ReviewVO {
	private int rev_num;
	private int mem_num;
	private int sch_num;
	private int rev_grade;
	private String rev_title;
	private String rev_content;
	private String rev_filename1;
	private String rev_filename2;
	private String rev_ip;
	private Date rev_reg_date;
	private Date rev_modify_date;
	private int rev_hit;
	private int rev_like;
	
	private String mem_name;
	private String sch_date;
	private String tra_name;
	
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getSch_date() {
		return sch_date;
	}
	public void setSch_date(String sch_date) {
		this.sch_date = sch_date;
	}
	public String getTra_name() {
		return tra_name;
	}
	public void setTra_name(String tra_name) {
		this.tra_name = tra_name;
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
	public int getSch_num() {
		return sch_num;
	}
	public void setSch_num(int sch_num) {
		this.sch_num = sch_num;
	}
	public int getRev_grade() {
		return rev_grade;
	}
	public void setRev_grade(int rev_grade) {
		this.rev_grade = rev_grade;
	}
	public String getRev_title() {
		return rev_title;
	}
	public void setRev_title(String rev_title) {
		this.rev_title = rev_title;
	}
	public String getRev_content() {
		return rev_content;
	}
	public void setRev_content(String rev_content) {
		this.rev_content = rev_content;
	}
	public String getRev_filename1() {
		return rev_filename1;
	}
	public void setRev_filename1(String rev_filename1) {
		this.rev_filename1 = rev_filename1;
	}
	public String getRev_filename2() {
		return rev_filename2;
	}
	public void setRev_filename2(String rev_filename2) {
		this.rev_filename2 = rev_filename2;
	}
	public String getRev_ip() {
		return rev_ip;
	}
	public void setRev_ip(String rev_ip) {
		this.rev_ip = rev_ip;
	}
	public Date getRev_reg_date() {
		return rev_reg_date;
	}
	public void setRev_reg_date(Date rev_reg_date) {
		this.rev_reg_date = rev_reg_date;
	}
	public Date getRev_modify_date() {
		return rev_modify_date;
	}
	public void setRev_modify_date(Date rev_modify_date) {
		this.rev_modify_date = rev_modify_date;
	}
	public int getRev_hit() {
		return rev_hit;
	}
	public void setRev_hit(int rev_hit) {
		this.rev_hit = rev_hit;
	}
	public int getRev_like() {
		return rev_like;
	}
	public void setRev_like(int rev_like) {
		this.rev_like = rev_like;
	}
}
