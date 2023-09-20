package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
}
