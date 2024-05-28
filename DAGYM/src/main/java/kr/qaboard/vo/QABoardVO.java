package kr.qaboard.vo;

import java.sql.Date;

public class QABoardVO {
	private int qab_num;
	private int mem_num;
	private int qab_type;
	private String qab_title;
	private String qab_content;
	private String qab_filename;
	private int qab_hit;
	private Date qab_reg_date;
	private Date qab_modify_date;
	private String qab_ip;
	private int qab_remove;
	private int qab_ref;
	
	private String mem_id;

	public int getQab_num() {
		return qab_num;
	}

	public void setQab_num(int qab_num) {
		this.qab_num = qab_num;
	}

	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	public int getQab_type() {
		return qab_type;
	}

	public void setQab_type(int qab_type) {
		this.qab_type = qab_type;
	}

	public String getQab_title() {
		return qab_title;
	}

	public void setQab_title(String qab_title) {
		this.qab_title = qab_title;
	}

	public String getQab_content() {
		return qab_content;
	}

	public void setQab_content(String qab_content) {
		this.qab_content = qab_content;
	}

	public String getQab_filename() {
		return qab_filename;
	}

	public void setQab_filename(String qab_filename) {
		this.qab_filename = qab_filename;
	}

	public int getQab_hit() {
		return qab_hit;
	}

	public void setQab_hit(int qab_hit) {
		this.qab_hit = qab_hit;
	}

	public Date getQab_reg_date() {
		return qab_reg_date;
	}

	public void setQab_reg_date(Date qab_reg_date) {
		this.qab_reg_date = qab_reg_date;
	}

	public Date getQab_modify_date() {
		return qab_modify_date;
	}

	public void setQab_modify_date(Date qab_modify_date) {
		this.qab_modify_date = qab_modify_date;
	}

	public String getQab_ip() {
		return qab_ip;
	}

	public void setQab_ip(String qab_ip) {
		this.qab_ip = qab_ip;
	}

	public int getQab_remove() {
		return qab_remove;
	}

	public void setQab_remove(int qab_remove) {
		this.qab_remove = qab_remove;
	}

	public int getQab_ref() {
		return qab_ref;
	}

	public void setQab_ref(int qab_ref) {
		this.qab_ref = qab_ref;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	
}
