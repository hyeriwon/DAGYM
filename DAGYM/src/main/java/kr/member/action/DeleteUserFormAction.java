package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;

public class DeleteUserFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer mem_num = (Integer) session.getAttribute("user_num");
		
		if(mem_num==null) {//로그인 실패시
			return "redirect:/member/loginForm.do";
		}
		
		//JSP 경로 반환
		return "/WEB-INF/views/member/deleteUserForm.jsp";
	}

}
