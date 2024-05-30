package kr.point.action;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import kr.attend.dao.AttendDAO;
import kr.attend.vo.AttendVO;
import kr.controller.Action;
import kr.point.dao.PointDAO;
import kr.point.vo.PointVO;
import kr.util.PagingUtil;

public class AdminListAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        Integer user_num = (Integer)session.getAttribute("user_num");
        Integer user_auth = (Integer)session.getAttribute("user_auth");

        if(user_num == null || (user_auth != 8 && user_auth != 9)) {
            //로그인이 안되었거나 관리자가 아닌 경우
            return "redirect:/member/loginForm.do";
        }

        //요청으로부터 mem_num 파라미터를 받음
        String memNumStr = request.getParameter("mem_num");
        if (memNumStr == null || memNumStr.isEmpty()) {
            //mem_num이 없으면 오류 처리
            return "redirect:/point/adminMemberList.do";
        }

        int mem_num = Integer.parseInt(memNumStr);
        
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null)
			pageNum = "1";

		PointDAO dao= PointDAO.getInstance();
		int count = dao.getPointCount();
		
		//페이지 처리
		PagingUtil page = new PagingUtil(Integer.parseInt(pageNum),count,7,10,"list.do");
		 
		List<PointVO> list = null;
		if(count > 0) {
			list = dao.getListPoint(mem_num, page.getStartRow(), page.getEndRow());
		}
		
		//포인트 전체누적 계산
        int totalPointsIn = dao.getTotalPointsIn(mem_num);
		//포인트 사용가능 계산
        int totalPointsInOut = dao.getTotalPointsInOut(mem_num);
        
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("page", page.getPage());
		request.setAttribute("totalPointsIn", totalPointsIn);
		request.setAttribute("totalPointsInOut", totalPointsInOut);
		request.setAttribute("mem_num", mem_num);//(주의) 버튼 누를 때 필요
		
		//JSP 경로 반환
		return "/WEB-INF/views/point/adminList.jsp";
    }
}