package kr.meal.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.meal.dao.MealDAO;

public class SearchMenuAndSetTmeNumAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String tme_name = request.getParameter("menu_name");
		MealDAO dao = MealDAO.getInstance();
		int tme_num = dao.searchMenuAndSetTmeNum(tme_name);
		request.setAttribute("tme_num", tme_num);
		
		return "/WEB-INF/views/meal/mealWriteForm.jsp";	
		}

}
