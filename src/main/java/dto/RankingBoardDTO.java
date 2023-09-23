package dto;

import java.sql.Timestamp;

public class RankingBoardDTO {
	private int seq;
	private String id;
	private String game_name;
	private int score;
	private Timestamp rank_date;
	private int rank;
	
	public RankingBoardDTO() {}
	public RankingBoardDTO(int seq, String id, String game_name, int score, Timestamp rank_date, int rank) {
		super();
		this.seq = seq;
		this.id = id;
		this.game_name = game_name;
		this.score = score;
		this.rank_date = rank_date;
		this.rank = rank;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGame_name() {
		return game_name;
	}
	public void setGame_name(String game_name) {
		this.game_name = game_name;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public Timestamp getRank_date() {
		return rank_date;
	}
	public void setRank_date(Timestamp rank_date) {
		this.rank_date = rank_date;
	}
	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank = rank;
	}
	


	
}
