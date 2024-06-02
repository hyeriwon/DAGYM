package kr.qaboard.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.qaboard.dao.QABoardDAO;

public class AdminDeleteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();

		//로그인 체크
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) {
			return "redirect:/member/loginForm.do";
		}
		//로그인한 사람이 관리자,강사가 맞는지 체크
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_auth < 8) {
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		int qab_num = Integer.parseInt(request.getParameter("qab_num"));
		
		QABoardDAO dao = QABoardDAO.getInstance();
		dao.deleteAdminBoard(qab_num);
		
		return "redirect:qaboard/adminAnswerDetail.do?="+qab_num;
	}

}
