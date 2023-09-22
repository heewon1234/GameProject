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
		RankingBoardDAO dao = RankingBoardDAO.getInstance();
		
		
		try {
			 
			if(cmd.equals("/list.rankBoard")) { // 게시물 리스트 가져오기
				System.out.println("옴");
				String id = (String) session.getAttribute("loginID");
				String gname = request.getParameter("game_name");
				RankingBoardDTO myRanking = rnkdao.selectByGName(id, gname);
				List<RankingBoardDTO> rankingList = rnkdao.selectAll(gname);
				
				request.setAttribute("myRanking", myRanking);
				request.setAttribute("rankingList", rankingList);
				request.getRequestDispatcher("/board/rankingBoard.jsp");
				
			} else if(cmd.equals("/search.rankBoard")) { // 랭킹 검색 ( 아이디 )
				
			}
			
			else if(cmd.equals("/rankReadPoint.rankBoard")) {
				
				// String score = request.getParameter("score");
				// String game_name = request.getParameter("game_name");
				// String id = (String) session.getAttribute("loginID");
				
				String game_name = "fullMoonBoat";
				String id = "dldidsla13";
				List<RankingBoardDTO> Check = dao.thisGameRankCheck(game_name, id);
				
				int isRank = Check.size();
				System.out.println(isRank);
				
				if(isRank > 0) {
					System.out.println(Check.get(2).getScore());
				}
				else {
					System.out.println("값이 없음.");
				}
				
				
				// RankingBoardDAO.rankUpdatePoint(score, loginID);
				
			}
			
			else if(cmd.equals("/myRankGames.rankBoard")) {//index.jsp에서 자신의 게임랭킹들을 보여주는 코드입니다.
	            String id = (String) session.getAttribute("loginID");
	            List<RankingBoardDTO> myGameList = rnkdao.selectById(id);
	            request.setAttribute("myGameList", myGameList);
	            request.getRequestDispatcher("/index.jsp").forward(request, response);
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
