class GameClearScene extends Phaser.Scene {
    constructor(){
        super({key:"GameClearScene"});
    }

    preload(){
        this.load.image("background3","/game/bounceball/img/bg.jpg");
        this.load.image("replay","/game/bounceball/img/replay.png");
        this.load.image("gameclear","/game/bounceball/img/gameclear.png");
    }

    create(){
$.ajax({
    url: "/rankReadPoint.rankBoard",
    data: {
        score: $("#score").val(),
        game_name: "bounceball",
        rank_type: "time"
    },
    method: "GET"
}).done(function(resp) {
    console.log(resp);
    if (resp === "true") { // 문자열 "true"와 비교
        alert("ㅊㅊㅊㅊㅊㅊㅊ");
    }
});
	
	
        let score = document.getElementById("score");
        this.background = this.add.tileSprite(0,0,800,600,"background3");
        this.background.setOrigin(0,0);

        this.physics.add.sprite(this.cameras.main.width/2,this.cameras.main.height/2-100,"gameclear").setOrigin(0.5).setScale(0.5);
        this.text = this.add.text(this.cameras.main.width/2,this.cameras.main.height/2,"Record : " + score.value + "s" ,{fill:"#ffffff"}).setOrigin(0.5);
        let replyBtn = this.physics.add.sprite(this.cameras.main.width/2,this.cameras.main.height/2+100,"replay").setOrigin(0.5).setScale(0.5).setInteractive();

        replyBtn.on("pointerover",()=>{
            this.game.canvas.style.cursor = "pointer";
        });

        replyBtn.on("pointerout",()=>{
            this.game.canvas.style.cursor = "default";
        })

        replyBtn.on("pointerdown",()=>{
            this.scene.start("PlayScene");
        })
    }

    update(){

    }
}