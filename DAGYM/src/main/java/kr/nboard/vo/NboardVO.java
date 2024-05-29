package kr.nboard.vo;

import java.sql.Date;

public class NboardVO {
	private int nbo_num;
	private int mem_num;
	private String nbo_title;
	private String nbo_content;
	private String nbo_filename;
	private int nbo_hit;
	private Date nbo_reg_date;
	private Date nbo_modify_date;
	
	public int getNbo_num() {
		return nbo_num;
	}
	public void setNbo_num(int nbo_num) {
		this.nbo_num = nbo_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public String getNbo_title() {
		return nbo_title;
	}
	public void setNbo_title(String nbo_title) {
		this.nbo_title = nbo_title;
	}
	public String getNbo_content() {
		return nbo_content;
	}
	public void setNbo_content(String nbo_content) {
		this.nbo_content = nbo_content;
	}
	public String getNbo_filename() {
		return nbo_filename;
	}
	public void setNbo_filename(String nbo_filename) {
		this.nbo_filename = nbo_filename;
	}
	public int getNbo_hit() {
		return nbo_hit;
	}
	public void setNbo_hit(int nbo_hit) {
		this.nbo_hit = nbo_hit;
	}
	public Date getNbo_reg_date() {
		return nbo_reg_date;
	}
	public void setNbo_reg_date(Date nbo_reg_date) {
		this.nbo_reg_date = nbo_reg_date;
	}
	public Date getNbo_modify_date() {
		return nbo_modify_date;
	}
	public void setNbo_modify_date(Date nbo_modify_date) {
		this.nbo_modify_date = nbo_modify_date;
	}
	
}
