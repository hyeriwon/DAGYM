package kr.review.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.history.dao.HistoryDAO;
import kr.history.vo.HistoryVO;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;
import kr.review.dao.ReviewDAO;
import kr.review.vo.ReviewVO;

public class DetailReviewAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer) session.getAttribute("user_num");
		
		int rev_num = Integer.parseInt(request.getParameter("rev_num"));
		
		ReviewDAO dao = ReviewDAO.getInstance();
		dao.updateReadCount(rev_num);
		ReviewVO review = dao.getReview(rev_num);
		
		HistoryDAO historyDAO = HistoryDAO.getInstance();
		HistoryVO history = historyDAO.getHistory(review.getSch_num());
		
		MemberDAO memberDAO = MemberDAO.getInstance();
		MemberVO user = memberDAO.getMember(user_num);
		MemberVO member = memberDAO.getMember(history.getMem_num());
		MemberVO trainer = memberDAO.getMember(history.getTra_num());
		
		request.setAttribute("review", review);
		request.setAttribute("history", history);
		request.setAttribute("member", member);
		request.setAttribute("trainer", trainer);
		request.setAttribute("user", user);
		
		return "/WEB-INF/views/review/detailReview.jsp";
	}

}
