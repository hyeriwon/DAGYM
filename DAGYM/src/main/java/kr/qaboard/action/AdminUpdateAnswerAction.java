package kr.qaboard.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.qaboard.dao.QABoardDAO;
import kr.qaboard.vo.QABoardVO;

public class AdminUpdateAnswerAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		request.setCharacterEncoding("utf-8");
		int re_num = Integer.parseInt(request.getParameter("qab_ref"));
		
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		QABoardDAO dao = QABoardDAO.getInstance();
		QABoardVO db_reply = dao.getAdminBoard(re_num);
		
				
		Map<String, String> mapAjax = new HashMap<String, String>();
		
		
		//로그인 확인
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) {
			mapAjax.put("result", "logout");
		}else if(user_num!=null && user_num==db_reply.getMem_num()){//로그인한 사람이 작성자와 일치하는지 체크
			QABoardVO qaboard = new QABoardVO();
			qaboard.setMem_num(user_num);//댓글 작성자 mem_num
			qaboard.setQab_content(request.getParameter("mre_content"));
			qaboard.setQab_ip(request.getRemoteAddr());
			qaboard.setQab_num(Integer.parseInt(request.getParameter("re_num")));//<qaboard.answer.js>에서 hidden으로 명시한 name
			
			dao.updateAdminBoard(qaboard);
			
			mapAjax.put("result", "success");
		}else {
			mapAjax.put("result", "wrongAccess");
		}
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
