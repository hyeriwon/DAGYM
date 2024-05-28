package kr.qaboard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import kr.member.vo.MemberVO;
import kr.util.DBUtil;

public class QABoardDAO {
	//문의내역 정보
	public MemberVO getInquiryHistory(int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberVO member = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			sql = "";
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return member;
	}
	
	//질문 등록
	
	//총 글의 개수, 검색 개수
	
	//글 목록, 검색 글 목록
	
	//글 상세
	
	//파일 삭제
	
	//글 수정
	
	//글 삭제
}
