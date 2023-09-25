package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;

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
		Gson gson = new GsonBuilder().registerTypeAdapter(Timestamp.class, new JsonSerializer<Timestamp>() {
			private final SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd. hh:mm");
			
			@Override
			public JsonElement serialize(Timestamp arg0, Type arg1, JsonSerializationContext arg2) {
				return new JsonPrimitive(sdf.format(arg0));
			}
		}).create();
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		gson.toJson(timestamp);

		try {

			if(cmd.equals("/list.rankBoard")) { //처음 랭킹 페이지 들어갔을 때 default로 지뢰찾기 초급을 보여주는 코드
				System.out.println("/list.rankBoard");
				List<RankingBoardDTO> rankingList = rnkdao.selectAll();
				request.setAttribute("rankingList", rankingList);
				response.setContentType("text/html; charset=utf8");
				pw.append(gson.toJson(rankingList));
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
						System.out.println("신기록 등록 하겠음.");
						dao.insert(id, newScore, game_name);
						updateCheck = "true";
						pw.append(updateCheck);
					}
				}
			}

			else if(cmd.equals("/myRankGames.rankBoard")) {//index.jsp에서 자신의 게임랭킹들을 보여주는 코드입니다.
				String id = (String) session.getAttribute("loginID");
				List<RankingBoardDTO> myGameLists = new ArrayList<>();

				myGameLists.addAll(rnkdao.selectByIdD(id));
				myGameLists.addAll(rnkdao.selectById(id));

				request.setAttribute("myGameLists", myGameLists);
				response.setContentType("text/html; charset=utf8");
				pw.append(gson.toJson(myGameLists));

			}
			else if(cmd.equals("/myMines.rankBoard")) {// 랭킹 처음에 들어갔을때 자신의 지뢰찾기 초급을 보여주는 코드입니다. 
				System.out.println("sda");
				String id = (String) session.getAttribute("loginID");
				List<RankingBoardDTO> myMines = rnkdao.selectMyMines(id);
				
				System.out.println(myMines);
				request.setAttribute("myMines", myMines);
				response.setContentType("text/html; charset=utf8");
				pw.append(gson.toJson(myMines));
			}
			else if(cmd.equals("/game.rankBoard")) {//각각의 게임들을 누르면 해당게임의 랭킹을 보여주는 코드입니다.
				String game_name = request.getParameter("game_name");
				List<RankingBoardDTO> gameList;

				if ("bounceball".equals(game_name) || "minesweeperEazy".equals(game_name) || "minesweeperNormal".equals(game_name) || "minesweeperHard".equals(game_name)) {
					gameList = rnkdao.gameListDESC(game_name);
				    request.setAttribute("gameListD", gameList);
					response.setContentType("text/html; charset=utf8");
					pw.append(gson.toJson(gameList));
				} else {
				    gameList = rnkdao.gameList(game_name);
				    request.setAttribute("gameList", gameList);
					response.setContentType("text/html; charset=utf8");
					pw.append(gson.toJson(gameList));
				}
			}
			else if(cmd.equals("/myGame.rankBoard")) {
				String game_name = request.getParameter("game_name");
				String id = (String) session.getAttribute("loginID");
				List<RankingBoardDTO> myList = new ArrayList<>();
				if ("bounceball".equals(game_name) || "minesweeperEazy".equals(game_name) || "minesweeperNormal".equals(game_name) || "minesweeperHard".equals(game_name)) {
					myList.addAll(rnkdao.myGameListD(id, game_name));
				}else {
					myList.addAll(rnkdao.myGameList(id, game_name));
				}
				request.setAttribute("myList", myList);
				response.setContentType("text/html; charset=utf8");
				pw.append(gson.toJson(myList));
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
