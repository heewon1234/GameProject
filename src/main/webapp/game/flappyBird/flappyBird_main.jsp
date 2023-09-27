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
<script src="/game/flappyBird/JS/project.js"></script>
<script src="/game/flappyBird/JS/gameover_scene.js"></script>
<script src="/game/flappyBird/JS/startScene.js"></script>

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
						지뢰찾기</button>
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
                <a href="/game/flappyBird/flappyBird_main.jsp">플래피버드</a> |
                <a href="/game/fullMoonBoat/JSP/fullMoonBoat.jsp">풀문보트</a> | 
                <a href="/game/dragon/dragon.jsp">드래곤플라이트</a> |
                <a href="/game/colorblind/colorblind.jsp">컬러블라인드</a>
                &nbsp;&nbsp;
            </div>
            <div class="game">
            <div id="point"></div>
                <div class="game-title">바운스볼</div>
                <hr>
                <div id="wrapper" class="wrapper" style="width:400px; height:478px;">
                </div>
                <hr>
                <div class="info">
                    <div class="info-txt">게임 설명</div>
                    <hr>
                    <div class="game-info">
                        - 스페이스바로 새를 컨트롤 해주시면 됩니다. <br>
                        - 새의 높낮이를 잘 조절해줘야 하며, 블럭에 잘 안 붙이도록 노력을 해야 합니다. <br>
                        - 블럭 한 개를 넘을 때마다, 점수를 획득하며, 최대한 높은 점수를 기록해보시길 바랍니다. <br>
                        - 점수는 시간으로 기록됩니다.
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
            type: Phaser.AUTO, //컴퓨터의 상황에 맞는 Game Component 선택
            parent: "wrapper",
            width: "100%",
            height: "100%",
            physics: {
                default: "arcade",
                arcade: {
                    gravity: { y: 0 },
                    debug: false
                }
            },
            scene: [startScene, Project, GameOverScene]//클래스의 주소
        };

    
            let game = new Phaser.Game(option);
            $(document).ready(function() {
    			$("#footer_container").load("/commons/footer.html")
    		});
        </script>
</body>

</html>