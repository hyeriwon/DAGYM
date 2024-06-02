package kr.inbody.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.inbody.dao.InbodyDAO;
import kr.inbody.vo.InbodyVO;

public class InbodyWriteFormAction implements Action{


	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");

		if(user_num == null) {
			request.setAttribute("notice_msg", "로그인 후 작성가능합니다.");
			request.setAttribute("notice_url", request.getContextPath()+"/member/loginForm.do");
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		InbodyDAO inbodydao = InbodyDAO.getInstance();
		String inb_date = request.getParameter("inb_date");
		if(inb_date !=null) {
			InbodyVO inbody = inbodydao.getInbody(inb_date, user_num);
			if(inbody !=null) {
				//해당날짜에 작성된 기록 있으면 작성된 기록으로 이동 
				if(inb_date.equals(inbody.getInb_date())) { 
					request.setAttribute("notice_msg", "인바디 등록된 내역이 있습니다.");
					request.setAttribute("notice_url", request.getContextPath()+"/inbody/inbodyList.do");
					return "/WEB-INF/views/common/alert_view.jsp";				
				}
			}

		}
		return "/WEB-INF/views/inbody/inbodyWriteForm.jsp";
	}
}

