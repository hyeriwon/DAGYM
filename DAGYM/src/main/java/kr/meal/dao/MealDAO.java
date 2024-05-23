package kr.meal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import kr.meal.vo.MealVO;
import kr.util.DBUtil;

public class MealDAO {
	
	//싱클턴 패턴
	private static MealDAO instance = new MealDAO();
	public static MealDAO getInstance() {
		return instance;
		}
	private MealDAO() {}
		
	//음식글 등록
	public void insertMeal(MealVO meal)throws Exception{
		Connection conn=null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			sql = "INSERT INTO meal (meal_num,tme_num,mem_num,meal_date,meal_time) "
					+ "VALUES(meal_seq.nextval,?,?,?,?)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1,meal.getTme_num());
			pstmt.setInt(2,meal.getMem_num());
			pstmt.setString(3,meal.getMeal_date());
			pstmt.setInt(4,meal.getMeal_time());
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
			
		}
	}
	
	//음식글 삭제
	//음식글 등록 상세정보 
	//음식글 총 갯수, 검색 갯수
	//음식 글 목록, 검색 글 목록
	
	//같은날짜 같은 식사 음식 계산
	//칼로리 계산
	
}
