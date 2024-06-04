package kr.exercise.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.exercise.dao.ExerciseDAO;
import kr.exercise.vo.ExerciseVO;

public class ExerciseWriteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		request.setCharacterEncoding("UTF-8");
		if(user_num == null) {
			request.setAttribute("notice_msg", "로그인 후 작성가능합니다.");
			request.setAttribute("notice_url", request.getContextPath()+"/member/loginForm.do");
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		ExerciseVO exercise = new ExerciseVO();
		exercise.setExe_date(request.getParameter("exe_date"));
		exercise.setExe_time(Integer.parseInt(request.getParameter("exe_time")));
		exercise.setExe_type(request.getParameter("exe_type"));
		exercise.setExe_content(request.getParameter("exe_content"));
		exercise.setMem_num(user_num);
		
		ExerciseDAO exedao = ExerciseDAO.getInstance();
		exedao.insertExercise(exercise);
		request.setAttribute("notice_msg", "운동기록 등록 완료");
		request.setAttribute("notice_url", request.getContextPath()+"/exercise/exerciseList.do");
		return "/WEB-INF/views/common/alert_view.jsp";
		
	}

}
