package kr.find.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import kr.member.vo.MemberVO;
import kr.util.DBUtil;

public class FindDAO {
	//싱글턴 패턴
	private static FindDAO instance = new FindDAO();
		
	public static FindDAO getInstance() {
		return instance;
	}
	private FindDAO() {}

	//아이디 찾기
	public MemberVO findMemberId(String name,String phone,String email)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberVO member = null;
		String sql = null;
		
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "SELECT mem_id FROM member JOIN member_detail USING(mem_num) "
					+ "WHERE mem_name=? AND mem_phone=? AND mem_email=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setString(1, name);
			pstmt.setString(2, phone);
			pstmt.setString(3, email);
			//SQL문 실행
			rs = pstmt.executeQuery();
			if(rs.next()) {
				member = new MemberVO();
				member.setMem_id(rs.getString("mem_id"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return member;
	}
	
	//비밀번호 찾기
	public MemberVO findMemberPasswd(String name,String id,String email)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberVO member = null;
		String sql = null;
		
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "SELECT mem_pw FROM member JOIN member_detail USING(mem_num) "
					+ "WHERE mem_name=? AND mem_id=? AND mem_email=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setString(1, name);
			pstmt.setString(2, id);
			pstmt.setString(3, email);
			//SQL문 실행
			rs = pstmt.executeQuery();
			if(rs.next()) {
				member = new MemberVO();
				member.setMem_pw(rs.getString("mem_pw"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return member;
	}
	
	//새로운 비밀번호 설정
	public void updateMemberPw(MemberVO member) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			
			//SQL문 작성
			sql = "UPDATE member_detail SET mem_pw = ? WHERE mem_num = (SELECT mem_num FROM member WHERE mem_id = ?)";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setString(1, member.getMem_pw());
			pstmt.setString(2, member.getMem_id());
			//SQL문 실행
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
}
