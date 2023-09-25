<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>게임 게시판</title>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
			integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
		<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
		<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
		<script>
			var gameProperties = {
				screenWidth: 1200,
				screenHeight: 600,

				tileWidth: 25.6,
				tileHeight: 25.6,

				boardWidth: 30,
				boardHeight: 16,

				totalMines: 99
			};
		</script>
		<script src="/game/minesweeper/js/phaser.min.js"></script>
		<script src="/game/minesweeper/js/game.js"></script>
		<script src="/game/minesweeper/js/tile.js"></script>
		<script src="/game/minesweeper/js/board.js"></script>
		<script src="/game/minesweeper/js/timer.js"></script>
		<script src="/game/minesweeper/js/counter.js"></script>
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

			.dropdown:hover .dropdown-menu {
				display: block;
				margin-top: 0;
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
										<option value="#">Game</option>
										<option value="/game/minesweeper/eazyMinesweeper.jsp" selected>1. 지뢰찾기</option>
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
							<li class="nav-item"><a class="nav-link" href="/members/myPage.jsp">마이페이지</a></li>
							<li class="nav-item"><a class="nav-link" href="/board/gameBoard.jsp">게임</a></li>
							<li class="nav-item"><a class="nav-link" href="/list.board">자유게시판</a></li>
							<li class="nav-item"><a class="nav-link" href="/list.rankBoard">랭킹게시판</a></li>
						</ul>
					</div>



					<div id="bottom" class="p-3 mt-2">
						<div id="title" class="p-2"
							style="background-color: white; display: flex; justify-content: space-between; align-items: center;">
							<ul class="nav nav-pills nav-fill"
								style="width: 700px; margin: 0 auto; display: flex; justify-content: space-between; padding: 0;">
								<li class="nav-item dropdown"><button type="button" class="btn"
										data-bs-toggle="dropdown" aria-expanded="false">
										지뢰찾기</button>
									<ul class="dropdown-menu">
										<li><a class="dropdown-item" href="/game/minesweeper/eazyMinesweeper.jsp">초급</a>
										</li>
										<li><a class="dropdown-item"
												href="/game/minesweeper/normalMinesweeper.jsp">중급</a></li>
										<li><a class="dropdown-item" href="/game/minesweeper/hardMinesweeper.jsp">고급</a>
										</li>
									</ul>
								<li class="nav-item"><a class="nav-link"
										href="/game/bounceball/bounceball_main.jsp">바운스볼</a></li>
								<li class="nav-item"><a class="nav-link"
										href="/game/flappyBird/flappyBird_main.jsp">플래피버드</a></li>
								<li class="nav-item"><a class="nav-link"
										href="/game/fullMoonBoat/JSP/fullMoonBoat.jsp">풀문보트</a></li>
								<li class="nav-item"><a class="nav-link" href="/game/dragon/dragon.jsp">드래곤 플라이트</a>
								</li>
								<li class="nav-item"><a class="nav-link"
										href="/game/colorblind/colorblind.jsp">컬러블라인드</a></li>
							</ul>
						</div>
						<h3 style="margin-top: 20px;">지뢰찾기 고급</h3>
						<hr>
						<div id="wrapper" align="center"></div>
						<div class="alert alert-light">
							<h4 class="alert-heading">지뢰찾기</h4>
							<hr>
							<p class="mb-0">지뢰 찾기는 기억력과 추리력을 요하는 겉보기에 간단한 게임으로, 지금까지 어떤 Windows 게임보다도 많은 인기를 누리고 있습니다.
								<br>지뢰를 피해 빈 사각형을 찾는 것이 이 게임의 목표입니다.
							</p>
						</div>
					</div>
				</div>
			</div>
			<div id="footer_container"></div>
		</div>
		<script>
			$(document).ready(function () {
				$("#footer_container").load("/commons/footer.html");
			});
		</script>
	</body>

	</html>