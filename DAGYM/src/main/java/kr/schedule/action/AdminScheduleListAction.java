package kr.schedule.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.schedule.dao.ScheduleDAO;
import kr.schedule.vo.ScheduleVO;

public class AdminScheduleListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
        Integer user_num = (Integer) session.getAttribute("user_num");
        Integer user_auth = (Integer)session.getAttribute("user_auth");

        if(user_num == null || user_auth != 9) {
            //로그인이 안되었거나 관리자가 아닌 경우
            return "redirect:/member/loginForm.do";
        }

        // ScheduleDAO를 사용하여 스케줄 데이터를 가져옴
        ScheduleDAO dao = ScheduleDAO.getInstance();
        List<ScheduleVO> schedules = dao.getAllSchedules();

        // request에 스케줄 데이터를 저장
        request.setAttribute("schedules", schedules);

        return "/WEB-INF/views/schedule/adminScheduleList.jsp";
	}

}
