<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Main</title>
<link href="/ui_css/index_css.css" rel="stylesheet" type="text/css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	rel="stylesheet">
<style>
.game-img {
	position: relative;
}

.game-img>img {
	position: absolute;
}

.game-img>img:first-child {
	z-index: 3;
}

.game-img>img:last-child {
	z-index: 2;
}

.game-img:hover>img:first-child {
	z-index: 1;
}

.game-img:hover>img:last-child {
	transform: scale(1.1);
	transition-duration: 0.75s;
}

.menubar>div {
	font-weight: bold;
	font-size: 23px;
}

.game-dropdown {
	font-weight: bold;
	font-size: 23px;
}

a {
	color: black;
	text-decoration: none;
}

.dropdown:hover {
	cursor: pointer;
}

.dropdown:hover .dropdown-menu {
	display: block;
	margin-top: 0;
}

#icon:hover {
	cursor: pointer;
}

#logoImg:hover {
	cursor: pointer;
}
</style>
</head>

<body>
	<div class="container header pt-5 p-0">
		<div class="row p-0 m-0 header" id="main-header">
			<div
				class="col-md-2 col-12 d-flex align-items-center justify-content-center logo">
				<img src="/UI_img/logo3.jpg" class="w-75 h-100" id="logoImg">
			</div>
			<div class="col-md-8 p-0">
				<div class="row p-0 m-0 h-100 menubar">
					<div
						class="col-md-3 p-0 d-flex align-items-center justify-content-center">
						<a href="/index.jsp">홈</a>
					</div>
					<div
						class="col-md-3 p-0 d-flex align-items-center justify-content-center">
						<div class="dropdown">
							<button class="btn dropdown-toggle game-dropdown" type="button"
								id="dropdownMenuButton1" data-bs-toggle="dropdown"
								aria-expanded="false">
								<i class="fas fa-gamepad me-2 mx-2" style="font-size: 1.5rem;"></i>
								게임
							</button>
							<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
								<c:choose>
									<c:when test="${loginID == null }">
										<li><a class="dropdown-item" href="/members/login.jsp">지뢰찾기</a></li>
										<li><a class="dropdown-item" href="/members/login.jsp">바운스볼</a></li>
										<li><a class="dropdown-item" href="/members/login.jsp">플래피버드</a></li>
										<li><a class="dropdown-item" href="/members/login.jsp">풀문보트</a></li>
										<li><a class="dropdown-item" href="/members/login.jsp">드래곤
												플라이트</a></li>
										<li><a class="dropdown-item" href="/members/login.jsp">컬러블라인드</a></li>
									</c:when>
									<c:otherwise>
										<li><a class="dropdown-item"
											href="/game/minesweeper/eazyMinesweeper.jsp">지뢰찾기</a></li>
										<li><a class="dropdown-item"
											href="/game/bounceball/bounceball_main.jsp">바운스볼</a></li>
										<li><a class="dropdown-item"
											href="/game/flappyBird/flappyBird_main.jsp">플래피버드</a></li>
										<li><a class="dropdown-item"
											href="/game/fullMoonBoat/JSP/fullMoonBoat.jsp">풀문보트</a></li>
										<li><a class="dropdown-item"
											href="/game/dragon/dragon.jsp">드래곤 플라이트</a></li>
										<li><a class="dropdown-item"
											href="/game/colorblind/colorblind.jsp">컬러블라인드</a></li>
									</c:otherwise>
								</c:choose>

							</ul>
						</div>
					</div>
					<div
						class="col-md-3 p-0 d-flex align-items-center justify-content-center">
						<c:choose>
							<c:when test="${loginID == null }">
								<a href="/members/login.jsp">자유게시판</a>
							</c:when>
							<c:otherwise>
								<a href="/list.board">자유게시판</a>
							</c:otherwise>
						</c:choose>

					</div>
					<div
						class="col-md-3 p-0 d-flex align-items-center justify-content-center">
						<c:choose>
							<c:when test="${loginID == null }">
								<a href="/members/login.jsp">랭킹게시판</a>
							</c:when>
							<c:otherwise>
								<a href="/board/rankingBoard.jsp">랭킹게시판</a>
							</c:otherwise>
						</c:choose>

					</div>
				</div>
			</div>
			<div
				class="col-md-2 mt-2 d-md-flex justify-content-end align-items-center icon-place d-none d-md-block pe-5"
				id="iconplace">
				<i class="fa-solid fa-right-to-bracket fa-2x" id="icon"></i>
			</div>
		</div>

	
	<hr>
	<div class="body">
		<div class="bodyBorder">
			<div class="banner">
				<div id="carouselExampleControls" class="carousel slide"
					data-bs-ride="carousel">
					<div class="carousel-inner">
						<div class="carousel-item active">
							<c:choose>
								<c:when test="${loginID == null }">
									<a href="/members/login.jsp"><img src="/UI_img/banner_1.png" class="d-block w-100" alt="..."></a>
								</c:when>
								<c:otherwise>
									<a href="/game/minesweeper/eazyMinesweeper.jsp"><img src="/UI_img/banner_1.png" class="d-block w-100" alt="..."></a>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="carousel-item">
							<c:choose>
								<c:when test="${loginID == null }">
									<a href="/members/login.jsp"><img src="/UI_img/banner_2.png" class="d-block w-100" alt="..."></a>
								</c:when>
								<c:otherwise>
									<a href="/game/bounceball/bounceball_main.jsp"><img src="/UI_img/banner_2.png" class="d-block w-100" alt="..."></a>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="carousel-item">
							<c:choose>
								<c:when test="${loginID == null }">
									<a href="/members/login.jsp"><img src="/UI_img/banner_3.png" class="d-block w-100" alt="..."></a>
								</c:when>
								<c:otherwise>
									<a href="/game/flappyBird/flappyBird_main.jsp"><img src="/UI_img/banner_3.png" class="d-block w-100" alt="..."></a>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="carousel-item">
							<c:choose>
								<c:when test="${loginID == null }">
									<a href="/members/login.jsp"><img src="/UI_img/banner_4.png" class="d-block w-100" alt="..."></a>
								</c:when>
								<c:otherwise>
									<a href="/game/fullMoonBoat/JSP/fullMoonBoat.jsp"><img src="/UI_img/banner_4.png" class="d-block w-100" alt="..."></a>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="carousel-item">
							<c:choose>
								<c:when test="${loginID == null }">
									<a href="/members/login.jsp"><img src="/UI_img/banner_5.png" class="d-block w-100" alt="..."></a>
								</c:when>
								<c:otherwise>
									<a href="/game/dragon/dragon.jsp"><img src="/UI_img/banner_5.png" class="d-block w-100" alt="..."></a>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="carousel-item">
							<c:choose>
								<c:when test="${loginID == null }">
									<a href="/members/login.jsp"><img src="/UI_img/banner_6.png" class="d-block w-100" alt="..." style="border: 1px solid gainsboro;"></a>
								</c:when>
								<c:otherwise>
									<a href="/game/colorblind/colorblind.jsp"><img src="/UI_img/banner_6.png" class="d-block w-100" alt="..." style="border: 1px solid gainsboro;"></a>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<button class="carousel-control-prev" type="button"
						data-bs-target="#carouselExampleControls" data-bs-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Previous</span>
					</button>
					<button class="carousel-control-next" type="button"
						data-bs-target="#carouselExampleControls" data-bs-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Next</span>
					</button>
				</div>
			</div>
			<div class="contents">
				<div class="contents-left">
					<div class="game-border">
						<div class="game-select-text">게임선택</div>
						<hr>
						<div class="game-select">
							<div class="game">
								<div class="game-list">
									<c:choose>
										<c:when test="${loginID == null }">
											<a href="/members/login.jsp">
										</c:when>
										<c:otherwise>
											<a href="/game/minesweeper/eazyMinesweeper.jsp">
										</c:otherwise>
									</c:choose>

									<div class="game-img">
										<img src="/UI_img/1_1.png" style="width: 80%; object-fit: cover;"> <img
											src="/UI_img/3.gif" style="width: 80%">
									</div>
									<div class="game-txt">지뢰찾기</div>
									</a>
								</div>
								<div class="game-list">
									<c:choose>
										<c:when test="${loginID == null }">
											<a href="/members/login.jsp">
										</c:when>
										<c:otherwise>
											<a href="/game/bounceball/bounceball_main.jsp">
										</c:otherwise>
									</c:choose>

									<div class="game-img">
										<img src="/UI_img/2.png" style="width: 80%; object-fit: cover;"> <img
											src="/UI_img/4.gif" style="width: 80%;">
									</div>
									<div class="game-txt">바운스볼</div>
									</a>
								</div>
								<div class="game-list">
									<c:choose>
										<c:when test="${loginID == null }">
											<a href="/members/login.jsp">
										</c:when>
										<c:otherwise>
											<a href="/game/flappyBird/flappyBird_main.jsp">
										</c:otherwise>
									</c:choose>

									<div class="game-img">
										<img src="/UI_img/3.png" style="width: 80%; object-fit: cover;"> <img
											src="/UI_img/2.gif" style="width: 80%">
									</div>
									<div class="game-txt">플래피버드</div>
									</a>
								</div>
							</div>
							<div class="game">
								<div class="game-list">
									<c:choose>
										<c:when test="${loginID == null }">
											<a href="/members/login.jsp">
										</c:when>
										<c:otherwise>
											<a href="/game/fullMoonBoat/JSP/fullMoonBoat.jsp">
										</c:otherwise>
									</c:choose>

									<div class="game-img">
										<img src="/UI_img/4.png" style="width: 80%; object-fit: cover;"> <img
											src="/UI_img/1.gif" style="width: 80%">
									</div>
									<div class="game-txt">풀문보트</div>
									</a>
								</div>
								<div class="game-list">
									<c:choose>
										<c:when test="${loginID == null }">
											<a href="/members/login.jsp">
										</c:when>
										<c:otherwise>
											<a href="/game/dragon/dragon.jsp">
										</c:otherwise>
									</c:choose>

									<div class="game-img">
										<img src="/UI_img/5.png" style="width: 80%; object-fit: cover;"> <img
											src="/UI_img/5.gif" style="width: 80%">
									</div>
									<div class="game-txt">드래곤플라이트</div>
									</a>
								</div>
								<div class="game-list">
									<c:choose>
										<c:when test="${loginID == null }">
											<a href="/members/login.jsp">
										</c:when>
										<c:otherwise>
											<a href="/game/colorblind/colorblind.jsp">
										</c:otherwise>
									</c:choose>

									<div class="game-img">
										<img src="/UI_img/6.png"
											style="width: 80%; border: 1px solid gainsboro; object-fit: cover;"> <img
											src="/game/gameUI/colorblind_new.gif" style="width: 80%; object-fit: cover;">
									</div>
									<div class="game-txt">컬러블라인드</div>
									</a>
								</div>
							</div>
						</div>
					</div>
					<div class="board-border">
						<div class="board-text">
							<c:choose>
								<c:when test="${loginID == null}">
									<a href="/members/login.jsp"
										style="text-decoration-line: none;">최근게시물 ></a>
								</c:when>
								<c:otherwise>
									<a href="/list.board" style="text-decoration-line: none;">최근게시물
										></a>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="board">
							<table class="table">
								<thead>
									<tr>
										<th scope="col" style="padding: 0px;">번호</th>
										<th scope="col" style="padding: 0px; text-align: center;">카테고리</th>
										<th scope="col" style="padding: 0px; text-align: center;">제목</th>
										<th scope="col" style="padding: 0px; text-align: center;">조회수</th>
										<th scope="col" style="padding: 0px; text-align: center;">작성자</th>
										<th scope="col" style="padding: 0px; text-align: center;">작성일</th>
									</tr>
								</thead>
								<tbody class="table-group-divider" id="tableBody">

								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="contents-right">
					<div class="loginbox">
						<c:choose>
							<c:when test="${loginID == null }">
								<div class="login-button">
									<button id="loginButton">로그인</button>
								</div>
								<div class="login-txt">
									<a href="/goToIdSearch.members">아이디찾기</a> | <a
										href="/goToPwSearch.members">비밀번호찾기</a> | <a
										href="/goToSignUp.members">회원가입</a>
								</div>
							</c:when>
							<c:otherwise>
								<div class="login-top">
									<div class="login-user">
										<div class="user-img-place"
											style="font-size: 3.5rem; margin-left: 15px; margin-right: 15px;">
											<i class="fa-solid fa-user"></i>
										</div>
									</div>
									<div class="user-info">
										<div style="margin-top: 20px;">${loginID }</div>
										<div>${email }</div>
									</div>
									<div class="logout-btn"
										style="display: flex; justify-content: center; align-items: center;">
										<button id="logoutBtn">
											로그아웃<img src="/UI_img/log-out.svg" style="margin-left: 5px;">
										</button>
									</div>

								</div>
								<div class="login-bottom" style="text-align: center;">
									<a href="/mypage.members">마이페이지</a>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="rnk-board">
						<div class="rnk-txt">
							<c:choose>
								<c:when test="${loginID == null}">
									<a href="/members/login.jsp"
										style="text-decoration-line: none;">나의 랭킹 ></a>
								</c:when>
								<c:otherwise>
									<a href="/board/rankingBoard.jsp"
										style="text-decoration-line: none;">나의 랭킹 ></a>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="rnk-board-contents">
							<table class="table">
								<thead>
									<tr>
										<th scope="col">랭킹</th>
										<th scope="col">게임</th>
										<th scope="col">score</th>
										<th scope="col">날짜</th>
									</tr>
								</thead>
								<tbody class="table-group-divider" id="rankList">

								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
	</div>
	<div id="footer_container"></div>
	<script>
				$("#logoImg").on("click",function(){
					location.href="/index.jsp";
				})
				
				if(${loginID == null}){
							$("#icon").css("display","none");
						}
				
				$("#icon").on("click",function(){
					location.href="/logout.members";
				});
				$(document).ready(function () {
					$("#loginButton").on("click", function () {
						location.href = "/goToLogin.members";
					})
					
					$("#logoutBtn").on("click",function(){
						location.href="/logout.members";
					})
				});

				$(document).ready(function() {
					$("#footer_container").load("/commons/footer.html");
				});
				

				// 최근 게시물
				$.ajax({
					type: "POST",
					url: "/indexList.board",
					dataType: "json",
				}).done(
					function (resp) {
						try {
							var parsedData = resp;
							// 성공적으로 서버로부터 데이터를 받았을 때 실행되는 부분
							var $tableBody = $("#tableBody");

							if (parsedData.length > 0) {
								// 데이터가 존재하는 경우
								for (var i = 0; i < parsedData.length; i++) {
									var fiveList = parsedData[i];

									var $row = $("<tr>");
										$row.append($("<td>").text(fiveList.seq),
										$("<td>").text(fiveList.game_name).css("text-align", "center"),
										$("<td>").css("text-align", "center").append($("<a>").attr("href", "/showContents.board?seq=" + fiveList.seq).text(fiveList.title)),
										$("<td>").text(fiveList.view_count).css("text-align", "center"),
										$("<td>").text(fiveList.writer).css("text-align", "center"),
										$("<td>").text(fiveList.write_date)).css("text-align", "center");
									$tableBody.append($row);
								}
							}
						} catch (error) {
							console.error("JSON 파싱 오류:", error);
						}
					}).fail(function (xhr, status, error) {
						console.error("요청 실패:", status, error);
					});
				// 내 랭킹
				$.ajax({
					type: "POST",
					url: "/myRankGames.rankBoard",
					dataType: "json",
				}).done(
					function (resp) {
						try {
							var parsedData = resp;
							// 성공적으로 서버로부터 데이터를 받았을 때 실행되는 부분
							var $rankList = $("#rankList");

							if (parsedData.length > 0) {
								// 데이터가 존재하는 경우
								for (var i = 0; i < parsedData.length; i++) {
									var myRank = parsedData[i];

									var $row = $("<tr>");
									$row.append($("<td>").text(myRank.ranking), 
									$("<td>").text(myRank.game_name), 
									$("<td>").text(myRank.score), 
									$("<td>").text(myRank.rank_date));
									$rankList.append($row);
								}
							}
						} catch (error) {
							console.error("JSON 파싱 오류:", error);
						}
					}).fail(function (xhr, status, error) {
						console.error("요청 실패:", status, error);
					});
			</script>


</body>

</html>