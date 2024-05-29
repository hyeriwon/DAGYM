package kr.review.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.review.vo.ReviewVO;
import kr.util.DBUtil;
import kr.util.StringUtil;

public class ReviewDAO {
	//싱글톤 패턴 작성
	private static ReviewDAO instance;
	
	public static ReviewDAO getInstance() {
		return instance;
	}
	
	private ReviewDAO() {}
	
	/*        사용자        */
	//수강후기 등록
	public void insertReview(ReviewVO review) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
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
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
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
				if(keyfield.equals("1")) sub_sql += "WHERE tra_name LIKE '%'|| ? ||'%'";	    //트레이너
				else if(keyfield.equals("2")) sub_sql += "WHERE rev_title LIKE '%'|| ? ||'%'";   //제목
				else if(keyfield.equals("3")) sub_sql += "WHERE rev_content LIKE '%'|| ? ||'%'";//내용
			}
			//SQL문 작성 -> 좋아요 순?
			sql = "SELECT * FROM "
					+ "(SELECT re.*, md1.mem_name, md2.mem_name AS tra_name, sc.sch_date, sc.sch_time, rownum rnum "
					+ "FROM review re "
					+ "JOIN member_detail md1 ON re.mem_num = md1.mem_num "
					+ "JOIN history his ON his.sch_num = re.sch_num "
					+ "JOIN member_detail md2 ON his.tra_num = md2.mem_num "
					+ "JOIN schedule sc ON sc.sch_num = his.sch_num" + sub_sql 
					+ " ORDER BY rev_num DESC) "
					+ "WHERE rnum >= ? AND rnum <= ?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			if(keyword!=null && !"".equals(keyword)) {
				pstmt.setString(++cnt, keyfield);
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
				review.setMem_name(rs.getString("mem_name"));
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
	//수강후기 수정
	//수강후기 삭제	
	//수강후기 상세
	
	/*       강사&관리자     */
	//수강후기 목록(이름 전체) ?
	//수강후기 삭제(게시보류)
}
