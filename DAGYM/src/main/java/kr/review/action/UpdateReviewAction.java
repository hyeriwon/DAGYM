package kr.review.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.review.dao.ReviewDAO;
import kr.review.vo.ReviewVO;
import kr.util.FileUtil;

public class UpdateReviewAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer mem_num = (Integer) session.getAttribute("user_num");
		
		//로그인 여부 확인하기
		if(mem_num==null) {
			return "redirect:/member/loginForm.do";
		}
		
		//전송된 데이터 인코딩 타입 지정
		request.setCharacterEncoding("utf-8");		
		
		//전송된 데이터 반환
		int rev_num = Integer.parseInt(request.getParameter("rev_num"));
		
		ReviewDAO dao = ReviewDAO.getInstance();
		
		//수정 전 데이터 불러오기
		ReviewVO db_review = dao.getReview(rev_num);
		
		//로그인한 회원번호와 후기 작성 회원번호가 같은지 확인
		if(mem_num != db_review.getMem_num()) {
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		//전송된 데이터 반환받아 reviewVO 객체에 대입
		ReviewVO review = new ReviewVO();
		review.setRev_num(rev_num);
		review.setRev_title(request.getParameter("rev_title"));
		review.setRev_grade(Integer.parseInt(request.getParameter("rev_grade")));
		review.setRev_filename1(FileUtil.createFile(request, "rev_filename1"));
		review.setRev_fileExist1(Integer.parseInt(request.getParameter("rev_fileExist1")));
		review.setRev_filename2(FileUtil.createFile(request, "rev_filename2"));
		review.setRev_fileExist2(Integer.parseInt(request.getParameter("rev_fileExist2")));
		review.setRev_content(request.getParameter("rev_content"));		
		review.setRev_ip(request.getRemoteAddr()); 
		
		System.out.println("fileExist1: "+review.getRev_fileExist1());
		System.out.println("fileExist2: "+review.getRev_fileExist2());
		
		//DB에 review 수정하기
		dao.updateReview(review);
		
		//이전 파일 삭제하기
		if(review.getRev_filename1()!=null && !"".equals(review.getRev_filename1())) {
			FileUtil.removeFile(request, db_review.getRev_filename1());
		}
		if(review.getRev_filename2()!=null && !"".equals(review.getRev_filename2())) {
			FileUtil.removeFile(request, db_review.getRev_filename2());
		}
		
		return "redirect:/review/detailReview.do?rev_num="+rev_num;
	}

}
