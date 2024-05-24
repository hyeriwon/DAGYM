package kr.schedule.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import kr.schedule.vo.ScheduleVO;
import kr.util.DBUtil;

public class ScheduleDAO {
	//싱글턴 패턴
	private static ScheduleDAO instance = new ScheduleDAO();
	
	public static ScheduleDAO getInstance() {
		return instance;
	}
	private ScheduleDAO () {}
	
	public void insertSchedule(ScheduleVO schedule) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			
			sql = "INSERT INTO schedule (sch_num, mem_num, sch_date, sch_status) VALUES (schedule_seq.nextval,?,?,?)";
			
			//PreparedStatement 생성
			pstmt = conn.prepareStatement(sql);
			
			// ?에 데이터 바인딩
			pstmt.setInt(1, schedule.getMem_num());
			pstmt.setString(2, schedule.getSch_date());
			pstmt.setInt(3, 0);
			
			// SQL믄 실행
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	
}
