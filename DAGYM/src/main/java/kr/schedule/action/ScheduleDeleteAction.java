package kr.schedule.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.schedule.dao.ScheduleDAO;

public class ScheduleDeleteAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		Integer user_num = (Integer) session.getAttribute("user_num");
		Integer user_auth = (Integer) session.getAttribute("user_auth");

		if (user_num == null) {
			// 로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}

		if (user_auth != 8) {
			// 트레이너로 로그인하지 않은 경우
			return "/WEB-INF/views/common/notice.jsp";
		}
		// 트레이너로 로그인 된 경우
		// 전송된 데이터 인코딩 타입 지정
		request.setCharacterEncoding("utf-8");

		int schNum = Integer.parseInt(request.getParameter("sch_num"));

		ScheduleDAO dao = ScheduleDAO.getInstance();

		try {
			dao.deleteSchedule(schNum, user_num);
		} catch (Exception e) {
			Throwable cause = e.getCause();
			if (cause instanceof java.sql.SQLIntegrityConstraintViolationException) {
				response.setContentType("text/html;charset=UTF-8");
				response.getWriter().print("<script>alert('이미 예약된 스케줄입니다.');history.back();</script>");
				return null; // JSP 경로를 반환하지 않음
			} else {
				throw e; // 다른 예외는 다시 던짐
			}
		}

		// JSP 경로 반환
		return "/WEB-INF/views/schedule/scheduleDeleteForm.jsp";
	}
}