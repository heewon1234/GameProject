class Project extends Phaser.Scene {
    constructor() {
        super({ key: "Project" });
    }

    init() {
        this.topBoxes = [];
        this.downBoxes = [];
        this.elapsedTime = 0;
        this.isJumping = false;
        this.jumpTimer = null;
        this.cnt = 0;
    }

    preload() {
        this.load.audio('bgm', '/game/flappyBird/mp3/왕벌의 비행.mp3');
        this.load.image("background6", "/game/flappyBird/img/플래피버드배경화면.jpg");
        this.load.image("player", "/game/flappyBird/img/플래피버드.png");
        this.load.image("player_jump", "/game/flappyBird/img/플래피버드점프.png");
    }
    registerTexture() { // 함수를 임의로 만듬 , 직접 만들때
        let texture = this.make.graphics();//만들기만 하고 띄우지는 않는다.
        texture.fillStyle(0x73be2e, 1);//(색깔,투명도)-1은 불투명, 투명은1이하로
        texture.fillRect(0, 0, 30, 30);//사각형으로 채우겠다.
        texture.lineStyle(2, 0x000000, 1);//두께,색깔,투명도
        texture.strokeRect(0, 0, 30, 30);//테두리 적용
        texture.generateTexture("box", 30, 30);//디자인을 생성하겠다., 화면에 아직 띄우진 않는다.(key,넓이,높이)
    }

    create() {
        this.registerTexture();
        // 배경 음악 설정
        const prevScene = this.scene.get("startScene");
    if (prevScene && prevScene.backgroundMusic.isPlaying) {
        prevScene.backgroundMusic.stop();
    }

    // 배경 음악 재생
    if (!this.sound.get('bgm')) {
        this.backgroundMusic = this.sound.add('bgm', { loop: true });
        this.backgroundMusic.play();
    } else {
        this.backgroundMusic = this.sound.get('bgm');
        if (!this.backgroundMusic.isPlaying) {
            this.backgroundMusic.play();
        }
    }
    
        // 게임 요소 초기화
        this.cursors = this.input.keyboard.createCursorKeys();
        this.back = this.add.tileSprite(0, 0, 1000, 478, "background6");
        this.back.setOrigin(0, 0);
        this.player = this.physics.add.sprite(100, 250, "player");
        this.player.setSize(30, 30);
        this.player.setCollideWorldBounds(true);

        // 점프 이벤트 처리
        this.input.keyboard.on('keydown-SPACE', () => {
            if (!this.isJumping) {
                this.isJumping = true;
                this.player.setTexture("player_jump");
                this.player.setVelocityY(-400);

                this.jumpTimer = this.time.delayedCall(300, () => {
                    this.isJumping = false;
                    this.player.setTexture("player");
                });
            }
        });

        // 게임 루프
        this.timer = this.time.addEvent({
            delay: 2000,
            callback: () => {
                this.createRandomBoxes();
                this.createRandomBoxes1();
                this.createScoreBoundary();
            },
            callbackScope: this,
            loop: true

        });
        // 1초 간격으로 updateTimer 함수 호출
        this.timer = this.time.addEvent({
            delay: 1000,
            callback: this.updateTimer,
            callbackScope: this,
            loop: true
        });

        // 충돌 검사
        this.physics.add.overlap(this.player, this.topBoxes, this.gameOver, null, this);
        this.physics.add.overlap(this.player, this.downBoxes, this.gameOver, null, this);
        this.spaceKey = this.input.keyboard.addKey(Phaser.Input.Keyboard.KeyCodes.SPACE);
        this.physics.world.enable(this.player);
        this.player.body.gravity.y = 2000;

        // Score 텍스트 생성
        this.scoreText = this.add.text(10, 10, 'Score: 0', {
            fontSize: '24px',
            fill: '#fff',
            align: 'left'
        });

        // Time 텍스트 생성
        this.timeText = this.add.text(this.cameras.main.width - 10, 10, 'Time: 0 초', {
            fontSize: '24px',
            fill: '#fff',
            align: 'right'
        });
        this.timeText.setOrigin(1, 0);

        // 상단, 하단 경계 설정
        let topBoundary = this.add.rectangle(0, this.cameras.main.height - 476, this.cameras.main.width, 1, 0xFFFFFF);
        topBoundary.setOrigin(0, 0);
        this.physics.add.existing(topBoundary);
        this.physics.add.overlap(topBoundary, this.player, function (boundary, box) {
            box.destroy();
            this.gameOver();
        }, null, this);

        let bottomBoundary = this.add.rectangle(0, this.cameras.main.height-2, this.cameras.main.width, 1, 0xFFFFFF);
        bottomBoundary.setOrigin(0, 0);
        this.physics.add.existing(bottomBoundary);
        this.physics.add.overlap(bottomBoundary, this.player, function (boundary, box) {
            box.destroy();
            this.gameOver();
        }, null, this);
    }

    createScoreBoundary() {
        const scoreBoundary = this.add.rectangle(430, 0, 1, this.cameras.main.height, 0, 0xFFFFFF);
        scoreBoundary.setOrigin(0, 0);
        this.physics.add.existing(scoreBoundary);
        scoreBoundary.body.velocity.x = -200;

        let hasCollided = false;

        this.physics.add.overlap(scoreBoundary, this.player, function (boundary, box) {
            if (!hasCollided) {
                this.cnt++;
                console.log(this.cnt);
                hasCollided = true;
            }
        }, null, this);
    }

    gameOver = () => {
        alert(`Time: ${this.elapsedTime} seconds`);
        this.backgroundMusic.pause(); // 음악 일시 중지
        this.scene.start("GameOverScene");
    }

    updateTimer() {
        this.elapsedTime += 1;
        this.timeText.setText(`Time: ${this.elapsedTime} 초`);
    }

    updateCnt() {
        this.scoreText.setText(`Score: ${this.cnt}`);
    }

    update() {
        this.updateCnt();
        this.back.tilePositionX += 3;
        if (this.topBoxes && this.downBoxes) {
            for (let i = 0; i < this.topBoxes.length; i++) {
                if (this.topBoxes[i]) {
                    this.topBoxes[i].setVelocityX(-200);
                }
            }
            for (let i = 0; i < this.downBoxes.length; i++) {
                if (this.downBoxes[i]) {
                    this.downBoxes[i].setVelocityX(-200);
                }
            }
        }
        if (Phaser.Input.Keyboard.JustDown(this.spaceKey)) {
            this.player.setVelocityY(-500);
        }
    }

    createRandomBoxes() {
        const numBoxes = Phaser.Math.Between(4, 6);
        for (let i = 0; i < numBoxes; i++) {
            const box = this.physics.add.sprite(410, 7 + i * 30, "box");
            box.setOrigin(0, 0);
            this.topBoxes.push(box);
        }
    }

    createRandomBoxes1() {
        const numBoxes = Phaser.Math.Between(4, 6);
        for (let i = 0; i < numBoxes; i++) {
            const box = this.physics.add.sprite(410, 440 - i * 30, "box");
            box.setOrigin(0, 0);
            this.downBoxes.push(box);
        }
    }


}
