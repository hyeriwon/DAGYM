package kr.schedule.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.schedule.dao.ScheduleDAO;

public class ScheduleCompliteAction implements Action 
{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		int sch_num = Integer.parseInt(request.getParameter("sch_num"));
        int his_num = Integer.parseInt(request.getParameter("his_num"));

        // ScheduleDAO 인스턴스 생성
        ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();

        // 스케줄과 히스토리 상태를 업데이트
        scheduleDAO.completeHistory(sch_num, his_num);

        // 완료 후 리스트 페이지로 리다이렉트
        
        request.setAttribute("notice_msg", "PT 최종 완료!");
		request.setAttribute("notice_url", request.getContextPath()+"/schedule/mylist.do");
        
        // return "redirect:/schedule/mylist.do";
		return "/WEB-INF/views/schedule/mylist.jsp";
	}
}
