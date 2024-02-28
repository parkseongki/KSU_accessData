package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class BbsDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	String dbID = "teacher1";
	String dbPassword = "rudtjd12!@";
	String dbURL = "jdbc:oracle:thin:@210.110.162.20:1521:ksudb";	
	
	public BbsDAO() {
		try {
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	// 현재 시간을 가져오는 함수, 게시판의 글을 작성할 때 현재 서버의 시간을 넣어주는 역할
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류
	}
	
	
	// 게시글 번호는 하나씩 늘어나므로 마지막에 쓰인 글을 가져와서 +1을 하면 다음 번호가 된다 
	public int getNext() {
		String SQL = "SELECT BBS_NUM FROM TBLACCESS ORDER BY BBS_NUM DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫 번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	// 실제로 글을 작성하는 함수
	public int getWrite(String getGO_DATAMD, String getST_TIME, String getED_TIME, String getWORK, String getCOMPANY, String getCOMPANYUSER, String getGO_ST, String getGO_ENTER, String getETC) {
		String SQL = "INSERT INTO TBLACCESS VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, getGO_DATAMD);
			pstmt.setString(3, getST_TIME);
			pstmt.setString(4, getED_TIME);
			pstmt.setString(5, getWORK);
			pstmt.setString(6, getCOMPANY);
			pstmt.setString(7, getCOMPANYUSER);
			pstmt.setString(8, getGO_ST);
			pstmt.setString(9, getGO_ENTER);
			pstmt.setString(10, getETC);

			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

 
	
}