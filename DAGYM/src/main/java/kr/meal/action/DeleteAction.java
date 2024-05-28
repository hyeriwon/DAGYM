package kr.meal.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.meal.dao.MealDAO;
import kr.meal.vo.MealVO;

public class DeleteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = 
				(Integer)session.getAttribute("user_num");
		Integer user_auth = 
				(Integer)session.getAttribute("user_auth");
		if(user_num == null) {
			request.setAttribute("notice_msg", "로그인을 해야합니다.");
			request.setAttribute("notice_url", request.getContextPath()+"/member/loginForm.do");
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		//로그인 된 경우
		int meal_num = Integer.parseInt(
				      request.getParameter("meal_num"));
		MealDAO dao = MealDAO.getInstance();
		MealVO db_meal = dao.getMeal(meal_num);
		//로그인한 회원번호와 작성자 회원번호 일치 여부 체크
		if(user_num != db_meal.getMem_num()) {
			request.setAttribute("notice_msg", "회원본인이 삭제해야합니다.");
			request.setAttribute("notice_url", request.getContextPath()+"/member/loginForm.do");
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		
		if(user_auth ==9) {
			request.setAttribute("notice_msg", "회원본인이 삭제해야합니다.");
			request.setAttribute("notice_url", request.getContextPath()+"/meal/mealDetail.do");
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		//로그인한 회원번호와 작성자 회원번호 일치
		dao.deleteMeal(meal_num);
		//파일 삭제
		
		request.setAttribute("notice_msg", "글 삭제 완료");
		request.setAttribute("notice_url", request.getContextPath()+"/meal/mealDetail.do");
		
		return "/WEB-INF/views/common/alert_view.jsp";
	}
}

