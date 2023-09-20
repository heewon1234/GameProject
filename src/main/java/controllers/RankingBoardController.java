package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.rankBoard")
public class RankingBoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd = request.getRequestURI();
		try {
			
			if(cmd.equals("/list.rankBoard")) { // 게시물 리스트 가져오기
				
			} else if(cmd.equals("/goToRanking.rankBoard")) { // 랭킹게시판 창으로 이동
				
			} else if(cmd.equals("/search.rankBoard")) { // 랭킹 검색 ( 아이디 )
				
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
