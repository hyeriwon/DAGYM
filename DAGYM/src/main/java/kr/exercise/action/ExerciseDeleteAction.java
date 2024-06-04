package kr.exercise.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.exercise.dao.ExerciseDAO;

public class ExerciseDeleteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		request.setCharacterEncoding("UTF-8");
		if(user_num == null) {
			request.setAttribute("notice_msg", "로그인 후 작성가능합니다.");
			request.setAttribute("notice_url", request.getContextPath()+"/member/loginForm.do");
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		if(user_auth >=8) { //관리자일 경우
			
			Integer client_num = Integer.parseInt(request.getParameter("client_num"));
			Integer exe_num = Integer.parseInt(request.getParameter("exe_num"));
			ExerciseDAO exercisedao = ExerciseDAO.getInstance();
			exercisedao.deleteExercise(exe_num);
			request.setAttribute("notice_msg", "삭제 처리 되었습니다.");
			request.setAttribute("notice_url", request.getContextPath()+"/exercise/exerciseList.do?client_num="+client_num);
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		Integer exe_num = Integer.parseInt(request.getParameter("exe_num"));
		ExerciseDAO exercisedao = ExerciseDAO.getInstance();
		exercisedao.deleteExercise(exe_num);
		request.setAttribute("notice_msg", "삭제 처리 되었습니다.");
		request.setAttribute("notice_url", request.getContextPath()+"/exercise/exerciseList.do");
		
		return "/WEB-INF/views/common/alert_view.jsp";
	}

}
