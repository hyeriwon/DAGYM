package kr.review.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.review.vo.RevLikeVO;
import kr.review.vo.ReviewVO;
import kr.util.DBUtil;
import kr.util.StringUtil;

public class ReviewDAO {
	//싱글톤 패턴 작성
	private static ReviewDAO instance = new ReviewDAO();
	
	public static ReviewDAO getInstance() {
		return instance;
	}
	
	private ReviewDAO() {}
	
	/*        사용자        */
	//수강후기 등록
	public void insertReview(ReviewVO review) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		String sql = null;
		
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			
			//SQL문 작성
			sql = "INSERT INTO review(rev_num,mem_num,sch_num,rev_grade,rev_title,"
					+ "rev_content,rev_filename1,rev_filename2,rev_ip) "
					+ "VALUES (review_seq.nextval,?,?,?,?,?,?,?,?)";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, review.getMem_num());
			pstmt.setInt(2, review.getSch_num());
			pstmt.setInt(3, review.getRev_grade());
			pstmt.setString(4, review.getRev_title());
			pstmt.setString(5, review.getRev_content());
			pstmt.setString(6, review.getRev_filename1());
			pstmt.setString(7, review.getRev_filename2());
			pstmt.setString(8, review.getRev_ip());
			//SQL문 실행
			pstmt.executeUpdate();
			
			//포인트 추가
			
			conn.commit();
		}catch(Exception e) {
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//수강후기 개수, 검색 개수
	public int getReviewCount(String keyfield,String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;
		
		try {
			conn = DBUtil.getConnection();
			//sub_sql문 작성
			if(keyword!=null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql += "WHERE tra_name LIKE '%'|| ? ||'%'";	    //트레이너
				else if(keyfield.equals("2")) sub_sql += "WHERE rev_title LIKE '%'|| ? ||'%'";   //제목
				else if(keyfield.equals("3")) sub_sql += "WHERE rev_content LIKE '%'|| ? ||'%'";//내용
			}
			//SQL문 작성
			sql = "SELECT COUNT(*) FROM review re "
					+ "JOIN history his ON his.sch_num = re.sch_num "
					+ "JOIN member_detail md2 ON his.tra_num = md2.mem_num "+sub_sql;
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
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
	//수강후기 목록(전체), 수강후기 검색 목록
	public List<ReviewVO> getListReview(int start,int end,String keyfield,String keyword) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ReviewVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt=0;
		
		try {
			conn = DBUtil.getConnection();
			//sub_sql문 작성
			if(keyword!=null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql += "WHERE md.mem_name LIKE '%'|| ? ||'%'";	    //트레이너
				else if(keyfield.equals("2")) sub_sql += "WHERE rev_title LIKE '%'|| ? ||'%'";   //제목
				else if(keyfield.equals("3")) sub_sql += "WHERE rev_content LIKE '%'|| ? ||'%'";//내용
			}
			//SQL문 작성 -> 좋아요 순?
			sql = "SELECT * FROM "
					+ "(SELECT re.*, mb.mem_id, md.mem_name AS tra_name, sc.sch_date, sc.sch_time, rownum rnum "
					+ "FROM review re "
					+ "JOIN member mb ON re.mem_num = mb.mem_num "
					+ "JOIN history his ON his.sch_num = re.sch_num "
					+ "JOIN member_detail md ON his.tra_num = md.mem_num "
					+ "JOIN schedule sc ON sc.sch_num = his.sch_num " + sub_sql 
					+ " ORDER BY rev_num DESC) "
					+ "WHERE rnum >= ? AND rnum <= ?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			if(keyword!=null && !"".equals(keyword)) {
				pstmt.setString(++cnt, keyword);
			}
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			//SQL문 실행
			rs = pstmt.executeQuery();
			list = new ArrayList<ReviewVO>();
			while(rs.next()) {
				ReviewVO review = new ReviewVO();
				review.setRev_num(rs.getInt("rev_num"));
				review.setRev_reg_date(rs.getDate("rev_reg_date"));
				review.setRev_title(StringUtil.useNoHTML(rs.getString("rev_title")));
				review.setTra_name(rs.getString("tra_name"));
				review.setMem_id(rs.getString("mem_id"));
				review.setRev_grade(rs.getInt("rev_grade"));
				review.setRev_hit(rs.getInt("rev_hit"));
				review.setSch_date(rs.getString("sch_date")+" "+rs.getString("sch_time"));
				
				list.add(review);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	
	//수강후기 조회수 증가
	public void updateReadCount(int rev_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "UPDATE review SET rev_hit=rev_hit+1 WHERE rev_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rev_num);
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
	}
	//수강후기 상세
	public ReviewVO getReview(int rev_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ReviewVO review = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM review WHERE rev_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rev_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				review = new ReviewVO();
				review.setRev_num(rs.getInt("rev_num"));
				review.setRev_title(rs.getString("rev_title"));
				review.setMem_num(rs.getInt("mem_num"));
				review.setSch_num(rs.getInt("sch_num"));
				review.setRev_grade(rs.getInt("rev_grade"));
				review.setRev_content(rs.getString("rev_content"));
				review.setRev_filename1(rs.getString("rev_filename1"));
				review.setRev_filename2(rs.getString("rev_filename2"));
				review.setRev_hit(rs.getInt("rev_hit"));
				review.setRev_like(rs.getInt("rev_like"));
				review.setRev_reg_date(rs.getDate("rev_reg_date"));
				review.setRev_modify_date(rs.getDate("rev_modify_date"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return review;
	}
	
	//수강후기 작성여부 확인
	public boolean checkReview(int sch_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM review WHERE sch_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sch_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
			return false;
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);;
		}
	}
	
	//수강후기 수정
	public void updateReview(ReviewVO review) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		
		try {
			conn = DBUtil.getConnection();
			
			if(review.getRev_filename1()!=null && !"".equals(review.getRev_filename1())) {
				sub_sql += "rev_filename1=?,";
			}
			if(review.getRev_fileExist1()==0) {
				sub_sql += "rev_filename1=null,";
			}
			if(review.getRev_filename2()!=null && !"".equals(review.getRev_filename2())) {
				sub_sql += "rev_filename2=?,";
			}
			if(review.getRev_fileExist2()==0) {
				sub_sql += "rev_filename2=null,";
			}
			sql = "UPDATE review SET rev_title=?,rev_grade=?,"+sub_sql
				  + "rev_content=?,rev_modify_date=sysdate WHERE rev_num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(++cnt, review.getRev_title());
			pstmt.setInt(++cnt, review.getRev_grade());
			if(review.getRev_filename1()!=null && !"".equals(review.getRev_filename1())) {
				pstmt.setString(++cnt, review.getRev_filename1());
			}
			if(review.getRev_filename2()!=null && !"".equals(review.getRev_filename2())) {
				pstmt.setString(++cnt, review.getRev_filename2());
			}
			pstmt.setString(++cnt, review.getRev_content());
			pstmt.setInt(++cnt, review.getRev_num());
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//수강후기 삭제	
	public void deleteReview(ReviewVO review) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			
			sql = "DELETE FROM review WHERE rev_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, review.getRev_num());
			pstmt.executeUpdate();
			
			//좋아요 삭제
			
			//포인트 차감
			
			conn.commit();
		}catch(Exception e) {
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//수강후기 좋아요 수
	public void countReviewLikes(int rev_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			
			sql = "SELECT COUNT(*) FROM review_like WHERE rev_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rev_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
			sql = "UPDATE review SET rev_like=? WHERE rev_num=?";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, count);
			pstmt2.setInt(2, rev_num);
			pstmt2.executeUpdate();
			
			conn.commit();
		}catch(Exception e) {
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
	}
	
	//수강후기 좋아요 여부 확인
	public RevLikeVO getRevLike(RevLikeVO revLike) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		RevLikeVO like = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM review_like WHERE rev_num=? AND mem_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, revLike.getRev_num());
			pstmt.setInt(2, revLike.getMem_num());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				like = new RevLikeVO();
				like.setRev_num(rs.getInt("rev_num"));
				like.setMem_num(rs.getInt("mem_num"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return like;
	}
	
	//수강후기 좋아요 등록
	public void insertLike(RevLikeVO revLike) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			
			sql = "INSERT INTO review_like(rev_num,mem_num) VALUES (?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, revLike.getRev_num());
			pstmt.setInt(2, revLike.getMem_num());
			pstmt.executeUpdate();
			
			sql = "UPDATE review SET rev_like=rev_like+1 WHERE rev_num=?";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, revLike.getRev_num());
			pstmt2.executeUpdate();
			
			conn.commit();
		}catch(Exception e) {
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, null);
			DBUtil.executeClose(null, pstmt2, conn);
		}
	}
	
	//수강후기 좋아요 취소
	public void deleteLike(RevLikeVO revLike) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			
			sql = "DELETE FROM review_like WHERE rev_num=?,mem_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, revLike.getRev_num());
			pstmt.setInt(2, revLike.getMem_num());
			pstmt.executeUpdate();
			
			sql = "UPDATE review SET rev_like=rev_like-1 WHERE rev_num=?";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, revLike.getRev_num());
			pstmt2.executeUpdate();
			
			conn.commit();
		}catch(Exception e) {
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	/*       관리자        */
	//수강후기 삭제(게시보류)
}
