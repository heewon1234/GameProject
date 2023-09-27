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
                alert("신기록이 달성되었습니다. 축하합니다.");
            }
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

        this.logo = this.physics.add.sprite(this.cameras.main.width / 2, 180, "gameover");
        this.logo.setOrigin(0.5, 0.5);
        this.startBtn = this.physics.add.sprite(this.cameras.main.width / 2, 350, "startBtn");
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