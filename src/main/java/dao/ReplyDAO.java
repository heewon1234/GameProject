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

import dto.ReplyDTO;

public class ReplyDAO {
	
	private static ReplyDAO instance; 

	public static ReplyDAO getInstance() {
		if(instance == null) {
			instance = new ReplyDAO();
		}
		return instance;
	}

	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/mysql");
		return ds.getConnection();

	}

	public List<ReplyDTO> replySelectRead(int seq) throws Exception{
		String sql = "select * from reply where parent_seq = ?;";

		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {

			pstat.setInt(1, seq);
			try(ResultSet rs = pstat.executeQuery()){
				List<ReplyDTO> list = new ArrayList<>();

				while(rs.next()) {
					int replyseq = rs.getInt("seq");
					int parent_seq = rs.getInt("parent_seq");
					String writer = rs.getString("writer");
					String contents = rs.getString("contents");
					Timestamp write_date = rs.getTimestamp("write_date");

					list.add(new ReplyDTO(replyseq, writer, contents, write_date,parent_seq));
				}return list;
			}
		} 
	}
}
