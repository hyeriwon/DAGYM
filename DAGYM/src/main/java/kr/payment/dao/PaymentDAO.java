package kr.payment.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.member.vo.MemberVO;
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
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "INSERT INTO qaboard (qab_num,mem_num,qab_type,qab_title,qab_content,qab_ip,qab_remove,qab_ref) VALUES(qaboard_seq.nextval,?,4,?,?,?,?,?)";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, qaboard.getMem_num());
			pstmt.setString(2, qaboard.getQab_title());
			pstmt.setString(3, qaboard.getQab_content());
			pstmt.setString(4, qaboard.getQab_ip());
			pstmt.setInt(5, qaboard.getQab_remove());
			pstmt.setInt(6, qaboard.getQab_ref());
			//SQL문 실행
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//회원 목록 개수(관리자)
	public int getMemberCountPayment(String keyfield,String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//검색처리
			if(keyword!=null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql += "WHERE mem_name LIKE '%' || ? || '%'";
				else if(keyfield.equals("2")) sub_sql += "WHERE mem_id LIKE '%' || ? || '%'";
			}
			//SQL문 작성
			sql = "SELECT COUNT(*) FROM member LEFT OUTER JOIN member_detail USING(mem_num) " + sub_sql;
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			if(keyword!=null && !"".equals(keyword)) {
				pstmt.setString(1, keyword);
			}
			//SQL문 실행
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return count;
	}
	
	//회원 목록, 검색 목록(관리자)
	public List<MemberVO> getListMemberPayment(int start, int end, String keyfield, String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<MemberVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//검색처리
			if(keyword!=null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql += "AND mem_name LIKE '%' || ? || '%'";
				else if(keyfield.equals("2")) sub_sql += "AND mem_id LIKE '%' || ? || '%'";
			}
			//SQL문 작성
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM member LEFT OUTER JOIN member_detail USING(mem_num) WHERE mem_auth !=8 AND mem_auth!=9 " 
					+ sub_sql + " ORDER BY mem_auth DESC)a) WHERE rnum >= ? AND rnum <= ?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			if(keyword!=null && !"".equals(keyword)) {
				pstmt.setString(++cnt, keyword);
			}
			//?에 데이터 바인딩
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			//SQL문 실행
			rs = pstmt.executeQuery();
			list = new ArrayList<MemberVO>();
			while(rs.next()) {
				MemberVO member = new MemberVO();
				member.setMem_num(rs.getInt("mem_num"));
				member.setMem_id(rs.getString("mem_id"));
				member.setMem_name(rs.getString("mem_name"));
				member.setMem_phone(rs.getString("mem_phone"));

				list.add(member);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	
	//회원별 회원권 결제내역 총 개수(회원상세)
	public int getPayMemCount(int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "SELECT COUNT(*) FROM payment WHERE mem_num=? ";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, mem_num);
			//SQL문 실행
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return count;
	}
	
	//회원상세(회원권 결제내역)
	public List<PaymentVO>getPayMemList(int mem_num,int start,int end)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<PaymentVO>list = null;
		String sql = null;
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			
			//SQL문 작성
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM "
					+ "(SELECT mem_num,mem_name,pay_num,pay_fee,pay_enroll,pay_reg_date,pay_status,"
					+ "CASE WHEN pay_enroll = 10 THEN ADD_MONTHS(pay_reg_date,5) "
					+ "WHEN pay_enroll = 20 THEN ADD_MONTHS(pay_reg_date,10) "
					+ "WHEN pay_enroll = 30 THEN ADD_MONTHS(pay_reg_date,18) "
					+ "END pay_exp FROM payment JOIN member_detail "
					+ "USING(mem_num) ORDER BY pay_num DESC)a) "
					+ "WHERE mem_num=? AND rnum >= ? AND rnum <= ?";
			
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, mem_num);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			//SQL문 실행
			rs = pstmt.executeQuery();
			list = new ArrayList<PaymentVO>();
			while(rs.next()) {
				PaymentVO payment = new PaymentVO();
				payment.setMem_num(rs.getInt("mem_num"));
				payment.setPay_num(rs.getInt("pay_num"));
				payment.setPay_fee(rs.getInt("pay_fee"));
				payment.setPay_enroll(rs.getInt("pay_enroll"));
				payment.setPay_reg_date(rs.getDate("pay_reg_date"));
				payment.setPay_exp(rs.getDate("pay_exp"));
				payment.setMem_name(rs.getString("mem_name"));
				payment.setPay_status(rs.getInt("pay_status"));
				
				list.add(payment);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	
	//회원 이름
	public String getMemberName(int mem_num) throws Exception {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String mem_name = null;
	    try {
	        conn = DBUtil.getConnection();
	        String sql = "SELECT mem_name FROM member_detail WHERE mem_num=?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, mem_num);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            mem_name = rs.getString("mem_name");
	        }
	    } catch (Exception e) {
	        throw new Exception(e);
	    } finally {
	        DBUtil.executeClose(rs, pstmt, conn);
	    }
	    return mem_name;
	}
	
	//보유한 회원권 계산 (남은 회원권)
	public int remainpayment(int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		int remain = 0;
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "SELECT (COALESCE(SUM(p.pay_enroll), 0) - COALESCE((SELECT COUNT(*) FROM history h "
					+ "WHERE h.mem_num = p.mem_num AND h.his_status = 2), 0)) AS result FROM payment p WHERE p.mem_num = ? AND p.pay_status = 0 "
					+ "GROUP BY p.mem_num";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, mem_num);
			//SQL문 실행
			rs = pstmt.executeQuery();
			if(rs.next()) {
				remain = rs.getInt(1);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return remain;
	}
	
	//회원권 등록(관리자)
		public void insertMembership(PaymentVO payment)throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				//커넥션 풀로부터 커넥션 할당
				conn = DBUtil.getConnection();
				//SQL문 작성
				sql = "INSERT INTO payment (pay_num, pay_fee, pay_enroll, mem_num) VALUES (payment_seq.nextval, ?, ?, ?)";
				//PreparedStatement 객체 생성
				pstmt = conn.prepareStatement(sql);
				//?에 데이터 바인딩
				pstmt.setInt(1, payment.getPay_fee());
				pstmt.setInt(2, payment.getPay_enroll());
				pstmt.setInt(3, payment.getMem_num());
				//SQL문 실행
				pstmt.executeUpdate();
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(null, pstmt, conn);
			}
		}
	
	//회원권 결제취소(관리자)
		public void updateMembership(int pay_num)throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				//커넥션 풀로부터 커넥션 할당
				conn = DBUtil.getConnection();
				//SQL문 작성
				sql = "UPDATE payment SET pay_status = 1 WHERE pay_num = ?";
				//PreparedStatement 객체 생성
				pstmt = conn.prepareStatement(sql);
				//?에 데이터 바인딩
				pstmt.setInt(1, pay_num);
				//SQL문 실행
				pstmt.executeUpdate();
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(null, pstmt, conn);
			}
		}
		
		//만료한 회원권 업데이트
		public void updateExpMembership(int mem_num)throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				//커넥션풀로부터 커넥션 할당
				conn = DBUtil.getConnection();
				//SQL문 작성
				 sql = "UPDATE payment "
			                + "SET pay_enroll = 0, pay_status = 2 "
			                + "WHERE mem_num = ? AND CASE "
			                + "WHEN pay_enroll = 10 THEN ADD_MONTHS(pay_reg_date, 5) "
			                + "WHEN pay_enroll = 20 THEN ADD_MONTHS(pay_reg_date, 10) "
			                + "WHEN pay_enroll = 30 THEN ADD_MONTHS(pay_reg_date, 18) "
			                + "END < SYSDATE AND pay_status = 0";
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setInt(1, mem_num);
				 pstmt.executeUpdate();
				
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(null, pstmt, conn);
			}
		}
}