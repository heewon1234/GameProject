class Main extends Phaser.Scene {
  constructor() {
    super({
      key: "index",
    });
  }

  init() {
    this.frame = 0;
    this.enemy_arr = [];
    this.enemy_arr_2 = [];
    this.enemy_arr_count = 0;
    this.enemy_position_arr = [300, 450, 600];
  }

  preload() {
    // 배경 사진 로드
    this.load.image("background", "../SRC/background.jpg");

    // 돌(적) 사진 로드
    this.load.image("enemy", "../SRC/enemy.png");
  }

  create() {
    this.enemy_arr = [];
    let backgroundImage = this.add.image(0, 0, "background").setOrigin(0, 0);
    for(let i = 0; i < 10; i++) {
      for(let k = 0; k < 1; k++) {
        this.enemy_random_index_1 = Math.floor(Math.floor(Math.random() * (2 - 0 + 1)) + 0);
        this.enemy_random_index_2 = Math.floor(Math.floor(Math.random() * (2 - 0 + 1)) + 0);

        if (this.enemy_random_index_1 == this.enemy_random_index_2) {
          while(this.enemy_random_index_1 == this.enemy_random_index_2) {
            this.enemy_random_index_2 = Math.floor(Math.floor(Math.random() * (2 - 0 + 1)) + 0);
          }
        }
        let enemy_1 = this.physics.add.sprite(this.enemy_position_arr[this.enemy_random_index_1] , 0,"enemy");
        let enemy_2 = this.physics.add.sprite(this.enemy_position_arr[this.enemy_random_index_2] , 0,"enemy");
        this.enemy_arr.push(enemy_1, enemy_2);
      }
    }
  }

  create_2() {
    this.enemy_arr_2 = [];
    for(let i = 0; i < 4; i++) {
      for(let k = 0; k < 1; k++) {
        this.enemy_random_index_1 = Math.floor(Math.floor(Math.random() * (2 - 0 + 1)) + 0);
        this.enemy_random_index_2 = Math.floor(Math.floor(Math.random() * (2 - 0 + 1)) + 0);

        if (this.enemy_random_index_1 == this.enemy_random_index_2) {
          while(this.enemy_random_index_1 == this.enemy_random_index_2) {
            this.enemy_random_index_2 = Math.floor(Math.floor(Math.random() * (2 - 0 + 1)) + 0);
          }
        }
        let enemy_1 = this.physics.add.sprite(this.enemy_position_arr[this.enemy_random_index_1] , 0,"enemy");
        let enemy_2 = this.physics.add.sprite(this.enemy_position_arr[this.enemy_random_index_2] , 0,"enemy");
        this.enemy_arr_2.push(enemy_1, enemy_2);
      }
    }
  }
  update() {
    this.frame++;
    $("#point").html(Math.floor(this.frame / 60));

    if(this.frame % 60 == 0) {
      if(this.enemy_arr_count <= 2) {
        console.log("1번 루트");
        console.log(this.enemy_arr_count);
        this.enemy_arr[this.enemy_arr_count].setVelocityY(400);
        this.enemy_arr[this.enemy_arr_count].setOrigin(0.5, 0.5);
  
        this.enemy_arr[this.enemy_arr_count+1].setVelocityY(400);
        this.enemy_arr[this.enemy_arr_count+1].setOrigin(0.5, 0.5);
  
        this.enemy_arr_count = this.enemy_arr_count + 2;

        if(this.enemy_arr_count == 4) {
          this.create_2();
          this.enemy_arr_2[this.enemy_arr_count].setVelocityY(400);
        this.enemy_arr_2[this.enemy_arr_count].setOrigin(0.5, 0.5);
  
        this.enemy_arr_2[this.enemy_arr_count+1].setVelocityY(400);
        this.enemy_arr_2[this.enemy_arr_count+1].setOrigin(0.5, 0.5);
  
        this.enemy_arr_count = this.enemy_arr_count + 2;
        this.enemy_arr_count = 0;
        this.create();
        }
      }
      else {
        console.log("2번 루트");
        console.log(this.enemy_arr_count);
        
        
        
      }

    }

    if(this.frame % 1 == 0) {
      for(let i = 0; i < 10; i++) {
        this.enemy_arr[i].setScale((this.enemy_arr[i].y / 900));
    }
    
    // if(this.enemy_arr_2.length > 1){
    //   this.enemy_arr_2[i].setScale((this.enemy_arr_2[i].y / 900));
    // }
    }

  

    //     
    //     new_enemy_1.setOrigin(0, 0);
    //     new_enemy_1.setImmovable();
    //     new_enemy_1.setVelocityY(400);

    //     
    //     new_enemy_2.setOrigin(0, 0);
    //     new_enemy_2.setVelocityY(400);
    //     new_enemy_1.setScale(0.5);
    //     console.log(new_enemy_2.y);

    //     this.enemy_arr.push(new_enemy_1, new_enemy_2); // 새로운 상자를 배열에 추가
    }
  
  }
