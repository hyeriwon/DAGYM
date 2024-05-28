package kr.attend.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.attend.dao.AttendDAO;
import kr.attend.vo.AttendVO;
import kr.controller.Action;
import kr.util.PagingUtil;

public class ListAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num == null) {//로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		//로그인 된 경우

		AttendDAO dao = AttendDAO.getInstance();

		List<AttendVO> list = null;
		list = dao.getList(user_num);
		
		request.setAttribute("list", list);
		
        //이번달 출석일수 계산
        String month = new java.text.SimpleDateFormat("yyyy-MM").format(new java.util.Date());
        int attendCount = dao.getMonthlyAttendCount(user_num, month);
        request.setAttribute("month", month);
        request.setAttribute("attendCount", attendCount);
        
		//JSP 경로 반환
		return "/WEB-INF/views/attend/list.jsp";
	}
}