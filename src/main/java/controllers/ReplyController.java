package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.reply")
public class ReplyController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd = request.getRequestURI();
		try {
			if(cmd.equals("/list.reply")) { // 댓글 리스트 가져오기
				
			} else if(cmd.equals("/insert.reply")) { // 댓글 등록
				
			} else if(cmd.equals("/delete.reply")) { // 댓글 삭제
				
			} else if(cmd.equals("/update.reply")) { // 댓글 수정
				
			} 
		} catch(Exception e) {
			e.printStackTrace();
			response.sendRedirect("/error.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
