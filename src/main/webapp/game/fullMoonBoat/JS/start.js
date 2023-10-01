

class Start extends Phaser.Scene {
    constructor() {
        super({ key: "start" }); // 여기서 넣는 키 값이 앞에 quiz_01에서 scene.start에서 넣는 키 값임
    }

    preload() {
        this.load.image("background", "../SRC/background_start.png");
        this.load.image("start_btn", "../SRC/start_btn.png")
    }

    create() {
		let bestScore;
        $.ajax({
            url: "/rankaddBest.rankBoard?game_name=fullMoonBoat",
        }).done(function (resp) {
            bestScore = resp;
        });


        let backgroundImage = this.add.image(0, 0, "background").setOrigin(0, 0);
        
        let startBTN = this.add.image(this.cameras.main.width / 2, 
 			this.cameras.main.height / 2 + 100, "start_btn").setOrigin(0.5).setInteractive();

        startBTN.on("pointerover", () => {
            this.game.canvas.style.cursor = "pointer";
        });

        startBTN.on("pointerout", () => {
            this.game.canvas.style.cursor = "default";
        });

        startBTN.on("pointerdown", () => {
            this.scene.start("index");
        });
        
        startBTN.setSize(150, 65);
       
    }

    update() {
    }
    
}