package kr.schedule.action;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.schedule.dao.ScheduleDAO;

public class AdminScheduleDeleteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
        Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		if(user_num == null || user_auth != 9) { //로그인이 안되었거나 관리자가 아닌 경우
            return "redirect:/member/loginForm.do";
        }
		//로그인 된 경우
		//전송된 데이터 인코딩 타입 지정
		request.setCharacterEncoding("utf-8");
		
		int schNum = Integer.parseInt(request.getParameter("sch_num"));
		
		ScheduleDAO dao = ScheduleDAO.getInstance();
		dao.deleteScheduleByAdmin(schNum);
		
		//JSP 경로 반환
		return "/WEB-INF/views/schedule/adminScheduleDeleteForm.jsp";
	}
}