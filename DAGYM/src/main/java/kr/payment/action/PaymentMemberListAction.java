package kr.payment.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;
import kr.util.PagingUtil;

public class PaymentMemberListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
		//로그인체크
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_auth != 9) {
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) pageNum = "1";
		
		//검색
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");
		
		MemberDAO dao = MemberDAO.getInstance();
		int count = dao.getMemberCountByAdmin(keyfield, keyword);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, Integer.parseInt(pageNum), count, 20,10,"adminMemberList.do");
		
		List<MemberVO> list = null;
		if(count > 0) {
			list = dao.getListMemberByAdmin(page.getStartRow(), page.getEndRow(), keyfield, keyword);
		}
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("page", page.getPage());
		
		return "/WEB-INF/views/payment/paymentMemberList.jsp";
	}
}
