package kr.schedule.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.payment.dao.PaymentDAO;

public class ScheduleCompleteFormAction implements Action {

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
		try {
			// 전달받은 날짜와 mem_num을 request에서 가져오기
			String sch_date = request.getParameter("sch_date");
			int mem_num_history = Integer.parseInt(request.getParameter("mem_num_history"));

			// 로그인한 사용자의 잔여 PT 횟수 조회
			PaymentDAO paymentDAO = PaymentDAO.getInstance();
			int remainingPT = paymentDAO.remainpayment(mem_num_history);

			request.setAttribute("remainingPT", remainingPT);
			request.setAttribute("sch_date", sch_date);
		} catch (NumberFormatException e) {
			// JavaScript로 alert 표시 후 새로고침
			request.setAttribute("error", "비정상적인 접근입니다.");
			request.setAttribute("redirectMain", true);
			return "/WEB-INF/views/history/list.jsp";
		}
		return "/WEB-INF/views/schedule/scheduleCompleteForm.jsp";
	}
}
