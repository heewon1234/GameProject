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

import dto.BoardDTO;
import dto.RankingBoardDTO;
import dto.ReplyDTO;

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

				return new RankingBoardDTO(seq,id1,game_name,score,rank_date);

			}
		} 
	}
	public int update(int newScore, String ID) throws Exception {
		String sql = "UPDATE rankingBoard SET score = CASE WHEN ? > score THEN ? ELSE score END WHERE id = ?;";
		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			pstat.setInt(1, newScore);
			pstat.setInt(2, newScore);
			pstat.setString(3, ID);
			int result = pstat.executeUpdate();
			return result;
		}
	}
	public List<RankingBoardDTO> selectAll(String gname) throws Exception{
		String sql = "select * from rankingBoard where game_name = ?;";

		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {

			pstat.setString(1, gname);
			try(ResultSet rs = pstat.executeQuery()){
				List<RankingBoardDTO> list = new ArrayList<>();

				while(rs.next()) {
					int seq = rs.getInt("seq");
					String id1 = rs.getString("id");
					String game_name = rs.getString("game_name");
					int score = rs.getInt("score");
					Timestamp rank_date = rs.getTimestamp("rank_date");

					list.add(new RankingBoardDTO(seq,id1,game_name,score,rank_date));
				}return list;
			}
		} 
	}
	
	public List<RankingBoardDTO> rankThisGameCheck(String game_name, String id) throws Exception {
		String sql = "select * from (select row_number() over(order by seq asc) as number, rankingBoard.* from rankingBoard) as sub where game_name like ?' and id like ?;";
		List<RankingBoardDTO> list = new ArrayList<>();

		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1,game_name);
			pstat.setString(2,id); 
			try(ResultSet rs = pstat.executeQuery();){
				
				
				while(rs.next()) {
					int seq = rs.getInt("seq");
					String id_in = rs.getString("id");
					String game_name_in = rs.getString("game_name");
					int score = rs.getInt("score");
					Timestamp rank_date = rs.getTimestamp("rank_date");
					list.add(new RankingBoardDTO(seq, id_in, game_name_in, score, rank_date));
					
				}
				return list;
			}
		}
	
		
	};
	
	   //index.jsp에서 자신의 게임들의 랭킹을 보여주는 코드입니다.
	   public List<RankingBoardDTO> selectById(String loggedInUserId) throws Exception {
	       String sql = "SELECT * FROM rankingBoard WHERE id = ? ;";

	       try (
	           Connection con = this.getConnection();
	           PreparedStatement pstat = con.prepareStatement(sql);
	       ) {
	           pstat.setString(1, loggedInUserId);

	           try (ResultSet rs = pstat.executeQuery()) {
	               List<RankingBoardDTO> list = new ArrayList<>();

	               while (rs.next()) {
	                   int seq = rs.getInt("seq");
	                   String id1 = rs.getString("id");
	                   String game_name = rs.getString("game_name");
	                   int score = rs.getInt("score");
	                   Timestamp rank_date = rs.getTimestamp("rank_date");

	                   list.add(new RankingBoardDTO(seq, id1, game_name, score, rank_date));
	               }
	               return list;
	           }
	       }
	   }

	
//	public boolean rankUpdatePoint(RankingBoardDTO dto) {
//		String sql = "update rankingBoard set title=?, contents=?, game_name=? where seq = ?;" ;
//
//		try {
//			Class.forName("com.mysql.cj.jdbc.Driver");
//		}
//
//		catch (ClassNotFoundException e) {
//			e.printStackTrace();
//		}
//
//		try(
//				Connection con = this.getConnection();
//				PreparedStatement pstat = con.prepareStatement(sql);
//				) 
//		{
//			pstat.setString(1, dto.getTitle());
//			pstat.setString(2, dto.getContents());
//			return pstat.executeUpdate();
//		}
//
//	}
}
