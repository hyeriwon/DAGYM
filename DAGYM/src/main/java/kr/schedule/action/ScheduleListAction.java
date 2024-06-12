package kr.schedule.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.schedule.dao.ScheduleDAO;
import kr.schedule.vo.ScheduleVO;

public class ScheduleListAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer) session.getAttribute("user_num");
		Integer user_auth = (Integer) session.getAttribute("user_auth");

		if (user_num == null) { // 로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}

		if (user_auth != 8) {
			// 트레이너로 로그인하지 않은 경우
			return "/WEB-INF/views/common/notice.jsp";
		}
		// 트레이너로 로그인 된 경우
		// 전송된 데이터 인코딩 타입 지정
		request.setCharacterEncoding("utf-8");

		// ScheduleDAO를 사용하여 스케줄 데이터를 가져옴
		ScheduleDAO dao = ScheduleDAO.getInstance();
		List<ScheduleVO> schedules = dao.getAllSchedules();

		// request에 스케줄 데이터를 저장
		request.setAttribute("schedules", schedules);

		return "/WEB-INF/views/schedule/list.jsp";
	}
}
