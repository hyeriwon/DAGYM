package kr.point.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.point.dao.PointDAO;

public class OutAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
        HttpSession session = request.getSession();
        Integer user_num = (Integer) session.getAttribute("user_num");
        Integer user_auth = (Integer) session.getAttribute("user_auth");

        if (user_num == null || (user_auth != 8 && user_auth != 9)) {
            // 로그인이 안되었거나 관리자가 아닌 경우
            return "redirect:/member/loginForm.do";
        }

        request.setCharacterEncoding("UTF-8");
        
        // 요청으로부터 파라미터 받기
        String memNumStr = request.getParameter("mem_num");
        String poi_type = request.getParameter("poi_type");
        String poiOutStr = request.getParameter("poi_out");

        int mem_num = Integer.parseInt(memNumStr);
        int poi_out = Integer.parseInt(poiOutStr);
        
        PointDAO dao = PointDAO.getInstance();
        
        //차감할 포인트 > 사용 가능 포인트 = 차감 불가
        int totalPointsInOut = dao.getTotalPointsInOut(mem_num);
        if (poi_out > totalPointsInOut) {
            request.setAttribute("notice_msg", "포인트가 부족합니다.");
            request.setAttribute("notice_url", request.getContextPath() + "/point/adminList.do?mem_num=" + mem_num);
            return "/WEB-INF/views/common/alert_view.jsp";
        }
        
        dao.insertOut(mem_num, poi_type, poi_out);

		request.setAttribute("notice_msg", "포인트 사용이 완료되었습니다.");
		request.setAttribute("notice_url", request.getContextPath() + "/point/adminList.do?mem_num=" + mem_num);
		
		//JSP 경로 반환
		return "/WEB-INF/views/common/alert_view.jsp";
	}
}
