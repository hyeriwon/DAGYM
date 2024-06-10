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
        Integer user_auth = (Integer)session.getAttribute("user_auth");

		
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
		
		//로그인한 사람과 수강한 사람의 일치 여부 확인, 관리자 조건 추가
		if(mem_num != history.getMem_num() && user_auth != 9) {
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		
		MemberDAO memDAO = MemberDAO.getInstance();
		MemberVO trainer = memDAO.getMember(history.getTra_num());
		
		//해당 PT에 대해 이미 후기가 작성되었는지 확인
		ReviewDAO revDAO = ReviewDAO.getInstance();
		ReviewVO review = revDAO.checkReview(sch_num);
		if(review!=null && review.getRev_del()==0) {
			String notice_msg = "이미 후기를 작성했습니다.";
			String notice_url = request.getContextPath()+"/review/listReview.do";
			request.setAttribute("notice_msg", notice_msg);
			request.setAttribute("notice_url", notice_url);
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		
		request.setAttribute("history", history);
		request.setAttribute("trainer", trainer);
		
		return "/WEB-INF/views/review/writeReviewForm.jsp";
	
	}
}
