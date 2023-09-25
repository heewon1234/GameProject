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
		String sql = "INSERT INTO MEMBERS VALUES(?, ?, ?, ?, ?, ?, ?, ?, default, default)";

		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
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
			return pstat.executeUpdate();

		}
	}

	// ID 중복체크
	public boolean isDuplicatedID(String input) throws Exception {
		String qry = "select id from MEMBERS where id=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(qry);

				) {
			pstat.setString(1, input);
			try(
					ResultSet rs = pstat.executeQuery();
					){
				return rs.next();
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
				String password = rs.getString("PASSWORD");
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
	public String getEmail(String loginID) throws Exception { 
		String sql = "SELECT EMAIL FROM MEMBERS WHERE ID = ?;";

		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, loginID);

			try (ResultSet rs = pstat.executeQuery();) {
				if (rs.next()) {
					return rs.getString("EMAIL");
				} else {
					// 해당 ID에 대한 사용자가 없을 경우 처리할 내용을 추가할 수 있습니다.
					return null;
				}
			}
		}
	}

	public String getPassword(String loginID) throws Exception {
		String sql = "SELECT PASSWORD FROM MEMBERS WHERE ID = ?";

		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, loginID);

			try (ResultSet rs = pstat.executeQuery();) {
				if (rs.next()) {
					return rs.getString("PASSWORD");
				} else {
					// 해당 ID에 대한 사용자가 없을 경우 처리할 내용을 추가할 수 있습니다.
					return null;
				}
			}
		}
	}

	public String getIdByEmail(String email) throws Exception {
		String sql = "SELECT ID FROM MEMBERS WHERE EMAIL = ?";

		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, email);

			try (ResultSet rs = pstat.executeQuery();) {
				if (rs.next()) {
					return rs.getString("ID");
				} else {
					// 해당 Email에 대한 사용자가 없을 경우 처리할 내용을 추가할 수 있습니다.
					return null;
				}
			}
		}
	}
	
	public int updatePassword(String id, String newPassword) throws Exception {
        String sql = "UPDATE MEMBERS SET PASSWORD = ? WHERE ID = ?";
        
        try (
            Connection con = this.getConnection();
            PreparedStatement pstat = con.prepareStatement(sql);
        ) {
            pstat.setString(1, newPassword);
            pstat.setString(2, id);
            
            return pstat.executeUpdate();
        }
    }
	
	public List<MembersDTO> selectMembersInfo() throws Exception {
		String sql = "SELECT * FROM MEMBERS WHERE position IN ('user', 'banned')";
		List<MembersDTO> list = new ArrayList<>();
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);) {

			try(ResultSet rs = pstat.executeQuery();) {

				while(rs.next()) {
					String id = rs.getString("ID");
					String password = rs.getString("PASSWORD");
					String name = rs.getString("NAME");
					String phone = rs.getString("PHONE");
					String email = rs.getString("EMAIL");
					String zipcode = rs.getString("ZIPCODE");
					String address1 = rs.getString("ADDRESS1");
					String address2 = rs.getString("ADDRESS2");
					Timestamp signupDate = rs.getTimestamp("SIGNUP_DATE");
					String position = rs.getString("POSITION");
					
					list.add(new MembersDTO(id, password, name, phone, email, zipcode, address1, address2, signupDate, position));
				}
				

				return list;
			}
		}
	}
	
	public int banMember(String id) throws Exception {
		String sql = "UPDATE MEMBERS SET position = 'banned' WHERE ID = ?";
        
        try (
            Connection con = this.getConnection();
            PreparedStatement pstat = con.prepareStatement(sql);
        ) {
            pstat.setString(1, id);
            
            return pstat.executeUpdate();
        }
	}
	
	public int unbanMember(String id) throws Exception {
		String sql = "UPDATE MEMBERS SET position = 'user' WHERE ID = ?";
        
        try (
            Connection con = this.getConnection();
            PreparedStatement pstat = con.prepareStatement(sql);
        ) {
            pstat.setString(1, id);
            
            return pstat.executeUpdate();
        }
	}
	
	public boolean isBanned(String id) throws Exception {
		String sql = "SELECT * FROM MEMBERS WHERE position = 'banned' and id=?";

		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, id);
			try(ResultSet rs = pstat.executeQuery();) {
				return rs.next();
			}
		}
	}

}