package kr.qaboard.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.qaboard.dao.QABoardDAO;
import kr.qaboard.vo.QABoardVO;
import kr.util.FileUtil;

public class UserUpdateAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		
		//로그인 체크
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num==null) {
			return "redirect:/member/loginForm.do";
		}
		
		request.setCharacterEncoding("utf-8");
		int qab_num = Integer.parseInt(request.getParameter("qab_num"));
		QABoardDAO dao = QABoardDAO.getInstance();
		QABoardVO db_qaboard = dao.getUserBoard(qab_num, user_num);
		
		if(user_num!=db_qaboard.getMem_num()) {
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		QABoardVO qaboard = new QABoardVO();
		qaboard.setQab_num(qab_num);
		qaboard.setQab_title(request.getParameter("qab_title"));
		qaboard.setQab_type(Integer.parseInt(request.getParameter("qab_type")));
		qaboard.setQab_content(request.getParameter("qab_content"));
		qaboard.setQab_filename(FileUtil.createFile(request, "qab_filename"));
		qaboard.setQab_ip(request.getRemoteAddr());
		
		dao.updateUserBoard(qaboard);
		
		//파일명이 null이 아니고 비어있지 않은 경우, 기존의 파일 데이터 삭제
		if(qaboard.getQab_filename()!=null&&!"".equals(qaboard.getQab_filename())) {
			FileUtil.removeFile(request, db_qaboard.getQab_filename());
		}
		
		return "redirect:/qaboard/userDetail.do?qab_num="+qab_num;
	}
}
