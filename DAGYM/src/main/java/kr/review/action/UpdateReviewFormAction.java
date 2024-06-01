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
import kr.util.StringUtil;

public class UpdateReviewFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer mem_num = (Integer) session.getAttribute("user_num");
		
		if(mem_num==null) {
			return "redirect:/member/loginForm.do";
		}
		
		int rev_num = Integer.parseInt(request.getParameter("rev_num"));
		
		ReviewDAO dao = ReviewDAO.getInstance();
		ReviewVO review = dao.getReview(rev_num);
		
		if(mem_num != review.getMem_num()) {
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		review.setRev_title(StringUtil.parseQuot(review.getRev_title()));
		
		HistoryDAO historyDAO = HistoryDAO.getInstance();
		HistoryVO history = historyDAO.getHistory(review.getSch_num());
		
		MemberDAO memberDAO = MemberDAO.getInstance();
		MemberVO member = memberDAO.getMember(history.getMem_num());
		MemberVO trainer = memberDAO.getMember(history.getTra_num());
		
		request.setAttribute("review", review);
		request.setAttribute("history", history);
		request.setAttribute("member", member);
		request.setAttribute("trainer", trainer);
		
		return "/WEB-INF/views/review/updateReviewForm.jsp";
	}

}
