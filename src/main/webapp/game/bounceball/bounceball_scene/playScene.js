class PlayScene extends Phaser.Scene {
    constructor(){
        super({key:"PlayScene"});
    }

    init(){
        this.blocks = [];
        this.delBlocks = [];
        this.lightnings = [];
        this.jumps = [];
        this.rightBoosts = [];
        this.leftBoosts = [];
        this.stars = [];
        this.collide = true;
        this.velocity = 180;
        this.boost = false;
        this.frame = 0;
        this.time = 0;

        this.destroy = false;

    }

    preload(){
        // background
        this.load.image("background1","/game/bounceball/img/bg1.png");
        
        // block
        this.load.image("block","/game/bounceball/img/block.png");
        this.load.image("block_w2","/game/bounceballimg/block_w2.png");
        this.load.image("block_w4","/game/bounceball/img/block_w4.png");
        this.load.image("block_w8","/game/bounceball/img/block_w8.png");
        this.load.image("block_h2","/game/bounceball/img/block_h2.png");
        this.load.image("block_h4","/game/bounceball/img/block_h4.png");
        this.load.image("block_h8","/game/bounceball/img/block_h8.png");

        // lightning
        this.load.image("lightning","/game/bounceball/img/lightning.png");
        this.load.image("lightning_w2","/game/bounceball/img/lightning_w2.png");
        this.load.image("lightning_w4","/game/bounceball/img/lightning_w4.png");
        this.load.image("lightning_w8","/game/bounceball/img/lightning_w8.png");
        this.load.image("lightning_h2","/game/bounceball/img/lightning_h2.png");
        this.load.image("lightning_h4", "/game/bounceball/img/lightning_h4.png");
        this.load.image("lightning_h8","/game/bounceball/img/lightning_h8.png");

        // delBlock
        this.load.image("delBlock","/game/bounceball/img/delBlock.png");
        this.load.image("delBlock_w2","/game/bounceball/img/delBlock_w2.png");
        this.load.image("delBlock_w4","/game/bounceball/img/delBlock_w4.png");
        this.load.image("delBlock_w8", "/game/bounceball/img/delBlock_w8.png");
        this.load.image("delBlock_h2","/game/bounceball/img/delBlock_h2.png");
        this.load.image("delBlock_h4","/game/bounceball/img/delBlock_h4.png");
        this.load.image("delBlock_h8","/game/bounceball/img/delBLock_h8.png");

        // jump
        this.load.image("jump","/game/bounceball/img/jump.png");

        // leftBoost
        this.load.image("leftBoost","/game/bounceball/img/leftBoost.png");

        // rightBoost
        this.load.image("rightBoost","/game/bounceball/img/rightBoost.png");

        // ball
        this.load.image("ball","/game/bounceball/img/ball.png");

        // star
        this.load.image("star","/game/bounceball/img/star.png");
    }

    bounceBallBlock(){
        this.ratioX = 800/1600;
        this.ratioY = 600/1200;
        // block add
        this.blocks[0] = this.physics.add.sprite(1400*this.ratioX,250*this.ratioY,"block_w4").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.blocks[1] = this.physics.add.sprite(1400*this.ratioX,200*this.ratioY,"block").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.blocks[2] = this.physics.add.sprite(1100*this.ratioX,250*this.ratioY,"block_w4").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.blocks[3] = this.physics.add.sprite(600*this.ratioX,250*this.ratioY,"block_w4").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.blocks[4] = this.physics.add.sprite(550*this.ratioX,250*this.ratioY,"block").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.blocks[5] = this.physics.add.sprite(100*this.ratioX,1100*this.ratioY,"block").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.blocks[6] = this.physics.add.sprite(500*this.ratioX,500*this.ratioY,"block").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.blocks[7] = this.physics.add.sprite(150*this.ratioX,850*this.ratioY,"block").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.blocks[8] = this.physics.add.sprite(50*this.ratioX,700*this.ratioY,"block_h4").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        

        // lightning add
        this.lightnings[0] = this.physics.add.sprite(1300*this.ratioX,250*this.ratioY,"lightning_w2").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[1] = this.physics.add.sprite(900*this.ratioX,250*this.ratioY,"lightning_w4").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[2] = this.physics.add.sprite(800*this.ratioX,250*this.ratioY,"lightning_w2").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[3] = this.physics.add.sprite(150*this.ratioX,200*this.ratioY,"lightning_w8").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[4] = this.physics.add.sprite(0*this.ratioX,200*this.ratioY,"lightning_w2").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[5] = this.physics.add.sprite(50*this.ratioX,250*this.ratioY,"lightning_h4").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[6] = this.physics.add.sprite(50*this.ratioX,450*this.ratioY,"lightning_h2").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[7] = this.physics.add.sprite(50*this.ratioX,550*this.ratioY,"lightning_h2").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[8] = this.physics.add.sprite(150*this.ratioX,250*this.ratioY,"lightning_h4").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[9] = this.physics.add.sprite(150*this.ratioX,450*this.ratioY,"lightning_w2").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[10] = this.physics.add.sprite(250*this.ratioX,450*this.ratioY,"lightning").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[11] = this.physics.add.sprite(550*this.ratioX,500*this.ratioY,"lightning_w4").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[12] = this.physics.add.sprite(50*this.ratioX,900*this.ratioY,"lightning_h4").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[13] = this.physics.add.sprite(900*this.ratioX,400*this.ratioY,"lightning").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[14] = this.physics.add.sprite(1100*this.ratioX,450*this.ratioY,"lightning_h4").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[15] = this.physics.add.sprite(1400*this.ratioX,900*this.ratioY,"lightning_h2").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[16] = this.physics.add.sprite(1100*this.ratioX,650*this.ratioY,"lightning").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[17] = this.physics.add.sprite(1100*this.ratioX,700*this.ratioY,"lightning_h2").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[18] = this.physics.add.sprite(1150*this.ratioX,450*this.ratioY,"lightning_w4").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[19] = this.physics.add.sprite(1450*this.ratioX,400*this.ratioY,"lightning_h8").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[20] = this.physics.add.sprite(1250*this.ratioX,600*this.ratioY,"lightning_w4").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[21] = this.physics.add.sprite(1150*this.ratioX,750*this.ratioY,"lightning_w2").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[22] = this.physics.add.sprite(1250*this.ratioX,750*this.ratioY,"lightning").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[23] = this.physics.add.sprite(1250*this.ratioX,800*this.ratioY,"lightning").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[24] = this.physics.add.sprite(1400*this.ratioX,700*this.ratioY,"lightning_h4").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[25] = this.physics.add.sprite(1503*this.ratioX,400*this.ratioY,"lightning_w2").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[26] = this.physics.add.sprite(850*this.ratioX,950*this.ratioY,"lightning_h2").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[27] = this.physics.add.sprite(550*this.ratioX,950*this.ratioY,"lightning_h2").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[28] = this.physics.add.sprite(500*this.ratioX,950*this.ratioY,"lightning").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[29] = this.physics.add.sprite(150*this.ratioX,900*this.ratioY,"lightning_h4").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[30] = this.physics.add.sprite(50*this.ratioX,900*this.ratioY,"lightning_h4").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[31] = this.physics.add.sprite(50*this.ratioX,1100*this.ratioY,"lightning").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[32] = this.physics.add.sprite(150*this.ratioX,1100*this.ratioY,"lightning").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.lightnings[33] = this.physics.add.sprite(850*this.ratioX,900*this.ratioY,"lightning").setOrigin(0,0).setScale(this.ratioX,this.ratioY);

        // delBlock add
        this.delBlocks[0] = this.physics.add.sprite(400*this.ratioX,150*this.ratioY,"delBlock").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.delBlocks[1] = this.physics.add.sprite(250*this.ratioX,150*this.ratioY,"delBlock").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.delBlocks[2] = this.physics.add.sprite(100*this.ratioX,150*this.ratioY,"delBlock").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.delBlocks[3] = this.physics.add.sprite(50*this.ratioX,650*this.ratioY,"delBlock").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.delBlocks[4] = this.physics.add.sprite(250*this.ratioX,650*this.ratioY,"delBlock").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.delBlocks[5] = this.physics.add.sprite(400*this.ratioX,550*this.ratioY,"delBlock").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.delBlocks[6] = this.physics.add.sprite(450*this.ratioX,500*this.ratioY,"delBlock").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.delBlocks[7] = this.physics.add.sprite(1300*this.ratioX,1000*this.ratioY,"delBlock_w2").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.delBlocks[8] = this.physics.add.sprite(1150*this.ratioX,1000*this.ratioY,"delBlock").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.delBlocks[9] = this.physics.add.sprite(1050*this.ratioX,950*this.ratioY,"delBlock").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.delBlocks[10] = this.physics.add.sprite(100*this.ratioX,650*this.ratioY,"delBlock").setOrigin(0,0).setScale(this.ratioX,this.ratioY);

        // jump
        this.jumps[0] = this.physics.add.sprite(1100*this.ratioX,200*this.ratioY,"jump").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.jumps[1] = this.physics.add.sprite(150*this.ratioX,650*this.ratioY,"jump").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.jumps[2] = this.physics.add.sprite(300*this.ratioX,650*this.ratioY,"jump").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.jumps[3] = this.physics.add.sprite(800*this.ratioX,500*this.ratioY,"jump").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.jumps[4] = this.physics.add.sprite(1000*this.ratioX,500*this.ratioY,"jump").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.jumps[5] = this.physics.add.sprite(1250*this.ratioX,1000*this.ratioY,"jump").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.jumps[6] = this.physics.add.sprite(950*this.ratioX,1000*this.ratioY,"jump").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.jumps[7] = this.physics.add.sprite(600*this.ratioX,1000*this.ratioY,"jump").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.jumps[8] = this.physics.add.sprite(450*this.ratioX,900*this.ratioY,"jump").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.jumps[9] = this.physics.add.sprite(550*this.ratioX,200*this.ratioY,"jump").setOrigin(0,0).setScale(this.ratioX,this.ratioY);

        // leftBoost
        this.leftBoosts[0] = this.physics.add.sprite(1100*this.ratioX,30*this.ratioY,"leftBoost").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.leftBoosts[1] = this.physics.add.sprite(1400*this.ratioX,550*this.ratioY,"leftBoost").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.leftBoosts[3] = this.physics.add.sprite(750*this.ratioX,950*this.ratioY,"leftBoost").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.leftBoosts[2] = this.physics.add.sprite(350*this.ratioX,800*this.ratioY,"leftBoost").setOrigin(0,0).setScale(this.ratioX,this.ratioY);

        // rightBoost
        this.rightBoosts[0] = this.physics.add.sprite(500*this.ratioX,450*this.ratioY,"rightBoost").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.rightBoosts[1] = this.physics.add.sprite(1100*this.ratioX,400*this.ratioY,"rightBoost").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.rightBoosts[2] = this.physics.add.sprite(1150*this.ratioX,700*this.ratioY,"rightBoost").setOrigin(0,0).setScale(this.ratioX,this.ratioY);

        // star
        this.stars[0] = this.physics.add.sprite(1250*this.ratioX,200*this.ratioY,"star").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.stars[1] = this.physics.add.sprite(550*this.ratioX,150*this.ratioY,"star").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.stars[2] = this.physics.add.sprite(100*this.ratioX,100*this.ratioY,"star").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.stars[3] = this.physics.add.sprite(100*this.ratioX,600*this.ratioY,"star").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.stars[4] = this.physics.add.sprite(900*this.ratioX,350*this.ratioY,"star").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.stars[5] = this.physics.add.sprite(1400*this.ratioX,400*this.ratioY,"star").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.stars[6] = this.physics.add.sprite(1150*this.ratioX,550*this.ratioY,"star").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.stars[7] = this.physics.add.sprite(1350*this.ratioX,700*this.ratioY,"star").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.stars[8] = this.physics.add.sprite(850*this.ratioX,850*this.ratioY,"star").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.stars[9] = this.physics.add.sprite(100*this.ratioX,800*this.ratioY,"star").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.stars[10] = this.physics.add.sprite(100*this.ratioX,1050*this.ratioY,"star").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
    }

    setImmovable(){
        for(let i=0;i<this.blocks.length;i++){
            this.blocks[i].setImmovable(true);
        }

        for(let i=0;i<this.lightnings.length;i++){
            this.lightnings[i].setImmovable(true);
        }

        for(let i=0;i<this.delBlocks.length;i++){
            this.delBlocks[i].setImmovable(true);
        }

        for(let i=0;i<this.jumps.length;i++){
            this.jumps[i].setImmovable(true);
        }

        for(let i=0;i<this.leftBoosts.length;i++){
            this.leftBoosts[i].setImmovable(true);
        }

        for(let i=0;i<this.rightBoosts.length;i++){
            this.rightBoosts[i].setImmovable(true);
        }

        for(let i=0;i<this.stars.length;i++){
            this.stars[i].setImmovable(true);
        }
        

    }

    setCollide(){
        
        this.physics.add.collider(this.player,this.blocks,(player, block)=>{
            if(player.x + (player.width * this.ratioX) >= block.x && player.x<=block.x+(block.width * this.ratioX ) && player.y + ( player.height * this.ratioY ) - 5 <= block.y){
                this.collide = true;
                player.setVelocityY(-this.velocity*1.1);
            } else{
                this.collide = false;
                this.boost = false;
            }
 
        });

        this.physics.add.collider(this.player,this.lightnings,(player,lightning)=>{
            player.destroy();
            this.destroy = true;
        });
        
        this.physics.add.overlap(this.player,this.stars,(player,star)=>{
            this.player.data.values.star += 1;
            star.destroy();
        });

        this.physics.add.collider(this.player,this.delBlocks,(player,delBlock)=>{

            if(player.x + (player.width * this.ratioX) >= delBlock.x && player.x<=delBlock.x+(delBlock.width * this.ratioX) && player.y + (player.height * this.ratioY) - 5 <= delBlock.y){
               
                this.collide = true;
                player.setVelocityY(-this.velocity * 1.1);
                delBlock.destroy();
            } else{
                this.collide = false;
            }
            
        });

        this.physics.add.collider(this.player,this.jumps,(player,jump)=>{
            if(player.x + (player.width * this.ratioX ) >= jump.x && player.x<=jump.x+(jump.width * this.ratioX ) && player.y + (player.height * this.ratioY) - 5 <= jump.y){
                player.setVelocityY(-this.velocity * 1.6);
            } else {
                this.collide = false;
            }
        });

        this.physics.add.collider(this.player,this.leftBoosts,(player,leftBoost)=>{
            this.boost = true;
            this.player.x = leftBoost.x - (this.player.width*this.ratioX);
            this.player.y = leftBoost.y;
            this.player.setVelocityY(0);
            this.player.body.gravity.y = 0;
            this.player.setVelocityX(-this.velocity*1.3);
        });

        this.physics.add.collider(this.player,this.rightBoosts,(player,rightBoost)=>{
            this.boost = true;
            this.player.x = rightBoost.x + (rightBoost.width * this.ratioX );
            this.player.y = rightBoost.y;
            this.player.setVelocityY(0);
            this.player.body.gravity.y = 0;
            this.player.setVelocityX(this.velocity*1.3);
        });

        this.physics.add.collider(this.player,this.leftBoundary,(player,boundary)=>{
            this.destroy = true;
            player.destroy();
        });

        this.physics.add.collider(this.player,this.rightBoundary,(player,boundary)=>{
            this.destroy = true;
            player.destroy();
        });

        this.physics.add.collider(this.player,this.topBoundary,(player,boundary)=>{
            this.destroy = true;
            player.destroy();
        });

        this.physics.add.collider(this.player,this.bottomBoundary,(player,boundary)=>{
            this.destroy = true;
            player.destroy();
        });
    }

    create(){
        this.cursors = this.input.keyboard.createCursorKeys();
        
        // background
        this.background = this.add.tileSprite(0,0,1600,1200,"background1");
        this.background.setOrigin(0,0);

        // create block
        this.bounceBallBlock();
        this.setImmovable();

        // player
        this.player = this.physics.add.sprite(1500*this.ratioX,150*this.ratioY,"ball").setOrigin(0,0).setScale(this.ratioX,this.ratioY);
        this.player.setCollideWorldBounds(true);
        this.player.body.gravity.y = 200;
        this.player.setData('star',0);
        this.player.setCircle(20);
        this.player.setBounce(1);

        // leftBoundary
        this.leftBoundary = this.add.rectangle(0,0,1,1200*this.ratioY,0x000000);
        this.leftBoundary.setOrigin(0,0);
        this.physics.add.existing(this.leftBoundary,true);


        // rightBoundary
        this.rightBoundary = this.add.rectangle(1600*this.ratioX,0,1,1200*this.ratioY,0x000000);
        this.rightBoundary.setOrigin(0,0);
        this.physics.add.existing(this.rightBoundary,true);

        // topBoundary
        this.topBoundary = this.add.rectangle(0,0,1600*this.ratioX,1,0x000000);
        this.topBoundary.setOrigin(0,0);
        this.physics.add.existing(this.topBoundary,true);

        // bottomBoundary
        this.bottomBoundary = this.add.rectangle(0,1200*this.ratioY,1600*this.ratioX,1,0x000000);
        this.bottomBoundary.setOrigin(0,0);
        this.physics.add.existing(this.bottomBoundary,true);

        this.setCollide();

        this.text = this.add.text(this.cameras.main.width-140,10,"",{font:"25px Bahnschrift", fill:"#000000"});
    }

    update(){


        if(this.destroy){
            this.scene.start("GameOverScene");
        } else{
            this.time++;
            let timer = this.time / 60;
            $("#point").html(Math.floor(this.time / 60));
            this.text.setText("Time : " + Math.floor(timer));
            $("#score").val(Math.floor(timer));
        }

        if(this.player.getData("star") == 11){
            this.scene.start("GameClearScene");
            
        }
        if(!this.collide){
            this.frame++;
            if(this.frame % 6 == 0){
                this.collide = true;
            }
        } 

        if(!this.boost && !this.destroy){
            this.player.setVelocityX(0);
            this.player.body.gravity.y = 600;
        }

        if(this.cursors.left.isDown && !this.destroy){ // 왼쪽 방향키가 눌렸다면
            this.boost = false;
            if(this.collide){
                this.player.setVelocityX(-this.velocity*0.6); // X 방향으로 속력 ( 속도 )
            } else{
                this.player.setVelocityX(50);
            }
            
        }

        if(this.cursors.right.isDown && !this.destroy){ // 왼쪽 방향키가 눌렸다면
            this.boost = false;
            if(this.collide){
                this.player.setVelocityX(this.velocity*0.6);
            } else{
                this.player.setVelocityX(-50);
            }
             
        }

        if(this.cursors.down.isDown && !this.destroy){
            this.boost = false;
        }
    }
}