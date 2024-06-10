package kr.history.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.history.dao.HistoryDAO;
import kr.history.vo.HistoryVO;
import kr.schedule.vo.ScheduleVO;
import kr.util.PagingUtil;

public class AdminHistoryListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
        Integer user_auth = (Integer)session.getAttribute("user_auth");

		if(user_num == null || user_auth != 9) {
            //로그인이 안되었거나 관리자가 아닌 경우
            return "redirect:/member/loginForm.do";
        }
		
		//관리자로 로그인한 경우
		/*
		 * String pageNum = request.getParameter("pageNum"); if(pageNum == null) pageNum
		 * = "1";
		 * 
		 * String keyfield = request.getParameter("keyfield"); String keyword =
		 * request.getParameter("keyword");
		 * 
		 * HistoryDAO dao = HistoryDAO.getInstance(); int count =
		 * dao.getHistoryCountByAdmin(keyfield, keyword);
		 * 
		 * PagingUtil page = new
		 * PagingUtil(keyfield,keyword,Integer.parseInt(pageNum),count,20,10,
		 * "adminHistoryList.do"); List<HistoryVO> list = null; if(count > 0) { list =
		 * dao.getListHistoryByAdmin(user_num,page.getStartRow(), page.getEndRow(),
		 * keyfield, keyword); }
		 * 
		 * request.setAttribute("count", count); request.setAttribute("list", list);
		 * request.setAttribute("page", page.getPage());
		 */
		
		// HistoryDAO를 사용하여 스케줄 데이터를 가져옴
		HistoryDAO dao = HistoryDAO.getInstance();
        List<ScheduleVO> schedules = dao.getHistoryListByAdmin();


        // request에 스케줄 데이터를 저장
        request.setAttribute("schedules", schedules);
		
		
		return "/WEB-INF/views/history/adminHistoryList.jsp";
	}

}
