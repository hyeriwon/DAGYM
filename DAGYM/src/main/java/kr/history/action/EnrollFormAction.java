package kr.history.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.payment.dao.PaymentDAO;
import kr.payment.vo.PaymentVO;
import kr.schedule.dao.ScheduleDAO;
import kr.schedule.vo.ScheduleVO;

public class EnrollFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		//로그인 된 경우
		request.setCharacterEncoding("utf-8");
		int sch_num = Integer.parseInt(request.getParameter("sch_num"));
		int mem_num = Integer.parseInt(request.getParameter("mem_num"));
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
		PaymentDAO paymentDAO = PaymentDAO.getInstance();
		//MemberDAO memberDAO = MemberDAO.getInstance();
		
		//ScheduleVO schedule = ScheduleDAO.getSchedule(sch_num);
		//PaymentVO payment = paymentDAO.getPayment(mem_num);
		
		//if(mem_num==)
		
		/*
		if (schedule != null) { // 스케줄이 존재하면
			request.setAttribute("schedule", schedule);
			request.setAttribute("payment", payment);
		} else { // 스케줄이 없으면
			request.setAttribute("result", "scheduleNotFound");
		}
		*/
		return "/WEB-INF/views/history/enrollForm.jsp";
	}

}
