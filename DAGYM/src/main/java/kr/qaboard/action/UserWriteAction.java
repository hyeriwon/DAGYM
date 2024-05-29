package kr.qaboard.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.qaboard.dao.QABoardDAO;
import kr.qaboard.vo.QABoardVO;
import kr.util.FileUtil;

public class UserWriteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		//로그인 체크
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		
		request.setCharacterEncoding("utf-8");
		QABoardVO qaboard = new QABoardVO();
		qaboard.setQab_type(Integer.parseInt(request.getParameter("qab_type")));
		qaboard.setQab_title(request.getParameter("qab_title"));
		qaboard.setQab_content(request.getParameter("qab_content"));
		qaboard.setQab_filename(FileUtil.createFile(request, "qab_filename"));
		qaboard.setQab_ip(request.getRemoteAddr());
		qaboard.setMem_num(user_num);
		
		QABoardDAO dao = QABoardDAO.getInstance();
		dao.insertInquiryBoard(qaboard);
		
		request.setAttribute("notice_msg", "문의가 정상적으로 등록되었습니다.");
		request.setAttribute("notice_url", request.getContextPath()+"/qaboard/userQuestionList.do");
		
		return "/WEB-INF/views/common/alert_view.jsp";
	}

}
