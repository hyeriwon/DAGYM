package kr.review.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.review.dao.ReviewDAO;
import kr.review.vo.RevReportVO;

public class ReportReviewAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//로그인 여부 확인하기
		HttpSession session = request.getSession();
		Integer user_num = (Integer) session.getAttribute("user_num");
		
		if(user_num==null) {
			return "/WEB-INF/views/common/notice_view.jsp";
		}
		
		//회원 등급 확인하기
		Integer user_auth = (Integer) session.getAttribute("user_auth");
		
		if(user_auth==9) {
			return "/WEB-INF/views/common/notice_view.jsp";
		}
		
		//데이터 인코딩 타입 지정
		request.setCharacterEncoding("utf-8");
		
		//반환된 데이터 받기
		int rev_num = Integer.parseInt(request.getParameter("rev_num"));
		int mem_num = Integer.parseInt(request.getParameter("mem_num"));
		String report_content = request.getParameter("report_content");
		
		//신고 여부 확인하기
		RevReportVO revReport = new RevReportVO();
		revReport.setRev_num(rev_num);
		revReport.setMem_num(mem_num);
		revReport.setReport_content(report_content);
		
		ReviewDAO dao = ReviewDAO.getInstance();
		RevReportVO db_revReport = dao.checkRevReport(revReport);
		
		//신고 불가능(이미 신고한 이력이 있으며 신고가 승인되지 않은 상태)
		if(db_revReport!=null && db_revReport.getReport_del()==0) {
			request.setAttribute("notice_msg", "신고 내역이 처리 중입니다.");
			request.setAttribute("notice_url", "detailReview.do?rev_num="+rev_num);
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		
		//신고하기
		dao.insertRevReport(revReport);
		
		request.setAttribute("notice_msg", "신고 완료되었습니다!");
		request.setAttribute("notice_url", "detailReview.do?rev_num="+rev_num);
		
		return "/WEB-INF/views/common/alert_view.jsp";
	}

}
