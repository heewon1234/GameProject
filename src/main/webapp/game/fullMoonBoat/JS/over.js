class Over extends Phaser.Scene {
    constructor() {
        super({ key: "over" }); // 여기서 넣는 키 값이 앞에 quiz_01에서 scene.start에서 넣는 키 값임
    }

    preload() {

    }

    create() {
        const pointValue = $("#point").html();
        console.log($("#point").html());

        $.ajax({
            url: "/rankReadPoint.rankBoard",
            // Point가 높을때 랭킹이 우선시 되는 경우에는  /rankReadPoint.rankBoard로 이동
            // Point(Time)이 낮을 때 랭킹이 우선시 되는 경우에는 /rankReadTime.rankBoard으로 이동

            data: {
                score: $("#point").html(),
                game_name: "fullMoonBoat"
            },
            method: "GET"
        });

        this.add.text(
            this.cameras.main.width / 2,
            this.cameras.main.height / 2, // 좌우, 상하 각각 크기의 절반 크기의 절반
            "Game Over",
            { fontSize: "30px", fill: "#FF0000" }
        ).setOrigin(0.5); // 체이닝해서 setOrigin해서 거기에서 또 절반 하면 각각 중간으로 간다함? 띠용

        let restartBTN = this.add.text(
            this.cameras.main.width / 2,
            this.cameras.main.height / 2 + 80,
            "Restart",
            { fontSize: "30px" }
        ).setOrigin(0.5).setInteractive().setPadding(15); // 셋 인터렉티브 하면 누를 수 있게 해줌

        restartBTN.on("pointerover", () => {
            restartBTN.setBackgroundColor("#F20938");
            this.game.canvas.style.cursor = "pointer";
        });

        restartBTN.on("pointerout", () => {
            restartBTN.setBackgroundColor("#000000");
            this.game.canvas.style.cursor = "default";
        });

        restartBTN.on("pointerdown", () => {
            this.scene.start("index");
        });
    }

    update() {

    }
}