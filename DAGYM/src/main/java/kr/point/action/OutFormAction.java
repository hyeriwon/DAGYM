package kr.point.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;

public class OutFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
        HttpSession session = request.getSession();
        Integer user_num = (Integer)session.getAttribute("user_num");
        Integer user_auth = (Integer)session.getAttribute("user_auth");

        if(user_num == null || (user_auth != 8 && user_auth != 9)) {
            //로그인이 안되었거나 관리자가 아닌 경우
            return "redirect:/member/loginForm.do";
        }

        //요청으로부터 mem_num 파라미터를 받음
        String mem_num = request.getParameter("mem_num");
        if (mem_num == null || mem_num.isEmpty()) {
            //mem_num이 없으면 오류 처리
            return "redirect:/point/outForm.do";
        }
        
        request.setAttribute("mem_num", mem_num);
	
		//JSP 경로 반환
		return "/WEB-INF/views/point/outForm.jsp";
	}
}
