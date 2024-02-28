<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<%-- bootstrap 5 적용 --%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>로그인</title>
</head>
<body>

	<%-- 로그인 세션--%>
	<%
		String userID = null;
		if (session.getAttribute("USERID") != null) {
			userID = (String) session.getAttribute("USERID");
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
	
	<%-- 로그인 화면 구성 --%>
	<div class="container">
		<%-- 화면의 동적 움직임을 자연스럽게 하기위해 lg, md, sm값 조정 / mx-auto를 넣어줘야 div 가 중앙으로 정렬됨 --%>
		<div class="col-lg-6 col-md-6 col-sm-6 mx-auto"></div>
		<div class="col-lg-6 col-md-6 col-sm-6 mx-auto">
		
			<%-- bootstrap 5 버전 부터는 jumbotron을 지원해주지 않아서 p-5 text-center bg-light을 통해 만듬 --%>
			<div class="p-5 text-center bg-light" style="margin-top: 20px;">
				<form method="post" action="loginAction.jsp">
					<h3 class="mb-3"style="text-align: center;">로그인</h3>
					<div class="form-group">
						<input type="text" class="form-control mb-3" placeholder="아이디" name="USERID" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control mb-3" placeholder="비밀번호" name="USERPW" maxlength="20">
					</div>
					<input type="submit" class="btn btn-primary form-control mb-3" value="로그인">
				</form>
			</div>
		</div>
		<div class="col-lg-6 col-md-6 col-sm-6 mx-auto"></div>
	</div>
	<script type="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>