package kr.payment.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import kr.payment.dao.PaymentDAO;
import kr.util.DBUtil;

public class PaymentDAO {
	//싱글턴 패턴
	private static PaymentDAO instance = new PaymentDAO();

	public static PaymentDAO getInstance() {
		return instance;
	}
	private PaymentDAO () {}
	/*
	public void membershipCounseling(QA_boardVO qaboard)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			sql = "INSERT INTO qa_board (qab_num,mem_num,qab_type,qab_title,qab_content,qab_hit,qab_ip,qab_remove,qab_ref) VALUES(qa_seq.nextval,?,1,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qaboard.getMem_num());
			pstmt.setString(2, qaboard.getQab_title());
			pstmt.setString(3, qaboard.getQab_content());
			pstmt.setInt(4, qaboard.getQab_hit());
			pstmt.setString(5, qaboard.getQab_ip());
			pstmt.setInt(6, qaboard.getQab_remove());
			pstmt.setInt(7, qaboard.getQab_ref());
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	*/
}