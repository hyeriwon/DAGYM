package kr.nboard.dao;

public class NboardDAO {
	//싱글턴 패턴
	private static NboardDAO instance = new NboardDAO();
	
	public static NboardDAO getInstance() {
		return instance;
	}
	private NboardDAO() {}
	
	//공지사항 등록
	
	//총 글의 개수, 검색 개수
	
	//글 목록, 검색 글 목록
	
	//글 상세
	
	//조회수 증가
	
	//파일 삭제
	
	//글 수정
	
	//글 삭제
	
}
