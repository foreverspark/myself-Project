import VPlay 2.0
import QtQuick 2.0
import "../entities"
import "../common" as Levels

Levels.LevelBase {
    id: level

    //    property alias crach:gameScene.crash
    width: 42 * gameScene.gridSize // 42 because our last tile is a size 30 Ground at row 12

    //    z: 2a
    Ground {
        row: 0
        column: 0
        size: 9
    }

    Ground {
        row: 9
        column: 0
        size: 53
    }
    Ground {
        row: 65
        column: 0
        size: 16
    }
    Ground {
        row: 83
        column: 0
        size: 2
    }
    Ground {
        row: 87
        column: 0
        size: 6
    }
    Ground {
        row: 95
        column: 0
        size: 31
    }

    Block {
        row: 7
        column: 3
        size: 1
    }
    Block {
        row: 9
        column: 3
        size: 1
    }
    Block {
        row: 10
        column: 3
        size: 1
    }

    Block {
        row: 13
        column: 4
        size: 1
    }

    Block {
        row: 17
        column: 4
        size: 3
    }

    Block {
        row: 33
        column: 3
        size: 2
    }
    Block {
        row: 54
        column: 3
        size: 2
    }

    Block {
        row: 57
        column: 1
        size: 5
    }

    Block {
        row: 59
        column: 2
        size: 3
    }

    Block {
        row: 60
        column: 3
        size: 2
    }
    Block {
        row: 61
        column: 4
        size: 1
    }

    Block {
        row: 61
        column: 5
        size: 1
    }
    Block {
        row: 61
        column: 6
        size: 1
    }

    Block {
        row: 61
        column: 7
        size: 1
    }

    Block {
        row: 75
        column: 3
        size: 1
    }
    Block {
        row: 78
        column: 3
        size: 1
    }

    Block {
        row: 96
        column: 3
        size: 5
    }
    Block {
        row: 97
        column: 1
        size: 3
    }
    Block {
        row: 101
        column: 2
        size: 3
    }
    Block {
        row: 102
        column: 4
        size: 2
    }

    Block {
        row: 101
        column: 5
        size: 1
    }

    Block {
        row: 104
        column: 5
        size: 1
    }
    Block {
        row: 105
        column: 6
        size: 2
    }
    Block {
        row: 114
        column: 4
        size: 3
    }

    Block2 {
        row: 8
        column: 3
        size: 1
    }
    Block2 {
        row: 9
        column: 5
        size: 1
    }
    Block2 {
        row: 10
        column: 3
        size: 1
    }
    Block2 {
        row: 22
        column: 3
        size: 2
    }
    Block2 {
        row: 52
        column: 3
        size: 2
    }
    Block2 {
        row: 76
        column: 3
        size: 2
    }
    BlockAdvanced {
        id: ba2
        row: 3
        column: 3
        property int oldx: row * gameScene.gridSize
        property int oldy: level.height - (column + 1) * gameScene.gridSize

        onChangepositon: {

            //          yin.anchors.bottom=ba.top
            //          yin.anchors.left = ba.left
            ba2.vspeed = -400
            ba2.hspeed = 0
        }

        Timer {
            id: bat2
            interval: 10
            running: true
            repeat: true

            onTriggered: {
                ba2.hspeed = 0
                //console.log("ba.iniy",ba.iniy)
                //console.log("ba.y",ba.y)
                if (ba2.type === Body.Dynamic && ba2.vspeed > 0) {
                    if (ba2.y > ba2.oldy - 5 && ba2.y < ba2.oldy + 5) {
                        ba2.type = Body.Static
                        ba2.x = ba2.oldx
                        ba2.y = ba2.oldy
                        //yin.x=ba.oldx
                        //yin.y = ba.oldy-64
                    }
                }
            }
        }
    }

    Bucket {
        row: 15
        column: 2
        size: 2
    }
    Bucket {
        row: 42
        column: 2
        size: 2
    }
    Bucket {
        row: 48
        column: 3
        size: 3
    }
    Bucket {
        row: 66
        column: 2
        size: 2
    }

    Bucket {
        row: 72
        column: 3
        size: 3
    }
    Bucket {
        row: 109
        column: 3
        size: 3
    }

    StaticMonster {
        row: 13
        column: 5
    }

    StaticMonster {
        row: 33
        column: 4
    }
    StaticMonster {
        row: 45
        column: 1
    }
    StaticMonster {
        row: 91
        column: 1
    }
    Coin {
        id: co
        row: 26
        column: 3
    }
    Coin {
        row: 27
        column: 4
    }
    Coin {
        row: 28
        column: 5
    }

    Coin {
        row: 29
        column: 4
    }
    Coin {
        row: 30
        column: 3
    }
    Coin {

        row: 36
        column: 3
    }
    Coin {
        row: 37
        column: 4
    }
    Coin {
        row: 38
        column: 5
    }

    Coin {
        row: 39
        column: 4
    }
    Coin {
        row: 40
        column: 3
    }

    Star {
        row: 69
        column: 5
    }

    Star {
        row: 46
        column: 5
    }

    Star {
        row: 103
        column: 6
    }

    //一个问题，刚开始鸟儿不需要都落到地上，鸟儿可以在砖块上
    MoveBird {
        row: 15
        column: 3
        perTime: 6000 //鸟儿单次往/返时间
        speed: 120
    }
    MoveBird {
        row: 20
        column: 4
        perTime: 5000 //鸟儿单次往/返时间
        speed: 180
    }

    MoveBird {
        row: 8
        column: 3
        perTime: 1000 //鸟儿单次往/返时间
        speed: 50
    }

    BlockJump {
        id: myBlockJump
        row: 5
        column: 3
        //        setInnateId(myMushroom)
        //        idName: myMushroom

        //这个函数可以执行，但是是var，并不能访问到id.的property
        //        Timer{
        //            interval: 10
        //            onTriggered: {
        //                myBlockJump.setInnateId(myMushroom)
        //                running = false
        //            }
        //        }
    }

    Mushroom {
        id: myMushroom //不能用属性y，会出现问题
        row: myBlockJump.row
        column: myBlockJump.column + 1

        //        enabled: false
        anchors.left: myBlockJump.left
        opacity: 0 //透明
    }
    InvisibleCoin {

        //InvisibleCoin
        anchors.fill: myBlockJump
    }

    BlockAdvanced {
        id: ba
        row: 3
        column: 3
        property int oldx: row * gameScene.gridSize
        property int oldy: level.height - (column + 1) * gameScene.gridSize

        onChangepositon: {

                     // yin.anchors.bottom=ba.top
                      //yin.anchors.left = ba.left
            ba.vspeed = -400
            ba.hspeed = 0
        }

        Timer {
            id: bat
            interval: 10
            running: true
            repeat: true

            onTriggered: {
                ba.hspeed = 0
                //console.log("ba.iniy",ba.iniy)
                //console.log("ba.y",ba.y)
                if (ba.type === Body.Dynamic && ba.vspeed > 0) {
                    if (ba.y > ba.oldy - 5 && ba.y < ba.oldy + 5) {
                        ba.type = Body.Static
                        ba.x = ba.oldx
                        ba.y = ba.oldy
                        //yin.x=ba.oldx
                        //yin.y = ba.oldy-64
                    }
                }
            }
        }
    }

//    BlockJumpOnly{
//        row:1
//        column: 3
//    }

//    BlockJumpOnly{
//        row:2
//        column: 3
//    }

    BlockJumpOnly {
        row: 34
        column: 6
    }


    BlockJumpOnly {
        row: 40
        column: 5
    }
    BlockJumpOnly {
        row: 41
        column: 5
    }
    BlockJumpOnly {
        row: 85
        column: 4
    }
    BlockJumpOnly {
        row: 105
        column: 3
    }
    MoveBird {
        row: 77
        column: 4
    }
    MoveBird {
        row: 98
        column: 4
    }

    Flagpole {
        row: 124
        column: 1
    }
    Flag {
        row: 124
        column: 4
    }
    SoundEffectVPlay {
        id: eat
        source: "../../assets/snd/pling.wav"
        autoPlay: false
    }
    SoundEffectVPlay {
        id: eatstar
        source: "../../assets/snd/onu.wav"
        autoPlay: false
    }
    SoundEffectVPlay {
        id: crash
        source: "../../assets/snd/win.wav"
        autoPlay: false
    }

    //    MoveMOnster {
    //        id: mm
    //        row: 2
    //        column: 4
    //        function back() {
    //            if (x == 6 * gameScene.gridSize) {
    //                na.from = 6 * gameScene.gridSize
    //                na.to = 2 * gameScene.gridSize
    //                na.start()
    //            }
    //            if (x == 2 * gameScene.gridSize) {
    //                na.from = 2 * gameScene.gridSize
    //                na.to = 6 * gameScene.gridSize
    //                na.start()
    //            }
    //        }

    //        NumberAnimation on x {
    //            id: na
    //            from: 2 * gameScene.gridSize
    //            to: 6 * gameScene.gridSize
    //            duration: 4000
    //            onStopped: mm.back()
    //        }
    //    }
    //    MoveMOnster {
    //        id: mm2
    //        row: 68
    //        column: 1
    //        function back() {
    //            if (x == 71 * gameScene.gridSize) {
    //                na2.from = 71 * gameScene.gridSize
    //                na2.to = 68 * gameScene.gridSize
    //                na2.start()
    //            }
    //            if (x == 68 * gameScene.gridSize) {
    //                na2.from = 68 * gameScene.gridSize
    //                na2.to = 71 * gameScene.gridSize
    //                na2.start()
    //            }
    //        }

    //        NumberAnimation on x {
    //            id: na2
    //            from: 68 * gameScene.gridSize
    //            to: 71 * gameScene.gridSize
    //            duration: 4000
    //            onStopped: mm2.back()
    //        }
    //    }
}
