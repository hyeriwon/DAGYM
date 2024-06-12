package kr.schedule.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

import kr.controller.Action;
import kr.schedule.dao.ScheduleDAO;
import kr.schedule.vo.ScheduleVO;

public class ScheduleEnrollAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");

		HttpSession session = request.getSession();
		Integer userNum = (Integer) session.getAttribute("user_num");
		Integer user_auth = (Integer) session.getAttribute("user_auth");

		String memId = (String) session.getAttribute("user_id");

		if (userNum == null) {
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

		String schDate = request.getParameter("sch_date");
		String[] timePeriods = request.getParameterValues("time_period");
		String[] hourlyTimePeriods = request.getParameterValues("hourly_time_period");

		if (schDate == null || schDate.isEmpty() || (timePeriods == null || timePeriods.length == 0)
				&& (hourlyTimePeriods == null || hourlyTimePeriods.length == 0)) {
			request.setAttribute("error", "잘못된 입력입니다.");
			return "/WEB-INF/views/schedule/scheduleEnrollForm.jsp";
		}

		List<ScheduleVO> schedules = new ArrayList<>();
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
		boolean hasDuplicate = false;

		if (timePeriods != null) {
			for (String period : timePeriods) {
				if (period.equals("morning")) {
					for (int hour = 9; hour <= 11; hour++) {
						if (scheduleDAO.isDuplicateSchedule(schDate, hour)) {
							hasDuplicate = true;
							request.setAttribute("message", "스케줄이 성공적으로 등록되었지만, 일부 시간대는 이미 등록된 시간입니다.");
						} else {
							schedules.add(createSchedule(userNum, memId, schDate, hour));
						}
					}
				} else if (period.equals("afternoon")) {
					for (int hour = 13; hour <= 20; hour++) {
						if (scheduleDAO.isDuplicateSchedule(schDate, hour)) {
							hasDuplicate = true;
							request.setAttribute("message", "스케줄이 성공적으로 등록되었지만, 일부 시간대는 이미 등록된 시간입니다.");
						} else {
							schedules.add(createSchedule(userNum, memId, schDate, hour));
						}
					}
				}
			}
		}

		if (hourlyTimePeriods != null) {
			for (String period : hourlyTimePeriods) {
				int hour = Integer.parseInt(period);
				if (scheduleDAO.isDuplicateSchedule(schDate, hour)) {
					hasDuplicate = true;
					request.setAttribute("error", "이미 등록된 시간입니다.");
				} else {
					schedules.add(createSchedule(userNum, memId, schDate, hour));
					request.setAttribute("error", "스케줄이 성공적으로 등록되었지만, 일부 시간대는 이미 등록된 시간입니다.");
				}
			}
		}

		try {
			for (ScheduleVO schedule : schedules) {
				scheduleDAO.insertSchedule(schedule);
			}
			if (!hasDuplicate) {
				request.setAttribute("message", "스케줄이 성공적으로 등록되었습니다.");
			}
		} catch (Exception e) {
			request.setAttribute("error", "스케줄 등록 중 오류가 발생했습니다.");
		}

		return "/WEB-INF/views/schedule/scheduleEnrollForm.jsp";
	}

	private ScheduleVO createSchedule(int userNum, String memId, String schDate, int hour) {
		ScheduleVO schedule = new ScheduleVO();
		schedule.setMem_num(userNum);
		schedule.setMem_id(memId);
		schedule.setSch_date(schDate);
		schedule.setSch_time(hour);
		schedule.setSch_status(0);

		return schedule;
	}
}
