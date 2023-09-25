class GameOverScene extends Phaser.Scene{
    constructor(){
        super({key:"GameOverScene"})
    }

    preload(){
        this.load.image("gameover","/game/bounceball/img/gameover.png");
        this.load.image("background2","/game/bounceball/img/bg.jpg");
        this.load.image("replay","/game/bounceball/img/replay.png");
    }

    create(){
	
	        console.log($("#point").html());

$.ajax({
    url: "/rankReadPoint.rankBoard",
    data: {
        score: $("#score").html(),
        game_name: "fullMoonBoat",
        rank_type: "point"
    },
    method: "GET"
}).done(function(resp) {
    console.log(resp);
    if (resp === "true") { // 문자열 "true"와 비교
        alert("ㅊㅊㅊㅊㅊㅊㅊ");
    }
});
	
	

        this.background = this.add.tileSprite(0,0,800,600,"background2");
        this.background.setOrigin(0,0);

        this.physics.add.sprite(this.cameras.main.width/2,this.cameras.main.height/2-100,"gameover").setOrigin(0.5).setScale(0.5);
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