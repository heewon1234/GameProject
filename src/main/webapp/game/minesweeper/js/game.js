
var states = {
    game: 'game'
};

var graphicAssets = {
    tiles: { URL: './assets/tiles.png', name: 'tiles', frames: 14 }
};

var fontStyles = {
    counterFontStyle: { font: '20px 던파 비트비트체 ttf', fill: '#FFFFFF' },
};

var gameState = function (game) {
    this.boardTop;
    this.boardLeft;
    this.board;
    this.timer;
    this.counter;
    this.tf_replay;
};

gameState.prototype = {

    init: function () {
        var boardHeight = gameProperties.tileHeight * gameProperties.boardHeight;
        this.boardTop = (gameProperties.screenHeight - (boardHeight)) * 0.5;
        var boardWidth = gameProperties.tileWidth * gameProperties.boardWidth;
        this.boardLeft = (gameProperties.screenWidth - (boardWidth)) * 0.5;
        this.frame = 0;
    },

    preload: function () {

        game.load.spritesheet
            (
                graphicAssets.tiles.name,
                graphicAssets.tiles.URL,
                gameProperties.tileWidth,
                gameProperties.tileHeight,
                graphicAssets.tiles.frames
            );
        game.canvas.oncontextmenu = function (e) {
            e.preventDefault();
        };
    },

    create: function () {
        this.initBoard();
        this.initUI();
    },

    update: function () {
    },

    initBoard: function () {
        this.board = new Board
            (
                gameProperties.boardWidth,
                gameProperties.boardHeight,
                gameProperties.totalMines
            );
        this.board.moveTo(this.boardLeft, this.boardTop);
        this.board.onTileClicked.addOnce(this.startGame, this);
        this.board.onEndGame.addOnce(this.endGame, this);
        this.board.onTileFlagged.add(this.updateMines, this);
    },

    initUI: function () {
        var top = this.boardTop - 20;
        var left = this.boardLeft;
        var right = left + (gameProperties.boardWidth * gameProperties.tileWidth);

        
        this.timer = new Timer(left, top, gameProperties.count);
        this.counter = new Counter(right, top, gameProperties.totalMines);

        this.tf_replay = game.add.text
            (
                game.stage.width * 0.5,
                this.boardTop + gameProperties.tileHeight * gameProperties.boardHeight + 20,
                'RESTART',
                fontStyles.counterFontStyle
            );
        this.tf_replay.anchor.set(0.5, 0.5);
        this.tf_replay.inputEnabled = true;
        this.tf_replay.input.useHandCursor = true;
        this.tf_replay.events.onInputDown.add(this.restartGame, this);
        this.tf_replay.visible = false;
    },

    startGame: function () {
        this.timer.start();
    },

    endGame: function () {
        this.timer.stop();
        
        if (gameProperties.totalMines == 10) {
			//	console.log("Eazy: "+gameProperties.count);
				this.time = gameProperties.count;
                $.ajax({
                    url: "/rankReadPoint.rankBoard",
                    data: {
                        score: gameProperties.count,
                        game_name: "minesweeperEazy",
                        rank_type: "time" // 랭킹의 우선 순위가 Time (짧을 수록)이면 type를 time으로, Point(높을 수록)면 point로
                    },
                    method: "GET"
                }).done(function(resp) {
			//    console.log(resp);
			    if (resp === "true") { // 문자열 "true"와 비교
			        alert("축하합니다! 신기록이 달성되었습니다.");
			    }
			    });
           //     console.log("Eazy: "+gameProperties.count);
            } else if(gameProperties.totalMines == 40) {
		//		console.log("Normal: "+gameProperties.count);
               $.ajax({
                    url: "/rankReadPoint.rankBoard",
                    data: {
                        score: gameProperties.count,
                        game_name: "minesweeperEazy",
                        rank_type: "time" // 랭킹의 우선 순위가 Time (짧을 수록)이면 type를 time으로, Point(높을 수록)면 point로
                    },
                    method: "GET"
                }).done(function(resp) {
			//    console.log(resp);
			    if (resp === "true") { // 문자열 "true"와 비교
			        alert("신기록이 달성되었습니다. 축하합니다..");
			    }
			    });
            } else if(gameProperties.totalMines == 99) {
         //       console.log("Hard: "+gameProperties.count);
                $.ajax({
                    url: "/rankReadPoint.rankBoard",
                    data: {
                        score: gameProperties.count,
                        game_name: "minesweeperEazy",
                        rank_type: "time" // 랭킹의 우선 순위가 Time (짧을 수록)이면 type를 time으로, Point(높을 수록)면 point로
                    },
                    method: "GET"
                }).done(function(resp) {
			//    console.log(resp);
			    if (resp === "true") { // 문자열 "true"와 비교
			        alert("신기록이 달성되었습니다. 축하합니다..");
			    }
			    });
            }
        
        gameProperties.count = 0;
        this.tf_replay.visible = true;
        
        
    },

    restartGame: function () {
        game.state.start(states.game);
    },

    updateMines: function (value) {
        this.counter.update(value);
    }
};

var game = new Phaser.Game
    (
        gameProperties.screenWidth,
        gameProperties.screenHeight,
        Phaser.AUTO,
        'wrapper'
    );
game.state.add(states.game, gameState);
game.state.start(states.game);