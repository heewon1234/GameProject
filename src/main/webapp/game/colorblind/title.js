// import AddEffectPropertiesProperties from './node_modules/phaser3-rex-plugins/plugins/effectproperties.js';
 import ScaleDownDestroy from './node_modules/phaser3-rex-plugins/plugins/scale-down-destroy.js';

class Title extends Phaser.Scene {
    constructor() {
        super({key : "Title"})
    }
    init(){

    }
    preload() {
        this.load.image("logo", "Colorblind_Logo_new_removebg.png");
    }
    create() {

        this.cameras.main.setBackgroundColor("#FFFFFF");
        
        let logo = this.add.image(this.cameras.main.centerX, this.cameras.main.centerY, "logo");
        logo.setOrigin(0.5, 0.5)

        let startButton = this.add.text(this.cameras.main.centerX, this.cameras.main.centerY*1.7, 'START GAME')
    .setOrigin(0.5, 0.5)
    .setPadding(10)
    .setFill("#000000")
    .setBackgroundColor("#FFFFFF")
    .setFontSize("20px")
    .setFontStyle("bold")
    .setInteractive({ useHandCursor: true })
    .on('pointerdown', () => { 
    ScaleDownDestroy(logo, 400);
    ScaleDownDestroy(startButton, 300);
    this.cameras.main.fadeOut(500, 255,255,255);
    })
    .on('pointerover', () => { startButton.setStyle({ fill: '#f39c12' }) })
    .on('pointerout', () => { startButton.setStyle({ fill: '#000000' }) })

    this.cameras.main.once(Phaser.Cameras.Scene2D.Events.FADE_OUT_COMPLETE, (cam, effect) => {
        this.scene.transition({target: "ColorBlind"}) 
    })
    }
    update() {

    }
}

export default Title