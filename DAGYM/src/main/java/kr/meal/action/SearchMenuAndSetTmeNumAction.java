package kr.meal.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.meal.dao.MealDAO;
import kr.meal.vo.MealVO;

public class SearchMenuAndSetTmeNumAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String tme_name = request.getParameter("menu_name");
		MealDAO dao = MealDAO.getInstance();
		int tme_num = dao.searchMenuAndSetTmeNum(tme_name);
		request.setAttribute("tme_num", tme_num);
		String meal_date= request.getParameter("meal_date");
		
		return "mealWriteForm.do?meal_date="+meal_date;	
		}

}
