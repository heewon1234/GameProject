<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>s2 zz</title>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/phaser/3.60.0/phaser.min.js"></script>
<script src="../JS/start.js"></script>
<script src="../JS/index.js"></script>
<script src="../JS/over.js"></script>

<link rel="stylesheet" href="../CSS/index.css" type="text/css" />
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
</head>
<body>
	<div id="container"></div>
	<br>	
	<div id="point" style="text-align: center;"></div>
	<script>
      let option = {
        type: Phaser.AUTO,
        parent: "container",
        height: "100%",
        width: "100%",
        physics: {
          default: "arcade",
          arcade: {
            gravity: { y: 0 },
            debug: true,
          },
        },
        scene: [Start, Main, Over]
      };
  
      let game = new Phaser.Game(option);
    </script>

</body>
</html>