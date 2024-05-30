package kr.history.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.history.dao.HistoryDAO;
import kr.schedule.vo.ScheduleVO;

public class HistoryEnrollFormAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        HttpSession session = request.getSession();
        
        Integer user_num = (Integer) session.getAttribute("user_num"); 
        if (user_num == null) { // 로그인이 되지 않은 경우 
            return "redirect:/member/loginForm.do";
        }

        // 전달받은 날짜를 request에 설정
        String his_date = request.getParameter("his_date");
        request.setAttribute("his_date", his_date);
        
        // 전달받은 스케줄 번호를 사용하여 스케줄 정보를 조회
        String sch_numStr = request.getParameter("sch_num");
        if (sch_numStr != null) {
            int sch_num = Integer.parseInt(sch_numStr);
            HistoryDAO dao = HistoryDAO.getInstance();
            ScheduleVO schedule = dao.getSchedule(sch_num);
            request.setAttribute("schedule", schedule);
        }
        
        return "/WEB-INF/views/history/historyEnrollForm.jsp";
    }
}
