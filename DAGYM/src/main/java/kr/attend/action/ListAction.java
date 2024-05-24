package kr.attend.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.attend.dao.AttendDAO;
import kr.attend.vo.AttendVO;
import kr.controller.Action;
import kr.util.PagingUtil;

public class ListAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num == null) {//로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		//로그인 된 경우
		
		//선택한 페이지 반환
		String pageNum = request.getParameter("pageNum");

		if(pageNum == null)
			pageNum = "1";

		AttendDAO dao = AttendDAO.getInstance();
		int count = dao.getCount();
		
										//currentPage,count,rowCount,pageCount
		PagingUtil page = new PagingUtil(Integer.parseInt(pageNum),count,20,10,"list.do");

		List<AttendVO> list = null;
		if(count > 0)
			list = dao.getList(user_num,page.getStartRow(),page.getEndRow());
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("page", page.getPage());
		
		//JSP 경로 반환
		return "/WEB-INF/views/attend/list.jsp";
	}
}