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
        Integer user_num = (Integer) session.getAttribute("user_num");
        Integer user_auth = (Integer)session.getAttribute("user_auth");
        
        if (user_num == null) {//로그인이 되지 않은 경우
            return "redirect:/member/loginForm.do";
        }

        // 관리자 여부 확인
        Integer auth = (Integer) session.getAttribute("user_auth");
        if (auth == null || (auth != 8 && auth != 9)) {
            // 권한이 없을 경우
            return "redirect:/member/loginForm.do";
        }

        // 특정 회원의 출석체크 정보를 확인
        String mem_num = request.getParameter("mem_num");
        Integer memNum = null;
        if (mem_num != null && mem_num.matches("\\d+")) {
            memNum = Integer.parseInt(mem_num);
        }

        // 선택한 페이지 반환
        String pageNum = request.getParameter("pageNum");

        if (pageNum == null)
            pageNum = "1";

        AttendDAO dao = AttendDAO.getInstance();
        int count = dao.getCount();

        // currentPage, count, rowCount, pageCount
        PagingUtil page = new PagingUtil(Integer.parseInt(pageNum), count, 20, 10, "adminList.do?mem_num=" + memNum);

        List<AttendVO> list = null;
        if (count > 0) {
            list = dao.getList(memNum, page.getStartRow(), page.getEndRow());
        }

        request.setAttribute("count", count);
        request.setAttribute("list", list);
        request.setAttribute("page", page.getPage());

        // 이번달 출석일수 계산
        String month = new java.text.SimpleDateFormat("yyyy-MM").format(new java.util.Date());
        int attendCount = dao.getMonthlyAttendCount(memNum, month);
        request.setAttribute("month", month);
        request.setAttribute("attendCount", attendCount);

        // JSP 경로 반환
        return "/WEB-INF/views/attend/adminList.jsp";
    }
}