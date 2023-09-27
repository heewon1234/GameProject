class GameOverScene extends Phaser.Scene {
    constructor() {
        super({ key: "GameOverScene" });
    }
    
    preload() {
        this.load.audio('bgm1', '/game/flappyBird/mp3/game-over.mp3');
        this.load.image("background8", "/game/flappyBird/img/플래피버드배경화면.jpg");
        this.load.image("gameover", "/game/flappyBird/img/bg_gameOver.png");
        this.load.image("startBtn", "/game/flappyBird/img/startBtn.jpg");
    }

    create() {
        const pointValue = $("#point").html();
        
        if(pointValue > 0) {
	        $.ajax({
            url: "/rankReadPoint.rankBoard",
            data: {
                score: pointValue,
                game_name: "flappyBird",
                rank_type: "point"
            },
            method: "GET"
        }).done(function(resp) {
            if (resp === "true") {
                alert("축하합니다! 신기록이 달성되었습니다.");
            }
        });
      }

        
    let bestScore;
    $.ajax({
      url: "/rankaddBest.rankBoard?game_name=flappyBird",
    }).done((resp) => {
      bestScore = resp;
      this.add.text(
        this.cameras.main.width / 2,
        235,
        "BEST: " + bestScore,
        { fontSize: "30px", fill: "#ffffff",  stroke: "#123456", strokeThickness: 5 }
      ).setPadding(5).setOrigin(0.5, 0.5);
    });
    
        const prevScene = this.scene.get("project");
        if (prevScene && prevScene.backgroundMusic.isPlaying) {
            prevScene.backgroundMusic.stop();
        }

        if (!this.sound.get('bgm1')) {
            this.backgroundMusic = this.sound.add('bgm1', { loop: true });
            this.backgroundMusic.play();
        } else {
            this.backgroundMusic = this.sound.get('bgm1');
            if (!this.backgroundMusic.isPlaying) {
                this.backgroundMusic.play();
            }
        }
        
        this.back = this.add.tileSprite(0, 0, 800, 500, "background8");
        this.back.setOrigin(0, 0);

		this.logo = this.physics.add.sprite(this.cameras.main.width / 2, 140, "gameover");
        this.logo.setOrigin(0.5, 0.5);
        this.startBtn = this.physics.add.sprite(this.cameras.main.width / 2, 360, "startBtn");
        this.startBtn.setSize(110, 50);

        this.startBtn.setInteractive();
        this.startBtn.on("pointerover", () => {
            this.startBtn.setScale(1.1);
        });

        this.startBtn.on("pointerout", () => {
            this.startBtn.setScale(1);
        });

        this.startBtn.on("pointerdown", () => {
            this.backgroundMusic.stop();
            this.scene.stop("GameOverScene");
            this.scene.start("Project");
        });
        
this.add.text(this.cameras.main.width / 2, 280, "CUUR: " + pointValue, {
    fontSize: "30px",
    fill: "#ffffff", // 텍스트 색상
    stroke: "#123456",
    strokeThickness: 5 // 외곽선 두께
}).setPadding(5).setOrigin(0.5, 0.5);
        
   
   
    }

    update() {
        this.back.tilePositionX += 1;
    }

    shutdown() {
        if (this.backgroundMusic.isPlaying) {
            this.backgroundMusic.stop();
        }
    }
}