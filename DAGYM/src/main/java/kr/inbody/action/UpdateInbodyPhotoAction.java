	package kr.inbody.action;
	
	import java.util.HashMap;
	import java.util.Map;
	
	import javax.servlet.http.HttpServletRequest;
	import javax.servlet.http.HttpServletResponse;
	import javax.servlet.http.HttpSession;
	
	import org.codehaus.jackson.map.ObjectMapper;
	
	import kr.controller.Action;
	import kr.inbody.dao.InbodyDAO;
import kr.inbody.vo.InbodyVO;
import kr.util.FileUtil;
	
	public class UpdateInbodyPhotoAction implements Action{
	
		@Override
		public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			Map<String,String> mapAjax = new HashMap<String,String>();
	
			HttpSession session = request.getSession();
			Integer user_num = 
					(Integer)session.getAttribute("user_num");
			if(user_num==null) {//로그인이 되지 않은 경우
				mapAjax.put("result", "logout");
			}else {//로그인 된 경우
				//전송된 데이터 인코딩 타입 지정
				request.setCharacterEncoding("UTF-8");
				//파일 업로드 처리
				String photo = 
						FileUtil.createFile(request, "photo");
				System.out.println(photo);
				
				InbodyDAO inbodydao = InbodyDAO.getInstance();
				String inb_date = request.getParameter("inb_date");
				InbodyVO inbody = inbodydao.getInbody(inb_date, user_num);
				inbodydao.updateMyInbodyPhoto(photo, inbody.getInb_num());
				mapAjax.put("result", "success");
			}
			ObjectMapper mapper = new ObjectMapper();
			String ajaxData = mapper.writeValueAsString(mapAjax);
			
			request.setAttribute("ajaxData", ajaxData);
	
			return "/WEB-INF/views/common/ajax_view.jsp";
		}
	}