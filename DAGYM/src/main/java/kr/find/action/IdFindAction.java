package kr.find.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.find.dao.FindDAO;
import kr.member.vo.MemberVO;

public class IdFindAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		
		FindDAO dao = FindDAO.getInstance();
		MemberVO db_member = dao.findMemberById(name, phone, email);
		
		if(db_member == null){
			request.setAttribute("notice_msg", "일치하는 회원 정보가 없습니다.");
			request.setAttribute("notice_url", request.getContextPath()+"/member/registerUserForm.do");
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		//일치하는 회원정보가 있는 경우
		request.setAttribute("foundId", db_member.getMem_id());
		
		return "/WEB-INF/views/find/id_find.jsp";
	}

}
