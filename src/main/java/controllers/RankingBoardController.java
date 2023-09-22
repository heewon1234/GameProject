package controllers;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.RankingBoardDAO;
import dto.RankingBoardDTO;

@WebServlet("*.rankBoard")
public class RankingBoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd = request.getRequestURI();
		RankingBoardDAO rnkdao = RankingBoardDAO.getInstance();
		HttpSession session = request.getSession();
		
		try {
			
			if(cmd.equals("/list.rankBoard")) { // 게시물 리스트 가져오기
				
				String id = (String)request.getSession().getAttribute("loginID");
				String gname = request.getParameter("game_name");
				RankingBoardDTO myRanking = rnkdao.selectByGName(id, gname);
				List<RankingBoardDTO> rankingList = rnkdao.selectAll(gname);
				
				request.setAttribute("myRanking", myRanking);
				request.setAttribute("rankingList", rankingList);
				request.getRequestDispatcher("/board/rankingBoard.jsp");
				
			} else if(cmd.equals("/search.rankBoard")) { // 랭킹 검색 ( 아이디 )
				
			}
			
			else if(cmd.equals("/rankReadPoint.rankBoard")) {
				
				
				
				String score = request.getParameter("score");
				String game_name = request.getParameter("game_name");
				System.out.println(score);
				String id = (String) session.getAttribute("loginID");
				System.out.println(id);
				List<RankingBoardDTO> Check = dao.rankThisGameCheck(game_name, id);
				// RankingBoardDAO.rankUpdatePoint(score, loginID);
				
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
