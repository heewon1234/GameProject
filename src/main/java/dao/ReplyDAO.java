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
	private ReplyDAO() {
	}
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/mysql");
		return ds.getConnection();

	}

	public List<ReplyDTO> selectByParent(int pseq) throws Exception{
		String sql = "select * from reply where parent_seq = ?;";

		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {

			pstat.setInt(1, pseq);
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
	public int insert(ReplyDTO dto) throws Exception {
		String sql = "insert into reply (writer, contents, parent_seq) values (?, ?, ?)";
		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			pstat.setString(1, dto.getWriter());
			pstat.setString(2, dto.getContents());
			pstat.setInt(3, dto.getParent_seq());
			int result = pstat.executeUpdate();
			
			return result;
		}
	}
	public int update(ReplyDTO rdto) throws Exception {
		String sql = "UPDATE reply SET contents=? where seq = ?";
		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			pstat.setString(1, rdto.getContents());
			pstat.setInt(2, rdto.getSeq());
			int result = pstat.executeUpdate();
			return result;
		}
	}
	public int delete(int seq)throws Exception{
		String sql = "delete from reply where seq = ?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, seq);
			int result = pstat.executeUpdate();
			return result;
		}
	}
}
