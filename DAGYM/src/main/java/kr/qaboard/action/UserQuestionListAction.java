package kr.qaboard.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.qaboard.dao.QABoardDAO;
import kr.qaboard.vo.QABoardVO;
import kr.util.PagingUtil;

public class UserQuestionListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		
		//로그인 확인
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) {
			return "redirect:/member/loginForm.do";
		}
		
		request.setCharacterEncoding("utf-8");
		
		//페이지처리
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) pageNum = "1";
		
		QABoardDAO qaboardDAO = QABoardDAO.getInstance();
		int count = qaboardDAO.getInquiryCount(user_num);
		
		PagingUtil page = new PagingUtil(Integer.parseInt(pageNum), count, 20,10,"userQuestionList.do");
		
		List<QABoardVO> list = null;
		if(count > 0) {
			list = qaboardDAO.getInquiryList(user_num, page.getStartRow(), page.getEndRow());
		}
		
		request.setAttribute("count", count);
        request.setAttribute("list", list);
        request.setAttribute("page", page.getPage());
		
		return "/WEB-INF/views/qaboard/userQuestionList.jsp";
	}
	
}
