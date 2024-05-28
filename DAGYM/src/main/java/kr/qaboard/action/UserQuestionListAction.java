package kr.qaboard.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;
import kr.qaboard.dao.QABoardDAO;
import kr.qaboard.vo.QABoardVO;
import kr.util.PagingUtil;

public class UserQuestionListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		
		//로그인 확인
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) {
			return "redirect:/member/loginForm.do";
		}
		
		//로그인이 된 경우
		MemberDAO memberDAO = MemberDAO.getInstance();
		MemberVO member = memberDAO.getMember(user_num);
		request.setAttribute("member", member);
		
		//페이지처리
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null) pageNum = "1";
		
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");
		
		QABoardDAO qaboardDAO = QABoardDAO.getInstance();
		int count = qaboardDAO.getInquiryCount(keyfield, keyword);
		
		PagingUtil page = new PagingUtil(keyfield, keyword, Integer.parseInt(pageNum), count, 20,10, "userQuestionList.do");
		
		List<QABoardVO> list = null;
		if(count > 0) {
			list = qaboardDAO.getInquiryList(user_num, page.getStartRow(), page.getEndRow(), keyfield, keyword);
		}
		
		return "WEB-INF/views/qaboard/userQuestionList.jsp";
	}
	
}