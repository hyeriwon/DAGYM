package kr.attend.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.attend.dao.AttendDAO;
import kr.attend.vo.AttendVO;
import kr.controller.Action;

public class WriteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num == null) {//로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		//로그인 된 경우
		
		//전송된 데이터 인코딩 타입 지정
		request.setCharacterEncoding("utf-8");
		
	    // 오늘 날짜를 문자열로 얻기
        String date = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
        
        AttendDAO dao = AttendDAO.getInstance();

        // 오늘 날짜에 이미 출석했는지 확인
        boolean isExist = dao.isAttendExist(user_num, date);
        
        if (isExist) {
            // 이미 출석한 경우 처리
            return "/WEB-INF/views/attend/error.jsp";
        } else {
            // 출석 등록
            dao.insert(user_num);
            return "/WEB-INF/views/attend/write.jsp";
        }
	}
}