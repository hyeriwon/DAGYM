package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;
import kr.util.FileUtil;

public class DeleteUserAction implements Action{
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//로그인 여부 확인하기
		HttpSession session = request.getSession();
		Integer mem_num = (Integer) session.getAttribute("user_num");
		
		if(mem_num==null) {
			return "redirect:/member/loginForm.do";
		}
		//전송된 데이터 인코딩 타입 지정
		request.setCharacterEncoding("utf-8");
		
		//전송된 데이터 받아오기
		String id = request.getParameter("mem_id");
		String pw = request.getParameter("mem_pw");
		
		//로그인된 아이디 받아오기
		String login_id = (String) session.getAttribute("user_id");
		
		MemberDAO dao = MemberDAO.getInstance();
		MemberVO db_mem = dao.getMember(mem_num);
		
		//로그인한 아이디와 입력한 아이디가 같은지 확인하고, 비밀번호 일치 여부도 확인
		String notice_msg = null;
		String notice_url = null;
		if(login_id.equals(id) && db_mem.isCheckedPassword(pw)) {
			//서버의 프로필 사진 제거
			FileUtil.removeFile(request, db_mem.getMem_photo());
			//회원탈퇴
			dao.deleteMember(mem_num);
			//로그아웃
			session.invalidate();
			
			notice_msg = "회원 탈퇴가 완료되었습니다.";
			notice_url = "../main/main.do";
		}else {
			notice_msg = "입력한 정보가 올바르지 않습니다.";
			notice_url = "deleteUserForm.do";
			System.out.println(request.getContextPath());
		}
		
		request.setAttribute("notice_msg", notice_msg);
		request.setAttribute("notice_url", notice_url);
		
		return "../WEB-INF/views/common/alert_view.jsp";
	}

}
