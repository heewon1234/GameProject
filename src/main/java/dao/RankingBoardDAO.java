package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.RankingBoardDTO;

public class RankingBoardDAO {
	private static RankingBoardDAO instance; 

	public static RankingBoardDAO getInstance() {
		if(instance == null) {
			instance = new RankingBoardDAO();
		}
		return instance;
	}
	private RankingBoardDAO() {
	}
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/mysql");
		return ds.getConnection();

	}
	public RankingBoardDTO selectByGName (String id,String gname) throws Exception{
		String sql = "select * from rankingBoard where id = ? and game_name = ?;";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {

			pstat.setString(1, id);
			pstat.setString(2, gname);
			try(ResultSet rs = pstat.executeQuery()){

				rs.next();
				int seq = rs.getInt("seq");
				String id1 = rs.getString("id");
				String game_name = rs.getString("game_name");
				int score = rs.getInt("score");
				Timestamp rank_date = rs.getTimestamp("rank_date");
				int ranking = rs.getInt("ranking");

				return new RankingBoardDTO(seq, id1, game_name, score, rank_date, ranking);
			}
		} 
	};
	// where game_name id로 내 랭킹을 보여주는 코드
	public List<RankingBoardDTO> myGameList(String id,String gname) throws Exception {
		String sql = "SELECT rb1.*, (SELECT COUNT(*) + 1 FROM rankingBoard AS rb2 WHERE rb2.game_name = rb1.game_name AND rb2.score > rb1.score) AS `ranking`\r\n"
				+ "FROM rankingBoard AS rb1\r\n"
				+ "WHERE id = ? and game_name = ? \r\n"
				+ "ORDER BY ranking;";

		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			pstat.setString(1, id);
			pstat.setString(2, gname);

			try (ResultSet rs = pstat.executeQuery()) {
				List<RankingBoardDTO> list = new ArrayList<>();

				while (rs.next()) {
					int seq = rs.getInt("seq");
					String id1 = rs.getString("id");
					String game_name = rs.getString("game_name");
					int score = rs.getInt("score");
					Timestamp rank_date = rs.getTimestamp("rank_date");
					int ranking = rs.getInt("ranking");

					list.add(new RankingBoardDTO(seq, id1, game_name, score, rank_date, ranking));
				}
				return list;
			}
		}
	};
	// 바운스볼, 지뢰찾기
	public List<RankingBoardDTO> myGameListD(String id,String gname) throws Exception {
		String sql = "SELECT rb1.*, (SELECT COUNT(*) + 1 FROM rankingBoard AS rb2 WHERE rb2.game_name = rb1.game_name AND rb2.score < rb1.score) AS `ranking`\r\n"
				+ "FROM rankingBoard AS rb1\r\n"
				+ "WHERE id = ? and game_name = ? \r\n"
				+ "ORDER BY ranking;";

		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			pstat.setString(1, id);
			pstat.setString(2, gname);

			try (ResultSet rs = pstat.executeQuery()) {
				List<RankingBoardDTO> list = new ArrayList<>();

				while (rs.next()) {
					int seq = rs.getInt("seq");
					String id1 = rs.getString("id");
					String game_name = rs.getString("game_name");
					int score = rs.getInt("score");
					Timestamp rank_date = rs.getTimestamp("rank_date");
					int ranking = rs.getInt("ranking");

					list.add(new RankingBoardDTO(seq, id1, game_name, score, rank_date, ranking));
				}
				return list;
			}
		}
	};
	// where game_name 인 해당 게임을 클릭 할 경우 전체 랭킹을 보여주는 코드
	public List<RankingBoardDTO> gameList(String gname) throws Exception {
		String sql = "SELECT rb1.*, (SELECT COUNT(*) + 1 FROM rankingBoard AS rb2 WHERE rb2.game_name = rb1.game_name AND rb2.score > rb1.score) AS `ranking` FROM rankingBoard AS rb1 WHERE game_name = ? ORDER BY score DESC";

		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			pstat.setString(1, gname); // 파라미터 설정

			try (ResultSet rs = pstat.executeQuery()) {
				List<RankingBoardDTO> list = new ArrayList<>();

				while (rs.next()) {
					int seq = rs.getInt("seq");
					String id1 = rs.getString("id");
					String game_name = rs.getString("game_name");
					int score = rs.getInt("score");
					Timestamp rank_date = rs.getTimestamp("rank_date");
					int ranking = rs.getInt("ranking");

					list.add(new RankingBoardDTO(seq, id1, game_name, score, rank_date, ranking));
				}
				return list;
			}
		}
	};
	//바운스볼 지뢰찾기
	public List<RankingBoardDTO> gameListDESC(String gname) throws Exception {
		String sql = "SELECT rb1.*, (SELECT COUNT(*) + 1 FROM rankingBoard AS rb2 WHERE rb2.game_name = rb1.game_name AND rb2.score < rb1.score) AS `ranking` FROM rankingBoard AS rb1 WHERE game_name = ?  ORDER BY ranking";

		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			pstat.setString(1, gname); // 파라미터 설정

			try (ResultSet rs = pstat.executeQuery()) {
				List<RankingBoardDTO> list = new ArrayList<>();

				while (rs.next()) {
					int seq = rs.getInt("seq");
					String id1 = rs.getString("id");
					String game_name = rs.getString("game_name");
					int score = rs.getInt("score");
					Timestamp rank_date = rs.getTimestamp("rank_date");
					int ranking = rs.getInt("ranking");

					list.add(new RankingBoardDTO(seq, id1, game_name, score, rank_date, ranking));
				}
				return list;
			}
		}
	};


	public List<RankingBoardDTO> thisGameRankCheck(String game_name, String id) throws Exception {
		String sql = "select * from (select row_number() over(order by seq asc) as number, rankingBoard.* from rankingBoard) as sub where game_name like ? and id like ?;";
		List<RankingBoardDTO> list = new ArrayList<>();

		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1,game_name);
			pstat.setString(2,id); 
			try(ResultSet rs = pstat.executeQuery();){

				while(rs.next()) {
					int seq = rs.getInt("seq");
					String id1 = rs.getString("id");
					String gamename = rs.getString("game_name");
					int score = rs.getInt("score");
					Timestamp rank_date = rs.getTimestamp("rank_date");
					int ranking = 0;
					list.add(new RankingBoardDTO(seq, id1, gamename, score, rank_date, ranking));

				}
				return list;
			}
		}
	};

	// 기존에 기록이 있을 때 신기록을 변경하는 코드
	public int update(int newScore, String ID, String game_name) throws Exception {
		String sql = "UPDATE rankingBoard SET score = ?, rank_date = NOW() WHERE id like ? and game_name like ?;";
		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			pstat.setInt(1, newScore);
			pstat.setString(2, ID);
			pstat.setString(3, game_name);
			int result = pstat.executeUpdate();
			return result;
		}
	};

	// 기존에 기록이 없을때 기록을 등록하는 코드
	public int insert (String id, int newScore, String game_name) throws Exception {

		String sql = "INSERT INTO rankingBoard (id, score, game_name) VALUES (?, ?, ?);" ;

		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) 
		{
			pstat.setString(1, id);
			pstat.setInt(2, newScore);
			pstat.setString(3, game_name);
			return pstat.executeUpdate();

		}

	};

	//index.jsp에서 자신의 게임들의 랭킹을 보여주는 코드입니다.
	public List<RankingBoardDTO> selectById(String loggedInUserId) throws Exception {
		String sql = "SELECT rb1.*, (SELECT COUNT(*) + 1 FROM rankingBoard AS rb2 WHERE rb2.game_name = rb1.game_name AND rb2.score > rb1.score) AS `ranking` FROM rankingBoard AS rb1 where id = ? and NOT (game_name = 'bounceball' OR game_name LIKE 'mine%') ORDER BY game_name";

		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			pstat.setString(1, loggedInUserId);
			try (ResultSet rs = pstat.executeQuery()) {
				List<RankingBoardDTO> list = new ArrayList<>();

				while (rs.next()) {
					int seq = rs.getInt("seq");
					String id = rs.getString("id");
					String gameName = rs.getString("game_name");
					int score = rs.getInt("score");
					Timestamp rankDate = rs.getTimestamp("rank_date");
					int ranking = rs.getInt("ranking"); // 추가: rank 컬럼 조회

					list.add(new RankingBoardDTO(seq, id, gameName, score, rankDate, ranking));
				}
				return list;
			}
		}
	};
	//바운스볼 지뢰찾기
	public List<RankingBoardDTO> selectByIdD(String loggedInUserId) throws Exception {
		String sql = "SELECT rb1.*, (SELECT COUNT(*) + 1 FROM rankingBoard AS rb2 WHERE rb2.game_name = rb1.game_name AND rb2.score < rb1.score) AS `ranking` FROM rankingBoard AS rb1 where id = ? and (game_name = 'bounceball' or game_name like 'mine%') ORDER BY game_name";

		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			pstat.setString(1, loggedInUserId);
			try (ResultSet rs = pstat.executeQuery()) {
				List<RankingBoardDTO> list = new ArrayList<>();

				while (rs.next()) {
					int seq = rs.getInt("seq");
					String id = rs.getString("id");
					String gameName = rs.getString("game_name");
					int score = rs.getInt("score");
					Timestamp rankDate = rs.getTimestamp("rank_date");
					int ranking = rs.getInt("ranking"); // 추가: rank 컬럼 조회

					list.add(new RankingBoardDTO(seq, id, gameName, score, rankDate, ranking));
				}
				return list;
			}
		}
	};
	//처음 랭킹 페이지 들어갔을 때 default로 지뢰찾기 초급을 보여주는 코드
	public List<RankingBoardDTO> selectAll() throws Exception {
		String sql = "SELECT rb1.*, (SELECT COUNT(*) + 1 FROM rankingBoard AS rb2 WHERE rb2.game_name = rb1.game_name AND rb2.score < rb1.score) AS `ranking` FROM rankingBoard AS rb1 WHERE game_name = 'minesweeperEazy'";

		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);

				ResultSet rs = pstat.executeQuery()) {
			List<RankingBoardDTO> list = new ArrayList<>();

			while (rs.next()) {
				int seq = rs.getInt("seq");
				String id = rs.getString("id");
				String gameName = rs.getString("game_name");
				int score = rs.getInt("score");
				Timestamp rankDate = rs.getTimestamp("rank_date");
				int ranking = rs.getInt("ranking"); 

				list.add(new RankingBoardDTO(seq, id, gameName, score, rankDate, ranking));
			}
			return list;

		}
	};
	//처음 랭킹 페이지 들어갔을 때 default로 지뢰찾기 초급 자신의 랭킹을  보여주는 코드
	public List<RankingBoardDTO> selectMyMines(String loggedInUserId) throws Exception {
		String sql = "SELECT rb1.*, (SELECT COUNT(*) + 1 FROM rankingBoard AS rb2 WHERE rb2.game_name = rb1.game_name AND rb2.score < rb1.score) AS `ranking` FROM rankingBoard AS rb1 WHERE game_name = 'minesweeperEazy' and id = ?";


		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			pstat.setString(1, loggedInUserId);
			try (ResultSet rs = pstat.executeQuery()) {
				List<RankingBoardDTO> list = new ArrayList<>();

				while (rs.next()) {
					int seq = rs.getInt("seq");
					String id = rs.getString("id");
					String gameName = rs.getString("game_name");
					int score = rs.getInt("score");
					Timestamp rankDate = rs.getTimestamp("rank_date");
					int ranking = rs.getInt("ranking"); // 추가: rank 컬럼 조회

					list.add(new RankingBoardDTO(seq, id, gameName, score, rankDate, ranking));
				}
				return list;
			}
		}
	};


	public String addBestRank(String id, String game_name) throws Exception {
		String sql = "select score from rankingBoard where id = ? and game_name = ?";
		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {			
			pstat.setString(1, id);
			pstat.setString(2, game_name);
			try (ResultSet rs = pstat.executeQuery()) {
				String score = null; // 변수를 초기화합니다.
				if (rs.next()) {
				    score = rs.getString("score");
				}
				else {
					score = "--";
				}
				return score;
			}

		}

	}
}
