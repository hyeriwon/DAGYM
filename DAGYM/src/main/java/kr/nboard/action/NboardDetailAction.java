package kr.nboard.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.nboard.dao.NboardDAO;
import kr.nboard.vo.NboardVO;
import kr.util.StringUtil;

public class NboardDetailAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//글번호 반환
		int nbo_num = Integer.parseInt(request.getParameter("nbo_num"));
		NboardDAO dao = NboardDAO.getInstance();
		//조회수 증가
		dao.updateReadcount(nbo_num);
		
		NboardVO nboard = dao.getNboard(nbo_num);
		//HTML를 허용하지 않음
		nboard.setNbo_title(StringUtil.useNoHTML(nboard.getNbo_title()));
		//HTML을 허용하지 않으면서 줄바꿈
		nboard.setNbo_content(StringUtil.useBrNoHTML(nboard.getNbo_content()));
		
		request.setAttribute("nboard", nboard);
		
		return "/WEB-INF/views/nboard/nboardDetail.jsp";
	}

}
