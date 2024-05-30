package kr.nboard.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.nboard.dao.NboardDAO;
import kr.nboard.vo.NboardVO;

public class NboardUpdateFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_auth != 9) {//관리자로 로그인하지 않은 경우
			return "/WEB-INF/views/common/notice.jsp";
		}
		//관리자로 로그인된 경우
		int nbo_num = Integer.parseInt(request.getParameter("nbo_num"));
		NboardDAO dao = NboardDAO.getInstance();
		NboardVO nboard = dao.getNboard(nbo_num);
		
		if(user_num!=nboard.getMem_num()) {
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		request.setAttribute("nboard", nboard);
		return "/WEB-INF/views/nboard/nboardUpdateForm.jsp";
	}

}
