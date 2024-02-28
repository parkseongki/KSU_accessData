package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	String dbID = "teacher1";
	String dbPassword = "rudtjd12!@";
	String dbURL = "jdbc:oracle:thin:@210.110.162.20:1521:ksudb";	
	
	public UserDAO() {
		try {
					
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
			
	}
	
	// 현재 시간
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
		
		return ""; 
	}
	
	
	// 하나의 계정에 대한 로그인 시도를 해주는 함수
	public int login(String USERID, String USERPW) throws SQLException {
		
		String SQL = "SELECT USERID, USERPW FROM TBLUSER WHERE USERID = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, USERID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(USERPW)) {
					// 로그인 성공
					///String uID = rs.getString("USERID"); //DB에 있는 ID가져옴
		    		//session.setAttribute("USERID", uID); //DB값을 세션에 넣음
		    		System.out.println("로그인 성공");
					return 1; // 로그인 성공		
				}
				else
					return 0; // 비밀번호 불일치
			}
			return -1; // 아이디가 없음
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			closeAll();
		}
		return -2; // 데이터베이스 오류
	}
	
	public int userAdd(User user) throws SQLException {
		
		String SQL = "INSERT INTO TBLUSER VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUSERID());
			pstmt.setString(2, user.getUSERPW());
			pstmt.setString(3, user.getCOMPANY());
			pstmt.setString(4, user.getCOMPANYUSER());
			pstmt.setString(5, user.getCOMPANYTEL());
			pstmt.setString(6, user.getETC());
			pstmt.setString(7, "N");
			pstmt.setString(8, getDate());
			
			System.out.println("회원가입 성공");
			return pstmt.executeUpdate();
	
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public void closeAll(){
			//rs 객체 종료
	     	if (rs != null) {
	            try {
	                rs.close();
	            } catch (SQLException e) { 
	                e.printStackTrace();
	            }
	        }
	     
	     	// pstmt 객체 종료
	        if (pstmt != null) {
	            try {
	                pstmt.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	        
	        // conn 객체 종료
	        if (conn != null) {
	            try {
	                conn.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	}
	
}