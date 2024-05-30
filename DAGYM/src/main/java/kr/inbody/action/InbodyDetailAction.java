package kr.inbody.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.inbody.dao.InbodyDAO;
import kr.inbody.vo.InbodyVO;

public class InbodyDetailAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num == null) {
			request.setAttribute("notice_msg", "로그인 후 확인가능합니다.");
			request.setAttribute("notice_url", request.getContextPath()+"/common/loginForm.do");
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		String inb_date = request.getParameter("inb_date");
		InbodyDAO inbodydao = InbodyDAO.getInstance();
		InbodyVO inbody = inbodydao.getInbody(inb_date, user_num);
		
		double heightInMeters = inbody.getInb_hei() / 100.0; // cm를 미터로 계산
        double bmi = inbody.getInb_wei() / (Math.pow(heightInMeters, 2));
        int bmi2 = (int) Math.round(bmi);
		request.setAttribute("inbody", inbody);
		request.setAttribute("inb_date", inb_date);
		request.setAttribute("inb_bmi", bmi2);
		
		return "/WEB-INF/views/inbody/inbodyDetail.jsp";
	}

}
