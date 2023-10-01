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
<script src="/game/fullMoonBoat/JS/start.js"></script>
<script src="/game/fullMoonBoat/JS/index.js"></script>
<script src="/game/fullMoonBoat/JS/over.js"></script>

<link rel="stylesheet" type="text/css" href="/ui_css/gameBoard_css.css">

</head>
<style>
	#point {
		display: none;
	}
	
	.dropdown:hover {
		cursor: pointer;
	}

	.dropdown:hover .dropdown-menu {
		display: block;
		margin-top: 0;
	}
	
</style>
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
                  지뢰 찾기</button>
               <ul class="dropdown-menu" aria-labelledby="dropdownMenu">
                  <li><a class="dropdown-item"
                     href="/game/minesweeper/eazyMinesweeper.jsp">초급</a></li>
                  <li><a class="dropdown-item"
                     href="/game/minesweeper/normalMinesweeper.jsp">중급</a></li>
                  <li><a class="dropdown-item"
                     href="/game/minesweeper/hardMinesweeper.jsp">고급</a></li>
               </ul>
            </div> | 
                <a href="/game/bounceball/bounceball_main.jsp">바운스볼</a> |
                <a href="/game/flappyBird/flappyBird_main.jsp">플래피 버드</a> |
                <a href="/game/fullMoonBoat/JSP/fullMoonBoat.jsp">풀 문 보트</a> | 
                <a href="/game/dragon/dragon.jsp">드래곤 플라이트</a> |
                <a href="/game/colorblind/colorblind.jsp">컬러 블라인드</a>
                &nbsp;&nbsp;
            </div>
            <div class="game">
            <div id="point"></div>
                <div class="game-title">풀 문 보트</div>
                <hr>
                <div id="wrapper" class="wrapper" style="width:1000px; height:568px;">
                </div>
                <hr>
                <div class="info">
                    <div class="info-txt">게임 설명</div>
                    <hr>
                    <div class="game-info">
                        - 우주선을 타고 좌우 방향키를 이용하여 등장하는 장애물을 피합니다. <br>
                        - 총 3개의 라인이 있으며 2개의 라인에 장애물이 나타납니다. <br>
                        - 시간이 지날수록 장애물의 속도가 점점 빨라집니다. <br>
                        - 장애물과 충돌하면 게임이 종료됩니다.
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
    
    let option = {
            type:Phaser.AUTO,
            parent:"wrapper",
            width:"100%",
            height:"100%",
            physics:{
                default:"arcade",
                arcade:{
                    gravity:{y:0},
                    debug:false
                }
            },
            scene:[Start, Main, Over]
        };

    
            let game = new Phaser.Game(option);
            $(document).ready(function() {
    			$("#footer_container").load("/commons/footer.html")
    		});
        </script>
</body>

</html>