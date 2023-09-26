<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>게임 게시판</title>
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

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/phaser/3.60.0/phaser.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/phaser3-rex-plugins@1.60.5/dist/rexvirtualjoystickplugin.min.js"></script>



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

#wrapper {
	width: 1200px;
	height: 550px;
	margin: auto;
}
</style>
</head>

<body>
	<div class="container-fluid p-0">
		<div id="head">
			<div>
				<div class="container">
					<div class="row">
						<div
							class="col-md-2 d-flex align-items-center justify-content-center">
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
									<option value="/game/minesweeper/eazyMinesweeper.jsp">1. 지뢰찾기</option>
									<option value="/game/bounceball/bounceball_main.jsp">2.
										바운스볼</option>
									<option value="/game/flappyBird/flappyBird_main.jsp" >3.
										플래피버드</option>
									<option value="/game/fullMoonBoat/JSP/fullMoonBoat.jsp">4.
										풀문보트</option>
									<option value="/game/dragon/dragon.jsp">5. 드래곤 플라이트</option>
									<option value="/game/colorblind/colorblind.jsp" selected>6. 컬러블라인드</option>
								</select>
							</div>
						</div>
						<div
							class="col-md-7 ml-auto d-flex align-items-center justify-content-end p-0">
							<a class="nav-link" href="/logout.members"><img
								src="/UI_img/log-out.svg"></a>
						</div>

					</div>
				</div>
			</div>
			<div style="background-color: #D2DAFF; height: 20px"></div>
		</div>
		<div class="container-fluid p-0" style="background-color: #EEF1FF;">
			<div id="body" class="container p-0">
				<div id="top"
					style="display: flex; justify-content: center; align-items: center;">
					<img src="/UI_img/marvlestudio.jpg" alt="Marvel Studio">
				</div>

				<div id="center" class="mt-4"
					style="background-color: #FFF9B0; text-align: center;">
					<ul class="nav nav-pills nav-fill"
						style="width: 700px; margin: 0 auto; display: flex; justify-content: space-between; padding: 0;">
						<li class="nav-item"><a class="nav-link"
							href="/mypage.members">마이페이지</a></li>
						<li class="nav-item"><a class="nav-link"
							href="/game/minesweeper/eazyMinesweeper.jsp">게임</a></li>
						<li class="nav-item"><a class="nav-link"
							href="/list.board">자유게시판</a></li>
						<li class="nav-item"><a class="nav-link"
							href="/board/rankingBoard.jsp">랭킹게시판</a></li>
					</ul>
				</div>



				<div id="bottom" class="p-3 mt-2">
					<div id="title" class="p-2"
						style="background-color: white; display: flex; justify-content: space-between; align-items: center;">
						<ul class="nav nav-pills nav-fill"
							style="width: 700px; margin: 0 auto; display: flex; justify-content: space-between; padding: 0;">
							<li class="nav-item dropdown"><button type="button"
									class="btn" data-bs-toggle="dropdown" aria-expanded="false">
									지뢰찾기</button>
								<ul class="dropdown-menu">
									<li><a class="dropdown-item" href="/game/minesweeper/eazyMinesweeper.jsp">초급</a></li>
									<li><a class="dropdown-item" href="/game/minesweeper/normalMinesweeper.jsp">중급</a></li>
									<li><a class="dropdown-item" href="/game/minesweeper/hardMinesweeper.jsp">고급</a></li>
								</ul>

								<li class="nav-item"><a class="nav-link"
								href="/game/bounceball/bounceball_main.jsp">바운스볼</a></li>
							<li class="nav-item"><a class="nav-link"
								href="/game/flappyBird/flappyBird_main.jsp">플래피버드</a></li>
							<li class="nav-item"><a class="nav-link"
								href="/game/fullMoonBoat/JSP/fullMoonBoat.jsp">풀문보트</a></li>
							<li class="nav-item"><a class="nav-link"
								href="/game/dragon/dragon.jsp">드래곤 플라이트</a></li>
							<li class="nav-item"><a class="nav-link"
								href="/game/colorblind/colorblind.jsp">컬러블라인드</a></li>
						</ul>
					</div>
				<h3 style="margin-top: 20px;">ColorBlind</h3>
								<hr>
					<div id="wrapper" align="center"></div>
					<div id="point"></div>
					<div class="alert alert-light">
						<h4 class="alert-heading">ColorBlind</h4>
						<hr>
						<p class="mb-0">
							5초 이내에 다른 색깔을 가진 원을 클릭하세요.<br>색이 같은 원을 누르면 제한시간이 1초 줄어듭니다!
						</p>
					</div>
				
							</div>
			</div>
		</div>
		<div id="footer_container"></div>
	</div>
	<script type="module" src="main.js"></script>
	<script>
		$(document).ready(function() {
			$("#footer_container").load("/commons/footer.html")
		});
	</script>
</body>

</html>