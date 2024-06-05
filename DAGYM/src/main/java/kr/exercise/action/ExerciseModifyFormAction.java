package kr.exercise.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.exercise.dao.ExerciseDAO;
import kr.exercise.vo.ExerciseVO;

public class ExerciseModifyFormAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_num == null) {
			request.setAttribute("notice_msg", "로그인 후 확인가능합니다.");
			request.setAttribute("notice_url", request.getContextPath()+"/member/loginForm.do");
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		Integer exe_num = Integer.parseInt(request.getParameter("exe_num"));
		ExerciseDAO exercisedao = ExerciseDAO.getInstance();
		ExerciseVO exercise = exercisedao.getDetailExerciseByExe_num(exe_num);
		if(exercise == null) {
			return "/WEB-INF/views/common/notice.jsp";
		}
		if(user_auth >= 8) {
			request.setAttribute("exercise", exercise);
			return "/WEB-INF/views/exercise/exerciseModifyForm.jsp";
			
		}
		if(user_num != exercise.getMem_num()) {
			request.setAttribute("notice_msg", "본인만 확인가능합니다.");
			request.setAttribute("notice_url", request.getContextPath()+"/member/loginForm.do");
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		
		request.setAttribute("exercise", exercise);
		
		
		return "/WEB-INF/views/exercise/exerciseModifyForm.jsp";
	}

}
