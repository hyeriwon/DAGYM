package kr.meal.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.meal.dao.MealDAO;
import kr.meal.vo.MealVO;
import kr.util.PagingUtil;

public class MealDetailAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pageNum = request.getParameter("pageNum");
		if (pageNum == null)
			pageNum = "1";
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");
		HttpSession session = request.getSession();
		Integer mem_num = (Integer) session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		if (mem_num == null) {
			return "redirect:/member/loginForm.do";
		}
		if(user_auth == 9) {
			mem_num = Integer.parseInt(request.getParameter("client_num"));
		}
		MealDAO dao = MealDAO.getInstance();
		int count = dao.getMealCount(keyfield,
		 keyword,mem_num); PagingUtil page = new
		 PagingUtil(keyfield,keyword,Integer.parseInt(pageNum),count,20,10,
		 "mealDetail.do"); List<MealVO> mealList =
		  dao.getListMeal(page.getStartRow(),page.getEndRow(), keyfield, keyword,
		  mem_num);
		  
		  request.setAttribute("meal",mealList); request.setAttribute("count", count);
		  request.setAttribute("page", page.getPage());
		  return "/WEB-INF/views/meal/meal_detail.jsp";
		 
	}

}
