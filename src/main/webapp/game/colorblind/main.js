import Title from "./title.js";
import Gameover from "./gameover.js";
import ColorBlind from "./ColorBlind.js";

// 초기 세팅 값
// import ScalePlugin from './rexScale.js'
let option = {
    type: Phaser.AUTO, // 컴퓨터의 상황에 맞는 Game Component 선택
    parent: "wrapper", // 게임을 구동 시킬 구역의 id
    width: "100%",
    height: "100%",
    backgroundColor: "#FFFFFF",
    physics: { // 물리 엔진 선택 
        default: "arcade", // 간단한 물리 엔진 / "matter" : 더 좋은 물리 엔진
        arcade: {
            gravity: { y: 0 },
            debug: true // true로 하면 객체의 테두리가 보임
        }
    },
    // plugins: {
    //     global: [{
    //         key: 'rexScale',
    //         plugin: ScalePlugin,
    //         start: true
    //     }]
    // },
    scene: [Title, ColorBlind, Gameover] // scene 등록 / 클래스 이름을 통해 등록함
}

let game = new Phaser.Game(option);