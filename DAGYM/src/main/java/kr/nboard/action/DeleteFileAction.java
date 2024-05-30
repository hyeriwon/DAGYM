package kr.nboard.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.nboard.dao.NboardDAO;
import kr.nboard.vo.NboardVO;
import kr.util.FileUtil;

public class DeleteFileAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//맵 객체 생성
		Map<String,String> mapAjax = new HashMap<String,String>();
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_num == null && user_auth != 9) {//로그인이 되지 않은 경우
			mapAjax.put("result", "wrongAccess");
		}else {
			request.setCharacterEncoding("utf-8");
			int nbo_num = Integer.parseInt(request.getParameter("nbo_num"));
			NboardDAO dao = NboardDAO.getInstance();
			NboardVO db_board = dao.getNboard(nbo_num);
			
			dao.deleteFile(nbo_num);
			//파일 삭제
			FileUtil.removeFile(request, db_board.getNbo_filename());
			
			mapAjax.put("result", "success");
		}
		
		//JSON 데이터 생성
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
