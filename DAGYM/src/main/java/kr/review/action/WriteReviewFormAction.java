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

public class WriteReviewFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//로그인 여부 확인하기
		HttpSession session = request.getSession();
		Integer mem_num = (Integer) session.getAttribute("user_num");
		
		if(mem_num==null) {
			return "redirect:/member/loginForm.do";
		}
				
		//수강 완료 여부 확인하기 -> 수강후기 작성 버튼을 <a>태그에 작성하여 get방식으로 sch_num 넘겨주기		
		int sch_num = Integer.parseInt(request.getParameter("sch_num"));
				
		HistoryDAO dao = HistoryDAO.getInstance();
		HistoryVO history = dao.getHistory(sch_num);
		
		if(history.getHis_status()!=2) {
			return "redirect:/history/히스토리목록보는 페이지";
		}
		
		//로그인한 사람과 수강한 사람의 일치 여부 확인
		if(mem_num != history.getMem_num()) {
			request.setAttribute("notice_msg", "수강후기 작성 권한이 없습니다.");
			request.setAttribute("notice_url", request.getContextPath()+"/history/히스토리목록보는 페이지");
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		
		MemberDAO memDAO = MemberDAO.getInstance();
		MemberVO trainer = memDAO.getMember(history.getTra_num());
		
		//해당 PT에 대해 이미 후기가 작성되었는지 확인
		ReviewDAO revDAO = ReviewDAO.getInstance();
		/* ReviewVO review = revDAO.getReview(sch_num); */
		
		request.setAttribute("history", history);
		request.setAttribute("trainer", trainer);
		
		return "/WEB-INF/views/review/writeReviewForm.jsp";
	
	}
}
