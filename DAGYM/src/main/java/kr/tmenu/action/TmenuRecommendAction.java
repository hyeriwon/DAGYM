package kr.tmenu.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.tmenu.dao.TmenuDAO;
import kr.tmenu.vo.TmenuVO;

public class TmenuRecommendAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_auth!=9) {
			return "/WEB-INF/views/common/notice.jsp";
		}
		Integer tme_num = Integer.parseInt(request.getParameter("tme_num"));
		TmenuDAO dao = TmenuDAO.getInstance();
		TmenuVO tmenu = dao.getTmenuDetail(tme_num);
		
		dao.recommendTmenu(tmenu.getTme_type(), tmenu.getTme_num());
		
		request.setAttribute("notice_msg", "추천 메뉴 등록 완료");
		 request.setAttribute("notice_url", request.getContextPath()+"/tmenu/tmenuList.do");
		return "/WEB-INF/views/common/alert_view.jsp";
		
	}

}
