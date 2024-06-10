package kr.exercise.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.exercise.dao.ExerciseDAO;
import kr.exercise.vo.ExerciseVO;

public class ExerciseDetailAction  implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		if(user_num == null) {
			request.setAttribute("notice_msg", "로그인 후 확인가능합니다.");
			request.setAttribute("notice_url", request.getContextPath()+"/common/loginForm.do");
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		if(user_auth >=8) {
			user_num = Integer.parseInt(request.getParameter("client_num"));
			String exe_date = request.getParameter("exe_date");
			ExerciseDAO exercisedao = ExerciseDAO.getInstance();
			List<ExerciseVO> exerciselist = exercisedao.getDetailExercise(exe_date, user_num);
			int total_exetime = exercisedao.calExetime(exe_date, user_num);
			request.setAttribute("total_exetime", total_exetime);
			request.setAttribute("exerciselist",exerciselist );
			request.setAttribute("exe_date", exe_date);
			return "/WEB-INF/views/exercise/exerciseDetail.jsp";
		}
		String exe_date = request.getParameter("exe_date");
		ExerciseDAO exercisedao = ExerciseDAO.getInstance();
		List<ExerciseVO> exerciselist = exercisedao.getDetailExercise(exe_date, user_num);
		int total_exetime = exercisedao.calExetime(exe_date, user_num);
		request.setAttribute("total_exetime", total_exetime);
		request.setAttribute("exerciselist",exerciselist );
		request.setAttribute("exe_date", exe_date);
		
		
		return "/WEB-INF/views/exercise/exerciseDetail.jsp";
	}

}
