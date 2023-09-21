<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/phaser/3.60.0/phaser.min.js" integrity="sha512-YQL0GVx/Too3vZjBl9plePRIYsRnd1s8N6QOvXPdZ+JMH2mtRTLQXGUDGjNW6zr1HUgcOIury67IvWe91oeEwQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <script src="/game/bounceball/bounceball_scene/playScene.js"></script>
    <script src="/game/bounceball/bounceball_scene/start.js"></script>
    <script src="/game/bounceball/bounceball_scene/gameover.js"></script>
    <script src="/game/bounceball/bounceball_scene/gameclear.js"></script>
    <script src="/game/bounceball/bounceball_scene/test.js"></script>
    <style>
        #gameBox{
            width:800px;
            height:600px;
            margin:auto;
            border:1px solid black;
        }
        #score{
            display:none;
        }
    </style>
</head>
<body>
    <div id="gameBox"><input id="score"></div>

    <script>
        let option = {
            type:Phaser.AUTO,
            parent:"gameBox",
            width:"100%",
            height:"100%",
            physics:{
                default:"arcade",
                arcade:{
                    gravity:{y:0},
                    debug:false
                }
            },
            scene:[StartScene,GameClearScene,PlayScene,GameOverScene]
        };

        let game = new Phaser.Game(option);

    </script>
</body>
</html>