class Main extends Phaser.Scene {
  constructor() {
    super({
      key: "index",
    });
  }

  init() {
    this.frame = 0;
    this.enemy_arr = [];
    this.enemy_arr_count = 0;
    this.enemy_position_arr = [300, 450, 600];
    this.stage_2_stop = false;
    this.stage_3_stop = false;
    this.stage_4_stop = false;
    this.stage_5_stop = false;
    this.stage_6_stop = false;
    this.stage_7_stop = false;
    this.stage_8_stop = false;
    this.stage_9_stop = false;
    this.stage_10_stop = false;
  }

  preload() {
    this.load.image("background", "../SRC/background.jpg");
    this.load.image("enemy", "../SRC/enemy.png");
    this.load.image("player", "../SRC/player.png");
  }

  create() {
    let backgroundImage = this.add.image(0, 0, "background").setOrigin(0, 0);

    this.player = this.physics.add.sprite(415, 475, "player");
    this.player.setOrigin(0, 0);
    this.player.setCollideWorldBounds(true);
    this.player.setSize(20, 30);

    this.cursors = this.input.keyboard.createCursorKeys();
    this.isMovingLeft = false;
    this.isMovingRight = false;
    this.text = this.add.text(910, 12, this.message);

    let bestScore;
    $.ajax({
      url: "/rankaddBest.rankBoard?game_name=fullMoonBoat",
    }).done((resp) => {
      bestScore = resp;
      this.add.text(
        800,
        50,
        "최고 기록 " + bestScore,
        { fontSize: "20px", fill: "#ffffff" }
      );
    });

    let bottomBoundary = this.add.rectangle(
      0,
      this.cameras.main.height - 10,
      this.cameras.main.width,
      5,
      0xffffff
    );
    bottomBoundary.setOrigin(0, 0);
    this.physics.add.existing(bottomBoundary, true);

    this.physics.add.overlap(
      bottomBoundary,
      this.enemy_arr,
      (boundary, enemy) => {
        enemy.destroy();
      }
    );

    this.physics.add.overlap(
      this.player,
      this.enemy_arr,
      () => {
        this.scene.start("over");
      }
    );
  }

  update() {
    this.frame++;
    let stage = 0;

    $("#point").html(Math.floor(this.frame / 60));

    if (this.frame <= 3000 - 300) {
      stage = Math.floor(1 + this.frame / 300);
      this.text.setText("STAGE " + stage);
    }

    if (this.player.x == 265) {
      if (this.cursors.right.isDown && !this.isMovingRight) {
        this.isMovingRight = true;
        this.player.x += 150;
      }
      if (!this.cursors.right.isDown) {
        this.isMovingRight = false;
      }
    }

    if (this.player.x == 415) {
      if (this.cursors.right.isDown && !this.isMovingRight) {
        this.isMovingRight = true;
        this.player.x += 150;
      }
      if (!this.cursors.right.isDown) {
        this.isMovingRight = false;
      }
      if (this.cursors.left.isDown && !this.isMovingLeft) {
        this.isMovingLeft = true;
        this.player.x -= 150;
      }
      if (!this.cursors.left.isDown) {
        this.isMovingLeft = false;
      }
    }

    if (this.player.x == 565) {
      if (this.cursors.left.isDown && !this.isMovingLeft) {
        this.isMovingLeft = true;
        this.player.x -= 150;
      }
      if (!this.cursors.left.isDown) {
        this.isMovingLeft = false;
      }
    }

    if (stage > 0) {
      let delay = 1000 / (11 - stage);
      if (!this[`stage_${stage}_stop`]) {
        this[`stage_${stage}_stop`] = true;
        setTimeout(() => {}, delay);
      } else {
        if (this.frame % (130 - 10 * stage) == 0) {
          this.enemy_arr_count = this.enemy_arr_count + 2;

          let enemy_indices = [];
          while (enemy_indices.length < 2) {
            let enemy_index = Math.floor(
              Math.random() * this.enemy_position_arr.length
            );
            if (!enemy_indices.includes(enemy_index)) {
              enemy_indices.push(enemy_index);
            }
          }

          for (let i = 0; i < 2; i++) {
            let enemy = this.physics.add.sprite(
              this.enemy_position_arr[enemy_indices[i]],
              0,
              "enemy"
            );
            enemy.setSize(100, 100);
            this.enemy_arr.push(enemy);
            enemy.setVelocityY(430 + 30 * stage);
            enemy.setOrigin(0.5, 0.5);
          }
        }

        for (let i = 0; i < this.enemy_arr.length; i++) {
          this.enemy_arr[i].setScale(this.enemy_arr[i].y / 700);
        }
      }
    }
  }
}