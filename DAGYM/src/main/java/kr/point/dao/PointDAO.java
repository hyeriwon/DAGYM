package kr.point.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.point.vo.PointVO;
import kr.util.DBUtil;
import kr.util.StringUtil;

public class PointDAO {
	//싱글턴 패턴
	private static PointDAO instance = new PointDAO();
	
	public static PointDAO getInstance() {
		return instance;
	}
	public PointDAO() {
		
	}

	//포인트 등록 (자동) (AttendDAO +10P)(회원권? 후기? ..)
	
	//총 포인트의 개수, 검색 개수
	public int getPointCount(String keyfield, String keyword) throws Exception{
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;
		
		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			
			if(keyword != null && "".equals(keyword)) {
				//검색처리
				if(keyfield.equals("1"))
					sub_sql += "WHERE title LIKE '%' || ? || '%'";
				else if (keyfield.equals("2"))
					sub_sql += "WHERE id LIKE '%' || ? || '%'";
				else if (keyfield.equals("3"))
					sub_sql += "WHERE content LIKE '%' || ? || '%'";
			}
			
			//SQL문 작성
			sql = "SELECT COUNT(*) FROM point JOIN member USING(mem_num) " + sub_sql;
			
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			if(keyword != null && "".equals(keyword)) {
				pstmt.setString(1, keyword);
			}
			
			//SQL문 실행
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				count = rs.getInt(1);//1 = COUNT(*)의 컬럼인덱스
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			//자원 정리
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return count;
	}

	//포인트 목록, 검색 포인트 목록
	public List<PointVO> getListPoint(int mem_num, int start, int end, String keyfield, String keyword) throws Exception{
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<PointVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		
		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			
			//SQL문 작성
			sql = "SELECT * FROM (SELECT a.*, rownum rnum "
				+ "FROM (SELECT * FROM point JOIN member USING(mem_num) " + sub_sql
				+ " WHERE mem_num = ? ORDER BY poi_num DESC)a) WHERE rnum >= ? AND rnum <= ?";
			
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			if(keyword != null && "".equals(keyword)) {
				pstmt.setString(++cnt, keyword);
			}
			//?에 데이터 바인딩
			pstmt.setInt(++cnt, mem_num);
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			
			//SQL문 실행
			rs = pstmt.executeQuery();
			
			list = new ArrayList<PointVO>();
			while(rs.next()) {
				PointVO point = new PointVO();
				point.setPoi_num(rs.getInt("poi_num"));
				point.setMem_num(rs.getInt("mem_num"));
				point.setPoi_type(rs.getString("poi_type"));
				point.setPoi_in(rs.getInt("poi_in"));
				point.setPoi_in_date(rs.getDate("poi_in_date"));
				point.setPoi_out(rs.getInt("poi_out"));
				point.setPoi_out_date(rs.getDate("poi_out_date"));
				//자바빈을 ArrayList에 저장
				list.add(point);
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			//자원 정리
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return list;
	}
	
	//포인트 전체누적 계산
    public int getTotalPointsIn(int mem_num) throws Exception {
    	
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        int totalPointsIn = 0;

        try {
            conn = DBUtil.getConnection();

            sql = "SELECT SUM(poi_in) AS total_in FROM point WHERE mem_num = ?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, mem_num);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                totalPointsIn = rs.getInt("total_in");
            }

        } catch (Exception e) {
            throw new Exception(e);
        } finally {
            DBUtil.executeClose(rs, pstmt, conn);
        }

        return totalPointsIn;
    }
	
	//포인트 사용가능 계산
    public int getTotalPointsInOut(int mem_num) throws Exception {
    	
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        int totalPointsInOut = 0;

        try {
            conn = DBUtil.getConnection();

            sql = "SELECT SUM(poi_in) - SUM(poi_out) AS total_inout FROM point WHERE mem_num = ?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, mem_num);

            rs = pstmt.executeQuery();

            if (rs.next()) {
            	totalPointsInOut = rs.getInt("total_inout");
            }

        } catch (Exception e) {
            throw new Exception(e);
        } finally {
            DBUtil.executeClose(rs, pstmt, conn);
        }

        return totalPointsInOut;
    }
    
	//(관리자) 포인트 차감
   public void insertOut(int mem_num, String poi_type, int poi_out) throws Exception {
    	
    	Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = null;
        
    	try {
        	//커넥션풀로부터 커넥션을 할당
            conn = DBUtil.getConnection();
            
            //SQL문 작성
            sql = "INSERT INTO point (poi_num, mem_num, poi_type, poi_out, poi_out_date) "
                + "VALUES (point_seq.nextval, ?, ?, ?, sysdate)";
            
            //PreparedStatement 객체 생성
            pstmt = conn.prepareStatement(sql);
            //?에 데이터 바인딩
            pstmt.setInt(1, mem_num);
            pstmt.setString(2, poi_type);
            pstmt.setInt(3, poi_out);
            
			//SQL문 실행
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			//자원 정리
			DBUtil.executeClose(null, pstmt, conn);
		}
    }
   
}