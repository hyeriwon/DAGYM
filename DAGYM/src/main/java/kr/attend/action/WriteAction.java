package kr.attend.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.attend.dao.AttendDAO;
import kr.attend.vo.AttendVO;
import kr.controller.Action;

public class WriteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		//전송된 데이터 인코딩 타입 지정
		request.setCharacterEncoding("utf-8");
		
		//자바빈(VO) 객체 생성
		AttendVO attendVO = new AttendVO();
		attendVO.setMem_num(Integer.parseInt(request.getParameter("mem_num")));

		AttendDAO dao = AttendDAO.getInstance();
		dao.insert(attendVO);
		
		//JSP 경로 반환
		return "/WEB-INF/views/attend/write.jsp";
	}
}