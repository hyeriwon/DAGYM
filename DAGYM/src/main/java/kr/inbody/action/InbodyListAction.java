package kr.inbody.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.inbody.dao.InbodyDAO;
import kr.inbody.vo.InbodyVO;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;
import kr.util.PagingUtil;

public class InbodyListAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        // 세션에서 로그인 정보 가져오기
        HttpSession session = request.getSession();
        Integer user_num = (Integer)session.getAttribute("user_num");
        Integer user_auth = (Integer)session.getAttribute("user_auth");
        request.setCharacterEncoding("utf-8"); // 한글 처리를 위한 인코딩 설정

        String pageNum = request.getParameter("pageNum");
        if (pageNum == null) pageNum = "1";
        String keyfield = request.getParameter("keyfield");
        String keyword = request.getParameter("keyword");
        String clientNumParam = request.getParameter("client_num"); // client_num 파라미터 받아오기
        
        if (user_num == null) {
            // 로그인되지 않은 사용자일 경우
            request.setAttribute("notice_msg", "로그인 후 확인 가능합니다.");
            request.setAttribute("notice_url", request.getContextPath() + "/member/loginForm.do");
            return "/WEB-INF/views/common/alert_view.jsp";
        }
        
        if (user_auth >= 8) {
            // 관리자일 경우  
            if (clientNumParam != null) {
                user_num = Integer.parseInt(clientNumParam); // 사용자 번호 파라미터 가져오기
            }
            InbodyDAO inbodydao = InbodyDAO.getInstance();
            int count = inbodydao.countInbodyByUser(keyfield, keyword,user_num);
            String addKey ="client_num="+user_num;
            PagingUtil page = new PagingUtil(keyfield, keyword, Integer.parseInt(pageNum),count, 10, 5, "inbodyList.do",addKey);
            List<InbodyVO> inbodylist = inbodydao.getListInbodyByUser(page.getStartRow(), page.getEndRow(), keyword, keyfield, user_num);
            MemberDAO memberdao = MemberDAO.getInstance();
            MemberVO member = memberdao.getMember(user_num);
            request.setAttribute("mem_name", member.getMem_name());
            request.setAttribute("count", count);
            request.setAttribute("list", inbodylist);
            request.setAttribute("page", page.getPage());
            return "/WEB-INF/views/inbody/inbodyList.jsp";
        } else if (user_auth == 2) {
            // 일반 사용자일 경우
            InbodyDAO inbodydao = InbodyDAO.getInstance();
            int count = inbodydao.countInbodyByUser(keyfield, keyword, user_num);
            PagingUtil page = new PagingUtil(keyfield, keyword, Integer.parseInt(pageNum),
                    count, 20, 10, "inbodyList.do");
            List<InbodyVO> inbodylist = inbodydao.getListInbodyByUser(page.getStartRow(), page.getEndRow(), keyword, keyfield, user_num);
            MemberDAO memberdao = MemberDAO.getInstance();
            MemberVO member = memberdao.getMember(user_num);
            request.setAttribute("mem_name", member.getMem_name());
            request.setAttribute("count", count);
            request.setAttribute("list", inbodylist);
            request.setAttribute("page", page.getPage());
            return "/WEB-INF/views/inbody/inbodyList.jsp";       
        }
        
        // 기본적으로는 회원 목록 페이지로 이동
        return "/WEB-INF/views/inbody/inbodyList.jsp";
    }
}
