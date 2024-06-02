package kr.qaboard.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.qaboard.dao.QABoardDAO;
import kr.qaboard.vo.QABoardVO;

public class AdminWriteAnswerAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();

		//로그인 체크
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) {
			return "redirect:/member/loginForm.do";
		}

		request.setCharacterEncoding("utf-8");
		int qab_num = Integer.parseInt(request.getParameter("qab_num"));

		//로그인한 사람이 관리자,강사가 맞는지 체크
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_auth < 8) {
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		QABoardVO qaboard = new QABoardVO();
		qaboard.setMem_num(user_num);
		qaboard.setQab_type(Integer.parseInt(request.getParameter("qab_type")));
		qaboard.setQab_content(request.getParameter("answer_content"));
		qaboard.setQab_ip(request.getRemoteAddr());
		qaboard.setQab_ref(qab_num);//댓글의 부모 글번호

		QABoardDAO dao = QABoardDAO.getInstance();
		dao.insertAnswerBoard(qaboard);

		request.setAttribute("result", qaboard);
		
		return "redirect:/qaboard/adminAnswerDetail.do?qab_num="+qab_num;
	}

}
