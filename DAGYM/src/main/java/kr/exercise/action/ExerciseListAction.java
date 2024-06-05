package kr.exercise.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.exercise.dao.ExerciseDAO;
import kr.exercise.vo.ExerciseVO;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;
import kr.util.PagingUtil;

public class ExerciseListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();

		//로그인체크
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) pageNum = "1";
		String keyfield = request.getParameter("keyfield");
		String keyword =request.getParameter("keyword");


		if(user_auth == 2) {//사용자일 경우
			ExerciseDAO exedao = ExerciseDAO.getInstance();
			int count = exedao.countExerciseByUser(keyfield, keyword, user_num);
			PagingUtil page = new PagingUtil(keyfield,keyword,Integer.parseInt(pageNum),count,10,5,"exerciseList.do");
			List<ExerciseVO> exerciseList = exedao.listExerciseByUser(page.getStartRow(),page.getEndRow(),keyfield,keyword,user_num);
			MemberDAO memberdao = MemberDAO.getInstance();
			MemberVO member = memberdao.getMember(user_num);
			request.setAttribute("mem_name", member.getMem_name());
			request.setAttribute("count",count);
			request.setAttribute("list", exerciseList);
			request.setAttribute("page", page.getPage());
		}
		else if(user_auth >=8) {//관리자일경우
			Integer client_num = Integer.parseInt(request.getParameter("client_num"));
			ExerciseDAO exedao = ExerciseDAO.getInstance();
			int count = exedao.countExerciseByUser(keyfield, keyword, client_num);
			String addKey = "client_num="+client_num;
			PagingUtil page = new PagingUtil(keyfield,keyword,Integer.parseInt(pageNum),count, 10,5,"exerciseList.do",addKey);
			List<ExerciseVO> exerciseList = exedao.listExerciseByUser(page.getStartRow(),page.getEndRow(),keyfield,keyword, client_num	);
			MemberDAO memberdao = MemberDAO.getInstance();
			MemberVO member = memberdao.getMember(client_num);
			request.setAttribute("mem_name", member.getMem_name());
			request.setAttribute("count",count);
			request.setAttribute("list", exerciseList);
			request.setAttribute("page", page.getPage());

			return "/WEB-INF/views/exercise/exerciseList.jsp";
		}
		return "/WEB-INF/views/exercise/exerciseList.jsp";

	}
}
