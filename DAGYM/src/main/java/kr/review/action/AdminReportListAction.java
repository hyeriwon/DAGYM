package kr.review.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.review.dao.ReviewDAO;
import kr.review.vo.RevReportVO;
import kr.util.PagingUtil;

public class AdminReportListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer) session.getAttribute("user_num");
		Integer user_auth = (Integer) session.getAttribute("user_auth");
		
		//로그인 여부 확인
		if(user_num==null) {
			return "redirect:/member/loginForm.do";
		}

		//관리자가 아닌 경우 접근 불가
		if(user_auth!=9) {
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		//검색유형, 검색어 받아오기		
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");
		
		//현재 페이지 번호 받아오기
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) pageNum="1";
		
		//해당되는 전체 페이지 번호 받아오기
		ReviewDAO dao = ReviewDAO.getInstance();		
		int count = dao.getReportCount(keyfield, keyword);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,Integer.parseInt(pageNum),count,20,10,"adminReportList.do");
		List<RevReportVO> list = null;
		if(count > 0) {
			list = dao.getAdminListReport(page.getStartRow(), page.getEndRow(), keyfield, keyword);
		}
		
		request.setAttribute("list", list);
		request.setAttribute("count", count);
		request.setAttribute("page", page.getPage());
		
		return "/WEB-INF/views/review/adminReportList.jsp";
	}

}
