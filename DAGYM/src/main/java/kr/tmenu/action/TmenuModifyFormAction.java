package kr.tmenu.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.tmenu.dao.TmenuDAO;
import kr.tmenu.vo.TmenuVO;

public class TmenuModifyFormAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Integer tme_num = Integer.parseInt(request.getParameter("tme_num"));
		TmenuDAO dao = TmenuDAO.getInstance();
		TmenuVO tmenu = dao.getTmenuDetail(tme_num);
		request.setAttribute("tmenu", tmenu);
		return "/WEB-INF/views/tmenu/modifyTmenuForm.jsp";
	}

}
