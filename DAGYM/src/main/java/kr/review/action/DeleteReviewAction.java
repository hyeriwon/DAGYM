package kr.review.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.review.dao.ReviewDAO;
import kr.review.vo.ReviewVO;
import kr.util.FileUtil;

public class DeleteReviewAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer) session.getAttribute("user_num");
		
		if(user_num==null) {
			return "redirect:/review/deleteReview.do";
		}
		
		request.setCharacterEncoding("utf-8");
			
		int rev_num = Integer.parseInt(request.getParameter("rev_num"));
			
		//db_review의 mem_num 값과 비교하기
		ReviewDAO dao = ReviewDAO.getInstance();
		ReviewVO db_review = dao.getReview(rev_num);
			
		if(db_review.getMem_num()!=user_num) {
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		dao.deleteReview(db_review);
				
		//서버의 파일 삭제
		FileUtil.removeFile(request, db_review.getRev_filename1());
		FileUtil.removeFile(request, db_review.getRev_filename2());		
		
		request.setAttribute("notice_msg", "삭제되었습니다.");
		request.setAttribute("notice_url", request.getContextPath()+"/review/listReview.do");
		
		return "/WEB-INF/views/common/alert_view.jsp";
	}

}
