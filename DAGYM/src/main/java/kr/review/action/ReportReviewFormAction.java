package kr.review.action; 

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.review.dao.ReviewDAO;
import kr.review.vo.RevReportVO;

public class ReportReviewFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//로그인 여부 확인
		HttpSession session = request.getSession();
		Integer user_num = (Integer) session.getAttribute("user_num");

		//로그인한 회원의 등급 받아오기
		Integer user_auth = (Integer) session.getAttribute("user_auth");

		if(user_auth==9) {
			return "/WEB-INF/views/common/notice_view.jsp";
		}

		//후기 글번호 받아오기
		int rev_num = Integer.parseInt(request.getParameter("rev_num"));
		
		//미 로그인시 신고 불가
		if(user_num==null) {
			request.setAttribute("notice_msg", "로그인 후 신고 가능합니다.");
			request.setAttribute("notice_url", "detailReview.do?rev_num="+rev_num);
			return "/WEB-INF/views/common/alert_view.jsp";
		}

		//신고 여부 확인하기
		RevReportVO revReport = new RevReportVO();
		revReport.setRev_num(rev_num);
		revReport.setMem_num(user_num);

		ReviewDAO dao = ReviewDAO.getInstance();
		RevReportVO db_revReport = dao.checkRevReport(revReport);

		//신고 불가능
		if(db_revReport!=null && db_revReport.getReport_del()==0) {//(이미 신고한 이력이 있으며 신고가 승인되지 않은 상태)
			request.setAttribute("notice_msg", "신고 내역이 처리 중입니다.");
			request.setAttribute("notice_url", "detailReview.do?rev_num="+rev_num);
			return "/WEB-INF/views/common/alert_view.jsp";
		}else if(db_revReport!=null && db_revReport.getReport_del()==1) {//(이미 신고한 이력이 있으며 신고가 승인된 상태)
			request.setAttribute("notice_msg", "신고 접수는 글 1개당 1번만 가능합니다.");
			request.setAttribute("notice_url", "detailReview.do?rev_num="+rev_num);
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		
		request.setAttribute("user_num", user_num);
		//request.setAttribute("user_auth", user_auth);
		request.setAttribute("rev_num", rev_num);

		return "/WEB-INF/views/review/reportReviewForm.jsp";
	}

}
