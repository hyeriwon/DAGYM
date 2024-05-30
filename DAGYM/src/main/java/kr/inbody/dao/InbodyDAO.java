package kr.inbody.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.inbody.vo.InbodyVO;
import kr.util.DBUtil;

public class InbodyDAO {
	//싱글턴 패턴
	private static InbodyDAO instance = new InbodyDAO();
	public static InbodyDAO getInstance() {
		return instance;
	}
	private InbodyDAO() {}
	
	//인바디 등록
	public void insertInbody(InbodyVO inbody)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			sql="INSERT INTO inbody(inb_num,mem_num,inb_hei,inb_wei,inb_mus,inb_date,inb_photo)"
					+ " VALUES(inbody_seq.nextval,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, inbody.getMem_num());
			pstmt.setInt(2, inbody.getInb_hei());
			pstmt.setInt(3, inbody.getInb_wei());
			pstmt.setInt(4, inbody.getInb_mus());
			pstmt.setString(5, inbody.getInb_date());
			pstmt.setString(6, inbody.getInb_photo());
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//인바디 삭제
	//인바디 상세
	public InbodyVO getInbody(int inb_num, int mem_num)throws Exception	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		InbodyVO inbody = null;
		
		try {
			conn= DBUtil.getConnection();
			sql = "SELECT * FROM inbody WHERE mem_num = ? AND inb_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
			pstmt.setInt(2, inb_num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				inbody = new InbodyVO();
				inbody.setMem_num(mem_num);
				inbody.setInb_num(inb_num);
				inbody.setInb_date(rs.getString("inb_date"));
				inbody.setInb_mus(rs.getInt("inb_mus"));
				inbody.setInb_hei(rs.getInt("inb_hei"));
				inbody.setInb_wei(rs.getInt("inb_wei"));
				inbody.setInb_photo(rs.getString("inb_photo"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
		return inbody;
	}
	
	//인바디 수정
	//인바디 검색 갯수(회원별)
	public int countInbodyByUser(String keyfield, String keyword, int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		String sql = null;
		String sub_sql = "";
		try {
			conn = DBUtil.getConnection();
			if(keyword !=null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql+= "AND inb_date LIKE  '%' || ? || '%'";
			}
			sql="SELECT count(*) FROM inbody WHERE mem_num = ? "+sub_sql;
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,mem_num);
			if(keyword !=null && !"".equals(keyword)) {
			pstmt.setString(2,keyword);
			}
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
		return count;
	}
	//회원별 인바디 검색 (날짜별)
	public List<InbodyVO> getListInbodyByUser(int start, int end, String keyword, String keyfield ,int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<InbodyVO> list= null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		try {
			conn = DBUtil.getConnection();
			if(keyword !=null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql+= "AND inb_date LIKE '%' || ? || '%'";
			}
			sql="SELECT * FROM (SELECT a.*, rownum rnum  FROM (SELECT * FROM inbody WHERE mem_num = ?"
					+sub_sql+" ORDER BY inb_date DESC)a) "
				+ "WHERE rnum >=? AND rnum <=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(++cnt,mem_num);
			if(keyword !=null && !"".equals(keyword)) {
			pstmt.setString(++cnt,keyword);
			}
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			rs = pstmt.executeQuery();
			list = new ArrayList<InbodyVO>();
			while(rs.next()) {
				InbodyVO inbody = new InbodyVO();
				inbody.setInb_num(rs.getInt("inb_num"));
				inbody.setMem_num(rs.getInt("mem_num"));
				inbody.setInb_date(rs.getString("inb_date"));
				inbody.setInb_hei(rs.getInt("inb_hei"));
				inbody.setInb_wei(rs.getInt("inb_wei"));
				inbody.setInb_mus(rs.getInt("inb_mus"));
				inbody.setInb_photo(rs.getString("inb_photo"));
				list.add(inbody);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
		return list;
	}
	
	
}
