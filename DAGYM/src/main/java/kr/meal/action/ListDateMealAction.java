package kr.meal.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.meal.dao.MealDAO;
import kr.meal.vo.MealVO;

public class ListDateMealAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session = request.getSession();
		Integer mem_num = (Integer)session.getAttribute("user_num");
		String meal_date = request.getParameter("meal_date");
		MealDAO dao = MealDAO.getInstance();
		List<MealVO> mealList = dao.listDateMeal(mem_num,meal_date);
		
		
		int totalKcal = dao.calKcal(meal_date);
		request.setAttribute("totalKcal", totalKcal);
		request.setAttribute("meal",mealList);
		return "/WEB-INF/views/meal/listDateMeal.jsp";
	}

}
