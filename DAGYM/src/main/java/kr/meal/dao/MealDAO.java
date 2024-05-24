package kr.meal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
	public MealVO getMeal(int mem_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MealVO item = null;
		String sql = null;
		try {
			conn=DBUtil.getConnection();
			sql = "SELECT * FROM meal JOIN t_menu USING(tme_num) WHERE mem_num = ? ORDER BY meal_date DESC, meal_time DESC";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				item = new MealVO();
				item.setMeal_num(rs.getInt("meal_num"));
				item.setMeal_time(rs.getInt("meal_time"));
				item.setMeal_date(rs.getString("meal_date"));
				item.setMem_num(rs.getInt("mem_num"));
				item.setTme_kcal(rs.getInt("tme_kcal"));
				item.setTme_name(rs.getString("tme_name"));
				item.setTme_num(rs.getInt("tme_num"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return item;
	}
	//음식글 총 갯수, 검색 갯수
	//음식 글 목록, 검색 글 목록
	public List<MealVO> getListMeal(int start,int end, String keyfield, String keyword, String meal_date ,int meal_time)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		List<MealVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			if(keyword != null && !"".equals(keyword)) {
				//검색 처리
				if(keyfield.equals("1")) sub_sql += "AND tme_name LIKE '%'||?||'%'";
			}
			//SQL문 작성
			sql ="SELECT * FROM (SELECT a.*,rownum rnum FROM "
					+ "(SELECT * FROM meal JOIN t_menu USING(tme_num) WHERE meal_time = ? " + sub_sql
					+ " ORDER BY meal_date DESC, meal_type DESC)a) WHERE rnum >=? AND rnum <=?";
			pstmt =conn.prepareStatement(sql);
			pstmt.setInt(++cnt,meal_time);
			if(keyword!=null && !"".equals(keyword)) {
				pstmt.setString(++cnt,keyword);
			}
			pstmt.setInt(++cnt,start);
			pstmt.setInt(++cnt,end);
			rs=pstmt.executeQuery();
			list = new ArrayList<MealVO>();
			while(rs.next()) {
				MealVO item = new MealVO();
				item.setMeal_num(rs.getInt("meal_num"));
				item.setMeal_time(rs.getInt("meal_time"));
				item.setMeal_date(rs.getString("meal_date"));
				item.setMem_num(rs.getInt("mem_num"));
				item.setTme_kcal(rs.getInt("tme_kcal"));
				item.setTme_name(rs.getString("tme_name"));
				item.setTme_num(rs.getInt("tme_num"));
				list.add(item);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	
	
	
	//같은날짜 같은 식사 음식 계산
	//오늘의 메뉴 검색처리
	public int searchMenuAndSetTmeNum(String tme_name)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int tme_num = -1;
		try {
			conn=DBUtil.getConnection();
			sql="SELECT tme_num FROM t_menu WHERE tme_name = ?";
			pstmt =conn.prepareStatement(sql);
			pstmt.setString(1,tme_name);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				tme_num = rs.getInt("tme_num");
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return tme_num;
	}
	
	//칼로리 계산
	public void a()throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn=DBUtil.getConnection();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
}
