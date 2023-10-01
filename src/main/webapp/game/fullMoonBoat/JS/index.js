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
    // 배경 사진 로드
    this.load.image("background_index", "../SRC/background_index.jpg");

    // 돌(적) 사진 로드
    this.load.image("enemy", "../SRC/enemy.png");

    // 플레이어 사진 로드
    this.load.image("player", "../SRC/player.png");
  }

  create() {
	
	        let bestScore;
        $.ajax({
	url: "/rankaddBest.rankBoard?game_name=fullMoonBoat",
    }).done((resp) => {
      bestScore = resp;
      this.add.text(
        130,
        30,
        "BEST: " + bestScore,
        {fontFamily: 'Arial', fontSize: 24, fontWeight : 'bold' }
      ).setOrigin(0.5);
    });
	
	
    let backgroundImage = this.add.image(0, 0, "background_index").setOrigin(0, 0);

    this.player = this.physics.add.sprite(415, 475, "player"); // 씬에 추가하면 물리 안 받고, 피직스에 넣으면 물리 받음 뒤 스프라이트는 좌표임
    this.player.setOrigin(0, 0);
    this.player.setCollideWorldBounds(true); // 세계에 튕겨져 나가지 않겠다는거임
    this.player.setSize(20, 30);

    this.cursors = this.input.keyboard.createCursorKeys();
    this.isMovingLeft = false; // 왼쪽으로 이동 중인지 여부
    this.isMovingRight = false; // 오른쪽으로 이동 중인지 여부
    this.stage = this.add.text(this.cameras.main.width / 2 + 15, 30, this.message, {fontFamily: 'Arial', fontSize: 24, fontWeight : 'bold' }).setOrigin(0.5);
    this.time_score = this.add.text(this.cameras.main.width -100, 30, this.message, {fontFamily: 'Arial', fontSize: 24, fontWeight : 'bold' }).setOrigin(0.5);

    let bottomBoundary = this.add.rectangle(
      0,
      this.cameras.main.height + 5, // 이 부분을 조정하여 선을 원하는 위치에 그릴 수 있습니다.
      this.cameras.main.width,
      5,
      0xffffff
    );
    bottomBoundary.setOrigin(0, 0);
    this.physics.add.existing(bottomBoundary, true);

    this.physics.add.overlap(
      bottomBoundary,
      this.enemy_arr, // 수정된 부분: "getChildren()" 제거
      (boundary, enemy) => {
        enemy.destroy(); // 충돌한 적 삭제
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

    // 스테이지 구간 조절
    if (this.frame <= 3000 - 300) {
      stage = Math.floor(1 + this.frame / 300);
      this.stage.setText("STAGE: " + stage);
    }
    
    this.time_score.setText("SCORE: " + Math.floor(this.frame / 60));

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

    // 1라운드 시작

    if (stage == 1) {
      if (this.frame % 130 == 0) {
        this.enemy_arr_count = this.enemy_arr_count + 2;

        this.enemy_random_index_1 = Math.floor(
          Math.floor(Math.random() * (2 - 0 + 1)) + 0
        );
        this.enemy_random_index_2 = Math.floor(
          Math.floor(Math.random() * (2 - 0 + 1)) + 0
        );

        if (this.enemy_random_index_1 == this.enemy_random_index_2) {
          while (this.enemy_random_index_1 == this.enemy_random_index_2) {
            this.enemy_random_index_2 = Math.floor(
              Math.floor(Math.random() * (2 - 0 + 1)) + 0
            );
          }
        }

        let enemy_1 = this.physics.add.sprite(
          this.enemy_position_arr[this.enemy_random_index_1],
          0,
          "enemy"
        );
        let enemy_2 = this.physics.add.sprite(
          this.enemy_position_arr[this.enemy_random_index_2],
          0,
          "enemy"
        );
        enemy_1.setSize(100, 100);
        enemy_2.setSize(100, 100);
        this.enemy_arr.push(enemy_1, enemy_2);

        this.enemy_arr[this.enemy_arr_count - 2].setVelocityY(430);
        this.enemy_arr[this.enemy_arr_count - 2].setOrigin(0.5, 0.5);

        this.enemy_arr[this.enemy_arr_count - 1].setVelocityY(430);
        this.enemy_arr[this.enemy_arr_count - 1].setOrigin(0.5, 0.5);
      }

      for (let i = 0; i < this.enemy_arr.length; i++) {
        this.enemy_arr[i].setScale(this.enemy_arr[i].y / 700);
      }
    }

    // 1라운드 끝
    // 2라운드 시작
    else if (stage == 2) {
      if (!this.stage_2_stop) {
        this.stage_2_stop = true;
        setTimeout(() => {}, 1000);
      } else {
        if (this.frame % 120 == 0) {
          this.enemy_arr_count = this.enemy_arr_count + 2;

          this.enemy_random_index_1 = Math.floor(
            Math.floor(Math.random() * (2 - 0 + 1)) + 0
          );
          this.enemy_random_index_2 = Math.floor(
            Math.floor(Math.random() * (2 - 0 + 1)) + 0
          );

          if (this.enemy_random_index_1 == this.enemy_random_index_2) {
            while (this.enemy_random_index_1 == this.enemy_random_index_2) {
              this.enemy_random_index_2 = Math.floor(
                Math.floor(Math.random() * (2 - 0 + 1)) + 0
              );
            }
          }

          let enemy_1 = this.physics.add.sprite(
            this.enemy_position_arr[this.enemy_random_index_1],
            0,
            "enemy"
          );
          let enemy_2 = this.physics.add.sprite(
            this.enemy_position_arr[this.enemy_random_index_2],
            0,
            "enemy"
          );
          enemy_1.setSize(100, 100);
          enemy_2.setSize(100, 100);
          this.enemy_arr.push(enemy_1, enemy_2);

          this.enemy_arr[this.enemy_arr_count - 2].setVelocityY(460);
          this.enemy_arr[this.enemy_arr_count - 2].setOrigin(0.5, 0.5);

          this.enemy_arr[this.enemy_arr_count - 1].setVelocityY(460);
          this.enemy_arr[this.enemy_arr_count - 1].setOrigin(0.5, 0.5);
        }

        for (let i = 0; i < this.enemy_arr.length; i++) {
          this.enemy_arr[i].setScale(this.enemy_arr[i].y / 700);
        }
      }
    }

    // 2라운드 끝
    // 3라운드 시작
    else if (stage == 3) {
      if (!this.stage_3_stop) {
        this.stage_3_stop = true;
        setTimeout(() => {}, 1000);
      } else {
        if (this.frame % 110 == 0) {
          this.enemy_arr_count = this.enemy_arr_count + 2;

          this.enemy_random_index_1 = Math.floor(
            Math.floor(Math.random() * (2 - 0 + 1)) + 0
          );
          this.enemy_random_index_2 = Math.floor(
            Math.floor(Math.random() * (2 - 0 + 1)) + 0
          );

          if (this.enemy_random_index_1 == this.enemy_random_index_2) {
            while (this.enemy_random_index_1 == this.enemy_random_index_2) {
              this.enemy_random_index_2 = Math.floor(
                Math.floor(Math.random() * (2 - 0 + 1)) + 0
              );
            }
          }

          let enemy_1 = this.physics.add.sprite(
            this.enemy_position_arr[this.enemy_random_index_1],
            0,
            "enemy"
          );
          let enemy_2 = this.physics.add.sprite(
            this.enemy_position_arr[this.enemy_random_index_2],
            0,
            "enemy"
          );
          enemy_1.setSize(100, 100);
          enemy_2.setSize(100, 100);
          this.enemy_arr.push(enemy_1, enemy_2);

          this.enemy_arr[this.enemy_arr_count - 2].setVelocityY(490);
          this.enemy_arr[this.enemy_arr_count - 2].setOrigin(0.5, 0.5);

          this.enemy_arr[this.enemy_arr_count - 1].setVelocityY(490);
          this.enemy_arr[this.enemy_arr_count - 1].setOrigin(0.5, 0.5);
        }

        for (let i = 0; i < this.enemy_arr.length; i++) {
          this.enemy_arr[i].setScale(this.enemy_arr[i].y / 700);
        }
      }
    }
    // 3라운드 끝
    // 4라운드 시작
    else if (stage == 4) {
      if (!this.stage_4_stop) {
        this.stage_4_stop = true;
        setTimeout(() => {}, 1000);
      } else {
        if (this.frame % 100 == 0) {
          this.enemy_arr_count = this.enemy_arr_count + 2;

          this.enemy_random_index_1 = Math.floor(
            Math.floor(Math.random() * (2 - 0 + 1)) + 0
          );
          this.enemy_random_index_2 = Math.floor(
            Math.floor(Math.random() * (2 - 0 + 1)) + 0
          );

          if (this.enemy_random_index_1 == this.enemy_random_index_2) {
            while (this.enemy_random_index_1 == this.enemy_random_index_2) {
              this.enemy_random_index_2 = Math.floor(
                Math.floor(Math.random() * (2 - 0 + 1)) + 0
              );
            }
          }

          let enemy_1 = this.physics.add.sprite(
            this.enemy_position_arr[this.enemy_random_index_1],
            0,
            "enemy"
          );
          let enemy_2 = this.physics.add.sprite(
            this.enemy_position_arr[this.enemy_random_index_2],
            0,
            "enemy"
          );
          enemy_1.setSize(100, 100);
          enemy_2.setSize(100, 100);
          this.enemy_arr.push(enemy_1, enemy_2);

          this.enemy_arr[this.enemy_arr_count - 2].setVelocityY(520);
          this.enemy_arr[this.enemy_arr_count - 2].setOrigin(0.5, 0.5);

          this.enemy_arr[this.enemy_arr_count - 1].setVelocityY(520);
          this.enemy_arr[this.enemy_arr_count - 1].setOrigin(0.5, 0.5);
        }

        for (let i = 0; i < this.enemy_arr.length; i++) {
          this.enemy_arr[i].setScale(this.enemy_arr[i].y / 700);
        }
      }
    }
    // 4라운드 끝
    // 5라운드 시작
    else if (stage == 5) {
      if (!this.stage_5_stop) {
        this.stage_5_stop = true;
        setTimeout(() => {}, 1000);
      } else {
        if (this.frame % 90 == 0) {
          this.enemy_arr_count = this.enemy_arr_count + 2;

          this.enemy_random_index_1 = Math.floor(
            Math.floor(Math.random() * (2 - 0 + 1)) + 0
          );
          this.enemy_random_index_2 = Math.floor(
            Math.floor(Math.random() * (2 - 0 + 1)) + 0
          );

          if (this.enemy_random_index_1 == this.enemy_random_index_2) {
            while (this.enemy_random_index_1 == this.enemy_random_index_2) {
              this.enemy_random_index_2 = Math.floor(
                Math.floor(Math.random() * (2 - 0 + 1)) + 0
              );
            }
          }

          let enemy_1 = this.physics.add.sprite(
            this.enemy_position_arr[this.enemy_random_index_1],
            0,
            "enemy"
          );
          let enemy_2 = this.physics.add.sprite(
            this.enemy_position_arr[this.enemy_random_index_2],
            0,
            "enemy"
          );
          enemy_1.setSize(100, 100);
          enemy_2.setSize(100, 100);
          this.enemy_arr.push(enemy_1, enemy_2);

          this.enemy_arr[this.enemy_arr_count - 2].setVelocityY(550);
          this.enemy_arr[this.enemy_arr_count - 2].setOrigin(0.5, 0.5);

          this.enemy_arr[this.enemy_arr_count - 1].setVelocityY(550);
          this.enemy_arr[this.enemy_arr_count - 1].setOrigin(0.5, 0.5);
        }

        for (let i = 0; i < this.enemy_arr.length; i++) {
          this.enemy_arr[i].setScale(this.enemy_arr[i].y / 700);
        }
      }
    }
    // 5라운드 끝
    // 6라운드 시작
    else if (stage == 6) {
      if (!this.stage_6_stop) {
        this.stage_6_stop = true;
        setTimeout(() => {}, 1000);
      } else {
        if (this.frame % 80 == 0) {
          this.enemy_arr_count = this.enemy_arr_count + 2;

          this.enemy_random_index_1 = Math.floor(
            Math.floor(Math.random() * (2 - 0 + 1)) + 0
          );
          this.enemy_random_index_2 = Math.floor(
            Math.floor(Math.random() * (2 - 0 + 1)) + 0
          );

          if (this.enemy_random_index_1 == this.enemy_random_index_2) {
            while (this.enemy_random_index_1 == this.enemy_random_index_2) {
              this.enemy_random_index_2 = Math.floor(
                Math.floor(Math.random() * (2 - 0 + 1)) + 0
              );
            }
          }

          let enemy_1 = this.physics.add.sprite(
            this.enemy_position_arr[this.enemy_random_index_1],
            0,
            "enemy"
          );
          let enemy_2 = this.physics.add.sprite(
            this.enemy_position_arr[this.enemy_random_index_2],
            0,
            "enemy"
          );
          enemy_1.setSize(100, 100);
          enemy_2.setSize(100, 100);
          this.enemy_arr.push(enemy_1, enemy_2);

          this.enemy_arr[this.enemy_arr_count - 2].setVelocityY(580);
          this.enemy_arr[this.enemy_arr_count - 2].setOrigin(0.5, 0.5);

          this.enemy_arr[this.enemy_arr_count - 1].setVelocityY(580);
          this.enemy_arr[this.enemy_arr_count - 1].setOrigin(0.5, 0.5);
        }

        for (let i = 0; i < this.enemy_arr.length; i++) {
          this.enemy_arr[i].setScale(this.enemy_arr[i].y / 700);
        }
      }
    }

    // 6라운드 끝
    // 7라운드 시작
    else if (stage == 7) {
      if (!this.stage_7_stop) {
        this.stage_7_stop = true;
        setTimeout(() => {}, 1000);
      } else {
        if (this.frame % 70 == 0) {
          this.enemy_arr_count = this.enemy_arr_count + 2;

          this.enemy_random_index_1 = Math.floor(
            Math.floor(Math.random() * (2 - 0 + 1)) + 0
          );
          this.enemy_random_index_2 = Math.floor(
            Math.floor(Math.random() * (2 - 0 + 1)) + 0
          );

          if (this.enemy_random_index_1 == this.enemy_random_index_2) {
            while (this.enemy_random_index_1 == this.enemy_random_index_2) {
              this.enemy_random_index_2 = Math.floor(
                Math.floor(Math.random() * (2 - 0 + 1)) + 0
              );
            }
          }

          let enemy_1 = this.physics.add.sprite(
            this.enemy_position_arr[this.enemy_random_index_1],
            0,
            "enemy"
          );
          let enemy_2 = this.physics.add.sprite(
            this.enemy_position_arr[this.enemy_random_index_2],
            0,
            "enemy"
          );
          enemy_1.setSize(100, 100);
          enemy_2.setSize(100, 100);
          this.enemy_arr.push(enemy_1, enemy_2);

          this.enemy_arr[this.enemy_arr_count - 2].setVelocityY(610);
          this.enemy_arr[this.enemy_arr_count - 2].setOrigin(0.5, 0.5);

          this.enemy_arr[this.enemy_arr_count - 1].setVelocityY(610);
          this.enemy_arr[this.enemy_arr_count - 1].setOrigin(0.5, 0.5);
        }

        for (let i = 0; i < this.enemy_arr.length; i++) {
          this.enemy_arr[i].setScale(this.enemy_arr[i].y / 700);
        }
      }
    }
    // 7라운드 끝
    // 8라운드 시작
    else if (stage == 8) {
      if (!this.stage_8_stop) {
        this.stage_8_stop = true;
        setTimeout(() => {}, 1000);
      } else {
        if (this.frame % 60 == 0) {
          this.enemy_arr_count = this.enemy_arr_count + 2;

          this.enemy_random_index_1 = Math.floor(
            Math.floor(Math.random() * (2 - 0 + 1)) + 0
          );
          this.enemy_random_index_2 = Math.floor(
            Math.floor(Math.random() * (2 - 0 + 1)) + 0
          );

          if (this.enemy_random_index_1 == this.enemy_random_index_2) {
            while (this.enemy_random_index_1 == this.enemy_random_index_2) {
              this.enemy_random_index_2 = Math.floor(
                Math.floor(Math.random() * (2 - 0 + 1)) + 0
              );
            }
          }

          let enemy_1 = this.physics.add.sprite(
            this.enemy_position_arr[this.enemy_random_index_1],
            0,
            "enemy"
          );
          let enemy_2 = this.physics.add.sprite(
            this.enemy_position_arr[this.enemy_random_index_2],
            0,
            "enemy"
          );
          enemy_1.setSize(100, 100);
          enemy_2.setSize(100, 100);
          this.enemy_arr.push(enemy_1, enemy_2);

          this.enemy_arr[this.enemy_arr_count - 2].setVelocityY(640);
          this.enemy_arr[this.enemy_arr_count - 2].setOrigin(0.5, 0.5);

          this.enemy_arr[this.enemy_arr_count - 1].setVelocityY(640);
          this.enemy_arr[this.enemy_arr_count - 1].setOrigin(0.5, 0.5);
        }

        for (let i = 0; i < this.enemy_arr.length; i++) {
          this.enemy_arr[i].setScale(this.enemy_arr[i].y / 700);
        }
      }
    }
    // 8라운드 끝
    // 9라운드 시작
    else if (stage == 9) {
      if (!this.stage_9_stop) {
        this.stage_9_stop = true;
        setTimeout(() => {}, 1000);
      } else {
        if (this.frame % 40 == 0) {
          this.enemy_arr_count = this.enemy_arr_count + 2;

          this.enemy_random_index_1 = Math.floor(
            Math.floor(Math.random() * (2 - 0 + 1)) + 0
          );
          this.enemy_random_index_2 = Math.floor(
            Math.floor(Math.random() * (2 - 0 + 1)) + 0
          );

          if (this.enemy_random_index_1 == this.enemy_random_index_2) {
            while (this.enemy_random_index_1 == this.enemy_random_index_2) {
              this.enemy_random_index_2 = Math.floor(
                Math.floor(Math.random() * (2 - 0 + 1)) + 0
              );
            }
          }

          let enemy_1 = this.physics.add.sprite(
            this.enemy_position_arr[this.enemy_random_index_1],
            0,
            "enemy"
          );
          let enemy_2 = this.physics.add.sprite(
            this.enemy_position_arr[this.enemy_random_index_2],
            0,
            "enemy"
          );
          enemy_1.setSize(100, 100);
          enemy_2.setSize(100, 100);
          this.enemy_arr.push(enemy_1, enemy_2);

          this.enemy_arr[this.enemy_arr_count - 2].setVelocityY(670);
          this.enemy_arr[this.enemy_arr_count - 2].setOrigin(0.5, 0.5);

          this.enemy_arr[this.enemy_arr_count - 1].setVelocityY(670);
          this.enemy_arr[this.enemy_arr_count - 1].setOrigin(0.5, 0.5);
        }

        for (let i = 0; i < this.enemy_arr.length; i++) {
          this.enemy_arr[i].setScale(this.enemy_arr[i].y / 700);
        }
      }
    }

    // 9라운드 끝
    // 10라운드 시작
    else {
      if (!this.stage_10_stop) {
        this.stage_10_stop = true;
        setTimeout(() => {}, 1000);
      } else {
        if (this.frame % 27 == 0) {
          this.enemy_arr_count = this.enemy_arr_count + 2;

          this.enemy_random_index_1 = Math.floor(
            Math.floor(Math.random() * (2 - 0 + 1)) + 0
          );
          this.enemy_random_index_2 = Math.floor(
            Math.floor(Math.random() * (2 - 0 + 1)) + 0
          );

          if (this.enemy_random_index_1 == this.enemy_random_index_2) {
            while (this.enemy_random_index_1 == this.enemy_random_index_2) {
              this.enemy_random_index_2 = Math.floor(
                Math.floor(Math.random() * (2 - 0 + 1)) + 0
              );
            }
          }

          let enemy_1 = this.physics.add.sprite(
            this.enemy_position_arr[this.enemy_random_index_1],
            0,
            "enemy"
          );
          let enemy_2 = this.physics.add.sprite(
            this.enemy_position_arr[this.enemy_random_index_2],
            0,
            "enemy"
          );
          enemy_1.setSize(100, 100);
          enemy_2.setSize(100, 100);
          this.enemy_arr.push(enemy_1, enemy_2);

          this.enemy_arr[this.enemy_arr_count - 2].setVelocityY(750);
          this.enemy_arr[this.enemy_arr_count - 2].setOrigin(0.5, 0.5);

          this.enemy_arr[this.enemy_arr_count - 1].setVelocityY(750);
          this.enemy_arr[this.enemy_arr_count - 1].setOrigin(0.5, 0.5);
        }

        for (let i = 0; i < this.enemy_arr.length; i++) {
          this.enemy_arr[i].setScale(this.enemy_arr[i].y / 700);
        }
      }
    }
  }
}
