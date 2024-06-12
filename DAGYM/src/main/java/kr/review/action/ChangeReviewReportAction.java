package kr.review.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.review.dao.ReviewDAO;
import kr.review.vo.RevReportVO;
import kr.review.vo.ReviewVO;

public class ChangeReviewReportAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,String> mapAjax = new HashMap<>();
		
		//관리자 로그인 확인하기
		HttpSession session = request.getSession();
		Integer user_num = (Integer) session.getAttribute("user_num");
		Integer user_auth = (Integer) session.getAttribute("user_auth");

		if(user_num==null) {
			mapAjax.put("result", "logout");
		}else if(user_num!=null && user_auth!=9) {
			mapAjax.put("result","notAuthority");
		}else {
			request.setCharacterEncoding("utf-8");
			
			int rev_num = Integer.parseInt(request.getParameter("rev_num"));
			int mem_num = Integer.parseInt(request.getParameter("mem_num"));
			
			ReviewDAO dao = ReviewDAO.getInstance();
			RevReportVO report = new RevReportVO();
			report.setRev_num(rev_num);
			report.setMem_num(mem_num);
			
			RevReportVO db_report = dao.checkRevReport(report);
			
			//report_del=0이면 신고 승인, report_del=1이면 신고 취소
			if(db_report==null) {
				mapAjax.put("result", "notExistReport");
			}else {
				if(db_report.getReport_del()==0) {
					dao.AdminReportYes(db_report);					
					mapAjax.put("status", "reportYes");
					if(dao.totalRevReport(rev_num) >= 3) {
						dao.blindReview(rev_num);
						ReviewVO db_review = dao.getReview(db_report.getRev_num());
						MemberDAO memDAO = MemberDAO.getInstance();
						memDAO.updateMemberByAdmin(1, db_review.getMem_num());
						mapAjax.put("count", "blind");
					}
				}else if(db_report.getReport_del()==1) {
					dao.AdminReportNo(db_report);				
					mapAjax.put("status", "reportNo");
					if(dao.totalRevReport(rev_num) == 2) {
						dao.cancelBlindReview(rev_num);
						ReviewVO db_review = dao.getReview(db_report.getRev_num());
						MemberDAO memDAO = MemberDAO.getInstance();
						memDAO.updateMemberByCancel(2, db_review.getMem_num());
						mapAjax.put("count", "clearBlind");
					}
				}
				mapAjax.put("result", "success");
			} 
						
		}
		//JSON 문자열 만들기
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
