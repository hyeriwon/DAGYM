package kr.schedule.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.schedule.dao.ScheduleDAO;

public class ScheduleCompleteAction implements Action 
{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int sch_num = Integer.parseInt(request.getParameter("sch_num"));
        int his_num = Integer.parseInt(request.getParameter("his_num"));

        // ScheduleDAO 인스턴스 생성
        ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();

        // 스케줄과 히스토리 상태를 업데이트
        scheduleDAO.completeHistory(sch_num, his_num);

        // 완료 후 메시지와 리다이렉트 URL 설정
        request.setAttribute("result_msg", "PT 최종 완료!");
        request.setAttribute("redirect_url", request.getContextPath() + "/schedule/mylist.do");

        // JSP로 포워딩
        return "/WEB-INF/views/schedule/scheduleComplete.jsp";
    }
}
