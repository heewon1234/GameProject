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
	
	// board 모든 게시물 검색
	public List<BoardDTO> selectBy(int start, int end) throws Exception{
		BoardDTO dto = new BoardDTO();
		List<BoardDTO> list = new ArrayList<>();
		String sql = "select * from (select row_number() over(order by seq desc) as rn, board.* from board) as sub where rn between ? and ?;";
		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, start);
			pstat.setInt(2, end);
			try(ResultSet rs = pstat.executeQuery();){
				while(rs.next()) {
					int seq = rs.getInt("seq");
					String writer = rs.getString("writer");
					String title = rs.getString("title");
					String contents = rs.getString("contents");
					Timestamp write_date = rs.getTimestamp("write_date");
					int view_count = rs.getInt("view_count");
					String game_name = rs.getString("game_name");
					list.add(new BoardDTO(seq,writer,title,contents,write_date,view_count, game_name));
				}
				return list;
			}
		}
	}
	
	// board 제목, 내용, 작성자 중 키워드 검색
	public List<BoardDTO> selectBy(int start, int end, String searchText) throws Exception{
		List<BoardDTO> list = new ArrayList<>();
		String sql = "select * from (select row_number() over(order by seq desc) as rn, board.* from board where contents like ? or title like ? or writer like ?) as sub where rn between ? and ?";
		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(4, start);
			pstat.setInt(5, end);
			pstat.setString(1, "%"+searchText+"%");
			pstat.setString(2, "%"+searchText+"%");
			pstat.setString(3, "%"+searchText+"%"); 
			try(ResultSet rs = pstat.executeQuery();){
				while(rs.next()) {
					int seq = rs.getInt("seq");
					String writer = rs.getString("writer");
					String title = rs.getString("title");
					String contents = rs.getString("contents");
					Timestamp write_date = rs.getTimestamp("write_date");
					int view_count = rs.getInt("view_count");
					String game_name = rs.getString("game_name");
					list.add(new BoardDTO(seq,writer,title,contents,write_date,view_count, game_name));
				}
				return list;
			}
		}
	}

	// board 게시물 작성
	public int insert(BoardDTO dto) throws Exception{
		String sql = "insert into board (writer, title, contents, game_name)\r\n"
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
		String sql = "update board set title=?, contents=?, game_name=? where seq = ?;" ;

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
	
	// 평상시 레코드 개수 반환
	public int getRecordCount() throws Exception {
		String qry = "select count(*) as cnt from board;";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(qry);
				) {
			try(
					ResultSet rs = pstat.executeQuery();
					){
					rs.next();
					int result = rs.getInt("cnt");
					return result;
					// return rs.getInt(1);
			}
		}
	}
	//index.jsp에서 최근 5개로 불러오는 코드입니다.
	public List<BoardDTO> selectRecentFive() throws Exception {
	    List<BoardDTO> list = new ArrayList<>();
	    String sql = "SELECT * FROM board ORDER BY write_date DESC LIMIT 5;";
	    
	    try (
	        Connection con = this.getConnection();
	        PreparedStatement pstat = con.prepareStatement(sql);
	        ResultSet rs = pstat.executeQuery();
	    ) {
	        while (rs.next()) {
	            int seq = rs.getInt("seq");
	            String writer = rs.getString("writer");
	            String title = rs.getString("title");
	            String contents = rs.getString("contents");
	            Timestamp write_date = rs.getTimestamp("write_date");
	            int view_count = rs.getInt("view_count");
	            String game_name = rs.getString("game_name");
	            list.add(new BoardDTO(seq, writer, title, contents, write_date, view_count, game_name));
	        }
	    }
	    
	    return list;
	}

	
	// 검색시 레코드 개수 반환
	public int getRecordCountOnSearch(String keyword) throws Exception {
		keyword = "%" + keyword + "%";
		String qry  = "select count(*) as cnt from board where title like ? or writer like ? or contents like ?;";

		try(
			Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(qry);
			) {
			pstat.setString(1, keyword);
			pstat.setString(2, keyword);
			pstat.setString(3, keyword);
			try(
					ResultSet rs = pstat.executeQuery();
					){
					rs.next();
					int result = rs.getInt("cnt");
					return result;
					// return rs.getInt(1);
			}
		}
	}
	
	// board 전체 게시물 불러오기 임시 폐업
//	public List<BoardDTO> list(int startNum, int endNum) throws Exception{
//		String sql = "SELECT * FROM (SELECT row_number() over(order by seq desc) as rn, board.* FROM board) AS rn WHERE rn BETWEEN ? AND ?;";
//
//		try(
//				Connection con = this.getConnection();
//				PreparedStatement pstat = con.prepareStatement(sql);
//				) {
//
//			pstat.setInt(1, startNum);
//			pstat.setInt(2, endNum);
//
//			try(ResultSet rs = pstat.executeQuery()){
//				List<BoardDTO> list = new ArrayList<>();
//
//				while(rs.next()) {
//					int seq = rs.getInt("seq");
//					String writer = rs.getString("writer");
//					String title = rs.getString("title");
//					String contents = rs.getString("contents");
//					Timestamp write_date = rs.getTimestamp("write_date");
//					int view_count = rs.getInt("view_count");
//					String game_name = rs.getString("game_name");
//
//					list.add(new BoardDTO(seq, writer, title, contents, write_date, view_count, game_name));
//				}return list;
//			}
//		} 
//	}
	
}
