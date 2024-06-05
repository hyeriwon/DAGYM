package kr.nboard.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.nboard.dao.NboardDAO;
import kr.nboard.vo.NboardVO;
import kr.util.FileUtil;

public class NboardUpdateAction implements Action{

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
		//전송된 데이터 인코딩 타입 지정
		request.setCharacterEncoding("utf-8");
		//전송된 데이터 반환
		int nbo_num = Integer.parseInt(request.getParameter("nbo_num"));
		NboardDAO dao = NboardDAO.getInstance();
		//수정 전 데이터
		NboardVO db_board = dao.getNboard(nbo_num);
		
		NboardVO nboard = new NboardVO();
		nboard.setNbo_num(nbo_num);
		nboard.setNbo_title(request.getParameter("nbo_title"));
		nboard.setNbo_content(request.getParameter("nbo_content"));
		nboard.setNbo_filename(FileUtil.createFile(request, "nbo_filename"));
		nboard.setNbo_type(Integer.parseInt(request.getParameter("nbo_type")));
		dao.updateNboard(nboard);
		
		if(nboard.getNbo_filename()!=null && !"".equals(nboard.getNbo_filename())) {
			//새 파일로 교체할 때 원래 파일 제거
			FileUtil.removeFile(request, db_board.getNbo_filename());
		}
		
		return "redirect:/nboard/nboardDetail.do?nbo_num="+nbo_num;
	}

}
