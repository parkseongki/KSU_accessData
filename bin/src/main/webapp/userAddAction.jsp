<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="USERID" />
<jsp:setProperty name="user" property="USERPW" />
<jsp:setProperty name="user" property="COMPANY" />
<jsp:setProperty name="user" property="COMPANYUSER" />
<jsp:setProperty name="user" property="COMPANYTEL" />
<jsp:setProperty name="user" property="ETC" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User Add Check</title>
</head>
<body>
	<%
		
		String userID = null;
		if (session.getAttribute("USERID") != null) {
		    userID = (String) session.getAttribute("USERID");
		}
		
		if(userID != null) {
		    PrintWriter script = response.getWriter();
		    script.println("<script>");
		    script.println("alert('이미 로그인이 되어있습니다.')");
		    script.println("location.href = 'login.jsp'");
		    script.println("</script>");
		}	
		
		
		if (user.getUSERID() == null || 
			user.getUSERPW() == null ) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력하지 않은 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script");
		} else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.userAdd(user);
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('회원가입 성공하였습니다.')");
				script.println("location.href = 'login.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>