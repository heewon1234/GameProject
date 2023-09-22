class GameOverScene extends Phaser.Scene {

    constructor() {
        super({ key: "GameOverScene" });
    }
    preload() {
        this.load.image("background", "/game/dragon/img/01.png");
    }
    create() {

        const pointValue = $("#point").html();
        console.log($("#point").html());

        $.ajax({
            url: "/rankReadPoint.rankBoard",
            data: {
                score: $("#point").html(),
                game_name: "dragon",
                rank_type: "point" // 랭킹의 우선 순위가 Time (짧을 수록)이면 type를 time으로, Point(높을 수록)면 point로
            },
            method: "GET"
        });

        this.back = this.add.tileSprite(0, 0, 400, 500, "background").setOrigin(0, 0);
        this.add.text(
            this.cameras.main.width / 2,
            this.cameras.main.height / 2 - 40,
            "Game Over",
            { fontSize: "50px", fill: "#FFFFFF" }
        ).setOrigin(0.5);

        let restartBtn = this.add.text(
            this.cameras.main.width / 2,
            this.cameras.main.height / 2 + 40,
            "Restart",
            { fontSize: "30px", color: "black" }
        ).setOrigin(0.5).setInteractive().setPadding(10); // setInteractive 클릭 이벤트\


        restartBtn.setBackgroundColor("#FFFFFF");
        restartBtn.on("pointerover", () => {
            restartBtn.setBackgroundColor("#A9F5E1");
            this.game.canvas.style.cursor = "pointer";
        });

        restartBtn.on("pointerout", () => {
            restartBtn.setBackgroundColor("#FFFFFF");
            this.game.canvas.style.cursor = "default";
        });

        restartBtn.on("pointerdown", () => {
            this.scene.start("MainScene");
        });
    }
    update() {

    }
}