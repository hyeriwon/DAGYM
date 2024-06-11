package kr.review.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.review.dao.ReviewDAO;
import kr.review.vo.ReviewVO;
import kr.util.FileUtil;

public class WriteReviewAction implements Action{

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
		
		//로그인한 회원번호와 수강내역의 회원번호 일치 여부 확인
		if(mem_num!= Integer.parseInt(request.getParameter("mem_num"))) {
			request.setAttribute("notice_msg", "수강후기 작성 권한이 없습니다.");
			request.setAttribute("notice_url", request.getContextPath()+"/history/히스토리목록보는 페이지");
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		
		
		//해당 PT에 대해 이미 후기가 작성되었는지 확인
		ReviewVO review = new ReviewVO();
		review.setSch_num(Integer.parseInt(request.getParameter("sch_num")));
		ReviewDAO revDAO = ReviewDAO.getInstance();
		ReviewVO revVO = revDAO.checkReview(review.getSch_num());
		if(revVO!=null && revVO.getRev_del()==0) {
			String notice_msg = "이미 후기를 작성했습니다.";
			String notice_url = request.getContextPath()+"/review/listReview.do";
			request.setAttribute("notice_msg", notice_msg);
			request.setAttribute("notice_url", notice_url);
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		
		//전송된 데이터 반환받아 reviewVO 객체에 대입		
		review.setMem_num(mem_num);		
		review.setRev_grade(Integer.parseInt(request.getParameter("rev_grade")));
		review.setRev_title(request.getParameter("rev_title"));
		review.setRev_content(request.getParameter("rev_content"));
		String filename1 = null;
		String filename2 = null;
		if(request.getPart("filename1")!=null) {
			filename1 = FileUtil.createFile(request, "filename1");
			review.setRev_filename1(filename1);
		}
		if(request.getPart("filename2")!=null) {
			filename2 = FileUtil.createFile(request, "filename2");
			review.setRev_filename2(filename2);
		}
		review.setRev_ip(request.getRemoteAddr());



		//DB에 review 기록하기
		ReviewDAO dao = ReviewDAO.getInstance();
		dao.insertReview(review);

		request.setAttribute("notice_msg", "수강후기 작성을 완료했습니다.");
		request.setAttribute("notice_url", request.getContextPath()+"/review/listReview.do");

		return "/WEB-INF/views/common/alert_view.jsp";
	}

}
