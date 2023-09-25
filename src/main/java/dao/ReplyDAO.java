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

	public int countReply(int pseq) throws Exception{
		String sql = "select count(*) from reply where parent_seq = ?;";

		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {

			pstat.setInt(1, pseq);
			try(ResultSet rs = pstat.executeQuery()){
				rs.next();
				return rs.getInt(1);

			}
		} 
	}

	public List<ReplyDTO> selectBy(int start, int end, int p_seq) throws Exception{
		ReplyDTO replyDTO = new ReplyDTO();
		List<ReplyDTO> list = new ArrayList<>();
		String sql = "select * from (select row_number() over(order by seq desc) as rn, reply.* from reply where parent_seq=?) as sub where rn between ? and ?;";

		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, p_seq);
			pstat.setInt(2, start);
			pstat.setInt(3, end);
			try(ResultSet rs = pstat.executeQuery();){
				while(rs.next()) {
					int seq = rs.getInt("seq");
					String writer = rs.getString("writer");
					String contents = rs.getString("contents");
					Timestamp write_date = rs.getTimestamp("write_date");
					int parent_seq = rs.getInt("parent_seq");
					list.add(new ReplyDTO(seq,writer,contents,write_date,parent_seq));
				}
				return list;
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
	public int update(String contents, int seq) throws Exception {
		String sql = "UPDATE reply SET contents=? where seq = ?";
		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			pstat.setString(1, contents);
			pstat.setInt(2, seq);
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
