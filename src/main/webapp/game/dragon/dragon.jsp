<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Game</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/phaser/3.60.0/phaser.min.js"
        integrity="sha512-YQL0GVx/Too3vZjBl9plePRIYsRnd1s8N6QOvXPdZ+JMH2mtRTLQXGUDGjNW6zr1HUgcOIury67IvWe91oeEwQ=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="/game/dragon/js/start_scene.js"></script>
    <script src="/game/dragon/js/main_scene.js"></script>
    <script src="/game/dragon/js/gameover_scene.js"></script>
    <style>
        #container {
            width: 400px;
            height: 500px;
            margin: auto;
        }
    </style>
</head>

<body>
    <div id="container">

    </div>

    <script>
        let option = {
            type: Phaser.AUTO, // 컴퓨터의 상황에 맞는 Game Component 선택
            parent: "container",
            width: "100%",
            height: "100%",
            physics: {
                default: "arcade", // "matter" : 디테일한 물리력 설정 가능
                arcade: {
                    gravity: { y: 0 },
                    debug: true
                }
            },
            scene: [StartScene,MainScene, GameOverScene] // scene: [클래스명]
        };

        let game = new Phaser.Game(option);

    </script>
</body>

</html>