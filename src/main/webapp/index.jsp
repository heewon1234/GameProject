<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>
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
* {
	box-sizing: border-box;
}

#head {
	background-color: #B1B2FF
}

#body {
	background-color: #D2DAFF
}

.gtext {
	color: navy;
}
</style>
</head>

<body>
	<div class="container-fluid p-0">
		<div id="head">
			<div>
				<div class="container">
					<div class="row">
						<div class="col-md-2">
							<img src="/UI_img/marvlestudio.jpg">
						</div>
						<div class="col-md-3 p-0">
							<div class="d-flex align-items-center justify-content-center"
								style="height: 40px; width: 200px; border-radius: 5px; background-color: #D2DAFF; margin-top: 2.4%">
								<i class="fas fa-gamepad me-2 mx-2" style="font-size: 1.5rem;"></i>
								<select class="form-select" aria-label="Default select example"
									style="max-width: 200px; background-color: #D2DAFF; width: 100%;"
									onchange="location = this.value;">
									<option value="#" selected>Game</option>
									<option value="/board/gameBoard.jsp">1. 지뢰찾기</option>
									<option value="/game/bounceball/bounceball_main.jsp">2.
										바운스볼</option>
									<option value="/game/flappyBird/flappyBird_main.jsp">3.
										플래피버드</option>
									<option value="/game/fullMoonBoat/JSP/fullMoonBoat.jsp">4.
										풀문보트</option>
									<option value="/game/dragon/dragon.jsp">5. 드래곤 플라이트</option>
									<option value="#">6. 컬러블라인드</option>
								</select>
							</div>
						</div>
					</div>
				</div>

			</div>
			<div style="background-color: #C9CFFF; height: 10px"></div>
		</div>
		<div class="container-fluid p-0" style="background-color: #EEF1FF;">
			<div id="body" class="container">
				<div id="carouselExampleSlidesOnly" class="carousel slide p-4"
					data-bs-ride="carousel">
					<div class="carousel-inner">
						<div class="carousel-item active">
							<img src="/UI_img/어벤져스.jpg" class="d-block w-100" alt="1"
								style="max-height: 350px">
						</div>
						<div class="carousel-item">
							<img src="/UI_img/어벤져스.jpg" class="d-block w-100" alt="2"
								style="max-height: 350px">
						</div>
						<div class="carousel-item">
							<img src="/UI_img/어벤져스.jpg" class="d-block w-100" alt="3"
								style="max-height: 350px">
						</div>
					</div>
				</div>
				<div id="contents" class="row pb-4">
					<div id="left" class="col-8 pt-4">
						<div class="container">
							<div id="top"
								style="border: 2px solid #000; border-radius: 15px; padding: 40px; background-color: #C9CFFF;">
								<div>
									<h5 style="color: white">게임선택</h5>
								</div>
								<div class="row row-cols-2 row-cols-lg-3 g-2 g-lg-3 text-center">
									<div class="col">
										<div class="p-3">
											<figure class="figure">
												<img src="/UI_img/캡틴.jpg"
													class="figure-img img-fluid rounded" alt="...">
												<figcaption class="figure-caption text-center">
													<a class="gtext" href="/board/gameBoard.jsp" style="text-decoration: none;">지뢰찾기</a>
												</figcaption>
											</figure>
										</div>
									</div>
									<div class="col">
										<div class="p-3">
											<figure class="figure">
												<img src="/UI_img/캡틴.jpg"
													class="figure-img img-fluid rounded" alt="...">
												<figcaption class="figure-caption text-center">
													<a class="gtext" href="/game/bounceball/bounceball_main.jsp" style="text-decoration: none;">바운스볼</a>
												</figcaption>
											</figure>
										</div>
									</div>
									<div class="col">
										<div class="p-3">
											<figure class="figure">
												<img src="/UI_img/캡틴.jpg"
													class="figure-img img-fluid rounded" alt="...">
												<figcaption class="figure-caption text-center">
													<a class="gtext" href="/game/flappyBird/flappyBird_main.jsp" style="text-decoration: none;">플래피버드</a>
												</figcaption>
											</figure>
										</div>
									</div>
									<div class="col">
										<div class="p-3">
											<figure class="figure">
												<img src="/UI_img/캡틴.jpg"
													class="figure-img img-fluid rounded" alt="...">
												<figcaption class="figure-caption text-center">
													<a class="gtext" href="/game/fullMoonBoat/JSP/fullMoonBoat.jsp" style="text-decoration: none;">풀문보트</a>
												</figcaption>
											</figure>
										</div>
									</div>
									<div class="col">
										<div class="p-3">
											<figure class="figure">
												<img src="/UI_img/캡틴.jpg"
													class="figure-img img-fluid rounded" alt="...">
												<figcaption class="figure-caption text-center">
													<a class="gtext" href="/game/dragon/dragon.jsp" style="text-decoration: none;">드래곤 플라이트</a>
												</figcaption>
											</figure>
										</div>
									</div>
									<div class="col">
										<div class="p-3">
											<figure class="figure">
												<img src="/UI_img/캡틴.jpg"
													class="figure-img img-fluid rounded" alt="...">
												<figcaption class="figure-caption text-center">
													<a class="gtext" href="#" style="text-decoration: none;">컬러블라인드</a>
												</figcaption>
											</figure>
										</div>
									</div>
								</div>
							</div>
							<div id="bottom"
								style="border: 2px solid #000; border-radius: 15px; padding: 40px; background-color: #C9CFFF;"
								class="mt-4">
								<div>
									<h5 ><a href="/list.board" style="color: white; text-decoration: none">최근 게시물 ></a></h5>
								</div>
								<table class="table mt-4">
									<thead>
										<tr>
											<th scope="col">번호</th>
											<th scope="col">카테고리</th>
											<th scope="col">제목</th>
											<th scope="col">조회수</th>
											<th scope="col">작성자</th>
											<th scope="col">작성일</th>
										</tr>
									</thead>
									<tbody class="table-group-divider">
										<c:forEach var="list" items="${myGameList }">
											<tr>
												<th scope="row" style="text-align: center">${list.seq}</th>
												<td style="text-align: center">${list.game_name}</td>
												<td>${list.title}</td>
												<td style="text-align: center">${list.view_count}</td>
												<td style="text-align: center">${list.writer}</td>
												<td style="text-align: center">${list.timestampToString}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div id="right" class="col-4 pt-4">
						<div class="container">
							<!-- ----------------------------------------------------------- -->
							<c:choose>
								<c:when test="${loginID == null }">
									<div id="login"
										style="border: 2px solid #000; border-radius: 15px; padding: 40px; padding-top: 60px; background-color: #C9CFFF;">
										<div class="mb-3" style="text-align: center">
											<h5>로그인 해주세요!!</h5>
										</div>
										<div class="row mb-3">
											<button type="button" class="btn btn-primary"
												id="loginButton">로그인</button>
										</div>
										<div class="row mb-3">
											<ul class="nav justify-content-center"
												style="font-size: 1rem;">
												<li class="nav-item"><a class="nav-link active p-2"
													aria-current="page" style="color: white"
													href="/goToIdSearch.members">아이디 찾기</a></li>
												<li class="nav-item"><a class="nav-link p-2"
													style="color: white" href="/goToPwSearch.members">비밀번호
														찾기</a></li>
												<li class="nav-item"><a class="nav-link p-2"
													style="color: white" href="/goToSignUp.members">회원가입</a></li>
											</ul>
										</div>
									</div>
								</c:when>
								<c:otherwise>
									<div id="profile"
										style="border: 2px solid #000; border-radius: 15px; padding: 25px; padding-top: 20px; background-color: #C9CFFF;">
										<div id="user" class="p-2" style="display: flex;">
											<div id="userIcon" style="font-size: 3rem">
												<i class="fa-solid fa-user"></i>
											</div>
											<div class="mt-3 mx-4">
												<div id="user">${loginID}</div>
												<div id="email">${email}</div>
											</div>

											<div class="mt-3 mx-4" style="cursor: pointer;"
												onclick="window.location.href='/logout.members';">
												<div class="d-flex border p-2"
													style="width: 120px; border-radius: 20px; align-items: center; justify-content: center;">
													<div>로그아웃</div>
													<img src="/UI_img/log-out.svg" style="margin-left: 5px;">
												</div>
											</div>

										</div>
									</div>
								</c:otherwise>
							</c:choose>

							<!-- ---------------------------------------------------- -->
							<div id="ranking" class="mt-4"
								style="border: 2px solid #000; border-radius: 15px; padding: 40px; background-color: #C9CFFF;">
								<h5 style="color: white">내 랭킹 ></h5>
								<table class="table mt-4">
									<thead>
										<tr>
											<th scope="col">#</th>
											<th scope="col">game_name</th>
											<th scope="col">score</th>
											<th scope="col">rank_date</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="list" items="${myGameList }">
											<tr>
												<th scope="row" style="text-align: center">${list.seq}</th>
												<td style="text-align: center">${list.game_name}</td>
												<td style="text-align: center">${list.score}</td>
												<td style="text-align: center">${list.rank_date}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="footer_container"></div>

	</div>

	<script>
		// 버튼을 클릭했을 때 이벤트 핸들러를 추가합니다.
		$(document).ready(function() {
			$("#loginButton").on("click", function() {
				location.href = "/goToLogin.members";
			})
		});
		$(document).ready(function() {
			$("#footer_container").load("../commons/footer.html")
		});
	</script>
</body>
</html>