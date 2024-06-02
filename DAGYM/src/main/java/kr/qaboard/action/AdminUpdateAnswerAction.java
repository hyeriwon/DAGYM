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
		
		Map<String, String> mapAjax = new HashMap<String, String>();
		QABoardDAO dao = QABoardDAO.getInstance();
		
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		//로그인 확인
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) {
			mapAjax.put("result", "logout");
		}else if(user_num!=null && user_auth >= 8){//로그인한 사람이 관리자,강사가 맞는지 체크
			QABoardVO qaboard = new QABoardVO();
			qaboard.setMem_num(user_num);
			qaboard.setQab_content(request.getParameter("re_content"));
			qaboard.setQab_ip(request.getRemoteAddr());
			qaboard.setQab_num(Integer.parseInt(request.getParameter("re_num")));
			
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
