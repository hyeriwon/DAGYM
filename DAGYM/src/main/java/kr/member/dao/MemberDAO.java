package kr.member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import kr.member.vo.MemberVO;
import kr.util.DBUtil;

public class MemberDAO {
	//싱글턴 패턴
	private static MemberDAO instance = new MemberDAO();
	
	public static MemberDAO getInstance() {
		return instance;
	}
	private MemberDAO() {}
	
	/*-------------------사용자------------------*/
	
	//회원가입
	public void insertMember(MemberVO member)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		ResultSet rs = null;
		String sql = null;
		int num = 0;
		try {
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			//회원번호(mem_num) 생성
			sql = "SELECT member_seq.nextval FROM dual";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				num = rs.getInt(1);
			}
			sql = "INSERT INTO member (mem_num,mem_id) VALUES (?,?)";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, num);
			pstmt2.setString(2, member.getMem_id());
			pstmt2.executeUpdate();
			sql = "INSERT INTO member_detail (mem_num,mem_name,mem_pw,mem_phone,"
				+ "mem_email,mem_gender,mem_birth,mem_zipcode,mem_address1,mem_address2,"
				+ "mem_reg_date,mem_modify_date) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt3 = conn.prepareStatement(sql);
			pstmt3.setInt(1, num);
			pstmt3.setString(2, member.getMem_name());
			pstmt.setString(3, member.getMem_pw());
			pstmt.setString(4, member.getMem_phone());
			pstmt.setString(5, member.getMem_email());
			pstmt.setString(6, member.getMem_gender());
			pstmt.setString(7, member.getMem_birth());
			pstmt.setString(8, member.getMem_zipcode());
			pstmt.setString(9, member.getMem_address1());
			pstmt.setString(10, member.getMem_address2());
			pstmt.setDate(11, member.getMem_reg_date());
			pstmt.setDate(12, member.getMem_modify_date());
			//commit
			conn.commit();
		}catch(Exception e) {
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt3, null);
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(rs, pstmt3, conn);
		}
	}
	//ID 중복 체크 및 로그인 처리
	
	//회원상세 정보
	
	//회원정보 수정
	
	//비밀번호 수정
	
	//프로필 사진 수정
	
	//회원 탈퇴(회원정보 삭제)
	
	/*-------------------관리자------------------*/
	//전체 내용 개수, 검색 내용 개수
	
	//목록, 검색 목록
	
	//회원등급 수정
	
}
