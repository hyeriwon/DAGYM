package kr.qaboard.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.qaboard.dao.QABoardDAO;
import kr.qaboard.vo.QABoardVO;
import kr.util.StringUtil;

public class AdminAnswerDetailAction implements Action{

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
		QABoardVO qaboard = dao.getUserBoardByAdmin(qab_num);
		QABoardVO answerBoard = dao.getAdminBoard(qab_num);

		//HTML 비허용
		qaboard.setQab_title(StringUtil.useNoHTML(qaboard.getQab_title()));
		qaboard.setQab_content(StringUtil.useBrNoHTML(qaboard.getQab_content()));
		
		request.setAttribute("qaboard", qaboard);
		request.setAttribute("answerBoard", answerBoard);
		request.setAttribute("user_auth", user_auth);
		return "/WEB-INF/views/qaboard/adminAnswerDetail.jsp";
	}

}
