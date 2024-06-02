package kr.history.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.history.dao.HistoryDAO;
import kr.history.vo.HistoryVO;
import kr.payment.vo.PaymentVO;

public class EnrollAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}

		//로그인 된 경우
		//전송된 데이터 인코딩 타입 지정
		request.setCharacterEncoding("utf-8");
		//자바빈(VO)를 생성한 후 전송된 데이터를 저장
		HistoryVO history = new HistoryVO();
		history.setMem_num(Integer.parseInt(request.getParameter("mem_num")));
		history.setSch_num(Integer.parseInt(request.getParameter("sch_num")));
		history.setTra_num(Integer.parseInt(request.getParameter("tra_num")));
		history.setHis_status(Integer.parseInt(request.getParameter("his_status")));
		history.setHis_part(request.getParameter("his_part"));
		history.setTra_id(request.getParameter("tra_id"));
		history.setSch_date(request.getParameter("sch_date"));
		
		PaymentVO payment = new PaymentVO();
		payment.setMem_num(Integer.parseInt(request.getParameter("mem_num")));
		
		HistoryDAO dao = HistoryDAO.getInstance();
		//dao.insertHistory(history,payment);
		
		request.setAttribute("result_title", "수강신청 완료");
		request.setAttribute("result_msg", "수강 신청이 완료되었습니다.");
		request.setAttribute("notice_url", request.getContextPath() + "/history/enrollList.do");//수강신청내역페이지로 이동
		
		
		return "/WEB-INF/views/common/result_view.jsp";
	}

}
