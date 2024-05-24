package kr.history.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;

public class EnrollFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		String sch_date = request.getParameter("sch_date");
		String tra_num = request.getParameter("mem_num");
		
		
		//날짜와 트레이너 번호를 request에 저장하여 JSP에 전달
		request.setAttribute("sch_date", sch_date);
		request.setAttribute("tra_num", tra_num);
		
		//로그인 된 경우
		return "/WEB-INF/views/history/enrollForm.jsp";
	}

}
