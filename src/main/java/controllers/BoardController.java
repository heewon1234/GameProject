package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.board")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd = request.getRequestURI();
		try {
			if(cmd.equals("/list.board")) { // 게시물 리스트 가져오기
				
			} else if(cmd.equals("/insert.board")) { // 게시물 등록
				
			} else if(cmd.equals("/delete.board")) { // 게시물 삭제
				
			} else if(cmd.equals("/update.board")) { // 게시물 수정
				
			} else if(cmd.equals("/goToWrite.board")) { // 글쓰기 창으로 이동
				
			} else if(cmd.equals("/showContents.board")) { // 게시글 보기
				
			} else if(cmd.equals("/search.board")) { // 게시글 검색 ( 제목 & 내용 & 카테고리 )
				
			}
		} catch(Exception e) {
			e.printStackTrace();
			response.sendRedirect("/error.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
