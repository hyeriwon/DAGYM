package kr.tmenu.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.tmenu.dao.TmenuDAO;
import kr.tmenu.vo.TmenuVO;

public class TmenuRecommendListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		TmenuDAO dao = TmenuDAO.getInstance();
		TmenuVO breakfast = dao.searchRecommendByTmetype(0);
		TmenuVO lunch = dao.searchRecommendByTmetype(1);
		TmenuVO dinner = dao.searchRecommendByTmetype(2);
		
		
		request.setAttribute("breakfast", breakfast);
		request.setAttribute("lunch", lunch);
		request.setAttribute("dinner", dinner);
		return "/WEB-INF/views/tmenu/tmenuRecommendList.jsp";
	}

}
