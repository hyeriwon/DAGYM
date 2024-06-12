package kr.qaboard.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.qaboard.dao.QABoardDAO;
import kr.qaboard.vo.QABoardVO;
import kr.util.PagingUtil;

public class AdminAnswerListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		
		//로그인 확인
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) {
			return "redirect:/member/loginForm.do";
		}
		
		//로그인한 사람이 관리자,강사가 맞는지 체크
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_auth < 8) {
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		request.setCharacterEncoding("utf-8");
		
		//페이지처리
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) pageNum = "1";
		
		//검색
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");
		String category = request.getParameter("category");
		
		QABoardDAO dao = QABoardDAO.getInstance();
		int count = dao.getAnswerCount(keyfield, keyword,category);
		
		PagingUtil page = new PagingUtil(keyfield, keyword, Integer.parseInt(pageNum), count, 20, 10, "adminAnswerList.do");
		
		List<QABoardVO> list = null;
		if(count > 0) {
			list = dao.getAnswerList(page.getStartRow(), page.getEndRow(), keyfield, keyword, category);
		}
		
		request.setAttribute("count", count);
        request.setAttribute("list", list);
        request.setAttribute("page", page.getPage());
		
		return "/WEB-INF/views/qaboard/adminAnswerList.jsp";
	}

}
