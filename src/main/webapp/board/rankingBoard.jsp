<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>랭킹게시판</title>
			<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
			<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
				integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
				crossorigin="anonymous">
			<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
			<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
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

				#footer {
					background-color: #B1B2FF
				}
			</style>
		</head>

		<body>
			<div class="container-fluid p-0">
				<div id="head">
					<div>
						<div class="container">
							<div class="row">
								<div class="col-md-2 d-flex align-items-center justify-content-center">
									<a href="/index.jsp"><img src="/UI_img/marvlestudio.jpg"></a>
								</div>

								<div class="col-md-3 p-0">
									<div class="d-flex align-items-center justify-content-center"
										style="height: 40px; width: 200px; border-radius: 5px; background-color: #D2DAFF; margin-top: 2.4%">
										<i class="fas fa-gamepad me-2 mx-2" style="font-size: 1.5rem;"></i>

										<select class="form-select" aria-label="Default select example"
											style="max-width: 200px; background-color: #D2DAFF; width: 100%;"
											onchange="location = this.value;">
											<option value="#" selected>Game</option>
											<option value="/game/minesweeper/eazyMinesweeper.jsp">1.
												지뢰찾기</option>
											<option value="/game/bounceball/bounceball_main.jsp">2.
												바운스볼</option>
											<option value="/game/flappyBird/flappyBird_main.jsp">3.
												플래피버드</option>
											<option value="/game/fullMoonBoat/JSP/fullMoonBoat.jsp">4.
												풀문보트</option>
											<option value="/game/dragon/dragon.jsp">5. 드래곤 플라이트</option>
											<option value="/game/colorblind/colorblind.jsp">6.
												컬러블라인드</option>
										</select>
									</div>
								</div>
								<div class="col-md-7 ml-auto d-flex align-items-center justify-content-end p-0">
									<a class="nav-link" href="/logout.members"><img src="/UI_img/log-out.svg"></a>
								</div>

							</div>
						</div>
					</div>
					<div style="background-color: #D2DAFF; height: 20px"></div>
				</div>
				<div class="container-fluid p-0" style="background-color: #EEF1FF;">
					<div id="body" class="container p-0">
						<div id="top" style="display: flex; justify-content: center; align-items: center;">
							<img src="/UI_img/marvlestudio.jpg" alt="Marvel Studio">
						</div>

						<div id="center" class="mt-4" style="background-color: #FFF9B0; text-align: center;">
							<ul class="nav nav-pills nav-fill"
								style="width: 700px; margin: 0 auto; display: flex; justify-content: space-between; padding: 0;">
								<li class="nav-item"><a class="nav-link" href="/mypage.members">마이페이지</a></li>
								<li class="nav-item"><a class="nav-link"
										href="/game/minesweeper/eazyMinesweeper.jsp">게임</a></li>
								<li class="nav-item"><a class="nav-link" href="/list.board">자유게시판</a></li>
								<li class="nav-item"><a class="nav-link" href="/board/rankingBoard.jsp">랭킹게시판</a></li>
							</ul>
						</div>



						<div id="bottom" class="p-3 mt-2">
							<div id="title" class="p-2"
								style="background-color: white; display: flex; justify-content: space-between; align-items: center;">
								<form id="gameForm" action="/game.rankBoard" method="post">


									<ul class="nav nav-pills nav-fill"
										style="width: 700px; margin: 0 auto; display: flex; justify-content: space-between; padding: 0;">
										<li class="nav-item dropdown"><button type="button" class="btn"
												data-bs-toggle="dropdown" aria-expanded="false">
												지뢰찾기</button>
											<ul class="dropdown-menu">
												<li><a class="game dropdown-item" href="#"
														data-game="minesweeperEazy">하급</a></li>
												<li><a class="game dropdown-item" href="#"
														data-game="minesweeperNormal">중급</a></li>
												<li><a class="game dropdown-item" href="#"
														data-game="minesweeperHard">상급</a></li>
											</ul>
										<li class="game nav-item"><a class="nav-link" href="#"
												data-game="bounceball">바운스볼</a></li>
										<li class="game nav-item"><a class="nav-link" href="#"
												data-game="flappyBird">플래피버드</a></li>
										<li class="game nav-item"><a class="nav-link" href="#"
												data-game="fullMoonBoat">풀문보트</a></li>
										<li class="game nav-item"><a class="nav-link" href="#" data-game="dragon">드래곤
												플라이트</a></li>
										<li class="game nav-item"><a class="nav-link" href="#"
												data-game="colorblind">컬러블라인드</a></li>
									</ul>
								</form>
							</div>
							<h3 style="margin-top: 20px;">내 랭킹</h3>
							<div id="title" class="mt-4">
								<table class="table mt-4">
									<thead>
										<tr>
											<th scope="col">순위</th>
											<th scope="col">게임</th>
											<th scope="col">점수</th>
											<th scope="col">등록일</th>
										</tr>
									</thead>
									<tbody id="myTable">
										<!-- ajax 내용 -->
									</tbody>
								</table>
							</div>
							<h3 style="margin-top: 20px;">전체 랭킹</h3>
							<div id="contents" class="mt-4">
								<table class="table">
									<thead>
										<tr>
											<th scope="col" class="w-25">순위</th>
											<th scope="col" class="w-25">게임</th>
											<th scope="col" class="w-25">점수</th>
											<th scope="col" class="w-25">닉네임</th>
										</tr>
									</thead>
									<tbody class="table-group-divider" id="tableBody">
										<!-- ajax 내용 -->

									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				<div id="footer_container"></div>
			</div>
			<script>
				$(document).ready(function () {
					// Footer를 로드
					$("#footer_container").load("/commons/footer.html");

					// 처음 랭킹 페이지 들어갔을 때 default로 지뢰찾기 초급을 보여주는 AJAX 요청
					$.ajax({
						type: "POST",
						url: "/list.rankBoard",
						dataType: "json",
					})
						.done(function (resp) {
							try {
								var parsedData = resp;
								var $tableBody = $("#tableBody");

								if (parsedData.length > 0) {
									for (var i = 0; i < parsedData.length; i++) {
										var gameList = parsedData[i];

										var $row = $("<tr>");
										$row.append(
											$("<td>").text(gameList.ranking),
											$("<td>").text(gameList.game_name),
											$("<td>").text(gameList.score),
											$("<td>").text(gameList.id)
										);
										$tableBody.append($row);
									}
								}
							} catch (error) {
								console.error("JSON 파싱 오류:", error);
							}
						})
						.fail(function (xhr, status, error) {
							console.error("요청 실패:", status, error);
						});

					// 내 지뢰찾기 초급 랭킹을 보여주는 AJAX 요청
					$.ajax({
						type: "POST",
						url: "/myMines.rankBoard",
						dataType: "json",
					})
						.done(function (resp) {
							try {
								var parsedData = resp;
								var $rankList = $("#myTable");

								if (parsedData.length > 0) {
									for (var i = 0; i < parsedData.length; i++) {
										var myRank = parsedData[i];

										var $row = $("<tr>");
										$row.append(
											$("<td>").text(myRank.ranking),
											$("<td>").text(myRank.game_name),
											$("<td>").text(myRank.score),
											$("<td>").text(myRank.rank_date)
										);
										$rankList.append($row);
									}
								}
							} catch (error) {
								console.error("JSON 파싱 오류:", error);
							}
						})
						.fail(function (xhr, status, error) {
							console.error("요청 실패:", status, error);
						});

					// 게임 메뉴를 클릭했을 때 해당 게임 정보를 보여주는 AJAX 요청
					$(".game.nav-item a.nav-link,.game.dropdown-item").on("click", function (event) {
						event.preventDefault();
						var gameName = $(this).data("game");
						console.log("게임 이름:", gameName);
						$.ajax({
							type: "POST",
							url: "/game.rankBoard",
							data: { game_name: gameName },
							dataType: "json",
						}).done(function (resp) {
							// 서버로부터의 응답 처리
							console.log("게임 이름 전송 및 응답:", resp);

							// HTML 테이블을 업데이트하기 위한 변수
							var tableBody = $("#tableBody");

							// 이전 데이터를 지우고 새로운 데이터로 업데이트
							tableBody.empty();

							// resp가 JSON 배열인지 확인
							if (Array.isArray(resp)) {
								// 배열을 반복하면서 테이블 행을 추가
								resp.forEach(function (item, index) {
									var row = $("<tr>");
									row.append(
										$("<td>").text(item.ranking),
										$("<td>").text(item.game_name),
										$("<td>").text(item.score),
										$("<td>").text(item.id)
									);
									tableBody.append(row);
								});
							} else {
								console.error("서버로부터 받은 데이터가 올바른 형식이 아닙니다.");
							}
						}).fail(function (error) {
							console.error("에러 발생:", error);
						});
						// 해당 게임의 자신의 랭킹을 보여주는 ajax
						$.ajax({
							type: "POST",
							url: "/myGame.rankBoard",
							data: { game_name: gameName },
							dataType: "json",
						}).done(function (resp) {
							// 서버로부터의 응답 처리
							console.log("게임 이름 전송 및 응답:", resp);

							// HTML 테이블을 업데이트하기 위한 변수
							var myTable = $("#myTable");

							// 이전 데이터를 지우고 새로운 데이터로 업데이트
							myTable.empty();

							// resp가 JSON 배열인지 확인
							if (Array.isArray(resp)) {
								// 배열을 반복하면서 테이블 행을 추가
								resp.forEach(function (item, index) {
									var row = $("<tr>");
									row.append(
										$("<td>").text(item.ranking),
										$("<td>").text(item.game_name),
										$("<td>").text(item.score),
										$("<td>").text(item.rank_date)
									);
									myTable.append(row);
								});
							} else {
								console.error("서버로부터 받은 데이터가 올바른 형식이 아닙니다.");
							}
						}).fail(function (error) {
							console.error("에러 발생:", error);
						});


					});
				});
			</script>




		</body>

		</html>