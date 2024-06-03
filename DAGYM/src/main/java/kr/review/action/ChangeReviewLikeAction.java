package kr.review.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.review.dao.ReviewDAO;
import kr.review.vo.RevLikeVO;

public class ChangeReviewLikeAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,Object> mapAjax = new HashMap<String,Object>();
		
		HttpSession session = request.getSession();
		Integer mem_num = (Integer) session.getAttribute("user_num");
		
		if(mem_num==null) {
			mapAjax.put("result", "logout");
		}else {
			request.setCharacterEncoding("utf-8"); 
			
			int rev_num = Integer.parseInt(request.getParameter("rev_num"));
			
			RevLikeVO reviewLike = new RevLikeVO();
			reviewLike.setRev_num(rev_num);
			reviewLike.setMem_num(mem_num);
			
			ReviewDAO dao = ReviewDAO.getInstance();			
			RevLikeVO db_revLike = dao.getRevLike(reviewLike);
			
			if(db_revLike!=null) {
				dao.deleteLike(db_revLike);
				mapAjax.put("status", "noLikes");
			}else {
				dao.insertLike(reviewLike);				
				mapAjax.put("status", "yesLikes");
			}
			mapAjax.put("result", "success");
			mapAjax.put("count", dao.countReviewLikes(rev_num));			
		}
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
