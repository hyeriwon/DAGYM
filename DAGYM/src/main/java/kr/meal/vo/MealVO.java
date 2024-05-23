package kr.meal.vo;

public class MealVO {
	private int meal_num;
	private int tme_num;
	private int mem_num;
	private String meal_date;
	private int meal_time;
	
	private int tme_kcal;
	private String tme_name;
	
	
	public int getMeal_num() {
		return meal_num;
	}
	public void setMeal_num(int meal_num) {
		this.meal_num = meal_num;
	}
	public int getTme_num() {
		return tme_num;
	}
	public void setTme_num(int tme_num) {
		this.tme_num = tme_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public String getMeal_date() {
		return meal_date;
	}
	public void setMeal_date(String meal_date) {
		this.meal_date = meal_date;
	}
	public int getMeal_time() {
		return meal_time;
	}
	public void setMeal_time(int meal_time) {
		this.meal_time = meal_time;
	}
	public int getTme_kcal() {
		return tme_kcal;
	}
	public void setTme_kcal(int tme_kcal) {
		this.tme_kcal = tme_kcal;
	}
	public String getTme_name() {
		return tme_name;
	}
	public void setTme_name(String tme_name) {
		this.tme_name = tme_name;
	}
}
