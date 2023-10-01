<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
<style>
body {
	padding-top: 60px;
}

a {
	text-decoration-line: none;
	color: black;
}

.row-alert {
	margin-top: 0px;
	margin-bottom: 0px;
	display: none;
}

.row-alert>div {
	font-size: small;
	padding: 0px;
	display: flex;
}
</style>
</head>
<body>
	<div class="containerBox">
		<div class="row p-0 m-0 header" id="main-header"></div>
		<hr>
		<div class="container border">
			<div class="row">
				<!-- 사이드바 -->
				<div class="col-md-3">
					<div class="panel panel-info">
						<div class="panel-heading" align="center">
							<h3>${myInfo.id}</h3>
							${myInfo.email}
						</div>
					</div>
					<hr>
					<div class="panel panel-info">
						<ul class="list-group">
							<li class="list-group-item"><a href="/mypage.members">내
									프로필</a></li>
							<li class="list-group-item"><a
								href="/board/rankingBoard.jsp">랭킹</a></li>
							<li class="list-group-item"><a
								href="/delAccountPage.members">회원탈퇴</a></li>
							<c:if test="${myInfo.id eq 'admin'}">
								<li class="list-group-item"><a href="/membersInfo.members">관리자
										페이지</a></li>
							</c:if>
						</ul>
					</div>
					<hr>
				</div>
				<div class="col-md-9 border" style="padding: 20px;">
					<table class="table">
						<thead>
							<tr>
								<th scope="col" style="width: 150px; text-align: center">아이디</th>
								<th scope="col" style="width: 80px; text-align: center">상태</th>
								<th style="width: 80px;"></th>
								<th style="width: 80px;"></th>
								<th style="width: 80px;"></th>
							</tr>
						</thead>
						<tbody class="table-group-divider">
							<c:forEach var="l" items="${list }">
								<tr>
									<th scope="row" style="text-align: center">${l.id}</th>
									<td style="text-align: center">${l.position}</td>
									<td></td>
									<c:choose>
										<c:when test="${l.position eq 'resigned'}">
											<td style="height: 55px;"></td>
											<td></td>
										</c:when>
										<c:otherwise>
											<td><button type="button"
													class="btn btn-outline-danger btn_ban" value="${l.id}">Ban</button></td>
											<td><button type="button"
													class="btn btn-outline-success btn_unban" value="${l.id}">Unban</button></td>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<div id="footer_container" style="margin-top:50px;"></div>
	<script>
		$(document).ready(function() {
			$("#main-header").load("/commons_ui/header.html");
		});
		$(document).ready(function() {
			$("#footer_container").load("/commons/footer.html")
		});

		$(".btn_ban").on("click", function() {
			let id = $(this).val();
			$.ajax({
				url : "/banMember.members",
				data : {
					id : id
				},
				type : "post"
			}).done(function(resp) {
				location.reload();
			})
		})

		$(".btn_unban").on("click", function() {
			let id = $(this).val();
			$.ajax({
				url : "/unbanMember.members",
				data : {
					id : id
				},
				type : "post"
			}).done(function(resp) {
				location.reload();
			})
		})
	</script>
</body>
</html>