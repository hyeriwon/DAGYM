package kr.tmenu.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.tmenu.dao.TmenuDAO;
import kr.tmenu.vo.TmenuVO;
import kr.util.FileUtil;

public class TmenuWriteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_auth!=9) {
			return "/WEB-INF/views/common/notice.jsp";
		}
		TmenuVO tmenu = new TmenuVO();
		tmenu.setTme_name(request.getParameter("menu_name"));
		tmenu.setTme_content(request.getParameter("menu_content"));
		tmenu.setTme_kcal(Integer.parseInt(request.getParameter("menu_kcal")));
		tmenu.setTme_crabs(Integer.parseInt(request.getParameter("menu_crabs")));
		tmenu.setTme_protein(Integer.parseInt(request.getParameter("menu_protein")));
		tmenu.setTme_lipid(Integer.parseInt(request.getParameter("menu_lipid")));
		tmenu.setTme_photo(FileUtil.createFile(request, "filename"));
		tmenu.setTme_type(Integer.parseInt(request.getParameter("tme_type")));
		TmenuDAO dao = TmenuDAO.getInstance();
		dao.insertTmenu(tmenu);
		
		
		request.setAttribute("notice_msg", "메뉴 등록 완료");
		 request.setAttribute("notice_url", request.getContextPath()+"/tmenu/tmenuList.do");
		return "/WEB-INF/views/common/alert_view.jsp";
	}

}
