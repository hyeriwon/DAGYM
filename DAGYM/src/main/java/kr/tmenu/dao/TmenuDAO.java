package kr.tmenu.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import kr.tmenu.vo.TmenuVO;
import kr.util.DBUtil;

public class TmenuDAO {
	
	private static TmenuDAO instance = new TmenuDAO();
	public static TmenuDAO getInstance() {
		return instance;
	}
	private TmenuDAO() {}
	
	//오늘의 메뉴 등록
	public void insertTmenu(TmenuVO tmenu)throws Exception	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			sql="insert INTO t_menu (tme_num,tme_name,tme_content,tme_kcal, tme_protein, tme_crabs,tme_lipid,tme_photo,tme_type)values "
					+ "(tmenu_seq.nextval,?,?,?,?,?,?,?,?)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,tmenu.getTme_name());
			pstmt.setString(2, tmenu.getTme_content());
			pstmt.setInt(3, tmenu.getTme_kcal());
			pstmt.setInt(4, tmenu.getTme_protein());
			pstmt.setInt(5, tmenu.getTme_crabs());
			pstmt.setInt(6, tmenu.getTme_lipid());
			pstmt.setString(7, tmenu.getTme_photo());
			pstmt.setInt(8, tmenu.getTme_type());
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//오늘의 메뉴 수정
	//오늘의 메뉴 목록
	//오늘의 메뉴 상세보기
	//오늘의 메뉴 삭제
	//파일삭제
	//메뉴 타입별 분류하기
}
