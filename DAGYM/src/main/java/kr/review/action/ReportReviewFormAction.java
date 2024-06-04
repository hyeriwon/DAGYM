package kr.review.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;

public class ReportReviewFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//로그인 여부 확인
		HttpSession session = request.getSession();
		Integer user_num = (Integer) session.getAttribute("user_num");
		
		//로그인한 회원의 등급 받아오기
		Integer user_auth = (Integer) session.getAttribute("user_auth");
		
		//후기 글번호 받아오기
		int rev_num = Integer.parseInt(request.getParameter("rev_num"));
		
		if(user_num==null) {
			request.setAttribute("notice_msg", "로그인 후 신고 가능합니다.");
			request.setAttribute("notice_url", "detailReview.do?rev_num="+rev_num);
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		
		if(user_auth!=2) {
			return "/WEB-INF/views/common/notice_view.jsp";
		}
		
		request.setAttribute("user_num", user_num);
		//request.setAttribute("user_auth", user_auth);
		request.setAttribute("rev_num", rev_num);
		
		return "/WEB-INF/views/review/reportReviewForm.jsp";
	}

}
