package kr.find.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.find.dao.FindDAO;
import kr.member.vo.MemberVO;

public class PwFindAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String name = request.getParameter("name");
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		
		FindDAO dao = FindDAO.getInstance();
		MemberVO db_member = dao.findMemberPasswd(name, id, email);
		
		if(db_member == null) {
			request.setAttribute("notice_msg", "일치하는 회원 정보가 없습니다.");
			request.setAttribute("notice_url", request.getContextPath()+"/find/pwFindForm.do");
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		//일치하는 회원정보가 있는 경우 새로운 비밀번호 설정으로
		request.setAttribute("foundPw", db_member.getMem_pw());
		request.setAttribute("mem_id", id);
		
		return "/WEB-INF/views/find/new_pw.jsp";
	}

}
