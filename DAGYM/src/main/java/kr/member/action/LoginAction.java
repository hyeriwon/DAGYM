package kr.member.action;

import java.time.LocalDate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class LoginAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8"); 
		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");
		
		MemberDAO dao = MemberDAO.getInstance();
		MemberVO member = dao.checkMember(id);
		boolean check = false;
		
		if(member!=null) {//동일한 id 존재
			check = member.isCheckedPassword(passwd);
			if(member.getMem_auth()==1) {
				LocalDate susDate = member.getMem_sus_date().toLocalDate();
				if(LocalDate.now().isAfter(susDate)) {
					dao.updateMemberByAdmin(2, member.getMem_num());					
					check = true;
				}
				request.setAttribute("susDate", susDate);
			}
			//정지 회원 상태 표시
			request.setAttribute("auth", member.getMem_auth());
		}
		if(check) {//로그인 완료
			HttpSession session = request.getSession();
			session.setAttribute("user_num", member.getMem_num());
			session.setAttribute("user_id", member.getMem_id());
			session.setAttribute("user_auth", member.getMem_auth());
			session.setAttribute("user_photo", member.getMem_photo());
			
			return "redirect:/main/main.do";
		}
		return "/WEB-INF/views/member/login.jsp";
	}

}
