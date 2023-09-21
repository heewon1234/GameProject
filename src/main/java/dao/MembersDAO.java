package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.BoardDTO;
import dto.MembersDTO;

public class MembersDAO {
	private static MembersDAO instance; 

	public static MembersDAO getInstance() {
		if(instance == null) {
			instance = new MembersDAO();
		}
		return instance;
	}

	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/mysql");
		return ds.getConnection();
	}
	
	// 회원가입
	public int insert(MembersDTO dto) throws Exception{
		String sql = "INSERT INTO MEMBERS VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, NULL, ?)";

		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
				) 

		{
			pstat.setString(1, dto.getId());
			pstat.setString(2, dto.getPassword());
			pstat.setString(3, dto.getName());
			pstat.setString(4, dto.getPhone());
			pstat.setString(5, dto.getEmail());
			pstat.setString(6, dto.getZipcode());
			pstat.setString(7, dto.getAddress1());
			pstat.setString(8, dto.getAddress2());
			pstat.setString(9, dto.getPosition());
			pstat.executeUpdate();

			try(ResultSet rs = pstat.getGeneratedKeys()){
				rs.next();
				return rs.getInt(1);
			}
		}
	}
	
	// 로그인
	public boolean isAccountExist(String id, String password) throws Exception{
		String sql = "select * from MEMBERS WHERE ID = ? AND PASSWORD = ?";
		
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, id);
			pstat.setString(2, password);

			try(ResultSet rs = pstat.executeQuery();) {
				return rs.next();
			}
		}
	}
	
	// 회원탈퇴
	public int delAccount(String id) throws Exception{
		String sql = "DELETE FROM MEMBERS WHERE ID = ?";

		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, id);

			return pstat.executeUpdate();
		}
	}
	
	// 정보수정
	public int updateAccount(MembersDTO dto) throws Exception {
		String sql = "UPDATE MEMBERS SET PASSWORD = ?, NAME = ? , PHONE = ?, EMAIL = ?, ZIPCODE = ?, ADDRESS1 = ?, ADDRESS2 = ? WHERE ID = ?";

		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);) {
			
			pstat.setString(1, dto.getPassword());
			pstat.setString(2, dto.getName());
			pstat.setString(3, dto.getPhone());
			pstat.setString(4, dto.getEmail());
			pstat.setString(5, dto.getZipcode());
			pstat.setString(6, dto.getAddress1());
			pstat.setString(7, dto.getAddress2());
			pstat.setString(8, dto.getId());

			return pstat.executeUpdate();
		}
	}
	
	// 마이페이지
	public MembersDTO mypage(String loginID) throws Exception{ 
		String sql = "SELECT * FROM MEMBERS WHERE ID = ?;";

		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, loginID);

			try(ResultSet rs = pstat.executeQuery();) {

				rs.next();
				String id = rs.getString("ID");
				String password = rs.getString("PW");
				String name = rs.getString("NAME");
				String phone = rs.getString("PHONE");
				String email = rs.getString("EMAIL");
				String zipcode = rs.getString("ZIPCODE");
				String address1 = rs.getString("ADDRESS1");
				String address2 = rs.getString("ADDRESS2");
				Timestamp signupDate = rs.getTimestamp("SIGNUP_DATE");
				String position = rs.getString("POSITION");

				return new MembersDTO(id, password, name, phone, email, zipcode, address1, address2, signupDate, position);
			}
		}
	}
}
