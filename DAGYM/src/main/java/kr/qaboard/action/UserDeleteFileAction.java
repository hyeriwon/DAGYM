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
import kr.util.FileUtil;

public class UserDeleteFileAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Map<String, String> mapAjax = new HashMap<String, String>();
		//로그인 확인
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) {
			mapAjax.put("result", "logout");
		}else {//로그인이 된 경우
			request.setCharacterEncoding("utf-8");
			int qab_num = Integer.parseInt(request.getParameter("qab_num"));
			
			QABoardDAO dao = QABoardDAO.getInstance();
			QABoardVO qaboard = dao.getUserBoard(qab_num,user_num);
			
			//로그인한 회원번호와 작성자 회원번호 일치 여부 체크
			if(user_num!=qaboard.getMem_num()) {
				mapAjax.put("result", "wrongAccess");
			}else {
				dao.deleteFile(qab_num);
				FileUtil.removeFile(request, qaboard.getQab_filename());
				
				mapAjax.put("result", "success");
			}
		}
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
