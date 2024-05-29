package kr.review.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.review.dao.ReviewDAO;
import kr.review.vo.ReviewVO;
import kr.util.FileUtil;

public class WriteReviewAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//로그인 여부 확인하기
		HttpSession session = request.getSession();
		Integer mem_num = (Integer) session.getAttribute("user_num");

		if(mem_num==null) {
			return "redirect:/member/loginForm.do";
		}
		
		//전송된 데이터 인코딩 타입 지정
		request.setCharacterEncoding("utf-8");
		
		//전송된 데이터 반환받아 reviewVO 객체에 대입
		ReviewVO review = new ReviewVO();
		review.setMem_num(mem_num);
		review.setSch_num(Integer.parseInt(request.getParameter("sch_num")));
		review.setRev_grade(Integer.parseInt(request.getParameter("rev_grade")));
		review.setRev_title(request.getParameter("rev_title"));
		review.setRev_content(request.getParameter("rev_content"));
		review.setRev_filename1(FileUtil.createFile(request, "filename1"));
		review.setRev_filename2(FileUtil.createFile(request, "filename2"));
		review.setRev_ip(request.getRemoteAddr());
		
		//DB에 review 기록하기
		ReviewDAO dao = ReviewDAO.getInstance();
		dao.insertReview(review);
		
		request.setAttribute("notice_msg", "수강후기 작성을 완료했습니다.");
		request.setAttribute("notice_url", "수강후기 목록 url");
		
		return "WEB-INF/views/common/alert_view.jsp";
	}

}
