<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 결과</title>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	rel="stylesheet">
</head>
<style>
.containerBox {
	padding-top: 60px;
	margin: auto;
}

a {
	text-decoration-line: none;
	color: black;
}

.foundID {
	border: 1px solid gray;
	border-radius: 10px;
	padding: 15px;
	font-weight: bolder;
}
#logoImg:hover{cursor:pointer;}
</style>
<body>
	<div class="containerBox" style="width: 50rem;">
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-6">
				<img src="/UI_img/logo3.jpg"
					style="width: 100%; margin-bottom: 35px;" id="logoImg">
			</div>
			<div class="col-md-3"></div>
		</div>
		<div class="container border">
			<div class="row">
				<!-- 사이드바 -->
				<div class="col-md-3" style="padding-top: 5%;">
					<hr>
					<div class="panel panel-info">
						<ul class="list-group">
							<li class="list-group-item" style="background-color: #DDE6ED;"><a
								href="/members/id_Search.jsp" style="color: #526D82">아이디 찾기</a></li>
							<li class="list-group-item"><a href="/members/pw_Search.jsp">비밀번호
									찾기</a></li>
							<li class="list-group-item"><a href="/members/login.jsp">로그인</a></li>
						</ul>
					</div>
					<hr>
				</div>
				<div class="col-md-9 border" style="padding: 20px;">

					<div>아이디 찾기</div>
					<hr>

					<div>고객님의 정보와 일치하는 아이디 목록입니다.</div>
					<hr style="color: white;">

					<div class="foundID">
						Found ID:
						<%=request.getAttribute("foundId")%>
					</div>


					<hr style="color: gray;">

					<div class="row justify-content-center">
						<div class="col-auto">
							<button class="btn btn-primary" id="btn-login">로그인하기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		$("#logoImg").on("click", function() {
			location.href = "/";
		})

		$("#btn-login").click(function() {
			window.location.href = "/members/login.jsp";
		});
	</script>
</body>
</html>