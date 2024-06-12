package kr.history.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.history.dao.HistoryDAO;
import kr.payment.dao.PaymentDAO;

public class HistoryEnrollFormAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		Integer user_num = (Integer) session.getAttribute("user_num");
		
		if (user_num == null) { // 로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}

		try {
			// 전달받은 날짜와 시간, 트레이너 번호를 request에 설정
			String his_date = request.getParameter("his_date");
			Integer sch_time = Integer.parseInt(request.getParameter("sch_time"));
			Integer tra_num = Integer.parseInt(request.getParameter("tra_num"));
			// 중복된 시간인지 확인
			HistoryDAO historyDAO = HistoryDAO.getInstance();
			boolean isDuplicate = historyDAO.isDuplicateSchedule(his_date, sch_time);
			if (isDuplicate) {
				request.setAttribute("errorMessage", "중복된 시간입니다.");
				return "/WEB-INF/views/history/mylist.jsp";
			}

			// 로그인한 사용자의 잔여 PT 횟수 조회
			PaymentDAO paymentDAO = PaymentDAO.getInstance();
			int remainingPT = paymentDAO.remainpayment(user_num);
			request.setAttribute("remainingPT", remainingPT);

			// 설정된 날짜와 트레이너 번호를 request에 설정
			request.setAttribute("his_date", his_date);
			request.setAttribute("tra_num", tra_num);
		} catch (NumberFormatException e) {
			// JavaScript로 alert 표시 후 새로고침
			request.setAttribute("error", "비정상적인 접근입니다.");
			request.setAttribute("redirectMain", true);
			return "/WEB-INF/views/history/list.jsp";
		}

		return "/WEB-INF/views/history/historyEnrollForm.jsp";
	}
}
