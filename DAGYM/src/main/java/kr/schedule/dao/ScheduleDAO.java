package kr.schedule.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.history.vo.HistoryVO;
import kr.schedule.vo.ScheduleVO;
import kr.util.DBUtil;

public class ScheduleDAO {
    // 싱글턴 패턴
    private static ScheduleDAO instance = new ScheduleDAO();

    public static ScheduleDAO getInstance() {
        return instance;
    }
    private ScheduleDAO() {}

    // 스케줄 등록
    public void insertSchedule(ScheduleVO schedule) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = null;

        try {
            conn = DBUtil.getConnection();

            sql = "INSERT INTO schedule (sch_num, mem_num, mem_id, sch_date, sch_time, sch_status) VALUES (schedule_seq.nextval, ?, ?, ?, ?, ?)";

            // PreparedStatement 생성
            pstmt = conn.prepareStatement(sql);

            // ?에 데이터 바인딩
            pstmt.setInt(1, schedule.getMem_num());
            pstmt.setString(2, schedule.getMem_id()); // mem_id 추가
            pstmt.setString(3, schedule.getSch_date());
            pstmt.setInt(4, schedule.getSch_time());
            pstmt.setInt(5, schedule.getSch_status());
     

            // SQL문 실행
            pstmt.executeUpdate();

        } catch (Exception e) {
            throw new Exception(e);
        } finally {
            DBUtil.executeClose(null, pstmt, conn);
        }
    }

    // 스케줄 중복 체크
    public boolean isDuplicateSchedule(String sch_date, int sch_time) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        boolean isDuplicate = false;

        try {
            conn = DBUtil.getConnection();

            sql = "SELECT COUNT(*) FROM schedule WHERE sch_date = ? AND sch_time = ?";

            // PreparedStatement 생성
            pstmt = conn.prepareStatement(sql);

            // ?에 데이터 바인딩
            pstmt.setString(1, sch_date);
            pstmt.setInt(2, sch_time);

            // SQL문 실행
            rs = pstmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                isDuplicate = true;
            }

        } catch (Exception e) {
            throw new Exception(e);
        } finally {
            DBUtil.executeClose(rs, pstmt, conn);
        }

        return isDuplicate;
    }

    
    // 스케줄 일괄 불러오기
    public List<ScheduleVO> getAllSchedules() throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ScheduleVO> schedules = new ArrayList<>();

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT * FROM schedule ORDER BY sch_date ASC, sch_time ASC"; // 적절한 SQL 쿼리로 변경해야 함

            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ScheduleVO schedule = new ScheduleVO();
                // 스케줄 객체에 필요한 데이터를 설정
                schedule.setSch_num(rs.getInt("sch_num"));
                schedule.setMem_num(rs.getInt("mem_num"));
                schedule.setMem_id(rs.getString("mem_id"));
                schedule.setSch_date(rs.getString("sch_date"));
                schedule.setSch_time(rs.getInt("sch_time"));
                schedule.setSch_status(rs.getInt("sch_status"));
                
                schedules.add(schedule);
            }
        } catch (Exception e) {
        	throw new Exception(e);
        } finally {
            DBUtil.executeClose(rs, pstmt, conn);
        }

        return schedules;
    }
    
    // 스케줄 삭제
    public boolean deleteSchedule(int schNum, int userNum) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;

        try {
            conn = DBUtil.getConnection();

            String sql = "DELETE FROM schedule WHERE sch_num = ? AND mem_num = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, schNum);
            pstmt.setInt(2, userNum);

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                success = true;
            }
        } catch (Exception e) {
            throw new Exception(e);
        } finally {
            DBUtil.executeClose(null, pstmt, conn);
        }

        return success;
    }
    
    
 // 관리자 - 스케줄 삭제
    public boolean deleteScheduleByAdmin(int schNum) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;

        try {
            conn = DBUtil.getConnection();

            String sql = "DELETE FROM schedule WHERE sch_num = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, schNum);

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                success = true;
            }
        } catch (Exception e) {
            throw new Exception(e);
        } finally {
            DBUtil.executeClose(null, pstmt, conn);
        }

        return success;
    }

    
    // 스케줄 조회
    public ScheduleVO getSchedule(int sch_num) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ScheduleVO schedule = null;
        String sql = "SELECT sch_num, sch_date, sch_time, mem_num, tra_id FROM schedule WHERE sch_num = ?";

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, sch_num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                schedule = new ScheduleVO();
                schedule.setSch_num(rs.getInt("sch_num"));
                schedule.setSch_date(rs.getString("sch_date"));
                schedule.setSch_time(rs.getInt("sch_time"));
                schedule.setMem_num(rs.getInt("mem_num"));
                schedule.setTra_id(rs.getString("tra_id"));
            }
        } catch (Exception e) {
            throw new Exception(e);
        } finally {
            DBUtil.executeClose(rs, pstmt, conn);
        }

        return schedule;
    }
    
    
    // 트레이너 - 본인이 등록한 스케줄만 가져오는 메소드(history 연동)
    public List<ScheduleVO> getMyScheduleListByTraNum(int user_num) throws Exception {
        List<ScheduleVO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT s.*, h.*, h.mem_num, m.mem_id AS mi, m.mem_num AS mn " +
        "FROM schedule s LEFT OUTER JOIN history h ON s.sch_num = h.sch_num " +
        "LEFT OUTER JOIN member m ON h.mem_num = m.mem_num " + 
        "WHERE s.mem_num = ?";
		/*
		 * String sql = "SELECT s.*, h.*, h.mem_num AS mn " + "FROM schedule s " +
		 * "LEFT OUTER JOIN history h ON s.sch_num = h.sch_num " +
		 * "WHERE s.mem_num = ?";
		 */
        
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, user_num);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                ScheduleVO schedule = new ScheduleVO();
                schedule.setSch_num(rs.getInt("sch_num"));
				schedule.setSch_date(rs.getString("sch_date"));
				schedule.setSch_time(rs.getInt("sch_time"));
				schedule.setMem_id(rs.getString("mi"));
				schedule.setMem_num(rs.getInt("mn"));
				schedule.setSch_status(rs.getInt("sch_status"));
				schedule.setHis_status(rs.getInt("his_status")); // 추가된 코드
				schedule.setHis_part(rs.getString("his_part"));
				schedule.setHis_num(rs.getInt("his_num"));
                
                // history 정보 설정
                HistoryVO history = new HistoryVO();
                history.setHis_num(rs.getInt("his_num"));
				history.setMem_num(rs.getInt("mem_num"));
				history.setSch_num(rs.getInt("sch_num"));
				history.setTra_num(rs.getInt("tra_num"));
				history.setHis_status(rs.getInt("his_status"));
				history.setHis_part(rs.getString("his_part"));
				
                
                // ScheduleVO에 HistoryVO 추가
                schedule.setHistory(history);
                
                list.add(schedule);
            }
        } catch (Exception e) {
            throw new Exception(e);
        } finally {
            DBUtil.executeClose(rs, pstmt, conn);
        }
        
        return list;
    }
    
	// PT 스케줄 진행 최종 완료 처리
    public void completeHistory(int sch_num, int his_num) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt1 = null;
        PreparedStatement pstmt2 = null;

        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false); // 트랜잭션 시작

            // schedule 테이블 업데이트
            String sql1 = "UPDATE schedule SET sch_status = 2 WHERE sch_num = ?";
            pstmt1 = conn.prepareStatement(sql1);
            pstmt1.setInt(1, sch_num);
            pstmt1.executeUpdate();

            // history 테이블 업데이트
            String sql2 = "UPDATE history SET his_status = 2 WHERE his_num = ?";
            pstmt2 = conn.prepareStatement(sql2);
            pstmt2.setInt(1, his_num);
            pstmt2.executeUpdate();

            conn.commit(); // 트랜잭션 커밋

        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback(); // 트랜잭션 롤백
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            throw new Exception(e);
        } finally {
            DBUtil.executeClose(null, pstmt1, conn);
            DBUtil.executeClose(null, pstmt2, null); // conn은 이미 위에서 닫혔으므로 null을 전달
        }
    }

}
