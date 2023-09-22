package controllers;

import java.io.IOException;
import java.io.PrintWriter;
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
		PrintWriter pw = response.getWriter();


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
				int newScore = Integer.parseInt(request.getParameter("score"));
				String game_name = request.getParameter("game_name");
				String rank_type = request.getParameter("rank_type");
				String id = (String) session.getAttribute("loginID");

				//				int newScore = 5;
				//				String game_name = "fullMoonBoat";
				//				String id = "dldidsla13";
				//				String rank_type = "point";

				List<RankingBoardDTO> Check = dao.thisGameRankCheck(game_name, id);

				int isRank = Check.size();
				String updateCheck = "false";

				if (rank_type.equals("point")) {
					System.out.println("포인트 타입임");
					if(isRank > 0) {
						int oriScore = Check.get(0).getScore();
						System.out.println("기존 스코어 : " + oriScore + " 새로 받아온 스코어 : " + newScore);
						if(newScore > oriScore) {
							System.out.println("업데이트 들어가자");
							dao.update(newScore, id, game_name);
							updateCheck = "true"; // 이거 홈페이지로 날려줘서 AJAX로 True 되면 랭킹 갱신 된거 축하한다고 해주면 됨
							pw.append(updateCheck);
						}
						else {
							System.out.println("기록이 꾸져서 신기록 달성 못함 ㅋ");
							// 신기록 달성에 실패한거임 ㅇㅇ..
							// updateCheck 홈페이지로 날려줘서 AJAX로 False 되면 아무 일도 없게 하면 됨 
							pw.append(updateCheck);
						}
					}
					else {
						// 기존 기록이 없는 경우로 새로 등록 해줘야함 
						System.out.println("신기록 등록 하겠음.");
						dao.insert(id, newScore, game_name);
						updateCheck = "true";
						pw.append(updateCheck);
					}
				}

				else if(rank_type.equals("time")) {
					System.out.println("타임 타입임");
					if(isRank > 0) {
						int oriScore = Check.get(0).getScore();
						System.out.println("기존 스코어 : " + oriScore + " 새로 받아온 스코어 : " + newScore);
						if(newScore < oriScore) {
							System.out.println("업데이트 들어가자");
							dao.update(newScore, id, game_name);
							updateCheck = "true"; // 이거 홈페이지로 날려줘서 AJAX로 True 되면 랭킹 갱신 된거 축하한다고 해주면 됨
							
						}
					}
					else {
						System.out.println("값이 없음.");
						// updateCheck 홈페이지로 날려줘서 AJAX로 False 되면 아무 일도 없게 하면 됨
						pw.append(updateCheck);
					}
				}
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
