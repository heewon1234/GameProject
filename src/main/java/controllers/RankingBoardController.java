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

				String id = (String)request.getSession().getAttribute("loginID");//?????????????????????????????????????????
				String gname = request.getParameter("game_name");
				RankingBoardDTO myRanking = rnkdao.selectByGName(id, gname);
				List<RankingBoardDTO> rankingList = rnkdao.selectAll(gname);

				request.setAttribute("myRanking", myRanking);
				request.setAttribute("rankingList", rankingList);
				request.getRequestDispatcher("/board/rankingBoard.jsp");

			} else if(cmd.equals("/search.rankBoard")) { // 랭킹 검색 ( 아이디 )

			} else if(cmd.equals("/rankRead.rankBoard")) {
				System.out.println("점수 확인");

				String score = request.getParameter("score");
				System.out.println(score);
				String id = (String) session.getAttribute("loginID");
				System.out.println(id);

			} else if(cmd.equals("/myRankGames.rankBoard")) {//index.jsp에서 자신의 게임랭킹들을 보여주는 코드입니다.
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
