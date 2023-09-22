class startScene extends Phaser.Scene {
    constructor() {
        super({ key: "startScene" });
    }

    preload() {
        this.load.image("background7", "/game/flappyBird/img/플래피버드배경화면.jpg");
        this.load.image("logo", "/game/flappyBird/img/플래피버드로고.png");
        this.load.image("startBtn", "/game/flappyBird/img/start.png");
        this.load.audio('bgm3', '/game/flappyBird/mp3/start.mp3'); // 배경 음악 로드
    }

    create() {
        this.back = this.add.tileSprite(0, 0, 800, 500, "background7");
        this.back.setOrigin(0, 0);
        this.logo = this.physics.add.sprite(210, 180, "logo");
        this.logo.setScale(1.5);
        this.logo.setSize(300, 50);
        this.startBtn = this.physics.add.sprite(200, 360, "startBtn");
        this.startBtn.setSize(110, 50);

        // 로고를 위아래로 흔들기 위한 Tween 애니메이션 설정
        this.tweens.add({
            targets: this.logo,
            y: 220, // 로고가 흔들리는 범위의 최대 y 좌표
            duration: 1000, // 애니메이션 지속 시간 (1초)
            ease: 'Sine.easeInOut', // 효과 종류
            yoyo: true, // 애니메이션을 순방향과 역방향으로 반복
            repeat: -1 // 무한 반복
        });
        
        // 배경 음악 로드 후 바로 재생
        this.backgroundMusic = this.sound.add('bgm3', { loop: true });
        this.backgroundMusic.play();

        // 버튼에 마우스 호버(hover) 이벤트 추가
        this.startBtn.setInteractive();
        this.startBtn.on("pointerover", () => {
            // 마우스 호버 이벤트 처리
            this.startBtn.setScale(1.1); // 버튼 크기를 조절하여 확대
        });

        // 버튼에서 마우스를 떼면 크기를 원래대로 복원
        this.startBtn.on("pointerout", () => {
            this.startBtn.setScale(1); // 버튼 크기를 원래 크기로 복원
        });

        this.startBtn.on("pointerdown", () => {
            this.scene.start("Project");
        });
    }
    update() {
        this.back.tilePositionX += 1;
    }

    shutdown() {
        // 씬이 종료될 때 음악 정지
        if (this.backgroundMusic.isPlaying) {
            this.backgroundMusic.stop();
        }
    }
}
