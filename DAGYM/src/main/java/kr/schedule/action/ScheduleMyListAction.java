package kr.schedule.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.schedule.dao.ScheduleDAO;
import kr.schedule.vo.ScheduleVO;

public class ScheduleMyListAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        Integer user_num = (Integer) session.getAttribute("user_num");

        if (user_num == null) { // 로그인이 되지 않은 경우
            return "redirect:/member/loginForm.do";
        }

        // HistoryDAO 인스턴스 생성
        ScheduleDAO dao = ScheduleDAO.getInstance();
        // 트레이너 번호로 스케줄 목록 조회
        List<ScheduleVO> schedules = dao.getMyScheduleListByTraNum(user_num);

        // 조회된 스케줄 목록을 request에 설정
        request.setAttribute("schedules", schedules);

        // JSP 경로 반환
        return "/WEB-INF/views/schedule/mylist.jsp";
    }
}
