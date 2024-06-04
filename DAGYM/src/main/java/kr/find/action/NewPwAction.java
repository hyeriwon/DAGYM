package kr.find.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.find.dao.FindDAO;
import kr.member.vo.MemberVO;

public class NewPwAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		MemberVO member = new MemberVO();
		member.setMem_pw(request.getParameter("mem_newPw"));
		member.setMem_id(request.getParameter("mem_id"));
		
		FindDAO dao = FindDAO.getInstance();
		dao.updateMemberPw(member);
		
		request.setAttribute("notice_msg", "새비밀번호로 변경되었습니다.");
		request.setAttribute("notice_url", request.getContextPath()+"/member/loginForm.do");
		
		return "/WEB-INF/views/common/alert_view.jsp";
	}

}
