package kr.tmenu.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.tmenu.dao.TmenuDAO;
import kr.tmenu.vo.TmenuVO;
import kr.util.PagingUtil;

public class TmenuListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) pageNum = "1";
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");
		TmenuDAO dao = TmenuDAO.getInstance();
		int count = dao.getCountTmenu(keyfield, keyword);
		PagingUtil page = new PagingUtil(keyfield, keyword, Integer.parseInt(pageNum),count, 20, 10,"tmenuList.do");
		List<TmenuVO> list = null;
		if(count > 0) {
			list = dao.getListTmenu(page.getStartRow(), page.getEndRow(), keyfield, keyword);
		}
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("page", page.getPage());
		return "/WEB-INF/views/tmenu/tmenuList.jsp";
	}

}
