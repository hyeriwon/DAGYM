package kr.history.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;

public class HistoryEnrollFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		Integer user_num = (Integer) session.getAttribute("user_num"); 
		  if (user_num == null) { // 로그인이 되지 않은 경우 
			  return "redirect:/member/loginForm.do";
		  }
		  
		     // 전달받은 날짜를 request에 설정
	        String his_date = request.getParameter("his_date");
	        request.setAttribute("his_date", his_date);
		  
		return "/WEB-INF/views/history/historyEnrollForm.jsp";
	}

}
