package kr.attend.action;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import kr.attend.dao.AttendDAO;
import kr.attend.vo.AttendVO;
import kr.controller.Action;
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
            return "redirect:/attend/adminMemberList.do";
        }

        int mem_num = Integer.parseInt(memNumStr);

        AttendDAO dao = AttendDAO.getInstance();

        List<AttendVO> list = null;
        list = dao.getList(mem_num);

        request.setAttribute("list", list);

        //이번 달 출석 일수 계산
        String month = new java.text.SimpleDateFormat("yyyy-MM").format(new java.util.Date());
        int attendCount = dao.getMonthlyAttendCount(mem_num, month);
        request.setAttribute("month", month);
        request.setAttribute("attendCount", attendCount);

        //JSP 경로 반환
        return "/WEB-INF/views/attend/adminList.jsp";
    }
}