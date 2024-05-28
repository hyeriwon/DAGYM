package kr.payment.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.payment.dao.PaymentDAO;
import kr.qaboard.vo.QABoardVO;

public class PaymentCounselingAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		//로그인 된 경우
		//전송된 데이터 인코딩 타입 지정
		request.setCharacterEncoding("utf-8");
		//자바빈(VO)를 생성한 후 전송된 데이터를 저장
		QABoardVO qaboard = new QABoardVO();
		qaboard.setQab_title(request.getParameter("qab_title"));
		qaboard.setQab_content(request.getParameter("qab_content"));
		qaboard.setQab_ip(request.getRemoteAddr());
		qaboard.setMem_num(user_num);
		
		PaymentDAO dao = PaymentDAO.getInstance();
		dao.membershipCounseling(qaboard);
		
		
		request.setAttribute("notice_msg", "상담신청 완료");
		request.setAttribute("notice_url", request.getContextPath()+"/payment/paymentInfo.do");
		
		return "/WEB-INF/views/common/alert_view.jsp";
	}
	
}