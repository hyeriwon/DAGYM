package kr.history.action;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
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
		/*
		ScheduleVO schedule = ScheduleDAO.getSchedule(sch_num);//DAO에서
		PaymentVO payment = paymentDAO.getPayment(mem_num);
		
		HashMap<String, Object> mapAjax = new HashMap<>();
		if(schedule!=null) {//스케줄이 존재하면
			mapAjax.put("schedule", schedule);
			mapAjax.put("payment", payment);
		}else {//스케줄이 없으면
			mapAjax.put("result", "scheduleNotFound");
		}
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("map", mapAjax);
		*/
		return "/WEB-INF/views/history/enrollForm.jsp";
	}

}
