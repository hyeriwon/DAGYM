package kr.member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
				+ "mem_email,mem_gender,mem_birth,mem_zipcode,mem_address1,mem_address2) "
				+ "VALUES (?,?,?,?,?,?,?,?,?,?)";
			pstmt3 = conn.prepareStatement(sql);
			pstmt3.setInt(1, num);
			pstmt3.setString(2, member.getMem_name());
			pstmt3.setString(3, member.getMem_pw());
			pstmt3.setString(4, member.getMem_phone());
			pstmt3.setString(5, member.getMem_email());
			pstmt3.setInt(6, member.getMem_gender());
			pstmt3.setString(7, member.getMem_birth());
			pstmt3.setString(8, member.getMem_zipcode());
			pstmt3.setString(9, member.getMem_address1());
			pstmt3.setString(10, member.getMem_address2());
			pstmt3.executeUpdate();
			//commit
			conn.commit();
		}catch(Exception e) {
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt3, null);
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(rs, pstmt, conn);
		}
	}
	//ID 중복 체크 및 로그인 처리
	public MemberVO checkMember(String id)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberVO member = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM member LEFT OUTER JOIN member_detail "
					+ "USING(mem_num) WHERE mem_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				member = new MemberVO();
				member.setMem_num(rs.getInt("mem_num"));
				member.setMem_id(rs.getString("mem_id"));
				member.setMem_auth(rs.getInt("mem_auth"));
				member.setMem_pw(rs.getString("mem_pw"));
				member.setMem_photo(rs.getString("mem_photo"));
				member.setMem_email(rs.getString("mem_email"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return member;
	}
	//이메일 중복체크
	public MemberVO checkEmail(String email)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberVO member = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM member_detail WHERE mem_email=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				member = new MemberVO();
				member.setMem_email(rs.getString("mem_email"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return member;
	}
	
	//회원상세 정보
	public MemberVO getMember(int mem_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberVO member = null;
		String sql = null;
		
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "SELECT * FROM member_detail JOIN member USING(mem_num) WHERE mem_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, mem_num);
			//SQL문 실행
			rs = pstmt.executeQuery();
			if(rs.next()) {
				member = new MemberVO();
				member.setMem_num(rs.getInt("mem_num"));
				member.setMem_id(rs.getString("mem_id"));
				member.setMem_pw(rs.getString("mem_pw"));
				member.setMem_auth(rs.getInt("mem_auth"));
				member.setMem_name(rs.getString("mem_name"));				
				member.setMem_phone(rs.getString("mem_phone"));
				member.setMem_email(rs.getString("mem_email"));
				member.setMem_gender(rs.getInt("mem_gender"));
				member.setMem_birth(rs.getString("mem_birth"));
				member.setMem_zipcode(rs.getString("mem_zipcode"));
				member.setMem_address1(rs.getString("mem_address1"));
				member.setMem_address2(rs.getString("mem_address2"));
				member.setMem_photo(rs.getString("mem_photo"));
				member.setMem_reg_date(rs.getDate("mem_reg_date"));
				member.setMem_modify_date(rs.getDate("mem_modify_date"));
				member.setMem_num(rs.getInt("mem_num"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return member;
	}
	//회원정보 수정
	public void updateMember(MemberVO member) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			
			//photo, password 변경 여부 확인
			if(member.getMem_photo()!=null  && !member.getMem_photo().isEmpty()) {
				sub_sql += "mem_photo=?,";
			}
			if(member.getMem_pw()!=null && !member.getMem_pw().isEmpty()) {
				sub_sql += "mem_pw=?,";
			}
			//SQL문 작성
			sql = "UPDATE member_detail SET mem_name=?,"+sub_sql+"mem_phone=?,mem_email=?,"
					+ "mem_gender=?,mem_birth=?,mem_zipcode=?, mem_address1=?, "
					+ "mem_address2=?, mem_modify_date=sysdate WHERE mem_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setString(++cnt, member.getMem_name());
			if(member.getMem_photo()!=null  && !member.getMem_photo().isEmpty()) {
				pstmt.setString(++cnt, member.getMem_photo());
			}
			if(member.getMem_pw()!=null && !member.getMem_pw().isEmpty()) {
				pstmt.setString(++cnt, member.getMem_pw());
			}
			pstmt.setString(++cnt, member.getMem_phone());
			pstmt.setString(++cnt, member.getMem_email());
			pstmt.setInt(++cnt, member.getMem_gender());
			pstmt.setString(++cnt, member.getMem_birth());
			pstmt.setString(++cnt, member.getMem_zipcode());
			pstmt.setString(++cnt, member.getMem_address1());
			pstmt.setString(++cnt, member.getMem_address2());
			pstmt.setInt(++cnt, member.getMem_num());
			//SQL문 실행
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}

	//회원 탈퇴(회원정보 삭제)
	public void deleteMember(int mem_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			
			sql = "UPDATE member SET mem_auth=0 WHERE mem_num=?";
			pstmt1 = conn.prepareStatement(sql);
			pstmt1.setInt(1, mem_num);
			pstmt1.executeUpdate();
			
			sql = "DELETE FROM member_detail WHERE mem_num=?";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, mem_num);
			pstmt2.executeUpdate();
			
			conn.commit();
		}catch(Exception e) {
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(null, pstmt1, conn);
		}
	}
	
	/*-------------------관리자------------------*/
	//전체 내용 개수, 검색 내용 개수
	public int getMemberCountByAdmin(String keyfield, String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;
		try {
			conn = DBUtil.getConnection();
			if(keyword!=null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql += "WHERE mem_name LIKE '%' || ? || '%'";
				else if(keyfield.equals("2")) sub_sql += "WHERE mem_id LIKE '%' || ? || '%'";
			}
			sql = "SELECT COUNT(*) FROM member LEFT OUTER JOIN member_detail USING(mem_num) " + sub_sql;
			pstmt = conn.prepareStatement(sql);
			if(keyword!=null && !"".equals(keyword)) {
				pstmt.setString(1, keyword);
			}
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
	//관리자 - 회원 목록, 검색 목록
	public List<MemberVO> getListMemberByAdmin(int start, int end, String keyfield, String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<MemberVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		try {
			conn = DBUtil.getConnection();
			if(keyword!=null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql += "AND mem_name LIKE '%' || ? || '%'";
				else if(keyfield.equals("2")) sub_sql += "AND mem_id LIKE '%' || ? || '%'";
			}
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM member LEFT OUTER JOIN member_detail USING(mem_num) WHERE mem_auth !=8 AND mem_auth!=9 " 
					+ sub_sql + " ORDER BY mem_auth DESC)a) WHERE rnum >= ? AND rnum <= ?";
			pstmt = conn.prepareStatement(sql);
			if(keyword!=null && !"".equals(keyword)) {
				pstmt.setString(++cnt, keyword);
			}
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			rs = pstmt.executeQuery();
			list = new ArrayList<MemberVO>();
			while(rs.next()) {
				MemberVO member = new MemberVO();
				member.setMem_num(rs.getInt("mem_num"));
				member.setMem_id(rs.getString("mem_id"));
				member.setMem_auth(rs.getInt("mem_auth"));
				member.setMem_name(rs.getString("mem_name"));
				member.setMem_phone(rs.getString("mem_phone"));
				member.setMem_birth(rs.getString("mem_birth"));
				member.setMem_reg_date(rs.getDate("mem_reg_date"));
				
				list.add(member);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	//관리자 - 트레이너 목록, 검색 목록
	public List<MemberVO> getListTrainerByAdmin(int start, int end, String keyfield, String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<MemberVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		try {
			conn = DBUtil.getConnection();
			if(keyword!=null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql += "AND mem_name LIKE '%' || ? || '%'";
				else if(keyfield.equals("2")) sub_sql += "AND mem_id LIKE '%' || ? || '%'";
			}
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM member LEFT OUTER JOIN member_detail USING(mem_num) WHERE mem_auth >= 8 " 
					+ sub_sql + " ORDER BY mem_auth)a) WHERE rnum >= ? AND rnum <= ?";
			pstmt = conn.prepareStatement(sql);
			if(keyword!=null && !"".equals(keyword)) {
				pstmt.setString(++cnt, keyword);
			}
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			rs = pstmt.executeQuery();
			list = new ArrayList<MemberVO>();
			while(rs.next()) {
				MemberVO member = new MemberVO();
				member.setMem_num(rs.getInt("mem_num"));
				member.setMem_id(rs.getString("mem_id"));
				member.setMem_auth(rs.getInt("mem_auth"));
				member.setMem_name(rs.getString("mem_name"));
				member.setMem_birth(rs.getString("mem_birth"));
				member.setMem_phone(rs.getString("mem_phone"));
				member.setMem_reg_date(rs.getDate("mem_reg_date"));
				
				list.add(member);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	//관리자 - 회원등급 수정
	public void updateMemberByAdmin(int mem_auth, int mem_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			sql = "UPDATE member SET mem_auth=? WHERE mem_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mem_auth);
			pstmt.setInt(2, mem_num);
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//강사 - 회원 목록, 검색 목록
}
