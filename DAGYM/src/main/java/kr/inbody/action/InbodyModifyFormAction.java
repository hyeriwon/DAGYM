package kr.inbody.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.inbody.dao.InbodyDAO;
import kr.inbody.vo.InbodyVO;

public class InbodyModifyFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num == null) {
			request.setAttribute("notice_msg", "로그인 후 확인가능합니다.");
			request.setAttribute("notice_url", request.getContextPath()+"/member	/loginForm.do");
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		String inb_date = request.getParameter("inb_date");
		System.out.println(inb_date);
		InbodyDAO inbodydao = InbodyDAO.getInstance();
		InbodyVO inbody = inbodydao.getInbody(inb_date, user_num);
		
		request.setAttribute("inbody", inbody);
		request.setAttribute("inb_date", inb_date);
		return "/WEB-INF/views/inbody/inbodyModifyForm.jsp";
	}

}
