class Over extends Phaser.Scene {
    constructor() {
        super({ key: "over" }); // Phaser.Scene을 상속받는 Over 클래스 정의
    }

    preload() {
        // 사전로드할 리소스가 있다면 이 곳에 추가
            this.load.image("background_over", "../SRC/background_over.png");
            this.load.image("restart_btn", "../SRC/restart_btn.png");
    }

    create() {
        // 게임 종료 화면을 생성하는 부분
                // 현재 플레이어의 점수를 가져옴
        const pointValue = $("#point").html();
        
        let bestScore;
        $.ajax({
	url: "/rankaddBest.rankBoard?game_name=fullMoonBoat",
    }).done((resp) => {
      bestScore = resp;
      this.add.text(
        this.cameras.main.width / 2,
        this.cameras.main.height / 2 + 65,
        "BEST: " + bestScore,
        { fontSize: "32px", fill: "#ffffff", fontFamily: 'Times New Roman', 
        fontWeight : 'bold', stroke: "#000000", strokeThickness: 2}
      ).setOrigin(0.5);
    });

        // 서버로 현재 점수를 전송하여 랭킹을 업데이트
         if(pointValue > 0) 
{
        $.ajax({
            url: "/rankReadPoint.rankBoard",
            data: {
                score: $("#point").html(),
                game_name: "fullMoonBoat",
                rank_type: "point"
            },
            method: "GET"
        }).done(function(resp) {
            if (resp === "true") { // 서버에서 반환한 응답을 확인하고 신기록일 경우 축하 메시지 출력
                alert("축하합니다! 신기록이 달성되었습니다.");
            }
        });
}
                
        let backgroundImage = this.add.image(0, 0, "background_over").setOrigin(0, 0);

        let restartBTN = this.add.image(this.cameras.main.width / 2, 
 			this.cameras.main.height / 2 + 150, "restart_btn").setOrigin(0.5).setInteractive();

        restartBTN.on("pointerover", () => {
            this.game.canvas.style.cursor = "pointer";
        });

        restartBTN.on("pointerout", () => {
            this.game.canvas.style.cursor = "default";
        });

        restartBTN.on("pointerdown", () => {
            this.scene.start("index");
        });
        
        restartBTN.setSize(200, 65);
        
        	this.cuur = this.add.text(
    this.cameras.main.width / 2,
    this.cameras.main.height / 2 + 25,
    "CUUR: " + pointValue,
    {
        fontSize: "32px",
        fill: "#ffffff",
        fontFamily: 'Times New Roman',
        fontWeight: 'bold',
        stroke: "#000000",
        strokeThickness: 2
    }
).setOrigin(0.5);
        
    }

    update() {
        // 게임 업데이트 로직이 있다면 이곳에 추가
    }
}