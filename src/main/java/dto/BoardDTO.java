package dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class BoardDTO {
	private int seq;
	private String writer;
	private String title;
	private String contents;
	private Timestamp write_date;
	private int view_count;
	private String game_name;
	
	public BoardDTO() {}
	
	public BoardDTO(int seq, String writer, String title, String contents, Timestamp write_date, int view_count,
			String game_name) {
		this.seq = seq;
		this.writer = writer;
		this.title = title;
		this.contents = contents;
		this.write_date = write_date;
		this.view_count = view_count;
		this.game_name = game_name;
	}
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public Timestamp getWrite_date() {
		return write_date;
	}
	public void setWrite_date(Timestamp write_date) {
		this.write_date = write_date;
	}
	public int getView_count() {
		return view_count;
	}
	public void setView_count(int view_count) {
		this.view_count = view_count;
	}
	public String getGame_name() {
		return game_name;
	}
	public void setGame_name(String game_name) {
		this.game_name = game_name;
	}
	public String getTimestampToString() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	    return sdf.format(getWrite_date());
	}

}
