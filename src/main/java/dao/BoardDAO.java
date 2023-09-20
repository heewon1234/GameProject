package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.BoardDTO;

public class BoardDAO {

	private static BoardDAO instance; 

	public static BoardDAO getInstance() {
		if(instance == null) {
			instance = new BoardDAO();
		}
		return instance;
	}

	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/mysql");
		return ds.getConnection();

	}

	// board 전체 게시물 불러오기
	public List<BoardDTO> list(int startNum, int endNum) throws Exception{
		String sql = "SELECT * FROM (SELECT row_number() over(order by seq desc) as rn, board.* FROM board) AS rn WHERE rn BETWEEN ? AND ?;";

		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {

			pstat.setInt(1, startNum);
			pstat.setInt(2, endNum);

			try(ResultSet rs = pstat.executeQuery()){
				List<BoardDTO> list = new ArrayList<>();

				while(rs.next()) {
					int seq = rs.getInt("seq");
					String writer = rs.getString("writer");
					String title = rs.getString("title");
					String contents = rs.getString("contents");
					Timestamp write_date = rs.getTimestamp("write_date");
					int view_count = rs.getInt("view_count");
					String game_name = rs.getString("game_name");

					list.add(new BoardDTO(seq, writer, title, contents, write_date, view_count, game_name));
					System.out.println(list.size());
				}return list;
			}
		} 
	}

	// board 게시물 작성
	public int insert(BoardDTO dto) throws Exception{
		String sql = "insert into board (write, title, contents, game_name)\r\n"
				+ "values(?, ?, ?, ?);" ;

		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
				) 

		{
			pstat.setString(1, dto.getWriter());
			pstat.setString(2, dto.getTitle());
			pstat.setString(3, dto.getContents());
			pstat.setString(4, dto.getGame_name());
			pstat.executeUpdate();

			try(ResultSet rs = pstat.getGeneratedKeys()){
				rs.next();
				return rs.getInt(1);
			}
		}
	}

	// board 게시물 삭제
	public int delContents(BoardDTO dto) throws Exception {
		String sql = "delete from board where seq = ?" ;

		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) 

		{
			pstat.setInt(1, dto.getSeq());
			return pstat.executeUpdate();
		}
	}

	// board 게시물 수정
	public int update(BoardDTO dto) throws Exception {
		String sql = "update board set title=?, contact=?, game_name=? where seq = ?;" ;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		}

		catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) 
		{
			pstat.setString(1, dto.getTitle());
			pstat.setString(2, dto.getContents());
			pstat.setString(3, dto.getGame_name());
			pstat.setInt(4, dto.getSeq());
			return pstat.executeUpdate();
		}

	}

	// board 게시물 읽기 showContents
	public List<BoardDTO> showContents(BoardDTO dto) throws Exception {
		String sql = "select * from board where seq=?" ;

		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {

			pstat.setInt(1, dto.getSeq());
			List<BoardDTO> list = new ArrayList<>();
			ResultSet rs = pstat.executeQuery();

			while(rs.next()) {
				int seq = rs.getInt("seq");
				String writer = rs.getString("writer");
				String title = rs.getString("title");
				String contents = rs.getString("contents");
				Timestamp write_date = rs.getTimestamp("write_date");
				int view_count = rs.getInt("view_count");
				String game_name = rs.getString("game_name");

				list.add(new BoardDTO(seq, writer, title, contents, write_date, view_count, game_name));
			}return list;
		} 
	}
	
	// board 게시물 조회수 추가하기
	public int viewCountUpdate(BoardDTO dto) throws Exception{
		String sql = "update board set view_count = view_count + 1 where seq = ?;" ;

		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) 
		{
			pstat.setInt(1, dto.getSeq());
			return pstat.executeUpdate();
		}
	}



}
