package kr.history.vo;

public class HistoryVO {
	private int his_num;
	private int mem_num;
	private int sch_num;
	private int tra_num;
	private int his_status;
	private String his_part;
	
	// 추가로 가져올 정보
	private String tra_id;
	private String sch_date;
	private String mem_phone;
	
	public String getMem_phone() {
		return mem_phone;
	}
	public void setMem_phone(String mem_phone) {
		this.mem_phone = mem_phone;
	}
	public String getSch_date() {
		return sch_date;
	}
	public void setSch_date(String sch_date) {
		this.sch_date = sch_date;
	}
	public String getTra_id() {
		return tra_id;
	}
	public void setTra_id(String getTra_id) {
		this.tra_id = getTra_id;
	}
	public int getHis_num() {
		return his_num;
	}
	public void setHis_num(int his_num) {
		this.his_num = his_num;
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
	public int getTra_num() {
		return tra_num;
	}
	public void setTra_num(int tra_num) {
		this.tra_num = tra_num;
	}
	public int getHis_status() {
		return his_status;
	}
	public void setHis_status(int his_status) {
		this.his_status = his_status;
	}
	public String getHis_part() {
		return his_part;
	}
	public void setHis_part(String his_part) {
		this.his_part = his_part;
	}
	
}
