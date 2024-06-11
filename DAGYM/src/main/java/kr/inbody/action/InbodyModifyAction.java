package kr.inbody.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.inbody.dao.InbodyDAO;
import kr.inbody.vo.InbodyVO;
import kr.util.FileUtil;

public class InbodyModifyAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_num == null) {
			request.setAttribute("notice_msg", "로그인 후 확인가능합니다.");
			request.setAttribute("notice_url", request.getContextPath()+"/common/loginForm.do");
			return "/WEB-INF/views/common/alert_view.jsp";
		}

		if(user_auth >=8) { //관리자일 경우
			int client_num = Integer.parseInt(request.getParameter("client_num"));
			request.setCharacterEncoding("utf-8");
			String inb_date = request.getParameter("inb_date");
			InbodyDAO inbodydao = InbodyDAO.getInstance();
			InbodyVO db_inbody = inbodydao.getInbody(inb_date, client_num);

			InbodyVO inbody = new InbodyVO();
			inbody.setMem_num(user_num);
			inbody.setInb_hei(Integer.parseInt(request.getParameter("inb_hei")));
			inbody.setInb_wei(Integer.parseInt(request.getParameter("inb_wei")));
			inbody.setInb_mus(Integer.parseInt(request.getParameter("inb_mus")));
			inbody.setInb_date(inb_date);
			inbody.setInb_num(Integer.parseInt(request.getParameter("inb_num")));
			inbody.setInb_photo(FileUtil.createFile(request, "inb_photo"));
			inbodydao.modifyInbody(inbody);
			if(inbody.getInb_photo()!=null && !"".equals(inbody.getInb_photo())) {
				FileUtil.removeFile(request, db_inbody.getInb_photo());
			}
			request.setAttribute("inb_date", inbody.getInb_date());
			request.setAttribute("notice_msg", "인바디 정보가 수정되었습니다.");
			request.setAttribute("notice_url", request.getContextPath()+"/inbody/inbodyDetail.do?inb_date="+inb_date+"&client_num="+client_num);
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		request.setCharacterEncoding("utf-8");
		String inb_date = request.getParameter("inb_date");
		InbodyDAO inbodydao = InbodyDAO.getInstance();
		InbodyVO db_inbody = inbodydao.getInbody(inb_date, user_num);

		InbodyVO inbody = new InbodyVO();
		inbody.setMem_num(user_num);
		inbody.setInb_hei(Integer.parseInt(request.getParameter("inb_hei")));
		inbody.setInb_wei(Integer.parseInt(request.getParameter("inb_wei")));
		inbody.setInb_mus(Integer.parseInt(request.getParameter("inb_mus")));
		inbody.setInb_date(inb_date);
		inbody.setInb_num(Integer.parseInt(request.getParameter("inb_num")));
		inbody.setInb_photo(FileUtil.createFile(request, "inb_photo"));
		inbodydao.modifyInbody(inbody);
		if(inbody.getInb_photo()!=null && !"".equals(inbody.getInb_photo())) {
			FileUtil.removeFile(request, db_inbody.getInb_photo());
		}
		request.setAttribute("inb_date", inbody.getInb_date());
		request.setAttribute("notice_msg", "인바디 정보가 수정되었습니다.");
		request.setAttribute("notice_url", request.getContextPath()+"/inbody/inbodyDetail.do?inb_date="+inbody.getInb_date());
		return "/WEB-INF/views/common/alert_view.jsp";

	}
}