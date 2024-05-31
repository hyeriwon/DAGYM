package kr.schedule.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;

public class ScheduleEnrollFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		Integer user_num = (Integer) session.getAttribute("user_num"); 
		  if (user_num == null) { // 로그인이 되지 않은 경우 
			  return "redirect:/member/loginForm.do";
		  }
		  
		     // 전달받은 날짜를 request에 설정
	        String sch_date = request.getParameter("sch_date");
		

	        request.setAttribute("sch_date", sch_date);

		  
		return "/WEB-INF/views/schedule/scheduleEnrollForm.jsp";
	}

}
