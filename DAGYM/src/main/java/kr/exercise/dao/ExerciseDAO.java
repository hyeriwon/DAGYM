package kr.exercise.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.exercise.vo.ExerciseVO;
import kr.util.DBUtil;
import kr.util.StringUtil;

public class ExerciseDAO {
	//싱글턴 패턴
	private static ExerciseDAO instance = new ExerciseDAO();
	public static  ExerciseDAO getInstance() {
		return instance;
	}
	private ExerciseDAO() {}


	//운동기록 등록
	public void insertExercise(ExerciseVO exercise) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn= DBUtil.getConnection();
			sql="INSERT INTO exercise(exe_num,mem_num,exe_type,exe_content,exe_date,exe_time) VALUES("
					+ "exercise_seq.nextval,?,?,?,?,?)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, exercise.getMem_num());
			pstmt.setString(2, exercise.getExe_type());
			pstmt.setString(3, exercise.getExe_content());
			pstmt.setString(4, exercise.getExe_date());
			pstmt.setInt(5, exercise.getExe_time());
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//운동기록 삭제
	public void deleteExercise(int exe_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			sql= "DELETE FROM exercise WHERE exe_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, exe_num);
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
		
	}

	//운동 기록 갯수(전체,검색)
	public int countExerciseByUser(String keyfield, String keyword, int mem_num)throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		String sql = null;
		String sub_sql = "";
		try {
			conn=DBUtil.getConnection();
			if(keyword !=null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql+= "AND exe_date LIKE '%' || ? || '%'";
				else if(keyfield.equals("2")) sub_sql+= "AND exe_type LIKE '%' || ? || '%'";
			}
			sql="SELECT COUNT(*) FROM exercise WHERE mem_num = ?"+sub_sql;
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
			if(keyword !=null && !"".equals(keyword)) {
				pstmt.setString(2,keyword);
			}
			rs=pstmt.executeQuery();
			if(rs.next()) {
				count=rs.getInt(1);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}


		return count;
	}

	//운동 기록 리스트(전체,검색)
	public List<ExerciseVO> listExerciseByUser(int start, int end, String keyfield, String keyword, int mem_num )throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int cnt = 0;
		List<ExerciseVO> list = null;
		String sql = null;
		String sub_sql = "";
		try {
			conn=DBUtil.getConnection();
			if(keyword !=null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql+= "AND exe_date LIKE '%' || ? || '%'";
				else if(keyfield.equals("2")) sub_sql+= "AND exe_type LIKE '%' || ? || '%'";
			}
			sql=	"SELECT *FROM(SELECT a.*, rownum rnum FROM("
					+"SELECT * FROM exercise WHERE mem_num = ? "+sub_sql
					+"ORDER BY exe_date DESC)a) WHERE rnum >=? AND rnum <=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(++cnt, mem_num);
			if(keyword !=null && !"".equals(keyword)) {
				pstmt.setString(++cnt, keyword);
			}
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			rs=pstmt.executeQuery();
			list = new ArrayList<ExerciseVO>();
			while(rs.next()) {
				ExerciseVO execise = new ExerciseVO();
				execise.setExe_num(rs.getInt("exe_num"));
				execise.setMem_num(mem_num);
				execise.setExe_type(rs.getString("exe_type"));
				execise.setExe_time(rs.getInt("exe_time"));
				execise.setExe_date(rs.getString("exe_date"));
				execise.setExe_content(StringUtil.useNoHTML(rs.getString("exe_content")));
				list.add(execise);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}


		return list;
	}

	//운동기록 상세
	public List<ExerciseVO> getDetailExercise(String exe_date,int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ExerciseVO> list = null;
		String sql = null;
		try {
			conn=DBUtil.getConnection();
			sql = "SELECT * FROM exercise WHERE exe_date = ? AND mem_num = ?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, exe_date);
			pstmt.setInt(2, mem_num);
			rs=pstmt.executeQuery();
			list = new ArrayList<ExerciseVO>();
			while(rs.next()) {
				ExerciseVO exercise = new ExerciseVO();
				exercise.setExe_num(rs.getInt("exe_num"));
				exercise.setMem_num(mem_num);
				exercise.setExe_type(rs.getString("exe_type"));
				exercise.setExe_time(rs.getInt("exe_time"));
				exercise.setExe_date(exe_date);
				exercise.setExe_content(StringUtil.useBrNoHTML(rs.getString("exe_content")));
				list.add(exercise);
			}
		}catch(Exception e){
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	//운동기록 수정
	public void updateExercise(ExerciseVO exercise) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn= DBUtil.getConnection();
			sql="UPDATE exercise set exe_type=?, exe_content=?,exe_time=? WHERE exe_num =?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, exercise.getExe_type());
			pstmt.setString(2, exercise.getExe_content());
			pstmt.setInt(3, exercise.getExe_time());
			pstmt.setInt(4, exercise.getExe_num());
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}

	//운동번호별 정보 가지고 오기
	public ExerciseVO getDetailExerciseByExe_num (int exe_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ExerciseVO exercise = null;
		String sql = null;
		try {
			conn=DBUtil.getConnection();
			sql = "SELECT * FROM exercise WHERE exe_num = ?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, exe_num);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				exercise = new ExerciseVO();
				exercise.setExe_num(exe_num);
				exercise.setMem_num(rs.getInt("mem_num"));
				exercise.setExe_type(rs.getString("exe_type"));
				exercise.setExe_time(rs.getInt("exe_time"));
				exercise.setExe_date(rs.getString("exe_date"));
				exercise.setExe_content(rs.getString("exe_content"));
			}
		}catch(Exception e){
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return exercise;
	}
	//날짜별 총 운동시간 구하기
	public int calExetime(String exe_date, int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int total_exetime=0;
		try {
			conn=DBUtil.getConnection();
			sql="SELECT SUM(exe_time) AS total_exetime FROM exercise WHERE exe_date= ?  AND mem_num = ? GROUP BY exe_date";
			pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, exe_date);
            pstmt.setInt(2, mem_num);
            rs = pstmt.executeQuery();
            if(rs.next()) {
            	total_exetime =rs.getInt("total_exetime");
            }
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return total_exetime;
	}
	


}