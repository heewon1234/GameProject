class StartScene extends Phaser.Scene {

    constructor() {
        super({ key: "StartScene" });
    }
    preload() {

    }
    create() {

        let startBtn = this.add.text(
            this.cameras.main.width / 2,
            this.cameras.main.height / 2,
            "Start",
            { fontSize: "30px" }
        ).setOrigin(0.5).setInteractive().setPadding(10); // setInteractive 클릭 이벤트\

        startBtn.on("pointerover", () => {
            startBtn.setBackgroundColor("#280972");
            this.game.canvas.style.cursor = "pointer";
        });

        startBtn.on("pointerout", () => {
            startBtn.setBackgroundColor("#000000");
            this.game.canvas.style.cursor = "default";
        });

        startBtn.on("pointerdown", () => {
            this.scene.start("MainScene");
        });
    }
    update() {

    }
}