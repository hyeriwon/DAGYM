package kr.qaboard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.member.vo.MemberVO;
import kr.qaboard.vo.QABoardVO;
import kr.util.DBUtil;

public class QABoardDAO {
	private static QABoardDAO instance = new QABoardDAO();
	public static QABoardDAO getInstance() {
		return instance;
	}
	private QABoardDAO() {}
	
	/*----------------------------------------------사용자----------------------------------------------*/
	//총 글의 개수, 검색 개수
	public int getInquiryCount(String keyfield, String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;
		try {
			conn = DBUtil.getConnection();
			if(keyword!=null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql += "WHERE qab_title LIKE '%' || ? || '%'";
				else if(keyfield.equals("2")) sub_sql += "WHERE qab_content LIKE '%' || ? || '%'";//이거 검색 가능..?
				//제목만 검색하도록하고 나머지는 필터설정?
			}
			sql = "SELECT count(*) FROM QABoard JOIN member USING(mem_num) " + sub_sql;
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
	//글 목록, 검색 글 목록
	public List<QABoardVO> getInquiryList(int mem_num, int startRow, int endRow, String keyfield, String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<QABoardVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		try {
			if(keyword!=null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql += "WHERE qab_title LIKE '%' || ? || '%'";
				else if(keyfield.equals("2")) sub_sql += "WHERE qab_content LIKE '%' || ? || '%'";//이거 검색 가능..?
				//제목만 검색하도록하고 나머지는 필터설정?
			}
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM qaboard JOIN member USING(mem_num) WHERE mem_num=? " 
					+ sub_sql + " ORDER BY mem_auth DESC)a) WHERE rnum >= ? AND rnum <= ?";
			pstmt = conn.prepareStatement(sql);
			if(keyword!=null && !"".equals(keyword)) {
				pstmt.setString(++cnt, keyword);
			}
			pstmt.setInt(++cnt, mem_num);
			pstmt.setInt(++cnt, startRow);
			pstmt.setInt(++cnt, endRow);
			rs = pstmt.executeQuery();
			list = new ArrayList<QABoardVO>();
			while(rs.next()) {
				QABoardVO qaboardVO = new QABoardVO();
				//내용작성
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally{
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	//질문 등록
	
	//글 상세
	
	//파일 삭제
	
	//글 수정
	
	//글 삭제
	
	/*----------------------------------------------관리자----------------------------------------------*/
	//총 글의 개수, 검색 개수
	public int getAnswerCount(String keyfield, String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;
		try {
			conn = DBUtil.getConnection();
			if(keyword!=null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql += "WHERE qab_title LIKE '%' || ? || '%'";
				else if(keyfield.equals("2")) sub_sql += "WHERE qab_content LIKE '%' || ? || '%'";//이거 검색 가능..?
				//제목만 검색하도록하고 나머지는 필터설정?
			}
			sql = "SELECT count(*) FROM QABoard JOIN member USING(mem_num) " + sub_sql;
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
	//글 목록, 검색 글 목록
	public List<QABoardVO> getAnswerList(int startRow, int endRow, String keyfield, String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<QABoardVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		try {
			if(keyword!=null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql += "WHERE qab_title LIKE '%' || ? || '%'";
				else if(keyfield.equals("2")) sub_sql += "WHERE qab_content LIKE '%' || ? || '%'";//이거 검색 가능..?
				//제목만 검색하도록하고 나머지는 필터설정?
			}
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM qaboard JOIN member USING(mem_num) " 
					+ sub_sql + " ORDER BY mem_auth DESC)a) WHERE rnum >= ? AND rnum <= ?";
			pstmt = conn.prepareStatement(sql);
			if(keyword!=null && !"".equals(keyword)) {
				pstmt.setString(++cnt, keyword);
			}
			pstmt.setInt(++cnt, startRow);
			pstmt.setInt(++cnt, endRow);
			rs = pstmt.executeQuery();
			list = new ArrayList<QABoardVO>();
			while(rs.next()) {
				QABoardVO qaboardVO = new QABoardVO();
				//내용작성
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally{
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	//답변 등록
	
	//글 상세
	
	//글 수정
	
	//글 삭제
}
