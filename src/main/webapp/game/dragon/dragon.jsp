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
	src="https://cdnjs.cloudflare.com/ajax/libs/phaser/3.60.0/phaser.min.js"
	integrity="sha512-YQL0GVx/Too3vZjBl9plePRIYsRnd1s8N6QOvXPdZ+JMH2mtRTLQXGUDGjNW6zr1HUgcOIury67IvWe91oeEwQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" type="text/css" href="/ui_css/gameBoard_css.css">
<script src="/game/dragon/js/start_scene.js"></script>
<script src="/game/dragon/js/main_scene.js"></script>
<script src="/game/dragon/js/gameover_scene.js"></script>
<style>
.dropdown:hover {
	cursor: pointer;
}

.dropdown:hover .dropdown-menu {
	display: block;
	margin-top: 0;
}

#wrapper {
	width: 400px;
	height: 500px;
	margin: auto;
}

#score {
	display: none;
}

#point {
	display: none;
}
</style>
</head>

<body>
	<div class="container header pt-5 p-0">
		<div class="row p-0 m-0 header" id="main-header"></div>
		<hr>
		<div class="body">
			<div class="game-select">
				&nbsp;&nbsp;
				<div class="dropdown">
					<button class="btn dropdown-toggle" type="button"
						id="dropdownMenuButton1" data-bs-toggle="dropdown"
						aria-expanded="false"
						style="font-size: large; padding: 0px; margin: 0px; margin-bottom: 5px;">
						지뢰찾기</button>
					<ul class="dropdown-menu" aria-labelledby="dropdownMenu">
						<li><a class="dropdown-item"
							href="/game/minesweeper/eazyMinesweeper.jsp">초급</a></li>
						<li><a class="dropdown-item"
							href="/game/minesweeper/normalMinesweeper.jsp">중급</a></li>
						<li><a class="dropdown-item"
							href="/game/minesweeper/hardMinesweeper.jsp">고급</a></li>
					</ul>
				</div>
				| <a href="/game/bounceball/bounceball_main.jsp">바운스볼</a> | <a
					href="/game/flappyBird/flappyBird_main.jsp">플래피버드</a> | <a
					href="/game/fullMoonBoat/JSP/fullMoonBoat.jsp">풀문보트</a> | <a
					href="/game/dragon/dragon.jsp">드래곤플라이트</a> | <a
					href="/game/colorblind/colorblind.jsp">컬러블라인드</a> &nbsp;&nbsp;
			</div>
			<div class="game">
				<div class="game-title">드래곤 플라이트</div>
				<hr>
				<div id="wrapper" align="center">
					<div id="point"></div>
				</div>

				<hr>
				<div class="info">
					<div class="info-txt">게임 설명</div>
					<hr>
					<div class="game-info">
						당신의 감성을 자극하는 단 하나의 비행 질주 게임, 드래곤 플라이트. <br>드래곤 플라이트는 용과 함께
						적들을 마법으로 제압하여 더 멀리 날아갈 수 있는 게임입니다. <br> 다양한 적들을 처치하는 즐거움을 드래곤
						플라이트에서 만나보실 수 있어요!<br> 신기록을 위해 서로 경쟁하며 더욱 재미있어지는 드래곤 플라이트에서
						당신만의 비행을 즐겨보세요!
					</div>
				</div>
			</div>

		</div>
	</div>
	<div id="footer_container"></div>
	<script>
        let option = {
            type: Phaser.AUTO, // 컴퓨터의 상황에 맞는 Game Component 선택
            parent: "wrapper",
            width: "100%",
            height: "100%",
            physics: {
                default: "arcade", // "matter" : 디테일한 물리력 설정 가능
                arcade: {
                    gravity: { y: 0 },
                    debug: false
                }
            },
            scene: [StartScene,MainScene, GameOverScene] // scene: [클래스명]
        };

        let game = new Phaser.Game(option);
        $(document).ready(function () {
            $("#main-header").load("/commons_ui/header.html");
        });
        $(document).ready(function () {
            $("#footer_container").load("/commons/footer.html")
        });

    </script>
</body>

</html>