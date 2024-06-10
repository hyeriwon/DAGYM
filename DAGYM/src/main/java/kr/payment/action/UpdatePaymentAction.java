package kr.payment.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.payment.dao.PaymentDAO;

public class UpdatePaymentAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,String> mapAjax = new HashMap<String,String>();

		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		if(user_num == null || user_auth == null || user_auth != 9) {
			mapAjax.put("result", "wrongAccess");
		}else {
			request.setCharacterEncoding("utf-8");
			
			int mem_num = Integer.parseInt(request.getParameter("mem_num"));
			int pay_num = Integer.parseInt(request.getParameter("pay_num"));
			PaymentDAO dao = PaymentDAO.getInstance();
			dao.updateMembership(pay_num, mem_num);
			mapAjax.put("result", "success");
		}
		
		//JSON 데이터 생성
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);

		return "/WEB-INF/views/common/ajax_view.jsp";

	}

}
