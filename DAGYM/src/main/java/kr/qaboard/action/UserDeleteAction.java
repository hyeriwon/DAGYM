package kr.qaboard.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.qaboard.dao.QABoardDAO;
import kr.qaboard.vo.QABoardVO;

public class UserDeleteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		
		//로그인 체크
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		
		int qab_num = Integer.parseInt(request.getParameter("qab_num"));
		
		//로그인, 작성자 일치 여부 체크
		QABoardDAO dao = QABoardDAO.getInstance();
		QABoardVO db_qaboard = dao.getUserBoard(qab_num);
		
		if(user_num!=db_qaboard.getMem_num()) {//작성자와 일치하는지 확인
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		//데이터 삭제
		dao.deleteUserBoard(qab_num);
		
		return "redirect:/qaboard/userQuestionList.do";
	}

}
