package kr.qaboard.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.qaboard.dao.QABoardDAO;
import kr.qaboard.vo.QABoardVO;
import kr.util.StringUtil;

public class UserDetailAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		
		//로그인 확인
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) {
			return "redirect:/member/loginForm.do";
		}
		
		int qab_num = Integer.parseInt(request.getParameter("qab_num"));
		
		QABoardDAO dao = QABoardDAO.getInstance();
		QABoardVO qaboard = dao.getUserBoard(qab_num,user_num);
		
		if(user_num!=qaboard.getMem_num()) {
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		//HTML 비허용
		qaboard.setQab_title(StringUtil.useNoHTML(qaboard.getQab_title()));
		qaboard.setQab_content(StringUtil.useBrNoHTML(qaboard.getQab_content()));
		
		request.setAttribute("qaboard", qaboard);
		
		return "/WEB-INF/views/qaboard/userDetail.jsp";
	}

}
