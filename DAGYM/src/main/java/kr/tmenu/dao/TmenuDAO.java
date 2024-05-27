package kr.tmenu.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
	//오늘의 메뉴 갯수 구하기
	public int getCountTmenu(String keyfield, String keyword) throws Exception{
		Connection conn= null;
		PreparedStatement pstmt=null;
		ResultSet rs =null;
		String sql = null;
		String sub_sql = "";
		int count= 0;
		int cnt = 0;
		try {
			conn = DBUtil.getConnection();
			if(keyword!=null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql +=" WHERE tme_name LIKE '%' || ? ||'%'";
			}
			sql= "SELECT COUNT(*) FROM t_menu" + sub_sql;
			pstmt =conn.prepareStatement(sql);
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
	//오늘의 메뉴 목록
	public List<TmenuVO> getListTmenu(int start,int end, String keyfield, String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		List<TmenuVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		try {
			conn=DBUtil.getConnection();
			if(keyword != null && !"".equals(keyword)) {
				//검색 처리
				if(keyfield.equals("1")) sub_sql += " WHERE tme_name LIKE '%'||?||'%'";
			}
			sql="SELECT * FROM (SELECT a.*,rownum rnum FROM "
					+ "(SELECT * FROM t_menu "+ sub_sql +")a) WHERE rnum >=? AND rnum <=?";
			pstmt=conn.prepareStatement(sql);
			if(keyword!=null && !"".equals(keyword)) {
				pstmt.setString(++cnt,keyword);
			}
			pstmt.setInt(++cnt,start);
			pstmt.setInt(++cnt,end);
			rs=pstmt.executeQuery();
			list = new ArrayList<TmenuVO>();
			while(rs.next()) {
				TmenuVO item = new TmenuVO();
				item.setTme_content(rs.getString("tme_content"));
				item.setTme_num(rs.getInt("tme_num"));
				item.setTme_crabs(rs.getInt("tme_crabs"));
				item.setTme_kcal(rs.getInt("tme_kcal"));
				item.setTme_lipid(rs.getInt("tme_lipid"));
				item.setTme_name(rs.getString("tme_name"));
				item.setTme_photo(rs.getString("tme_photo"));
				item.setTme_protein(rs.getInt("tme_protein"));
				item.setTme_type(rs.getInt("tme_type"));
				list.add(item);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	//오늘의 메뉴 상세보기
	public TmenuVO getTmenuDetail (int tme_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		TmenuVO item = null;
		String sql = null;
		try {
			conn=DBUtil.getConnection();
			sql = "SELECT * FROM t_menu WHERE tme_num =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, tme_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				item = new TmenuVO();
				item.setTme_content(rs.getString("tme_content"));
				item.setTme_num(rs.getInt("tme_num"));
				item.setTme_crabs(rs.getInt("tme_crabs"));
				item.setTme_kcal(rs.getInt("tme_kcal"));
				item.setTme_lipid(rs.getInt("tme_lipid"));
				item.setTme_name(rs.getString("tme_name"));
				item.setTme_photo(rs.getString("tme_photo"));
				item.setTme_protein(rs.getInt("tme_protein"));
				item.setTme_type(rs.getInt("tme_type"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return item;
	}
	//오늘의 메뉴 삭제
	//파일삭제
	//메뉴 타입별 분류하기
}

