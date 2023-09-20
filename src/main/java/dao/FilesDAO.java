package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.FilesDTO;

public class FilesDAO {
	
	private static FilesDAO instance; 

	public static FilesDAO getInstance() {
		if(instance == null) {
			instance = new FilesDAO();
		}
		return instance;
	}

	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/mysql");
		return ds.getConnection();

	}
	
	
	// file 테이블 삽입
	public int insert(FilesDTO dto) throws Exception {
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
}
