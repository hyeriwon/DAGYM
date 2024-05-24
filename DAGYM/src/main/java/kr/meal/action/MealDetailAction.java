package kr.meal.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.meal.dao.MealDAO;
import kr.meal.vo.MealVO;

public class MealDetailAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		  HttpSession session = request.getSession();
		 Integer user_num = (Integer)session.getAttribute("user_num");
		 
		
		MealDAO dao = MealDAO.getInstance();
		MealVO meal = dao.getMeal(user_num);
		
		request.setAttribute("meal",meal);
		return "/WEB-INF/views/meal/meal_detail.jsp";
	}

}
