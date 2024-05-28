package kr.payment.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import kr.payment.dao.PaymentDAO;
import kr.payment.vo.PaymentVO;
import kr.qaboard.vo.QABoardVO;
import kr.util.DBUtil;

public class PaymentDAO {
	//싱글턴 패턴
	private static PaymentDAO instance = new PaymentDAO();

	public static PaymentDAO getInstance() {
		return instance;
	}
	private PaymentDAO () {}
	
	//회원권상담신청
	public void membershipCounseling(QABoardVO qaboard)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			sql = "INSERT INTO qaboard (qab_num,mem_num,qab_type,qab_title,qab_content,qab_ip,qab_remove,qab_ref) VALUES(qaboard_seq.nextval,?,4,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qaboard.getMem_num());
			pstmt.setString(2, qaboard.getQab_title());
			pstmt.setString(3, qaboard.getQab_content());
			pstmt.setString(4, qaboard.getQab_ip());
			pstmt.setInt(5, qaboard.getQab_remove());
			pstmt.setInt(6, qaboard.getQab_ref());
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//회원권 등록(관리자)
	public void insertMembership(PaymentVO payment)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			
			sql = "INSERT INTO payment (pay_num,pay_fee,pay_enroll) VALUES (payment_seq.nextval,?,?) WHERE mem_num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, payment.getPay_fee());
			pstmt.setInt(2, payment.getPay_enroll());
			pstmt.setInt(3, payment.getMem_num());
			
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//회원권 결제내역
	
	
	//회원권 등록 횟수 계산
	
}