package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class MyPageAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession(); 
		Integer mem_num = (Integer)session.getAttribute("user_num");

		if(mem_num == null) { 
			return "redirect:/member/loginForm.do"; //로그인 페이지 url 작성하기 
		}
		
		MemberDAO dao = MemberDAO.getInstance();
		MemberVO member = dao.getMember(mem_num);

		request.setAttribute("member", member);
		
		//JSP 경로반환
		return "/WEB-INF/views/member/myPage.jsp";
		}
	}
