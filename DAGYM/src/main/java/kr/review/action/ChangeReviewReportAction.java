package kr.review.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;

public class ChangeReviewReportAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,String> mapAjax = new HashMap<>();
		
		//관리자 로그인 확인하기
		HttpSession session = request.getSession();
		Integer user_auth = (Integer) session.getAttribute("user_auth");
		
		if(user_auth!=9) {
			mapAjax.put("result", "notAdmin");
		}else {
			request.setCharacterEncoding("utf-8");
			
			int rev_num = Integer.parseInt(request.getParameter("rev_num"));
			
		}
		return null;
	}

}
