class StartScene extends Phaser.Scene{
    constructor(){
        super({key:"StartScene"})
    }

    preload(){
        this.load.image("background","/game/bounceball/img/bg.jpg");
        this.load.image("logo","/game/bounceball/img/logo.png");
        this.load.image("playBtn","/game/bounceball/img/playBtn.png");
    }

    create(){
        
        this.background = this.add.tileSprite(0,0,800,600,"background").setOrigin(0,0);

        this.physics.add.sprite(this.cameras.main.width/2,this.cameras.main.height/2-100,"logo").setOrigin(0.5).setScale(0.5);
        let playBtn = this.physics.add.sprite(this.cameras.main.width/2,this.cameras.main.height/2+100,"playBtn").setOrigin(0.5).setScale(0.5).setInteractive();
        
        playBtn.on("pointerover",()=>{
            this.game.canvas.style.cursor = "pointer";
        });

        playBtn.on("pointerout",()=>{
            this.game.canvas.style.cursor = "default";
        })

        playBtn.on("pointerdown",()=>{
            this.scene.start("PlayScene");
        })
        
        let bestScore;
    	$.ajax({
      		url: "/rankaddBest.rankBoard?game_name=bounceball",
    	}).done((resp) => {
     		bestScore = resp;
     		if(bestScore == "--"){bestScore='0'}
      		this.add.text(this.cameras.main.width/2,this.cameras.main.height/2+10,"최고 기록 : " + bestScore + "s",{ fontSize: "20px", fill: "#ffffff" }).setOrigin(0.5).setPadding(10);
    	});

    }

    update(){

    }
}