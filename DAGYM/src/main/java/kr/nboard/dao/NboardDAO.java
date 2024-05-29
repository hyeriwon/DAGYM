package kr.nboard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.nboard.vo.NboardVO;
import kr.util.DBUtil;
import kr.util.StringUtil;

public class NboardDAO {
	//싱글턴 패턴
	private static NboardDAO instance = new NboardDAO();
	
	public static NboardDAO getInstance() {
		return instance;
	}
	private NboardDAO() {}
	
	//공지사항 등록
	public void insertNboard(NboardVO nboard)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "INSERT INTO nboard (nbo_num,mem_num,nbo_title,nbo_content,nbo_filename) VALUES (nboard_seq.nextval,?,?,?,?)";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, nboard.getMem_num());
			pstmt.setString(2, nboard.getNbo_title());
			pstmt.setString(3, nboard.getNbo_content());
			pstmt.setString(4, nboard.getNbo_filename());
			//SQL문 실행
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//총 글의 개수, 검색 개수
	public int getNboardCount(String keyfield,String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			
			if(keyword!=null && !"".equals(keyword)) {
				//검색처리
				if(keyfield.equals("1")) sub_sql += "WHERE nbo_title LIKE '%' || ? || '%'";
				else if(keyfield.equals("2")) sub_sql += "WHERE nbo_content LIKE '%' || ? || '%'";
			}
			
			//SQL문 작성
			sql = "SELECT COUNT(*) FROM nboard JOIN member USING(mem_num) " + sub_sql;
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
	//글 목록, 검색 글 목록
	public List<NboardVO> getListNboard(int start,int end,String keyfield,String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<NboardVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			
			if(keyword!=null && !"".equals(keyword)) {
				//검색처리
				if(keyfield.equals("1")) sub_sql += "WHERE nbo_title LIKE '%' || ? || '%'";
				else if(keyfield.equals("2")) sub_sql += "WHERE nbo_content LIKE '%' || ? || '%'";
			}
			//SQL문 작성
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM "
					+ "(SELECT * FROM nboard JOIN member USING(mem_num) " + sub_sql + 
					"ORDER BY nbo_num DESC)a) WHERE rnum >= ? AND rnum <= ?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			if(keyword!=null && !"".equals(keyword)) {
				pstmt.setString(++cnt, keyword);
			}
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			//SQL문 실행
			rs = pstmt.executeQuery();
			list = new ArrayList<NboardVO>();
			while(rs.next()) {
				NboardVO nboard = new NboardVO();
				nboard.setNbo_num(rs.getInt("nbo_num"));
				nboard.setNbo_title(StringUtil.useNoHTML(rs.getString("nbo_title")));
				nboard.setNbo_hit(rs.getInt("nbo_hit"));
				nboard.setNbo_reg_date(rs.getDate("nbo_reg_date"));
				nboard.setMem_num(rs.getInt("mem_num"));
				
				list.add(nboard);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	//글 상세
	
	//조회수 증가
	
	//파일 삭제
	
	//글 수정
	
	//글 삭제
	
}
