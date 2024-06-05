package kr.nboard.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.nboard.dao.NboardDAO;
import kr.nboard.vo.NboardVO;
import kr.util.FileUtil;

public class NboardWriteAction implements Action{

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
		//관리자로 로그인 된 경우
		//전송된 데이터 인코딩 타입 지정
		request.setCharacterEncoding("utf-8");
		//자바빈(VO)를 생성한 후 전송된 데이터를 저장
		NboardVO nboard = new NboardVO();
		nboard.setNbo_title(request.getParameter("nbo_title"));
		nboard.setNbo_content(request.getParameter("nbo_content"));
		nboard.setNbo_filename(FileUtil.createFile(request, "nbo_filename"));
		nboard.setNbo_type(Integer.parseInt(request.getParameter("nbo_type")));
		
		nboard.setMem_num(user_num);
		
		NboardDAO dao = NboardDAO.getInstance();
		dao.insertNboard(nboard);
		
		request.setAttribute("notice_msg", "글쓰기 완료");
		request.setAttribute("notice_url", request.getContextPath()+"/nboard/nboardList.do");
		
		return "/WEB-INF/views/common/alert_view.jsp";
	}

}
