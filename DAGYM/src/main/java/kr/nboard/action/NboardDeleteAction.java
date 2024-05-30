package kr.nboard.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.nboard.dao.NboardDAO;
import kr.nboard.vo.NboardVO;
import kr.util.FileUtil;

public class NboardDeleteAction implements Action{

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
		//관리자로 로그인한 경우
		int nbo_num = Integer.parseInt(request.getParameter("nbo_num"));
		NboardDAO dao = NboardDAO.getInstance();
		NboardVO db_board = dao.getNboard(nbo_num);
		
		dao.deleteNboard(nbo_num);
		//파일 삭제
		FileUtil.removeFile(request, db_board.getNbo_filename());
		
		request.setAttribute("notice_msg", "글 삭제 완료");
		request.setAttribute("notice_url", request.getContextPath()+"/nboard/nboardList.do");
		
		return "/WEB-INF/views/common/alert_view.jsp";
	}

}
