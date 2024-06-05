package kr.inbody.action;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.inbody.dao.InbodyDAO;
import kr.inbody.vo.InbodyVO;
import kr.util.FileUtil;

public class InbodyWriteAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			return "redirect:/WEB-INF/common/login.jsp";
		}
		String inb_date = request.getParameter("inb_date");
		LocalDate selectedDate = LocalDate.parse(inb_date, DateTimeFormatter.ISO_DATE);
	    LocalDate today = LocalDate.now();
	    System.out.println(selectedDate);
	    if (selectedDate.isAfter(today)) {
	    	request.setAttribute("notice_msg", "오늘 날짜 이후의 인바디기록을 작성할 수 없습니다.");
            request.setAttribute("notice_url", request.getContextPath() + "/inbody/inbodyMain.do");
            return "/WEB-INF/views/common/alert_view.jsp";
	    }
		
		InbodyVO inbody = new InbodyVO();
		inbody.setMem_num(user_num);
		inbody.setInb_date(inb_date);
		inbody.setInb_hei(Integer.parseInt(request.getParameter("inb_hei")));
		inbody.setInb_wei(Integer.parseInt(request.getParameter("inb_wei")));
		inbody.setInb_mus(Integer.parseInt(request.getParameter("inb_mus")));
		inbody.setInb_photo(FileUtil.createFile(request,"inb_photo"));
		InbodyDAO inbodyDAO = InbodyDAO.getInstance();
		inbodyDAO.insertInbody(inbody);
		request.setAttribute("notice_msg", "인바디 등록 완료");
		
		request.setAttribute("notice_url", request.getContextPath()+"/inbody/inbodyList.do");
		return "/WEB-INF/views/common/alert_view.jsp";
	}

}
