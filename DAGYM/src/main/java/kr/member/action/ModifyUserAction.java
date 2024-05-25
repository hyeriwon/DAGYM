package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;
import kr.util.FileUtil;

public class ModifyUserAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//로그인이 되어있는지 여부 확인
		HttpSession session = request.getSession();
		Integer mem_num = (Integer)session.getAttribute("user_num");

		if(mem_num == null) {//로그인되지 않은 경우
			return "redirect:/member/loginForm.do";
		}

		//로그인이 된 경우
		//전송된 데이터 인코딩 타입 지정
		request.setCharacterEncoding("utf-8");

		MemberDAO dao = MemberDAO.getInstance();
		MemberVO db_mem = dao.getMember(mem_num);	
		//현재 비밀번호가 db에 저장된 비밀번호와 일치하는지 확인
		if(!db_mem.getMem_pw().equals(request.getParameter("mem_nowPw"))) {
			request.setAttribute("notice_msg", "일치하지 않는 비밀번호를 입력했습니다.");
			request.setAttribute("notice_url", "modifyUserForm.do");
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		
		
		//회원정보 수정하기
		MemberVO member = new MemberVO();
		String photo = null;
		member.setMem_num(mem_num);
		member.setMem_name(request.getParameter("mem_name"));
		if(request.getPart("mem_photo")!=null) {
			photo = FileUtil.createFile(request, "mem_photo");
			member.setMem_photo(photo);
		}
		if(request.getParameter("mem_newPw")!=null) {
			member.setMem_pw(request.getParameter("mem_newPw"));
		}
		member.setMem_phone(request.getParameter("mem_phone"));
		member.setMem_email(request.getParameter("mem_email"));
		member.setMem_gender(Integer.parseInt(request.getParameter("mem_gender")));
		member.setMem_birth(request.getParameter("mem_birth"));
		member.setMem_zipcode(request.getParameter("mem_zipcode"));
		member.setMem_address1(request.getParameter("mem_address1"));
		member.setMem_address2(request.getParameter("mem_address2"));

		dao.updateMember(member);
		
		if(member.getMem_photo()!=null) {
			String pre_photo = (String) session.getAttribute("user_photo");
			FileUtil.removeFile(request, pre_photo);
			session.setAttribute("user_photo", photo);
		}
		
		request.setAttribute("notice_msg", "회원정보가 수정되었습니다.");
		request.setAttribute("notice_url", "myPage.do");
		
		return "/WEB-INF/views/common/alert_view.jsp";
	}

}
