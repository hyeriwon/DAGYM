package kr.exercise.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import kr.exercise.vo.ExerciseVO;
import kr.util.DBUtil;

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
			pstmt.setInt(1, exercise.getExe_num());
			pstmt.setInt(2, exercise.getMem_num());
			pstmt.setString(3, exercise.getExe_type());
			pstmt.setString(4, exercise.getExe_content());
			pstmt.setString(5, exercise.getExe_date());
			pstmt.setInt(6, exercise.getExe_time());
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//운동기록 삭제
	//운동 기록 갯수(전체,검색)
	//운동 기록 리스트(전체,검색)
	//운동기록 수정
	
	

}
