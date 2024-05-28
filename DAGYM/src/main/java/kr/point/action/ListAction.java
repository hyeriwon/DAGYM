package kr.point.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.point.dao.PointDAO;
import kr.point.vo.PointVO;
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
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null)
			pageNum = "1";
		
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");
		
		PointDAO dao= PointDAO.getInstance();
		int count = dao.getPointCount(keyfield, keyword);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,Integer.parseInt(pageNum),count,20,10,"list.do");
		 
		List<PointVO> list = null;
		if(count > 0) {
			list = dao.getListPoint(user_num, page.getStartRow(), page.getEndRow(), keyfield, keyword);
		}
		
		//포인트 전체누적 계산
        int totalPointsIn = dao.getTotalPointsIn(user_num);
		//포인트 사용가능 계산
        int totalPointsInOut = dao.getTotalPointsInOut(user_num);
        
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("page", page.getPage());
		request.setAttribute("totalPointsIn", totalPointsIn);
		request.setAttribute("totalPointsInOut", totalPointsInOut);
		
		//JSP 경로 반환
		return "/WEB-INF/views/point/list.jsp";
	}
}