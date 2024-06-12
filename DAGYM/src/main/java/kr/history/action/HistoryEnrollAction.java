package kr.history.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.history.dao.HistoryDAO;
import kr.schedule.vo.ScheduleVO;
import kr.history.vo.HistoryVO;
import kr.payment.dao.PaymentDAO;

public class HistoryEnrollAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();

		Integer user_num = (Integer) session.getAttribute("user_num");
		if (user_num == null) { // 로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		// 로그인 된 경우
		// 전달받은 날짜를 request에 설정
		request.setCharacterEncoding("utf-8");
		String his_date = request.getParameter("his_date");
		request.setAttribute("his_date", his_date);

		// 전달받은 스케줄 번호를 사용하여 스케줄 정보를 조회
		String sch_numStr = request.getParameter("sch_num");

		// 로그인한 사용자의 잔여 PT 횟수 조회
		PaymentDAO paymentDAO = PaymentDAO.getInstance();
		int remainingPT = paymentDAO.remainpayment(user_num);
		request.setAttribute("remainingPT", remainingPT);

		if (sch_numStr != null && remainingPT > 0) {
			Integer sch_num = Integer.parseInt(sch_numStr);
			HistoryDAO dao = HistoryDAO.getInstance();
			ScheduleVO schedule = dao.getSchedule(sch_num);
			request.setAttribute("schedule", schedule);

			// 트레이너 번호 설정
			int tra_num = schedule.getMem_num();

			// HistoryVO 객체 생성 및 데이터 설정
			HistoryVO history = new HistoryVO();
			history.setMem_num(user_num);
			history.setSch_num(sch_num);
			history.setTra_num(tra_num);
			history.setHis_status(0); // 0: 예약완료
			history.setHis_part(request.getParameter("his_part"));

			// HistoryDAO를 사용하여 PT 등록
			dao.insertHistory(history);

			request.setAttribute("message", "PT 신청 완료!");

			// 알림 메시지를 띄운 후 mylist.jsp로 이동
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().println("<script>alert('PT 신청 완료!'); location.href='" + request.getContextPath()
					+ "/history/mylist.do';</script>");

		} else {
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().println("<script>alert('PT 잔여 횟수가 부족합니다!'); location.href='" + request.getContextPath()
					+ "/payment/paymentInfo.do';</script>");
		}

		return null; // 자바스크립트로 이동하므로 null 반환
	}
}
