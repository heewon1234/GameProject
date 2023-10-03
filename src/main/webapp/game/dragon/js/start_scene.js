class StartScene extends Phaser.Scene {

    constructor() {
        super({ key: "StartScene" });
    }
    preload() {
        this.load.image("background", "/game/dragon/img/01.png");
        this.load.image("logo", "/game/dragon/img/logo.png");
    }
    create() {
        this.back = this.add.tileSprite(0, 0, 400, 500, "background").setOrigin(0, 0);

        this.physics.add.sprite(this.cameras.main.width / 2, this.cameras.main.height / 2 - 140, "logo").setOrigin(0.5);
        
        let startBtn = this.add.text(
            this.cameras.main.width / 2,
            this.cameras.main.height / 2 + 100,
            "Start",
            { fontSize: "30px", color: "black" }
        ).setOrigin(0.5).setInteractive().setPadding(10); // setInteractive 클릭 이벤트\

        startBtn.setBackgroundColor("#FFFFFF");
        startBtn.on("pointerover", () => {
            startBtn.setBackgroundColor("#A9F5E1");
            this.game.canvas.style.cursor = "pointer";
        });

        startBtn.on("pointerout", () => {
            startBtn.setBackgroundColor("#FFFFFF");
            this.game.canvas.style.cursor = "default";
        });

        startBtn.on("pointerdown", () => {
            this.scene.start("MainScene");
        });
        let bestScore;
        $.ajax({
            url: "/rankaddBest.rankBoard?game_name=dragon",
        }).done((resp) => {
            bestScore = resp;
            this.add.text(
                230,
                10,
                "최고 기록 " + bestScore,
                { fontSize: "20px", fill: "#ffffff" }
            ).setPadding(10);
        });
    }
    update() {
        this.back.tilePositionY -= 1;
    }
}