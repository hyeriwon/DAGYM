package kr.meal.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.meal.dao.MealDAO;
import kr.meal.vo.MealVO;

public class MealWriteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Integer user_num = 99999;
		request.setCharacterEncoding("UTF-8");
		MealVO meal = new MealVO();
		meal.setTme_num(Integer.parseInt(request.getParameter("tme_num")));
		meal.setMeal_date(request.getParameter("meal_date"));
		meal.setMem_num(user_num);
		meal.setMeal_time(Integer.parseInt(request.getParameter("meal_time")));
		MealDAO dao = MealDAO.getInstance();
		dao.insertMeal(meal);
		
		
		request.setAttribute("notice_msg", "음식 등록 완료");
		 request.setAttribute("notice_url", request.getContextPath()+"/meal/list.do");
		return "/WEB-INF/views/common/alert_view.jsp";
	}

}
