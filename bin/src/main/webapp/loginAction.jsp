<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>

<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="USERID" />
<jsp:setProperty name="user" property="USERPW" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page Check</title>
</head>
<body>

	<%
		String USERID = null;
		if (session.getAttribute("USERID") != null) {
			USERID = (String) session.getAttribute("USERID");
		}
		
		if(USERID != null) {
		    PrintWriter script = response.getWriter();
		    script.println("<script>");
		    script.println("alert('이미 로그인이 되어있습니다.')");
		    script.println("location.href = 'login.jsp'");
		    script.println("</script>");
		}	
		
		UserDAO userDAO = new UserDAO();
		
		int result = userDAO.login(user.getUSERID(), user.getUSERPW());
		
		if (result == 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'accessList.jsp'");
			script.println("</script>");
		}
		else if (result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (result == -2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
	
</body>
</html>