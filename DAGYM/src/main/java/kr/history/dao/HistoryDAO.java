package kr.history.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.history.vo.HistoryVO;
import kr.payment.vo.PaymentVO;
import kr.schedule.vo.ScheduleVO;
import kr.util.DBUtil;

public class HistoryDAO {
	//싱글턴 패턴
	private static HistoryDAO instance = new HistoryDAO();

	public static HistoryDAO getInstance() {
		return instance;
	}
	private HistoryDAO () {}

	
    
    public ScheduleVO getSchedule(int sch_num) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ScheduleVO schedule = null;
        String sql = null;

        try {
            conn = DBUtil.getConnection();
            sql = "SELECT sch_num, sch_date, sch_time, mem_num FROM schedule WHERE sch_num = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, sch_num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                schedule = new ScheduleVO();
                schedule.setSch_num(rs.getInt("sch_num"));
                schedule.setSch_date(rs.getString("sch_date"));
                schedule.setSch_time(rs.getInt("sch_time"));
                schedule.setMem_num(rs.getInt("mem_num"));
                // schedule.setTra_id(rs.getString("tra_id"));
            }
        } catch (Exception e) {
            throw new Exception(e);
        } finally {
            DBUtil.executeClose(rs, pstmt, conn);
        }

        return schedule;
    }
    
 // 스케줄 조회 메서드
    public List<ScheduleVO> getScheduleList() throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ScheduleVO> list = null;
        String sql = null;

        try {
            conn = DBUtil.getConnection();
            sql = "SELECT sch_num, sch_date, sch_time, mem_id FROM schedule";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            list = new ArrayList<ScheduleVO>();
            while (rs.next()) {
                ScheduleVO schedule = new ScheduleVO();
                schedule.setSch_num(rs.getInt("sch_num"));
                schedule.setSch_date(rs.getString("sch_date"));
                schedule.setSch_time(rs.getInt("sch_time"));
                schedule.setMem_id(rs.getString("mem_id"));
                list.add(schedule);
            }
        } catch (Exception e) {
            throw new Exception(e);
        } finally {
            DBUtil.executeClose(rs, pstmt, conn);
        }

        return list;
    }

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/* =====================추후 수정 예정(LJY)====================== */
	/*-----회원-----*/
	//수강신청
	public void insertHistory(HistoryVO history, PaymentVO payment)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		String sql = null;
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//오토커밋 해제
			conn.setAutoCommit(false);

			//수강신청시 history 테이블에 데이터 등록
			sql = "INSERT INTO history (his_num,mem_num,sch_num,tra_num,his_status,his_part) VALUES (history_seq.nextval,?,?,?,?,?)";//WHERE절로 넘겨야 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, history.getMem_num());
			pstmt.setInt(2, history.getSch_num());
			pstmt.setInt(3, history.getTra_num());
			pstmt.setInt(4, history.getHis_status());
			pstmt.setString(5, history.getHis_part());
			pstmt.executeUpdate();
			//수강신청시 PT 등록횟수 차감			//pay_enroll 수정 필요		
			sql = "UPDATE payment SET pay_enroll = pay_enroll - 1 WHERE mem_num=? AND pay_enroll > 0";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, payment.getMem_num());
			pstmt2.executeUpdate();

			//예외 발생 없이 정상적으로 SQL문 실행
			conn.commit();
		}catch(Exception e) {
			//예외 발생
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//수강신청내역 총 개수, 검색 개수
	public int getHistoryCount(String keyfield, String keyword)throws Exception{
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
				else if(keyfield.equals("2")) sub_sql += "WHERE his_part LIKE '%' || ? || '%'";
			}
			//SQL문 작성
			sql = "SELECT COUNT(*) FROM history h " +
				      "JOIN member m USING (mem_num) " +
				      "JOIN member_detail md USING (mem_num) " + sub_sql;
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
	
	//수강내역 목록, 검색 목록
	public List<HistoryVO> getListHistory(int start,int end,String keyfield,String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<HistoryVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		try {
			conn = DBUtil.getConnection();
			if(keyword!=null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql += "WHERE mem_name LIKE '%' || ? || '%'";
				else if(keyfield.equals("2")) sub_sql += "WHERE his_part LIKE '%' || ? || '%'";
			}
			//SQL문 수정 필요! (OUTERJOIN 필요)
			 sql = "SELECT * FROM (SELECT h.*, md.mem_name AS mem_name, rownum rnum FROM " +
		              "(SELECT h.*, m.mem_num AS mem_num FROM history h " +
		              "JOIN member m ON h.mem_num = m.mem_num " +
		              "JOIN member_detail md ON m.mem_num = md.mem_num "  + sub_sql + " ORDER BY h.his_num DESC) h) " +
		              "WHERE rnum >= ? AND rnum <= ?";
			 
			 pstmt = conn.prepareStatement(sql);
			 if(keyword!=null && !"".equals(keyword)) {
				 pstmt.setString(++cnt, keyword);
			 }
			 pstmt.setInt(++cnt, start);
			 pstmt.setInt(++cnt, end);
			 
			 rs = pstmt.executeQuery();
			 list = new ArrayList<HistoryVO>();
			 while(rs.next()) {
				 HistoryVO history = new HistoryVO();
				 history.setHis_num(rs.getInt("his_num"));
				 history.setMem_num(rs.getInt("mem_num"));
				 history.setSch_num(rs.getInt("sch_num"));
				 history.setTra_num(rs.getInt("tra_num"));
				 history.setHis_status(rs.getInt("his_status"));
				 history.setHis_part(rs.getString("his_part"));
				 history.setTra_id(rs.getString("tra_id"));
				 
				 list.add(history);
			 }
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	/*-----강사-----*/
	//수강 내역 전체 개수, 검색 개수(강사)
	public int getHistoryCountByAdmin(String keyfield,String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT COUNT(*) FROM history";
			pstmt = conn.prepareStatement(sql);
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
	//수강내역(강사)
	public List<HistoryVO> getListHistoryByAdmin(int user_num,int start,int end,String keyfield,String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<HistoryVO> list = null;
		String sql = null;
		String sub_sql = "";
		try {
			conn = DBUtil.getConnection();
			
			//SQL문 수정 필요
			sql = "SELECT h.his_num, s.sch_date, h.his_part, md.mem_name, md.mem_phone, p.pay_enroll, h.his_status " +
                    "FROM history h " +
                    "JOIN member_detail md ON h.mem_num = md.mem_num " +
                    "JOIN payment p ON h.mem_num = p.mem_num " +
                    "JOIN schedule s ON h.sch_num = s.sch_num " +
                    "WHERE h.tra_num = ? AND rnum >= ? AND rnum <= ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, user_num);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList<HistoryVO>();
			while(rs.next()) {
				HistoryVO history = new HistoryVO();
				history.setHis_num(rs.getInt("his_num"));
				history.setSch_date(rs.getString("sch_date"));
				history.setHis_part(rs.getString("his_part"));
				history.setTra_id(rs.getString("mem_id"));
				history.setMem_phone(rs.getString("mem_phone"));
				//등록횟수 저장필요
				history.setHis_status(rs.getInt("his_status"));
				
				list.add(history);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return list;
	}
	/*---수강내역 상세---  -> 건드리지 마시오.*/
	public HistoryVO getHistory(int sch_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		HistoryVO history = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT h.*,sc.sch_date,sc.sch_time,md.mem_name "
					+ "FROM history h "
					+ "JOIN schedule sc ON h.sch_num = sc.sch_num "
					+ "JOIN member_detail md ON h.tra_num = md.mem_num "
					+ "WHERE h.sch_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sch_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				history = new HistoryVO();
				//history.setHis_num(rs.getInt("sch_mem")); -> 테이블에서 his_num 삭제시 제거됨
				history.setMem_num(rs.getInt("mem_num"));
				history.setSch_num(sch_num);
				history.setTra_num(rs.getInt("tra_num"));
				history.setHis_status(rs.getInt("his_status"));
				history.setHis_part(rs.getString("his_part"));
				history.setSch_date(rs.getString("sch_date")+" "+rs.getString("sch_time"));
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return history;
	}
}
