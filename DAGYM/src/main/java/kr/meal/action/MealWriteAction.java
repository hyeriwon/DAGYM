package kr.meal.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.meal.dao.MealDAO;
import kr.meal.vo.MealVO;

public class MealWriteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");

		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		MealVO meal = new MealVO();
		meal.setMeal_date(request.getParameter("meal_date"));
		meal.setMem_num(user_num);
		meal.setMeal_time(Integer.parseInt(request.getParameter("meal_time")));
		MealDAO dao = MealDAO.getInstance();
		int tme_num = dao.searchMenuAndSetTmeNum(request.getParameter("menu_name"));
		System.out.println(tme_num);
		meal.setTme_num(tme_num);
		System.out.println(meal.getTme_num());
		dao.insertMeal(meal);
		
		
		request.setAttribute("notice_msg", "음식 등록 완료");
		 request.setAttribute("notice_url", request.getContextPath()+"/meal/list.do");
		return "/WEB-INF/views/common/alert_view.jsp";
	}

}
