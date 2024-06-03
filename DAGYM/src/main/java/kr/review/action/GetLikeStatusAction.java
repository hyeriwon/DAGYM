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

public class GetLikeStatusAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,String> mapAjax = new HashMap<>();
		
		HttpSession session = request.getSession();
		Integer mem_num = (Integer) session.getAttribute("user_num");
		
		if(mem_num==null) {
			mapAjax.put("status", "logout");
		}else {
			request.setCharacterEncoding("utf-8");
			
			int rev_num = Integer.parseInt(request.getParameter("rev_num")); 
			
			RevLikeVO revLike = new RevLikeVO(); 
			revLike.setRev_num(rev_num);
			revLike.setMem_num(mem_num);
			
			ReviewDAO dao = ReviewDAO.getInstance();

			if(dao.getRevLike(revLike)!=null) {
				mapAjax.put("status", "yesLikes");
			}else {
				mapAjax.put("status", "noLikes");
			}
		}
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
