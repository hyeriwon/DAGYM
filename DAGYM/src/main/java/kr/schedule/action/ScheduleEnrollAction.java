package kr.schedule.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.schedule.dao.ScheduleDAO;
import kr.schedule.vo.ScheduleVO;
import kr.controller.Action;

public class ScheduleEnrollAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();

		Integer mem_num = (Integer) session.getAttribute("mem_num");
		if (mem_num == null) { // 로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		request.setCharacterEncoding("utf-8");
		// 자바빈(VO)를 생성한 후 전송된 데이터를 저장
		ScheduleVO schedule = new ScheduleVO();
		schedule.setMem_num(mem_num);
		schedule.setSch_date(request.getParameter("date"));
		schedule.setSch_status(0);

		
		ScheduleDAO dao = ScheduleDAO.getInstance();
		dao.insertSchedule(schedule);
		
		
		
		request.setAttribute("notice_msg", "스케줄 등록 완료");
		request.setAttribute("notice_url", request.getContextPath()+"/schedule/list.do");
		
		
		return "/WEB-INF/views/common/alert_view.jsp";
	
	}

}
