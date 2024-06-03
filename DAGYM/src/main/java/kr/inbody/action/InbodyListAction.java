package kr.inbody.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.inbody.dao.InbodyDAO;
import kr.inbody.vo.InbodyVO;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;
import kr.util.PagingUtil;

public class InbodyListAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//세션에서 로그인 정보 가져오기
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		if(user_num == null) {
			request.setAttribute("notice_msg", "로그인 후 확인가능합니다.");
			request.setAttribute("notice_url", request.getContextPath()+"/member/loginForm.do");
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		if(user_auth >=8) {
			user_num = Integer.parseInt(request.getParameter("client_num"));
		}
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null)pageNum="1";
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");
		List<InbodyVO> inbodylist = null;
		InbodyDAO inbodydao = InbodyDAO.getInstance();
		int count = inbodydao.countInbodyByUser(keyfield, keyword, user_num);
		PagingUtil page = new PagingUtil(keyfield,keyword,Integer.parseInt(pageNum),
				count,20,10,"inbodyList.do");
		if(count > 0) {
			inbodylist = inbodydao.getListInbodyByUser(page.getStartRow(),page.getEndRow(), keyword, keyfield, user_num);
		}
		MemberDAO memberdao = MemberDAO.getInstance();
		MemberVO member =memberdao.getMember(user_num);
		request.setAttribute("mem_name",member.getMem_name());
		request.setAttribute("count", count);
		request.setAttribute("list", inbodylist);
		request.setAttribute("page", page.getPage());
		return "/WEB-INF/views/inbody/inbodyList.jsp";
		
	}
  
}
  