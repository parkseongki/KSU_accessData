<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<%-- bootstrap 5 적용 --%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>통제구역 출입 대장</title>
<style type="text/css">
	a, a:hover {
		color: #000000;
		text-decoration: none;
	}
</style>
</head>
<body>


	<%
		String USERID = null;
		if (session.getAttribute("USERID") != null) {
			USERID = (String) session.getAttribute("USERID");
			
		}
		int pageNumber = 1; // 기본 페이지
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	
	<%-- 메뉴 바 구성 --%>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">통제구역 출입 대장</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link"
						aria-current="page" href="login.jsp">메인</a></li>
					<%--	
					<li class="nav-item"><a class="nav-link"
						aria-current="page" href="accessList.jsp">게시판</a></li>
					--%>
				</ul>
				<ul class="navbar-nav navbar-right">
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">
							회원정보 </a>
						<%-- dropdown-menu-end를 안하면 오른쪽에 있을 때 dropdown-menu 가 짤리게 된다. --%>
						<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item active" href="login.jsp">로그인</a></li>
							<li><a class="dropdown-item" href="userAdd.jsp">회원가입</a></li>
							<li><a class="dropdown-item" href="logoutAction.jsp">로그아웃</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	
	<%-- 통제구역 출입대장 구성 --%>
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">NUM</th>
						<th style="background-color: #eeeeee; text-align: center;">월일</th>
						<th style="background-color: #eeeeee; text-align: center;">시작시간</th>
						<th style="background-color: #eeeeee; text-align: center;">종료시간</th>
						<th style="background-color: #eeeeee; text-align: center;">용무</th>
						<th style="background-color: #eeeeee; text-align: center;">출입자 소속</th>
						<th style="background-color: #eeeeee; text-align: center;">출입자 성명</th>
						<th style="background-color: #eeeeee; text-align: center;">입회자 시작확인</th>
						<th style="background-color: #eeeeee; text-align: center;">입회자 종료확인</th>
						<th style="background-color: #eeeeee; text-align: center;">비고</th>
					</tr>
				</thead>
				<tbody>
				
			    <%
				 Class.forName("oracle.jdbc.driver.OracleDriver");
			     Connection conn = null;
			     Statement stmt = null;
			     ResultSet rs = null;
			     String sort = "";
			     
			     
			     try {
			    		
			    	String url = "jdbc:oracle:thin:@210.110.162.20:1521:ksudb";
			    	String userName = "teacher1";
			    	String userPassword = "rudtjd12!@";
			    	String query = "SELECT * FROM TBLACCESS ORDER BY BBS_NUM DESC";
			    	
			    	conn = DriverManager.getConnection(url, userName, userPassword);
			    	stmt = conn.createStatement();
			    	rs = stmt.executeQuery(query);
			         
			   	 while(rs.next()){  %>
			    <tr align=center>
			     	<td><%=rs.getString("BBS_NUM")%></td>
			        <td><%=rs.getString("GO_DATAMD")%></td>
			     	<td><%=rs.getString("ST_TIME")%></td>
			     	<td><%=rs.getString("ED_TIME")%></td>
			     	<td><%=rs.getString("WORK")%></td>
			     	<td><%=rs.getString("COMPANY")%></td>
			     	<td><%=rs.getString("COMPANYUSER")%></td>
			     	<td><%=rs.getString("GO_ST")%></td>
			        <td><%=rs.getString("GO_ENTER")%></td>
			        <td><%=rs.getString("ETC")%></td>
				</tr>
				<% 	}
			     }catch(SQLException ex){
			            out.println(ex.getMessage());
			            ex.printStackTrace();
			     
			      }finally{
			            // 6. 사용한 Statement 종료
			            if(rs != null) try { rs.close(); } catch(SQLException ex) {}
			            if(stmt != null) try { stmt.close(); } catch(SQLException ex) {}
			            // 7. 커넥션 종료
			            if(conn != null) try { conn.close(); } catch(SQLException ex) {}
			      } %>
			</tbody>
		</table>
		</div>
		<a href="accessAdd.jsp" class="btn btn-primary pull-right">글쓰기</a>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>