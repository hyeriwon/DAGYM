package kr.exercise.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.exercise.dao.ExerciseDAO;
import kr.exercise.vo.ExerciseVO;
import kr.util.StringUtil;

public class ExerciseModifyAction implements Action{

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
		
		request.setCharacterEncoding("utf-8");
		ExerciseVO exercise = new ExerciseVO();
		exercise.setMem_num(user_num);
		exercise.setExe_num(Integer.parseInt(request.getParameter("exe_num")));	
		exercise.setExe_time(Integer.parseInt(request.getParameter("exe_time")));
		exercise.setExe_type(request.getParameter("exe_type"));
		exercise.setExe_date(request.getParameter("exe_date"));
		exercise.setExe_content(StringUtil.useBrNoHTML(request.getParameter("exe_content")));
		ExerciseDAO exercisedao = ExerciseDAO.getInstance();
		exercisedao.updateExercise(exercise);
		
		request.setAttribute("notice_msg", "운동기록이 수정되었습니다.");
		request.setAttribute("notice_url", request.getContextPath()+"/exercise/exerciseDetail.do?exe_date="+exercise.getExe_date());
		return "/WEB-INF/views/common/alert_view.jsp";
		
	}

}
