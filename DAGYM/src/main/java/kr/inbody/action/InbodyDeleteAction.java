package kr.inbody.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.inbody.dao.InbodyDAO;
import kr.inbody.vo.InbodyVO;

public class InbodyDeleteAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//로그인 여부 확인하기
		HttpSession session = request.getSession();
		Integer mem_num = (Integer) session.getAttribute("user_num");

		if(mem_num==null) {
			return "redirect:/member/loginForm.do";
		}
		//전송된 데이터 인코딩 타입 지정
		request.setCharacterEncoding("utf-8");


		int inb_num = Integer.parseInt(request.getParameter("inb_num"));
		InbodyDAO inbodydao  = InbodyDAO.getInstance();
		InbodyVO db_inbody = inbodydao.getInbodybyInbnum(inb_num);
		if(db_inbody.getMem_num() == mem_num) {

			inbodydao.deleteInbody(inb_num);
			request.setAttribute("notice_msg", "삭제 처리되었습니다.");
			request.setAttribute("notice_url", request.getContextPath()+"/inbody/inbodyList.do" );
			}else {
				request.setAttribute("notice_msg", "본인만 삭제 가능합니다.");
				request.setAttribute("notice_url", request.getContextPath()+"/inbody/inbodyList.do" );
			}
		return "../WEB-INF/views/common/alert_view.jsp";
	}

}
