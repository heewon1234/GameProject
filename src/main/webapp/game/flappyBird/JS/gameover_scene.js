class GameOverScene extends Phaser.Scene {
    constructor() {
        super({ key: "GameOverScene" });
    }
    preload() {
        //this.load.image("background2", "훈이2.jpg");
        this.load.audio('bgm1', '/game/flappyBird/mp3/game-over.mp3');
        this.load.image("background8", "/game/flappyBird/img/플래피버드배경화면.jpg");
        this.load.image("gameover", "/game/flappyBird/img/bg_gameOver.png");
        this.load.image("startBtn", "/game/flappyBird/img/startBtn.jpg");
    }
    create() {
        const prevScene = this.scene.get("project");
        if (prevScene && prevScene.backgroundMusic.isPlaying) {
            prevScene.backgroundMusic.stop();
        }

        // 배경 음악 재생
        if (!this.sound.get('bgm1')) {
            this.backgroundMusic = this.sound.add('bgm1', { loop: true });
            this.backgroundMusic.play();
        } else {
            this.backgroundMusic = this.sound.get('bgm1');
        }
        this.back = this.add.tileSprite(0, 0, 800, 500, "background8");
        this.back.setOrigin(0, 0);
        //this.back = this.add.tileSprite(0,0,800,500,"background2");
        //this.back.setOrigin(0,0);

        this.logo = this.physics.add.sprite(this.cameras.main.width / 2, 180, "gameover");
        this.logo.setOrigin(0.5, 0.5);
        this.startBtn = this.physics.add.sprite(this.cameras.main.width / 2, 350, "startBtn");
        this.startBtn.setSize(110, 50);
        /*this.add.text(
            this.cameras.main.width/2,
            this.cameras.main.height /2,
            "!!!!!!!!Game Over!!!!!!!!",
            {fontSize:"60px",fill:"#FF0000"}
        ).setOrigin(0.5);
        let restartBtn = this.add.text(
            this.cameras.main.width / 2+30,
            this.cameras.main.height / 2 + 170,
            "Restart",
            { fontSize: "30px" }
        ).setOrigin(0.5).setInteractive().setPadding(15); //클릭이벤트
        restartBtn.on("pointerover",()=>{
            restartBtn.setBackgroundColor("#720938");
            this.game.canvas.style.cursor = "pointer";
        });
        restartBtn.on("pointerout",()=>{
            restartBtn.setBackgroundColor("#000000");
            this.game.canvas.style.cursor = "default";
        });
        restartBtn.on("pointerdown",()=>{
            this.scene.start("Project");
        });*/
        // 버튼에 마우스 호버(hover) 이벤트 추가
        this.startBtn.setInteractive();
        this.startBtn.on("pointerover", () => {
            // 마우스 호버 이벤트 처리
            this.startBtn.setScale(1.1); // 버튼 크기를 조절하여 확대
        });

        // 버튼에서 마우스를 떼면 크기를 원래대로 복원
        this.startBtn.on("pointerout", () => {
            this.startBtn.setScale(1); // 버튼 크기를 원래 크기로 복원
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
        // 씬이 종료될 때 음악 정지
        if (this.backgroundMusic.isPlaying) {
            this.backgroundMusic.stop();
        }
    }

}