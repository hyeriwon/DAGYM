package kr.attend.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.attend.dao.AttendDAO;
import kr.attend.vo.AttendVO;

@WebServlet("/insertAttend")
public class AttendWriteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int mem_num = Integer.parseInt(request.getParameter("mem_num"));

        AttendVO attendVO = new AttendVO();
        attendVO.setMem_num(mem_num);

        try {
            AttendDAO.getInstance().insert(attendVO);
            response.getWriter().write("success");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("error");
        }
    }
}
