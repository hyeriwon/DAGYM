package kr.schedule.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.payment.dao.PaymentDAO;

public class ScheduleCompliteFormAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        HttpSession session = request.getSession();
        Integer user_num = (Integer) session.getAttribute("user_num"); 
        
        if (user_num == null) { // 로그인이 되지 않은 경우 
            return "redirect:/member/loginForm.do";
        }
        
        
        // 전달받은 날짜와 mem_num을 request에서 가져오기
        String sch_date = request.getParameter("sch_date");
        int mem_num_history = Integer.parseInt(request.getParameter("mem_num_history"));

        // 로그인한 사용자의 잔여 PT 횟수 조회
        PaymentDAO paymentDAO = PaymentDAO.getInstance();
        int remainingPT = paymentDAO.remainpayment(mem_num_history);
        
        
        
        request.setAttribute("remainingPT", remainingPT);
        request.setAttribute("sch_date", sch_date);
        
        return "/WEB-INF/views/schedule/scheduleCompliteForm.jsp";
    }
}
