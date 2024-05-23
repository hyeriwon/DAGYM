package kr.schedule.dao;

import kr.member.dao.MemberDAO;

public class ScheduleDAO {
	//싱글턴 패턴
	private static ScheduleDAO instance = new ScheduleDAO();
	
	public static ScheduleDAO getInstance() {
		return instance;
	}
	private ScheduleDAO () {}
}
