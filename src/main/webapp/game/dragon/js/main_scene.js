class MainScene extends Phaser.Scene {
    constructor() {
        super({ key: "MainScene" });
    }

    init() {
        this.frame = 0;
        this.enemies = [];
        this.fires = [];
        this.collisionCounts = {};
        this.startTime = this.time.now;
        this.score = 0;
    }

    preload() {
        this.load.spritesheet("dragonSheet", "/game/dragon/img/dragon.png", { frameWidth: 80, frameHeight: 80 });

        for (let i = 1; i <= 7; i++) {
            this.load.image(`enemy${i}`, `/game/dragon/img/mon${i}.png`);
        }

        this.img = ["enemy1", "enemy2", "enemy3", "enemy4", "enemy5", "enemy6", "enemy7"];

        this.load.image("background1", "/game/dragon/img/01.png");
        this.load.image("background2", "/game/dragon/img/02.png");
        this.load.image("background3", "/game/dragon/img/03.png");

        this.load.image("fire", "/game/dragon/img/fire.png");
    }

    create() {
        this.backgrounds = ["background1", "background2", "background3"];
        this.currentBackgroundIndex = 0;

        this.back = this.add.tileSprite(0, 0, 400, 500, this.backgrounds[this.currentBackgroundIndex]);
        this.back.setOrigin(0, 0);

        this.elapsedTimeText = this.add.text(10, 10, "생존시간: 0 seconds", {
            font: "16px Arial",
            fill: "#ffffff"
        });

        this.scoreText = this.add.text(10, 30, "Score: 0 Point", {
            font: "16px Arial",
            fill: "#ffffff"
        });

        this.anims.create({
            key: "fly",
            frames: this.anims.generateFrameNumbers("dragonSheet", { start: 9, end: 11 }),
            frameRate: 10,
            repeat: -1
        });

        let bottomBoundary = this.add.rectangle(0, this.cameras.main.height + 20, this.cameras.main.width, 2, 0xFFFFFF);
        bottomBoundary.setOrigin(0, 0);

        this.physics.add.existing(bottomBoundary, true);
        this.physics.add.overlap(bottomBoundary, this.enemies, (bottomBoundary, enemy) => {
            enemy.destroy();
        });

        let topBoundary = this.add.rectangle(0, this.cameras.main.height - 520, this.cameras.main.width, 2, 0xFFFFFF);
        topBoundary.setOrigin(0, 0);

        this.physics.add.existing(topBoundary, true);
        this.physics.add.overlap(topBoundary, this.fires, (topBoundary, fire) => {
            fire.destroy();
        });


        this.cursors = this.input.keyboard.createCursorKeys();

        this.dragon = this.physics.add.sprite(200, 460, "dragonSheet");
        this.dragon.setOrigin(0.5, 0.5); // 이미지의 중심을 중앙으로 설정
        this.dragon.setCollideWorldBounds(true);
        this.dragon.setSize(50, 50);
        this.dragon.play("fly");

        this.physics.add.overlap(this.dragon, this.enemies, (dragon, enemy) => {
            this.scene.start("GameOverScene");
        });
    }

    destroyEnemy() {
        this.physics.add.overlap(this.enemies, this.fires, (enemy, fire) => {
            let imageName = enemy.texture.key;
            if (!this.collisionCounts[imageName]) {
                this.collisionCounts[imageName] = 0;
            }
            this.collisionCounts[imageName]++;
            let maxCollisions;
            let point;
            switch (imageName) {
                case "enemy1":
                    maxCollisions = 1;
                    point = 100;
                    break;
                case "enemy2":
                    maxCollisions = 2;
                    point = 200;
                    break;
                case "enemy3":
                    maxCollisions = 3;
                    point = 300;
                    break;
                case "enemy4":
                    maxCollisions = 4;
                    point = 400;
                    break;
                case "enemy5":
                    maxCollisions = 5;
                    point = 500;
                    break;
                case "enemy6":
                    maxCollisions = 6;
                    point = 600;
                    break;
                case "enemy7":
                    maxCollisions = 7;
                    point = 700;
                    break;
            }
            if (this.collisionCounts[imageName] >= maxCollisions) {
                enemy.destroy();
                this.score += point;
                this.collisionCounts[imageName] = 0;
            }

            fire.destroy();
        });
    }

    createEnemies(numImages) {
        let numEnemies = 5;
        let spacing = 80;

        for (let i = 0; i < numEnemies; i++) {
            let xPosition = i * spacing + 10;
            let randomImage = Phaser.Math.RND.pick(this.img.slice(0, numImages));
            let enemy = this.physics.add.sprite(xPosition, 0, randomImage);
            enemy.setOrigin(0, 0);
            enemy.setVelocityY(200);
            this.enemies.push(enemy);
        }
    }


    createFire() {
        this.fire = this.physics.add.sprite(this.dragon.x, this.dragon.y - 40, "fire");
        this.fire.setVelocityY(-300);
        this.fire.setSize(20, 20);
        this.fires.push(this.fire);
    }

    update() {
        this.frame++;

        let elapsedTime = this.time.now - this.startTime;
        let Time = elapsedTime / 1000;

        this.elapsedTimeText.setText("생존시간: " + Time.toFixed(2) + " seconds");

        this.scoreText.setText("Score:" + this.score + "Point");

        if (Time >= 0 && this.frame % 1800 == 0) {
            this.currentBackgroundIndex = (this.currentBackgroundIndex + 1) % this.backgrounds.length;
            this.back.setTexture(this.backgrounds[this.currentBackgroundIndex]);
        }

        this.back.tilePositionY -= 1;


        if (Time >= 0 && Time < 12 && this.frame % 90 == 0) {
            this.createEnemies(1);
            this.destroyEnemy();
        }

        if (Time >= 12 && Time < 24 && this.frame % 90 == 0) {
            this.createEnemies(2);
            this.destroyEnemy();
        }

        if (Time >= 24 && Time < 36 && this.frame % 90 == 0) {
            this.createEnemies(3);
            this.destroyEnemy();
        }

        if (Time >= 36 && Time < 48 && this.frame % 100 == 0) {
            this.createEnemies(4);
            this.destroyEnemy();
        }

        if (Time >= 48 && Time < 60 && this.frame % 100 == 0) {
            this.createEnemies(5);
            this.destroyEnemy();
        }

        if (Time >= 60 && Time < 72 && this.frame % 110 == 0) {
            this.createEnemies(6);
            this.destroyEnemy();
        }

        if (Time >= 72 && this.frame % 110 == 0) {
            this.createEnemies(7);
            this.destroyEnemy();
        }

        if (Time >= 3 && this.frame % 50 == 0) {
            this.createFire();
        }

        this.dragon.setVelocity(0);

        if (this.cursors.left.isDown) {
            this.dragon.setVelocityX(-250);
        }

        if (this.cursors.right.isDown) {
            this.dragon.setVelocityX(250);
        }

        $("#point").html(Math.floor(this.score));
    }
}