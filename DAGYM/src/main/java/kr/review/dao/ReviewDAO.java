package kr.review.dao;

public class ReviewDAO {
	//싱글톤 패턴 작성
	private static ReviewDAO instance = new ReviewDAO();
	
	public static ReviewDAO getInstance() {
		return instance;
	}
	
	private ReviewDAO() {}
	
	/*        사용자        */
	//수강내역 불러오기
	 
	//수강후기 등록
	
	//수강후기 수정
	//수강후기 삭제
	//수강후기 목록(전체)
	//수강후기 상세 -> pass
	
	/*       관리자&관리자     */
	//수강후기 목록(이름 전체) ?
	//수강후기 삭제(게시보류)
}
