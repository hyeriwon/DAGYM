package kr.schedule.vo;

import kr.history.vo.HistoryVO;

public class ScheduleVO {
	private int sch_num;
	private int mem_num;
	private String sch_date;
	private int sch_status;
	private int sch_time;
	private String mem_id;
	private int his_status;
	
	// 필요한 추가 정보
    private String tra_id;
    private HistoryVO history;
    private String his_part;
    private int his_num;
    private String trainerId; // 트레이너 ID
    private String memberId; // 회원 ID
    
	
	public int getSch_num() {
		return sch_num;
	}
	public void setSch_num(int sch_num) {
		this.sch_num = sch_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public String getSch_date() {
		return sch_date;
	}
	public void setSch_date(String sch_date) {
		this.sch_date = sch_date;
	}
	public int getSch_status() {
		return sch_status;
	}
	public void setSch_status(int sch_status) {
		this.sch_status = sch_status;
	}
	public int getSch_time() {
		return sch_time;
	}
	public void setSch_time(int sch_time) {
		this.sch_time = sch_time;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getTra_id() {
		return tra_id;
	}
	public void setTra_id(String tra_id) {
		this.tra_id = tra_id;
	}
	public int getHis_status() {
		return his_status;
	}
	public void setHis_status(int his_status) {
		this.his_status = his_status;
	}
	public HistoryVO getHistory() {
		return history;
	}
	public void setHistory(HistoryVO history) {
		this.history = history;
	}
	public String getHis_part() {
		return his_part;
	}
	public void setHis_part(String his_part) {
		this.his_part = his_part;
	}
	public int getHis_num() {
		return his_num;
	}
	public void setHis_num(int his_num) {
		this.his_num = his_num;
	}
	public String getTrainerId() {
		return trainerId;
	}
	public void setTrainerId(String trainerId) {
		this.trainerId = trainerId;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

}
