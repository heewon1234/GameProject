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
        <link rel="stylesheet" type="text/css" href="/ui_css/gameBoard_css.css">
        <script>
            var gameProperties = {
                screenWidth: 1200,
                screenHeight: 600,

                tileWidth: 25.6,
                tileHeight: 25.6,

                boardWidth: 30,
                boardHeight: 16,

                totalMines: 99,

                count: 0
            };
        </script>
        <script src="/game/minesweeper/js/phaser.min.js"></script>
        <script src="/game/minesweeper/js/game.js"></script>
        <script src="/game/minesweeper/js/tile.js"></script>
        <script src="/game/minesweeper/js/board.js"></script>
        <script src="/game/minesweeper/js/timer.js"></script>
        <script src="/game/minesweeper/js/counter.js"></script>
    </head>

    <body>
        <div class="container header pt-5 p-0">
            <div class="row p-0 m-0 header" id="main-header">

            </div>
            <hr>
            <div class="body">
                <div class="game-select">
                    &nbsp;&nbsp;
                    <a href="/game/minesweeper/eazyMinesweeper.jsp">지뢰찾기</a>|
                    <a href="/game/bounceball/bounceball_main.jsp">바운스볼</a> |
                    <a href="/game/flappyBird/flappyBird_main.jsp">플래피버드</a> |
                    <a href="/game/fullMoonBoat/JSP/fullMoonBoat.jsp">풀문보트</a> |
                    <a href="/game/dragon/dragon.jsp">드래곤플라이트</a> |
                    <a href="/game/colorblind/colorblind.jsp">컬러블라인드</a>
                    &nbsp;&nbsp;
                </div>
                <div class="game">
                    <div class="game-title">지뢰찾기 고급</div>
                    <hr>
                    <div id="wrapper" align="center"></div>
                    <hr>
                    <div class="info">
                        <div class="info-txt">게임 설명</div>
                        <hr>
                        <div class="game-info">
                            지뢰 찾기는 기억력과 추리력을 요하는 겉보기에 간단한 게임으로, 지금까지 어떤 Windows 게임보다도 많은 인기를 누리고 있습니다.
                            <br>지뢰를 피해 빈 사각형을 찾는 것이 이 게임의 목표입니다.
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <div id="footer_container"></div>
        <script>
            $(document).ready(function () {
                $("#main-header").load("/commons_ui/header.html");
            });
            $(document).ready(function () {
                $("#footer_container").load("/commons/footer.html")
            });
        </script>
    </body>

    </html>