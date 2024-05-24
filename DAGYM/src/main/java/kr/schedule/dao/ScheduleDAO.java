package kr.schedule.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import kr.history.vo.HistoryVO;
import kr.member.dao.MemberDAO;
import kr.payment.vo.PaymentVO;
import kr.util.DBUtil;

public class ScheduleDAO {
	//싱글턴 패턴
	private static ScheduleDAO instance = new ScheduleDAO();
	
	public static ScheduleDAO getInstance() {
		return instance;
	}
	private ScheduleDAO () {}
	
	
	
	
}
