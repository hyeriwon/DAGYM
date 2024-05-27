package kr.meal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.meal.vo.MealVO;
import kr.tmenu.vo.TmenuVO;
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
	public void deleteMeal(int meal_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "DELETE FROM meal WHERE meal_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, meal_num);
			//SQL문 실행
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//음식글 등록 상세정보 
	public MealVO getMeal(int meal_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MealVO item = null;
		String sql = null;
		try {
			conn=DBUtil.getConnection();
			sql = "SELECT * FROM meal LEFT OUTER JOIN t_menu USING(tme_num) WHERE meal_num = ? ORDER BY meal_date DESC, meal_time DESC";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, meal_num);
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
	// 회원별 음식글 총 갯수, 검색 갯수
	public int getMealCount(String keyfield, String keyword,int mem_num)throws Exception{
		Connection conn= null;
		PreparedStatement pstmt=null;
		ResultSet rs =null;
		String sql = null;
		String sub_sql = "";
		int count = 0;
		int cnt = 0;
		try {
			conn = DBUtil.getConnection();
			if(keyword!=null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql +=" AND tme_name LIKE '%' || ? ||'%'";
				else if(keyfield.equals("2")) sub_sql +=" AND meal_date LIKE '%' || ? ||'%'";
			}
			sql= "SELECT COUNT(*)FROM meal JOIN t_menu USING(tme_num) WHERE mem_num =? " +sub_sql;
			pstmt =conn.prepareStatement(sql);
			pstmt.setInt(++cnt, mem_num);
			if(keyword!=null && !"".equals(keyword)) {
				pstmt.setString(++cnt,keyword);
			}
			rs=pstmt.executeQuery();
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
	//음식 글 목록, 검색 글 목록
	public List<MealVO> getListMeal(int start,int end, String keyfield, String keyword, int mem_num )throws Exception{
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
					+ "(SELECT * FROM meal JOIN t_menu USING(tme_num) WHERE mem_num = ? " + sub_sql
					+ " ORDER BY meal_date DESC, meal_time DESC)a) WHERE rnum >=? AND rnum <=?";
			pstmt =conn.prepareStatement(sql);
			pstmt.setInt(++cnt,mem_num);
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

	
	//오늘의 메뉴 검색하기
	public List<TmenuVO> searchListTmenu(String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		List<TmenuVO> list = null;
		String sql = null;
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql ="SELECT * FROM t_menu WHERE tme_name LIKE '%' || ? || '%'";
			pstmt =conn.prepareStatement(sql);
			pstmt.setString(1,keyword);
			rs=pstmt.executeQuery();
			list = new ArrayList<TmenuVO>();
			while(rs.next()) {
				TmenuVO tmenu = new TmenuVO();
				tmenu.setTme_num(rs.getInt("tme_num"));
				tmenu.setTme_name(rs.getString("tme_name"));
				tmenu.setTme_kcal(rs.getInt("tme_kcal"));
				list.add(tmenu);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	
	
	
	//같은날짜 같은 식사 음식 계산
	public List<MealVO> listDateMeal(int mem_num,String meal_date)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		List<MealVO> list = null;
		String sql = null;
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			  sql = "SELECT * FROM meal JOIN t_menu USING(tme_num) WHERE mem_num =? AND meal_date = ?";
			pstmt =conn.prepareStatement(sql);
			System.out.println("mem-num :"+mem_num);
			pstmt.setInt(1, mem_num);
			pstmt.setString(2,meal_date);
			rs=pstmt.executeQuery();
			list = new ArrayList<MealVO>();
			while(rs.next()) {
				MealVO meal = new MealVO();
				meal.setMeal_date(meal_date);
				meal.setTme_num(rs.getInt("tme_num"));
				meal.setTme_name(rs.getString("tme_name"));
				meal.setTme_kcal(rs.getInt("tme_kcal"));
				list.add(meal);
				
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	
	//오늘의 메뉴 검색처리
	public int searchMenuAndSetTmeNum(String tme_name) throws Exception {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    int tme_num = -1;
	    
	    try {
	        conn = DBUtil.getConnection();
	        sql = "SELECT tme_num FROM t_menu WHERE tme_name = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, tme_name);
	        rs = pstmt.executeQuery();
	        System.out.println(tme_name);
	        if (rs.next()) {
	            tme_num = rs.getInt("tme_num");
	        }
	    } catch (Exception e) {
	        // 예외 발생 시 로그를 남기고 예외를 다시 던집니다.
	        System.err.println("Error occurred while searching for tme_num: " + e.getMessage());
	        throw new Exception(e);
	    } finally {
	        // 자원 해제를 수행합니다.
	        DBUtil.executeClose(rs, pstmt, conn);
	    }
	    
	    return tme_num;
	}

	
	//칼로리 계산
	public int calKcal(String meal_date)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalKcal = 0;
		try {
			conn=DBUtil.getConnection();
			sql="SELECT SUM(tme_kcal) AS totalKcal FROM meal JOIN t_menu USING(tme_num) WHERE meal_date= ? GROUP BY meal_date";
			pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, meal_date);
            rs = pstmt.executeQuery();
            if(rs.next()) {
            	totalKcal =rs.getInt("totalKcal");
            }
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return totalKcal;
	}
	
}
