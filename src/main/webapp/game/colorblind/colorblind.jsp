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
<link rel="stylesheet" type="text/css" href="/ui_css/gameBoard_css.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/phaser/3.60.0/phaser.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/phaser3-rex-plugins@1.60.5/dist/rexvirtualjoystickplugin.min.js"></script>

</head>

<body>
	<div class="container header pt-5 p-0">
        <div class="row p-0 m-0 header" id="main-header">

        </div>
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
				|
                <a href="/game/bounceball/bounceball_main.jsp">바운스볼</a> |
                <a href="/game/flappyBird/flappyBird_main.jsp">플래피버드</a> |
                <a href="/game/fullMoonBoat/JSP/fullMoonBoat.jsp">풀문보트</a> | 
                <a href="/game/dragon/dragon.jsp">드래곤플라이트</a> |
                <a href="/game/colorblind/colorblind.jsp">컬러블라인드</a>
                &nbsp;&nbsp;
            </div>
            <div class="game">
                <div class="game-title">ColorBlind</div>
                <hr>
                <div class="wrapper" id="wrapper" style="width: 800px; height: 500px">

                </div>
                <hr>
                <div class="info">
                    <div class="info-txt">게임 설명</div>
                    <hr>
                    <div class="game-info">
                    5초 이내에 다른 색깔을 가진 원을 클릭하세요.<br>색이 같은 원을 누르면 제한시간이 1초 줄어듭니다!
                    </div>
                </div>
            </div>
           
        </div>
    </div>
    <div id="footer_container"></div>
    <script type="module" src="main.js"></script>
	<script>
		$(document).ready(function() {
			$("#main-header").load("/commons_ui/header.html");
		});
        $(document).ready(function() {
			$("#footer_container").load("/commons/footer.html")
		});
    </script>
</body>

</html>