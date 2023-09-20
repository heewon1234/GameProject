package dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
		Context ctx = new InitialContext(); // 톰켓의 메모리 영역을 관리하는거임
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/mysql");
		return ds.getConnection();

	}
	
	public int write(BoardDTO dto) throws Exception{
		String sql = "insert into board (writer, title, contact, write_date)\r\n"
				+ "values(?,?,?,CURRENT_TIMESTAMP);" ;

		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
				) 
		{
			pstat.setString(1, dto.getWriter());
			pstat.setString(2, dto.getTitle());
			pstat.setString(3, dto.getContact());
			pstat.executeUpdate();
			
			try(ResultSet rs = pstat.getGeneratedKeys()){
				rs.next();
				return rs.getInt(1);
			}
		}
	}

//	public int write(BoardDTO dto) throws Exception{
//		String sql = "insert into board (writer, title, contact, write_date)\r\n"
//				+ "values(?,?,?,CURRENT_TIMESTAMP);" ;
//
//		try(
//				Connection con = this.getConnection();
//				PreparedStatement pstat = con.prepareStatement(sql);
//				) 
//		{
//			pstat.setString(1, dto.getWriter());
//			pstat.setString(2, dto.getTitle());
//			pstat.setString(3, dto.getContact());
//			return pstat.executeUpdate();
//		}
//	}
	
	public int writeFile(BoardDTO dto) throws Exception {
		String sql = "insert into file (ori_name, sys_name, parent_seq) values (?, ?, ?)";
		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			pstat.setString(1, dto.getOri_name());
			pstat.setString(2, dto.getSys_name());
			pstat.setInt(3, dto.getParent_seq());
			return pstat.executeUpdate();
		
		}
	}
	

	public static List<BoardDTO> timeRe(int seq, String writer, String title, String contact, String write_date, int view_count) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		Date givenTime = sdf.parse(write_date);
		Date currentTime = new Date(); // 현재 시간

		long gapTimeInMillis = currentTime.getTime() - givenTime.getTime();

		List<BoardDTO> list = new ArrayList<>();

		if (gapTimeInMillis < 60000) {
			long gettime = gapTimeInMillis / 1000;
			write_date = String.valueOf(gettime) + "초 전";
			list.add(new BoardDTO(seq, writer, title, contact, write_date, view_count));

		} else if (gapTimeInMillis < 60000 * 60) {
			long gettime = gapTimeInMillis / 60000;
			write_date = String.valueOf(gettime) + "분 전";
			list.add(new BoardDTO(seq, writer, title, contact, write_date, view_count));

		} else if (gapTimeInMillis < 60000 * 60 * 24) {
			long gettime = gapTimeInMillis / (60000 * 60);
			write_date = String.valueOf(gettime) + "시간 전";
			list.add(new BoardDTO(seq, writer, title, contact, write_date, view_count));

		} else {
			list.add(new BoardDTO(seq, writer, title, contact, write_date, view_count));
		}

		return list;
	}




	public List<BoardDTO> selectAll() throws Exception {
		String sql = "select * from board ORDER BY seq desc";

		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();
				) {
			List<BoardDTO> list = new ArrayList<>();

			while (rs.next()) {
				int seq = rs.getInt("seq");
				String writer = rs.getString("writer");
				String title = rs.getString("title");
				String contact = rs.getString("contact");
				String write_date = rs.getString("write_date");
				int view_count = rs.getInt("view_count");

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date givenTime = sdf.parse(write_date);
				Date currentTime = new Date(); // 현재 시간

				long gapTimeInMillis = currentTime.getTime() - givenTime.getTime();

				if (gapTimeInMillis < 60000) {
					long gettime = gapTimeInMillis / 1000;
					write_date = String.valueOf(gettime) + "초 전";
				} else if (gapTimeInMillis < 60000 * 60) {
					long gettime = gapTimeInMillis / 60000;
					write_date = String.valueOf(gettime) + "분 전";
				} else if (gapTimeInMillis < 60000 * 60 * 24) {
					long gettime = gapTimeInMillis / (60000 * 60);
					write_date = String.valueOf(gettime) + "시간 전";
				} else {
					write_date = sdf.format(givenTime); // 날짜 형식을 그대로 표시
				}

				list.add(new BoardDTO(seq, writer, title, contact, write_date, view_count));
			}
			return list;
		}
	}

	public List<BoardDTO> read(BoardDTO dto) throws Exception {


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
				String contact = rs.getString("contact");
				String write_date = rs.getString("write_date");
				int view_count = rs.getInt("view_count");

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date givenTime = sdf.parse(write_date);
				Date currentTime = new Date(); // 현재 시간

				long gapTimeInMillis = currentTime.getTime() - givenTime.getTime();

				if (gapTimeInMillis < 60000) {
					long gettime = gapTimeInMillis / 1000;
					write_date = String.valueOf(gettime) + "초 전";
				} else if (gapTimeInMillis < 60000 * 60) {
					long gettime = gapTimeInMillis / 60000;
					write_date = String.valueOf(gettime) + "분 전";
				} else if (gapTimeInMillis < 60000 * 60 * 24) {
					long gettime = gapTimeInMillis / (60000 * 60);
					write_date = String.valueOf(gettime) + "시간 전";
				} else {
					write_date = sdf.format(givenTime); // 날짜 형식을 그대로 표시
				}

				list.add(new BoardDTO(seq, writer, title, contact, write_date, view_count));
			}
			return list;
		} 
	}
	
	public List<BoardDTO> readFileList(int in_parent_seq) throws Exception {
		String sql = "select * from file where parent_seq like ?";
		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			List<BoardDTO> result = new ArrayList<>();
			pstat.setInt(1, in_parent_seq);
			
			ResultSet rs = pstat.executeQuery();
			while (rs.next()) {
				int seq = rs.getInt("seq");
				String ori_name = rs.getString("ori_name");
				String sys_name = rs.getString("sys_name");
				int parent_seq = rs.getInt("parent_seq");
				result.add(new BoardDTO(seq, ori_name, sys_name, parent_seq));
			}
			return result;
		}
	}

	public int getRecordCount() throws Exception {
		String sql = "select count(seq) from board;";
		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);)
		{
			ResultSet rs = pstat.executeQuery();
			rs.next();
			return rs.getInt(1);
		}

	};
	
	public int getSearchRecordCount(String boardTitleSearch) throws Exception {
		String sql = "select count(seq) from board where title LIKE ?";
		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);)
		{
			pstat.setString(1, "%" + boardTitleSearch + "%");
			ResultSet rs = pstat.executeQuery();
			rs.next();
			return rs.getInt(1);
		}

	};

//	public String getPageNavi(int currentPage) throws Exception {
//		int recordTotalCount = this.getRecordCount();
//		int recordCountPerPage = 10;
//		int naviCountPerPage = 10;
//
//		int pageTotalCount = 0; // 이거 원래 0이었음
//
//		if (recordTotalCount % Constants.RECODE_COUNT_PER_PAGE > 0 ) {
//			pageTotalCount = recordTotalCount / Constants.RECODE_COUNT_PER_PAGE + 1;
//		}
//
//		else {
//			pageTotalCount = recordTotalCount / Constants.RECODE_COUNT_PER_PAGE;
//		}
//
//		if(currentPage < 1) {
//			currentPage = 1;
//		}
//
//		else if (currentPage > pageTotalCount) {
//			currentPage = pageTotalCount;
//		}
//
//		int startNavi = (currentPage -1) / Constants.NAVI_COUNT_PER_PAGE * Constants.NAVI_COUNT_PER_PAGE + 1;
//		int endNavi = startNavi + (Constants.NAVI_COUNT_PER_PAGE - 1);
//
//		if(endNavi > pageTotalCount) {
//			endNavi = pageTotalCount;
//		}
//
//		System.out.println("현재 페이지 : " + currentPage);
//		System.out.println("네비 시작 : " + startNavi);
//		System.out.println("네비 끝 : " + endNavi);
//
//		boolean needPrev = true;
//		boolean needNext = true;
//
//		if(startNavi == 1) {
//			needPrev = false;
//		}
//
//		if(endNavi == pageTotalCount) {
//			needNext = false;
//		}
//
//		StringBuilder sb = new StringBuilder();
//
//		if(needPrev) {
//			sb.append("<a href='/boardList.board?cpage=" + (startNavi-1) +  "'> << </a> ");
//		}
//
//
//		for(int i = startNavi; i <= endNavi; i++) {
//			sb.append("<a href='/boardList.board?cpage="+i+"'>" + i + "</a> ");
//		}
//
//		if(needNext) {
//			sb.append("<a href='/boardList.board?cpage=" + (endNavi+1) +  "'> >> </a> ");
//
//		}
////		System.out.println(sb.toString());
//		return sb.toString();
//		
//
//	}


	public int viewCount(BoardDTO dto) throws Exception{
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

	public int delete(BoardDTO dto) throws Exception {

//		this.getConnection();
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

	public int update(BoardDTO dto) throws Exception {

//		this.getConnection();
		String sql = "update board set title=?, contact=? where seq = ?;" ;

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
			pstat.setString(2, dto.getContact());
			pstat.setInt(3, dto.getSeq());
			return pstat.executeUpdate();
		}

	}

	public List<BoardDTO> selectBy(int startNum, int endNum) throws Exception{
//		this.getConnection();
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
					String contact = rs.getString("contact");
					String write_date = rs.getString("write_date");
					int view_count = rs.getInt("view_count");

					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date givenTime = sdf.parse(write_date);
					Date currentTime = new Date(); // 현재 시간

					long gapTimeInMillis = currentTime.getTime() - givenTime.getTime();

					if (gapTimeInMillis < 60000) {
						long gettime = gapTimeInMillis / 1000;
						write_date = String.valueOf(gettime) + "초 전";
					} else if (gapTimeInMillis < 60000 * 60) {
						long gettime = gapTimeInMillis / 60000;
						write_date = String.valueOf(gettime) + "분 전";
					} else if (gapTimeInMillis < 60000 * 60 * 24) {
						long gettime = gapTimeInMillis / (60000 * 60);
						write_date = String.valueOf(gettime) + "시간 전";
					} else {
						write_date = sdf.format(givenTime); // 날짜 형식을 그대로 표시
					}

					list.add(new BoardDTO(seq, writer, title, contact, write_date, view_count));
					System.out.println(list.size());
				}return list;
			}
		} 
	}
	
	public List<BoardDTO> selectSearch(int startNum, int endNum, String keyword) throws Exception{
//		this.getConnection();
		String sql = "SELECT * FROM (\r\n"
				+ "    SELECT row_number() over(order by seq desc) as rn, board.*\r\n"
				+ "    FROM board where title LIKE ?\r\n"
				+ ") AS rn\r\n"
				+ "WHERE rn BETWEEN ? AND ?;";

		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			pstat.setString(1, "%" + keyword + "%");
			pstat.setInt(2, startNum);
			pstat.setInt(3, endNum);
			try(ResultSet rs = pstat.executeQuery()){
				List<BoardDTO> list = new ArrayList<>();

				while(rs.next()) {
					int seq = rs.getInt("seq");
					String writer = rs.getString("writer");
					String title = rs.getString("title");
					String contact = rs.getString("contact");
					String write_date = rs.getString("write_date");
					int view_count = rs.getInt("view_count");

					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date givenTime = sdf.parse(write_date);
					Date currentTime = new Date(); // 현재 시간

					long gapTimeInMillis = currentTime.getTime() - givenTime.getTime();

					if (gapTimeInMillis < 60000) {
						long gettime = gapTimeInMillis / 1000;
						write_date = String.valueOf(gettime) + "초 전";
					} else if (gapTimeInMillis < 60000 * 60) {
						long gettime = gapTimeInMillis / 60000;
						write_date = String.valueOf(gettime) + "분 전";
					} else if (gapTimeInMillis < 60000 * 60 * 24) {
						long gettime = gapTimeInMillis / (60000 * 60);
						write_date = String.valueOf(gettime) + "시간 전";
					} else {
						write_date = sdf.format(givenTime); // 날짜 형식을 그대로 표시
					}

					list.add(new BoardDTO(seq, writer, title, contact, write_date, view_count));
				}return list;
			}
		} 
	} 
	
	public int replyInsert(BoardDTO dto) throws Exception{
		String sql = "insert into reply (writer, contact, write_date, parent_seq)\r\n"
				+ "values(?, ?, CURRENT_TIMESTAMP, ?);" ;

		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) 
		{
			pstat.setString(1, dto.getWriter());
			pstat.setString(2, dto.getContact());
			pstat.setInt(3, dto.getSeq());
			return pstat.executeUpdate();
		}
	}
	
	public List<BoardDTO> replySelectRead(int seq) throws Exception{
		String sql = "select * from reply where parent_seq = ?;";

		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {

			pstat.setInt(1, seq);
			try(ResultSet rs = pstat.executeQuery()){
				List<BoardDTO> list = new ArrayList<>();

				while(rs.next()) {
					int replyseq = rs.getInt("seq");
					int parent_seq = rs.getInt("parent_seq");
					String writer = rs.getString("writer");
					String contact = rs.getString("contact");
					String write_date = rs.getString("write_date");;

					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date givenTime = sdf.parse(write_date);
					Date currentTime = new Date(); // 현재 시간

					long gapTimeInMillis = currentTime.getTime() - givenTime.getTime();

					if (gapTimeInMillis < 60000) {
						long gettime = gapTimeInMillis / 1000;
						write_date = String.valueOf(gettime) + "초 전";
					} else if (gapTimeInMillis < 60000 * 60) {
						long gettime = gapTimeInMillis / 60000;
						write_date = String.valueOf(gettime) + "분 전";
					} else if (gapTimeInMillis < 60000 * 60 * 24) {
						long gettime = gapTimeInMillis / (60000 * 60);
						write_date = String.valueOf(gettime) + "시간 전";
					} else {
						write_date = sdf.format(givenTime); // 날짜 형식을 그대로 표시
					}

					list.add(new BoardDTO(replyseq, parent_seq, writer, contact, write_date));
				}return list;
			}
		} 
	}
	
	public int replyUpdate(BoardDTO dto) throws Exception {

		String sql = "update reply set contact=? where seq = ?;" ;

		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) 
		{
			pstat.setString(1, dto.getContact());
			pstat.setInt(2, dto.getSeq());
			return pstat.executeUpdate();
		}

	}
	
	
	public int replyDpdate(BoardDTO dto) throws Exception {

		String sql = "delete from reply where seq = ?" ;

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


