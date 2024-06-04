package kr.review.vo;

import java.sql.Date;

public class RevReportVO {
	private int rev_num;
	private int mem_num;
	private String report_content;
	private int report_del;
	private Date report_date;
	
	//추가로 정보를 받아오기 위한 필드
	private String rev_title;
	private String mem_id;
	
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
	public String getReport_content() {
		return report_content;
	}
	public void setReport_content(String report_content) {
		this.report_content = report_content;
	}
	public int getReport_del() {
		return report_del;
	}
	public void setReport_del(int report_del) {
		this.report_del = report_del;
	}
	public Date getReport_date() {
		return report_date;
	}
	public void setReport_date(Date report_date) {
		this.report_date = report_date;
	}
	public String getRev_title() {
		return rev_title;
	}
	public void setRev_title(String rev_title) {
		this.rev_title = rev_title;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
}
