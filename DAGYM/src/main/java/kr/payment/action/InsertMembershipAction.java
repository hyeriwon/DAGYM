package kr.payment.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.payment.dao.PaymentDAO;
import kr.payment.vo.PaymentVO;

public class InsertMembershipAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		
		//로그인체크
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_auth != 9) {
			return "/WEB-INF/views/common/notice.jsp";
		}
		request.setCharacterEncoding("UTF-8");
		
		int mem_num = Integer.parseInt(request.getParameter("mem_num"));
		PaymentVO payment = new PaymentVO();
		payment.setPay_fee(Integer.parseInt(request.getParameter("pay_fee")));
        payment.setPay_enroll(Integer.parseInt(request.getParameter("pay_enroll")));
        payment.setMem_num(mem_num);
		
        PaymentDAO dao = PaymentDAO.getInstance();
        dao.insertMembership(payment);
        
        request.setAttribute("notice_msg", "회원권 등록 완료");
        request.setAttribute("notice_url", request.getContextPath()+"/payment/detailUserPaymentForm.do?mem_num="+mem_num);
        
        return "/WEB-INF/views/common/alert_view.jsp";

	}

}
