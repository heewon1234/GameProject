 import PopUp from './node_modules/phaser3-rex-plugins/plugins/popup.js';
 import MoveTo from './node_modules/phaser3-rex-plugins/plugins/moveto.js';
// import ScaleDownDestroy from './node_modules/phaser3-rex-plugins/plugins/scale-down-destroy.js';

class Gameover extends Phaser.Scene {
    constructor() {
        super({key : "Gameover"})
    }
    init(data){
        this.finalScore = data.score;
        // console.log(this.finalScore)
    }
    preload() {

    }
    create() {
	
	    let bestScore;
    $.ajax({
      url: "/rankaddBest.rankBoard?game_name=colorblind",
    }).done((resp) => {
      bestScore = resp;
      
    });
    if(this.finalScore > 0) {
        $.ajax({
            url: "/rankReadPoint.rankBoard",
            data: {
                score: this.finalScore,
                game_name: "colorblind",
                rank_type: "point" // 랭킹의 우선 순위가 Time (짧을 수록)이면 type를 time으로, Point(높을 수록)면 point로
            },
            method: "GET"
        }).done(function(resp) {
    console.log(resp);
    if (resp === "true") { // 문자열 "true"와 비교
        alert("축하합니다! 신기록이 달성되었습니다.");
    }})
    }
    
        this.events.on('transitioncomplete', () => {
            let ls = this.add.rectangle(this.cameras.main.x / 3, this.cameras.main.y, this.cameras.main.x / 3, this.cameras.main.y)
            .setFillStyle("#F506FB").setOrigin(1, 0)

            let score = this.add.text(this.cameras.main.centerX, 100, "Score : "+ this.finalScore).setColor('#000000')
            .setFontSize("30px").setFontStyle("bold").setOrigin(0.5,0.5)
            
            let bestScoreText = this.add.text(this.cameras.main.centerX, this.cameras.main.centerY, "최고 기록 : " + bestScore)
        .setOrigin(0.5, 0.5).setFontStyle("bold").setColor('#000000').setFontSize("30px").setPadding(5)

            let restartButton = this.add.text(this.cameras.main.centerX, this.cameras.main.centerY*1.5, 'Try Again')
    .setOrigin(0.5, 0.5)
    .setPadding(10)
    .setFill("#000000")
    .setBackgroundColor("#FFFFFF")
    .setFontSize("20px")
    .setFontStyle("bold")
    .setInteractive({ useHandCursor: true })
    .on('pointerdown', () => {

        this.cameras.main.fadeOut(500, 255,255,255);
    })
    .on('pointerover', () => restartButton.setStyle({ fill: '#f39c12' }))
    .on('pointerout', () => restartButton.setStyle({ fill: '#000000' }))

    PopUp(score, 500);
    PopUp(restartButton, 500);
    PopUp(bestScoreText, 500);

    let moveTo = new MoveTo(ls,{
        speed :300,
        rotateToTarget : false
    })
    moveTo.moveTo(this.cameras.main.x / 3, 0)
    moveTo.enable = true;
        })
        
        this.cameras.main.once(Phaser.Cameras.Scene2D.Events.FADE_OUT_COMPLETE, (cam, effect) => {
            this.scene.transition({target : "ColorBlind"})
        })
    }
    update() {

    }
}

export default Gameover