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
        let score = document.getElementById("score");
        this.background = this.add.tileSprite(0,0,800,600,"background3");
        this.background.setOrigin(0,0);

        this.physics.add.sprite(this.cameras.main.width/2,this.cameras.main.height/2-100,"gameclear").setOrigin(0.5).setScale(0.5);
        this.text = this.add.text(this.cameras.main.width/2,this.cameras.main.height/2,"Record : " + score.value + "s" ,{font:"40px Bahnschrift", fill:"#ffffff"}).setOrigin(0.5);
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