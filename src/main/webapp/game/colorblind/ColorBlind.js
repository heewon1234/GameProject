 import PopUp from './node_modules/phaser3-rex-plugins/plugins/popup.js';
 import ScaleDownDestroy from './node_modules/phaser3-rex-plugins/plugins/scale-down-destroy.js';

class ColorBlind extends Phaser.Scene {
    
    constructor() {
        super({key : "ColorBlind"})
    }
    init(){
        this.tiles = []
        this.score = 0;
    }
    preload() {

    }

    create() {
        
        let timer;
        let score;

        let createCircles = () => {
            for(let i = -1; i < 2; i++) {
                for(let j = -1; j < 2; j++) {
                    let tile = this.add.circle(this.cameras.main.centerX + (120*j), this.cameras.main.centerY + (120*i) + 50 ,50)
                    .setInteractive({ useHandCursor: true })
                    
                    this.tiles.push(tile);
                }
            }
            for(let i=0; i<this.tiles.length; i++)
                PopUp(this.tiles[i], 500)
            let rand = Math.floor(Math.random() * 9)
            let randRed = Math.floor((Math.random() * 20) - 10);
            let randGreen = Math.floor((Math.random() * 20) - 10);
            let randBlue = Math.floor((Math.random() * 20) - 10);
            if(randRed < 0) { randRed = -10 } else { randRed = 10 }
            if(randGreen < 0) { randGreen = -10 } else { randGreen = 10 }
            if(randBlue < 0) { randBlue = -5 } else { randBlue = 5 }
            
            let defaultRed =  Math.floor((Math.random() * 235) + 10);
            let defaultGreen =  Math.floor((Math.random() * 235) + 10);
            let defaultBlue =  Math.floor((Math.random() * 235) + 10);
            

            let defaultColor = "0x" + defaultRed.toString(16) + defaultGreen.toString(16) + defaultBlue.toString(16);
            let diffColor = "0x" + (defaultRed + randRed).toString(16) + (defaultGreen + randGreen).toString(16) + (defaultBlue + randBlue).toString(16);
            // console.log("defaultColor : " + defaultColor)
            // console.log(randRed + " " + randGreen + " " + randBlue)
            // console.log("diffColor : " + diffColor)
            for(let i=0;i<9;i++) {
                if(i != rand) {
                    this.tiles[i].setFillStyle(defaultColor).on('pointerdown', ()=> {
                        timer.text -= 1.0;
                    })
                } else {
                    this.tiles[i].setFillStyle(diffColor).on('pointerdown', () => {
                        this.tiles.forEach((el, i) => {
                            ScaleDownDestroy(el, 450);
                        })
                        this.score += 1;
                        score.text = "Score : " + this.score;
                        this.tiles = [];
                        createCircles();
                        timer.text = 5.0;
                    });
                    console.log(i+1);
                }
            }
        }

        this.events.on('transitioncomplete', ()=>{
            // Create Tiles
            createCircles()

            // Create Score
            score = this.add.text(1000, 50, "Score : "+ this.score).setColor('#000000').setFontSize("20px").setFontStyle("bold")

            // Timer Initialize
            timer = this.add.text(this.cameras.main.centerX, 50, "5").setColor("#000000").setOrigin(0.5,0).setFontSize('30px').setFontStyle("bold")
            let interval = setInterval(() => {
                timer.setText((timer.text - 0.01).toFixed(2))
                if(timer.text <= 0.0) {
                    timer.text = 0.00;
                    clearInterval(interval)
                    this.cameras.main.fadeOut(500, 255,255,255);
                    
                }
            } ,10)
        })
        this.cameras.main.once(Phaser.Cameras.Scene2D.Events.FADE_OUT_COMPLETE, (cam, effect) => {
            this.scene.transition({target : "Gameover" , data : {score : this.score}})
        })

    }
    update() {

    }
}

export default ColorBlind