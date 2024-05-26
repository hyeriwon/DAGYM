package kr.meal.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.meal.dao.MealDAO;
import kr.tmenu.vo.TmenuVO;

public class SearchTmenuAction implements Action {
	

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		Integer mem_num = (Integer)session.getAttribute("user_num");
		String tmenu_name = request.getParameter("tmenu_name");
		List<TmenuVO> tmenuList = null;
		MealDAO dao = MealDAO.getInstance();
		tmenuList = dao.searchListTmenu(tmenu_name);
		Map<String,Object> mapAjax =new HashMap<String,Object>();
		mapAjax.put("tmenuList", tmenuList);
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
