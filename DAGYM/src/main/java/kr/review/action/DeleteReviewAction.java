package kr.review.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.review.dao.ReviewDAO;
import kr.review.vo.ReviewVO;
import kr.util.FileUtil;

public class DeleteReviewAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,String> mapAjax = new HashMap<>();
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer) session.getAttribute("user_num");
		
		if(user_num==null) {
			mapAjax.put("result", "logout");
		}else {
			request.setCharacterEncoding("utf-8");
			
			int rev_num = Integer.parseInt(request.getParameter("rev_num"));
			
			//db_review의 mem_num 값과 비교하기
			ReviewDAO dao = ReviewDAO.getInstance();
			ReviewVO db_review = dao.getReview(rev_num);
			
			if(db_review.getMem_num()!=user_num) {
				mapAjax.put("result", "wrongAccess");
			}else {
				dao.deleteReview(db_review, user_num);
				
				//서버의 파일 삭제
				FileUtil.removeFile(request, db_review.getRev_filename1());
				FileUtil.removeFile(request, db_review.getRev_filename2());
				
				mapAjax.put("result", "success");
			}		
		}
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapper);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}
}
