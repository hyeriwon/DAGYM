package kr.history.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import kr.history.vo.HistoryVO;
import kr.payment.vo.PaymentVO;
import kr.util.DBUtil;

public class HistoryDAO {
	//싱글턴 패턴
		private static HistoryDAO instance = new HistoryDAO();
		
		public static HistoryDAO getInstance() {
			return instance;
		}
		private HistoryDAO () {}
	
	//수강신청
		public void insertHistory(HistoryVO history, PaymentVO payment)throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			PreparedStatement pstmt2 = null;
			String sql = null;
			try {
				//커넥션풀로부터 커넥션 할당
				conn = DBUtil.getConnection();
				//오토커밋 해제
				conn.setAutoCommit(false);
				
				//수강신청시 history 테이블에 데이터 등록
				sql = "INSERT INTO history (his_num,mem_num,sch_num,tra_num,his_status,his_part) VALUES (zboard_seq.nextval,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, history.getMem_num());
				pstmt.setInt(2, history.getSch_num());
				pstmt.setInt(3, history.getTra_num());
				pstmt.setInt(4, history.getHis_status());
				pstmt.setString(5, history.getHis_part());
				pstmt.executeUpdate();
				//수강신청시 PT 등록횟수 차감
				sql = "UPDATE payment SET pay_enroll = payment - 1 WHERE mem_num=? AND pay_enroll > 0";
				pstmt2 = conn.prepareStatement(sql);
				pstmt2.setInt(1, payment.getMem_num());
				pstmt2.executeUpdate();
				
				//예외 발생 없이 정상적으로 SQL문 실행
				conn.commit();
			}catch(Exception e) {
				//예외 발생
				conn.rollback();
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(null, pstmt2, null);
				DBUtil.executeClose(null, pstmt, conn);
			}
		}
}
