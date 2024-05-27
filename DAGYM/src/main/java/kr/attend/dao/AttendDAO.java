package kr.attend.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.attend.dao.AttendDAO;
import kr.attend.vo.AttendVO;
import kr.util.DBUtil;

public class AttendDAO {
	//싱글턴 패턴
	private static AttendDAO instance = new AttendDAO();
	
	public static AttendDAO getInstance() {
		return instance;
	}
	public AttendDAO() {
		
	}
	
	//출석 등록
    public void insert(int mem_num) throws Exception {
    	
    	Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = null;
        
    	try {
        	//커넥션풀로부터 커넥션을 할당
            conn = DBUtil.getConnection();
            
            //SQL문 작성
            sql = "INSERT INTO attend (att_num, mem_num) "
                + "VALUES (attend_seq.nextval, ?)";
            
            //PreparedStatement 객체 생성
            pstmt = conn.prepareStatement(sql);
            //?에 데이터 바인딩
            pstmt.setInt(1, mem_num);

			//SQL문 실행
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			//자원 정리
			DBUtil.executeClose(null, pstmt, conn);
		}
    }

	//출석 목록
	public List<AttendVO> getList(int mem_num, int startRow, int endRow) throws Exception{
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<AttendVO> list = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			
			//SQL문 작성
			sql = "SELECT * FROM (SELECT a.*, rownum rnum "
				+ "FROM (SELECT * FROM attend WHERE mem_num = ? ORDER BY att_num DESC)a) "
				+ "WHERE rnum >= ? AND rnum <= ?";
			
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, mem_num);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			//SQL문 실행
			rs = pstmt.executeQuery();
			list = new ArrayList<AttendVO>();
			while(rs.next()) {
				AttendVO attendVO = new AttendVO();
				attendVO.setAtt_num(rs.getInt("att_num"));
				attendVO.setMem_num(rs.getInt("mem_num"));
				attendVO.setAtt_date(rs.getDate("att_date"));
				//자바빈을 ArrayList에 저장
				list.add(attendVO);
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			//자원 정리
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return list;
	}
	
	//출석의 총 개수
	public int getCount() throws Exception{
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			
			//SQL문 작성
			sql = "SELECT COUNT(*) FROM attend";
			
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			
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
	
	//출석 여부 확인
    public boolean isAttendExist(int mem_num, String date) throws Exception {
    	
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        boolean isExist = false;

        try {
            //커넥션풀로부터 커넥션을 할당
            conn = DBUtil.getConnection();
            
            //SQL문 작성
            sql = "SELECT COUNT(*) FROM attend WHERE mem_num = ? AND TO_CHAR(att_date, 'YYYY-MM-DD') = ?";
            
            //PreparedStatement 객체 생성
            pstmt = conn.prepareStatement(sql);
            //?에 데이터 바인딩
            pstmt.setInt(1, mem_num);
            pstmt.setString(2, date);
            
            //SQL문 실행
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                isExist = (rs.getInt(1) > 0);
            }
            
        } catch(Exception e) {
            throw new Exception(e);
        } finally {
            //자원 정리
            DBUtil.executeClose(rs, pstmt, conn);
        }
        return isExist;
    }
    
    //이번달 출석일수
    public int getMonthlyAttendCount(int mem_num, String month) throws Exception {
    	
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        int count = 0;
        
        try {
            //커넥션풀로부터 커넥션을 할당
            conn = DBUtil.getConnection();
            
            //SQL문 작성
            sql = "SELECT COUNT(*) FROM attend WHERE mem_num = ? AND TO_CHAR(att_date, 'YYYY-MM') = ?";
            
            //PreparedStatement 객체 생성
            pstmt = conn.prepareStatement(sql);
            //?에 데이터 바인딩
            pstmt.setInt(1, mem_num);
            pstmt.setString(2, month);
            
            //SQL문 실행
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                count = rs.getInt(1); //1 = COUNT(*)의 컬럼인덱스
            }
            
        } catch (Exception e) {
            throw new Exception(e);
        } finally {
            //자원 정리
            DBUtil.executeClose(rs, pstmt, conn);
        }
        return count;
    }
    
	//출석 삭제
	public void delete(int att_num) throws Exception {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			
			//SQL문 작성
			sql = "DELETE FROM attend WHERE att_num=?";
			
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, att_num);
			
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
