package kr.exercise.vo;

public class ExerciseVO {
	private int exe_num;
	private int mem_num;
	private String exe_type;
	private String exe_content;
	public String getExe_content() {
		return exe_content;
	}
	public void setExe_content(String exe_content) {
		this.exe_content = exe_content;
	}
	private String exe_date;
	private int exe_time;
	public int getExe_num() {
		return exe_num;
	}
	public void setExe_num(int exe_num) {
		this.exe_num = exe_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public String getExe_type() {
		return exe_type;
	}
	public void setExe_type(String exe_type) {
		this.exe_type = exe_type;
	}
	public String getExe_date() {
		return exe_date;
	}
	public void setExe_date(String exe_date) {
		this.exe_date = exe_date;
	}
	public int getExe_time() {
		return exe_time;
	}
	public void setExe_time(int exe_time) {
		this.exe_time = exe_time;
	}
	

}
