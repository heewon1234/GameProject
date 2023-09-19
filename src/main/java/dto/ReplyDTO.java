package dto;

import java.sql.Timestamp;

public class ReplyDTO {
	private int seq;
	private String writer;
	private String contents;
	private Timestamp write_date;
	private int parent_seq;
}
