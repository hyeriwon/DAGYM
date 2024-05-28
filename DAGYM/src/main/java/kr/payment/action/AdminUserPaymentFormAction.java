package kr.payment.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.payment.dao.PaymentDAO;
import kr.payment.vo.PaymentVO;

public class AdminUserPaymentFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		//로그인도 되어 있어야 하고 관리자만 들어올 수 있게 해야 한다.
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_auth != 9) {//관리자로 로그인하지 않은 경우
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		//전송된 데이터 반환
		//int mem_num = Integer.parseInt(request.getParameter("mem_num"));
		PaymentDAO dao = PaymentDAO.getInstance();
		//PaymentVO member = dao.getPaymentMember(mem_num);
		
		//request.setAttribute("member", member);
		//JSP 경로 반환
		return "/WEB-INF/views/payment/detailpaymentUserForm.jsp";
	}

}
