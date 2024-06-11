package kr.tmenu.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.tmenu.dao.TmenuDAO;
import kr.tmenu.vo.TmenuVO;

public class TmenuRecommendAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Integer tme_num = Integer.parseInt(request.getParameter("tme_num"));
		TmenuDAO dao = TmenuDAO.getInstance();
		TmenuVO tmenu = dao.getTmenuDetail(tme_num);
		
		dao.recommendTmenu(tmenu.getTme_type(), tmenu.getTme_num());
		
		request.setAttribute("notice_msg", "추천 메뉴 등록 완료");
		 request.setAttribute("notice_url", request.getContextPath()+"/tmenu/tmenuList.do");
		return "/WEB-INF/views/common/alert_view.jsp";
		
	}

}
