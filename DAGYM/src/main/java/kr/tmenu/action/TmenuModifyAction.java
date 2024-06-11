package kr.tmenu.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.tmenu.dao.TmenuDAO;
import kr.tmenu.vo.TmenuVO;
import kr.util.FileUtil;
import kr.util.StringUtil;

public class TmenuModifyAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) {
			return "redirect:/member/loginForm.do";
		}
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_auth!=9) {
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		Integer tme_num = Integer.parseInt(request.getParameter("menu_num"));
		TmenuDAO dao = TmenuDAO.getInstance();
		TmenuVO db_Tmenu = dao.getTmenuDetail(tme_num);
		if(db_Tmenu.getTme_num() != tme_num) {
			return "/WEB-INF/views/common/notice.jsp";
		}
		TmenuVO tmenu = new TmenuVO();
		tmenu.setTme_num(tme_num);
		tmenu.setTme_name(request.getParameter("menu_name"));
		tmenu.setTme_content(request.getParameter("menu_content"));
		tmenu.setTme_kcal(Integer.parseInt(request.getParameter("menu_kcal")));
		tmenu.setTme_crabs(Integer.parseInt(request.getParameter("menu_crabs")));
		tmenu.setTme_protein(Integer.parseInt(request.getParameter("menu_protein")));
		tmenu.setTme_lipid(Integer.parseInt(request.getParameter("menu_lipid")));
		tmenu.setTme_photo(FileUtil.createFile(request, "filename"));
		tmenu.setTme_type(Integer.parseInt(request.getParameter("tme_type")));
		dao.modifyTmenu(tmenu);
		if(tmenu.getTme_photo() !=null && !"".equals(tmenu.getTme_photo())) {
			FileUtil.removeFile(request, db_Tmenu.getTme_photo());
		}
		return "redirect:/tmenu/tmenuDetail.do?tme_num="+tme_num;
	}

}
