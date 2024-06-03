package kr.qaboard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.qaboard.vo.QABoardVO;
import kr.util.DBUtil;
import kr.util.StringUtil;

public class QABoardDAO {
	private static QABoardDAO instance = new QABoardDAO();
	public static QABoardDAO getInstance() {
		return instance;
	}
	private QABoardDAO() {}
	
	/*--------------------사용자--------------------*/
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
				else if(keyfield.equals("3")) sub_sql += "WHERE qab_title LIKE '%' || ? || '%' OR qab_content LIKE '%' || ? || '%'";
				//제목만 검색하도록하고 나머지는 필터설정?
			}
			/* 필터링, 인자에 String qabtype 추가
			 if(qabtype!=null && !"".equals(qabtype)) {
				if(qabtype.equals("1")) sub_sql += "AND qab_type = ?";
			 }
			*/
			
			sql = "SELECT count(*) FROM qaboard JOIN member USING(mem_num) " + sub_sql;
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
	public List<QABoardVO> getInquiryList(int mem_num, int startRow, int endRow)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<QABoardVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		try {
			conn = DBUtil.getConnection();
			
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT q.qab_num, q.mem_num, q.qab_type,q.qab_title, "
				+ "q.qab_content, q.qab_reg_date, a.qab_ref,m.mem_id,q.qab_remove FROM qaboard q LEFT OUTER JOIN "
				+ "qaboard a ON q.qab_num = a.qab_ref JOIN member m ON q.mem_num = m.mem_num WHERE m.mem_num=? AND q.qab_remove=0 "
				+ "AND q.qab_ref=0 ORDER BY q.qab_reg_date DESC) a) WHERE rnum >= ? AND rnum <= ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(++cnt, mem_num);
			pstmt.setInt(++cnt, startRow);
			pstmt.setInt(++cnt, endRow);
			rs = pstmt.executeQuery();
			list = new ArrayList<QABoardVO>();
			while(rs.next()) {
				QABoardVO qaboard = new QABoardVO();
				qaboard.setMem_num(rs.getInt("mem_num"));
				qaboard.setQab_title(rs.getString("qab_title"));
				qaboard.setMem_id(rs.getString("mem_id"));
				qaboard.setQab_reg_date(rs.getDate("qab_reg_date"));
				qaboard.setQab_ref(rs.getInt("qab_ref"));
				qaboard.setQab_type(rs.getInt("qab_type"));
				qaboard.setQab_num(rs.getInt("qab_num"));
				list.add(qaboard);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally{
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	//문의글 등록
	public void insertInquiryBoard(QABoardVO qaboard)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			sql = "INSERT INTO qaboard (qab_num,qab_type,qab_title,qab_content,qab_filename,qab_ip,mem_num) VALUES (qaboard_seq.nextval,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qaboard.getQab_type());
			pstmt.setString(2, qaboard.getQab_title());
			pstmt.setString(3, qaboard.getQab_content());
			pstmt.setString(4, qaboard.getQab_filename());
			pstmt.setString(5, qaboard.getQab_ip());
			pstmt.setInt(6, qaboard.getMem_num());
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//글 상세
	public QABoardVO getUserBoard(int qab_num, int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		QABoardVO qaboard = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM qaboard WHERE qab_num=? AND mem_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qab_num);
			pstmt.setInt(2, mem_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				qaboard = new QABoardVO();
				qaboard.setMem_num(rs.getInt("mem_num"));
				qaboard.setQab_type(rs.getInt("qab_type"));
				qaboard.setQab_title(rs.getString("qab_title"));
				qaboard.setQab_content(rs.getString("qab_content"));
				qaboard.setQab_filename(rs.getString("qab_filename"));
				qaboard.setQab_reg_date(rs.getDate("qab_reg_date"));
				qaboard.setQab_modify_date(rs.getDate("qab_modify_date"));
				qaboard.setQab_num(rs.getInt("qab_num"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return qaboard;
	}
	//파일 삭제
	public void deleteFile(int qaboard_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			sql = "UPDATE qaboard SET qab_filename='' WHERE qab_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qaboard_num);
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//글 수정
	public void updateUserBoard(QABoardVO qaboard)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		try {
			conn = DBUtil.getConnection();
			if(qaboard.getQab_filename()!=null&&"".equals(qaboard.getQab_filename())) {
				sub_sql =",qab_filename=?";
			}
			sql = "UPDATE qaboard SET qab_type=?,qab_title=?,qab_content=?,qab_ip=?,qab_modify_date=SYSDATE" + sub_sql + " WHERE qab_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(++cnt, qaboard.getQab_type());
			pstmt.setString(++cnt, qaboard.getQab_title());
			pstmt.setString(++cnt, qaboard.getQab_content());
			pstmt.setString(++cnt, qaboard.getQab_ip());
			if(qaboard.getQab_filename()!=null&&"".equals(qaboard.getQab_filename())) {
				pstmt.setString(++cnt, qaboard.getQab_filename());
			}
			pstmt.setInt(++cnt, qaboard.getQab_num());
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//글 삭제
	public void deleteUserBoard(int qab_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			sql = "UPDATE qaboard SET qab_remove=? WHERE qab_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, 1);
			pstmt.setInt(2, qab_num);
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	/*--------------------관리자--------------------*/
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
				if(keyfield.equals("1")) sub_sql += "WHERE mem_id LIKE '%' || ? || '%'";
				else if(keyfield.equals("2")) sub_sql += "WHERE qab_title LIKE '%' || ? || '%'";
				else if(keyfield.equals("3")) sub_sql += "WHERE qab_content LIKE '%' || ? || '%'";
			}
			sql = "SELECT count(*) FROM qaboard JOIN member USING(mem_num) " + sub_sql;
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
			conn = DBUtil.getConnection();
			if(keyword!=null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql += "AND m.mem_id LIKE '%' || ? || '%'";
				else if(keyfield.equals("2")) sub_sql += "AND q.qab_title LIKE '%' || ? || '%'";
				else if(keyfield.equals("3")) sub_sql += "AND q.qab_content LIKE '%' || ? || '%'";
			}
			
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT q.qab_num, q.mem_num, q.qab_type,q.qab_title, q.qab_content, "
				+ "q.qab_reg_date, a.qab_ref,m.mem_id,q.qab_remove FROM qaboard q LEFT OUTER JOIN qaboard a ON q.qab_num = a.qab_ref "
				+ "JOIN member m ON q.mem_num = m.mem_num WHERE q.qab_ref = 0 "
				+ sub_sql + "ORDER BY q.qab_reg_date DESC) a) WHERE rnum >= ? AND rnum <= ?";
			pstmt = conn.prepareStatement(sql);
			if(keyword!=null && !"".equals(keyword)) {
				pstmt.setString(++cnt, keyword);
			}
			pstmt.setInt(++cnt, startRow);
			pstmt.setInt(++cnt, endRow);
			//SQL문 작성
			rs = pstmt.executeQuery();
			list = new ArrayList<QABoardVO>();
			while(rs.next()) {
				QABoardVO qaboard = new QABoardVO();
				qaboard.setQab_num(rs.getInt("qab_num"));
				qaboard.setQab_title(StringUtil.useNoHTML(rs.getString("qab_title")));
				qaboard.setMem_id(rs.getString("mem_id"));
				qaboard.setQab_reg_date(rs.getDate("qab_reg_date"));
				qaboard.setQab_type(rs.getInt("qab_type"));
				qaboard.setQab_ref(rs.getInt("qab_ref"));
				qaboard.setQab_remove(rs.getInt("qab_remove"));
				
				list.add(qaboard);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally{
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}

	//글 상세
	public QABoardVO getUserBoardByAdmin(int qab_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		QABoardVO qaboard = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM qaboard JOIN member USING (mem_num) LEFT OUTER JOIN member_detail USING(mem_num) WHERE qab_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qab_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				qaboard = new QABoardVO();
				qaboard.setMem_num(rs.getInt("mem_num"));
				qaboard.setQab_type(rs.getInt("qab_type"));
				qaboard.setMem_id(rs.getString("mem_id"));
				qaboard.setQab_title(rs.getString("qab_title"));
				qaboard.setQab_content(rs.getString("qab_content"));
				qaboard.setQab_filename(rs.getString("qab_filename"));
				qaboard.setQab_reg_date(rs.getDate("qab_reg_date"));
				qaboard.setQab_modify_date(rs.getDate("qab_modify_date"));
				qaboard.setQab_num(rs.getInt("qab_num"));
				qaboard.setMem_photo(rs.getString("mem_photo"));
				qaboard.setMem_photo(rs.getString("mem_photo"));
				qaboard.setQab_ref(rs.getInt("qab_ref"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return qaboard;
	}
	//답변 등록
	public void insertAnswerBoard(QABoardVO qaboard)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			sql = "INSERT INTO qaboard (qab_num,mem_num,qab_type,qab_content,qab_ip,qab_ref) VALUES (qaboard_seq.nextval,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qaboard.getMem_num());
			pstmt.setInt(2, qaboard.getQab_type());
			pstmt.setString(3, qaboard.getQab_content());
			pstmt.setString(4, qaboard.getQab_ip());
			pstmt.setInt(5, qaboard.getQab_ref());//댓글의 부모 번호
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//답변상세
	public QABoardVO getAdminBoard(int qab_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		QABoardVO qaboard = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM qaboard WHERE qab_ref=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qab_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				qaboard = new QABoardVO();
				qaboard.setMem_num(rs.getInt("mem_num"));
				qaboard.setQab_type(rs.getInt("qab_type"));
				qaboard.setQab_content(rs.getString("qab_content"));
				qaboard.setQab_reg_date(rs.getDate("qab_reg_date"));
				qaboard.setQab_modify_date(rs.getDate("qab_modify_date"));
				qaboard.setQab_num(rs.getInt("qab_num"));
				qaboard.setQab_ref(rs.getInt("qab_ref"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return qaboard;
	}
	//답변수정
	public void updateAdminBoard(QABoardVO qaboard)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			sql = "UPDATE qaboard SET mem_num=?,qab_content=?,qab_ip=?,qab_modify_date=SYSDATE WHERE qab_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qaboard.getMem_num());
			pstmt.setString(2, qaboard.getQab_content());
			pstmt.setString(3, qaboard.getQab_ip());
			pstmt.setInt(4, qaboard.getQab_num());
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//답변삭제
	public void deleteAdminBoard(int qab_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			sql = "DELETE FROM qaboard WHERE qab_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qab_num);
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
}
