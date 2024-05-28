package kr.point.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.point.vo.PointVO;
import kr.util.DBUtil;

public class PointDAO {
	//싱글턴 패턴
	private static PointDAO instance = new PointDAO();
	
	public static PointDAO getInstance() {
		return instance;
	}
	public PointDAO() {
		
	}

	//포인트 등록 (AttendDAO +10P)(회원권? 후기? ..)
	
	//포인트 목록
	public List<PointVO> getList(int mem_num) throws Exception{
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<PointVO> list = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			
			//SQL문 작성
			sql = "SELECT * FROM point WHERE mem_num = ? ORDER BY poi_num DESC";
			
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, mem_num);
			
			//SQL문 실행
			rs = pstmt.executeQuery();
			list = new ArrayList<PointVO>();
			while(rs.next()) {
				PointVO pointVO = new PointVO();
				pointVO.setPoi_num(rs.getInt("poi_num"));
				pointVO.setMem_num(rs.getInt("mem_num"));
				pointVO.setPoi_in(rs.getInt("poi_in"));
				pointVO.setPoi_in_date(rs.getDate("poi_in_date"));
				pointVO.setPoi_out(rs.getInt("poi_out"));
				pointVO.setPoi_out_date(rs.getDate("poi_out_date"));
				//자바빈을 ArrayList에 저장
				list.add(pointVO);
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			//자원 정리
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return list;
	}
	
	//포인트 차감 (관리자)
	
}
