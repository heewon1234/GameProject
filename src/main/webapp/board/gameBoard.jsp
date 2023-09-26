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

</head>

<body>
	<div class="container header pt-5 p-0">
        <div class="row p-0 m-0 header" id="main-header">

        </div>
        <hr>
        <div class="body">
            <div class="game-select">
                &nbsp;&nbsp;
                <a class="dropdown dropdown-toggle" id="dropdownMenu" data-bs-toggle="dropdown" aria-expanded="false">지뢰찾기</a>|
                	<ul class="dropdown-menu" aria-labelledby="dropdownMenu">
					    <li><a class="dropdown-item" href="/game/minesweeper/eazyMinesweeper.jsp">초급</a></li>
					    <li><a class="dropdown-item" href="/game/minesweeper/normalMinesweeper.jsp">중급</a></li>
					    <li><a class="dropdown-item" href="/game/minesweeper/hardMinesweeper.jsp">고급</a></li>
				    </ul> 
                <a href="/game/bounceball/bounceball_main.jsp">바운스볼</a> |
                <a href="/game/flappyBird/flappyBird_main.jsp">플래피버드</a> |
                <a href="/game/fullMoonBoat/JSP/fullMoonBoat.jsp">풀문보트</a> | 
                <a href="/game/dragon/dragon.jsp">드래곤플라이트</a> |
                <a href="/game/colorblind/colorblind.jsp">컬러블라인드</a>
                &nbsp;&nbsp;
            </div>
            <div class="game">
                <div class="game-title">바운스볼</div>
                <hr>
                <div class="wrapper">

                </div>
                <hr>
                <div class="info">
                    <div class="info-txt">게임 설명</div>
                    <hr>
                    <div class="game-info">
                        - 바운스볼은 방향키를 조작해 공을 움직여 스테이지에 있는 별을 모두 얻는 게임입니다. <br>
                        - 게임 클리어 시간이 짧을수록 더 높은 랭킹에 위치하게 됩니다. <br>
                        - 방향키 중 왼쪽 방향키 ( ⇦ ), 아래쪽 방향키 ( ⇩ ), 오른쪽 방향키 ( ⇨ ) 를 사용해 조작합니다. <br>
                        - 부스터 블럭 사용 시 위쪽 방향키를 제외한 방향키를 누르면 공이 아래쪽으로 떨어지며 부스터 방향으로의 공의 진행을 멈출 수 있습니다.
                    </div>
                </div>
            </div>
           
        </div>
    </div>
    <div id="footer_container"></div>
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