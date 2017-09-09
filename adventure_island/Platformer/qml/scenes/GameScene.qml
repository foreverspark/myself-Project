import VPlay 2.0
import QtQuick 2.0
import "../entities"
import "../levels"
import "../common"
import game.info 1.0

SceneBase {
    id: gameScene
    // the "logical size" - the scene content is auto-scaled to match the GameWindow size
    width: 800
    height: 500
    gridSize: 32

    property int offsetBeforeScrollingStarts: 240
    property string activeFileName
    property bool gameIsOver: false
    property string currentLevelFileName

    property alias gameScenes: gameScene
    property alias bgMusic: bgMusic
    property alias player: player
    property alias crash: crash
    property alias gameInfo: gameInfo

    function restartPlayer() {
        gameScene.player.x = 20
        gameScene.player.y = 100
        gameInfo.reset()
        player.contacts = 0
        player.horizontalVelocity = 0
    }

    GameInfo {
        id: gameInfo
    }
    function setLevel(fileName) {
        activeFileName = fileName
        console.log("set leveled file :" + activeFileName)
        console.log("gameOver is" + gameIsOver)
    }

    BackgroundMusic {
        id: bgMusic
        source: "../../assets/snd/bgm.mp3"
    }
    SoundEffectVPlay {
        id: pop
        source: "../../assets/snd/sfx_die.wav"
        autoPlay: false
    }
    SoundEffectVPlay {
        id: eat
        source: "../assets/snd/pling.wav"
        autoPlay: false
    }
    SoundEffectVPlay {
        id: eatstar
        source: "../assets/snd/onu.wav"
        autoPlay: false
    }
    SoundEffectVPlay {
        id: crash
        source: "../assets/snd/win.wav"
        autoPlay: false
    }

    //重新开始和返回按钮
    Column {
        anchors.right: parent.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: parent.gameWindowAnchorItem.top
        anchors.topMargin: 10
        //        z: 1
        spacing: 10
        MenuButton {
            id: backButton
            text: " "
            radius: 10
            color: "lightBlue"
            width: 20
            height: 20
            onClicked: {
                backButtonPressed()
                activeFileName = ""
            }
            Image {
                source: "../../assets/img/user-home.svg"
                anchors.fill: backButton
            }
        }

        MenuButton {
            id: replayButton
            width: 20
            height: 20
            radius: 10
            color: "lightBlue"
            onClicked: {
                gameScene.restartPlayer()
                currentLevelFileName = activeFileName
                activeFileName = ""
                setLevel(currentLevelFileName)
            }
            Image {
                source: "../../assets/img/edit-undo.svg"
                anchors.fill: parent
            }
        }
        PauseMusicButton {
            id: pauseMusicButton
        }
    }

    //游戏界面的得分等提示
    Row {
        anchors.top: parent.gameWindowAnchorItem.top
        anchors.topMargin: 10
        anchors.left: parent.gameWindowAnchorItem.left
        anchors.leftMargin: 100
        z: 1
        spacing: 50
        Image {
            height: 30
            width: 30
            //            height: gameScene.gameWindowAnchorItem.width * 0.04
            //            width: gameScene.gameWindowAnchorItem.height * 0.04
            source: "../../assets/img/mushroom.png"
            //            anchors.left: lifeRec.left
            //            anchors.top: lifeRec.top
        }
        Image {
            height: 30
            width: 30
            //            height: gameScene.gameWindowAnchorItem.width * 0.05
            //            width: gameScene.gameWindowAnchorItem.height * 0.04
            source: "../../assets/img/coin.png"
        }
        Image {
            height: 30
            width: 30
            //            height: gameScene.gameWindowAnchorItem.width * 0.05
            //            width: gameScene.gameWindowAnchorItem.height * 0.04
            source: "../../assets/img/chronometer-pause.svg"
        }
        Image {
            height: 20
            width: 20
            //            height: gameScene.gameWindowAnchorItem.width * 0.05
            //            width: gameScene.gameWindowAnchorItem.height * 0.04
            source: "../../assets/coldImg/powerup/star-0.png"
        }
    }

    Row {
        anchors.top: parent.gameWindowAnchorItem.top
        anchors.topMargin: 15
        anchors.left: parent.gameWindowAnchorItem.left
        anchors.leftMargin: 120

        spacing: 40
        Rectangle {
            id: lifeRec
            radius: 5
            //            width: gameScene.gameWindowAnchorItem.width * 0.05
            //            height: gameScene.gameWindowAnchorItem.height * 0.03
            width: 40
            height: 15
            Text {
                text: gameInfo.lifeNumber
                anchors.centerIn: parent
            }
        }
        Rectangle {
            id: coinRec
            radius: 5
            width: 40
            //            width: gameScene.gameWindowAnchorItem.width * 0.05
            height: 15
            //            height: gameScene.gameWindowAnchorItem.height * 0.03
            Text {
                text: gameInfo.coinNumber
                anchors.centerIn: parent
            }
        }
        Rectangle {
            id: timeRec
            radius: 5
            width: 40
            //            width: gameScene.gameWindowAnchorItem.width * 0.05
            height: 15
            //            height: gameScene.gameWindowAnchorItem.height * 0.03
            Text {
                text: gameInfo.time
                anchors.centerIn: parent
            }
        }
        Rectangle {
            id: starRec
            radius: 5
            width: 40
            height: 15
            //            width: gameScene.gameWindowAnchorItem.width * 0.05
            //            height: gameScene.gameWindowAnchorItem.height * 0.03
            Text {
                text: gameInfo.starNumber
                anchors.centerIn: parent
            }
        }
    }

    //可以做成精灵动画

    // ... followed by 2 parallax layers with trees and grass
    ParallaxScrollingBackground {
        //        sourceImage: "../../assets/coldImg/bg/云.png"
        sourceImage: "../../assets/coldImg/bg/雪山2.png"
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        anchors.horizontalCenter: gameScene.gameWindowAnchorItem.horizontalCenter

        anchors.left: gameScene.gameWindowAnchorItem.left
        anchors.top: gameScene.gameWindowAnchorItem.top
        movementVelocity: player.x > offsetBeforeScrollingStarts ? Qt.point(
                                                                       -player.horizontalVelocity,
                                                                       0) : Qt.point(
                                                                       0, 0)
        // the speed then gets multiplied by this ratio to create the parallax effect
        ratio: Qt.point(0.3, 0)
        z: -1
    }

    //可以做成精灵动画
    ParallaxScrollingBackground {
        //        sourceImage: "../../assets/coldImg/bg/冰钉.png"
        sourceImage: "../../assets/coldImg/bg/云.png"
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        anchors.horizontalCenter: gameScene.gameWindowAnchorItem.horizontalCenter
        movementVelocity: player.x > offsetBeforeScrollingStarts ? Qt.point(
                                                                       -player.horizontalVelocity,
                                                                       0) : Qt.point(
                                                                       0, 0)
        ratio: Qt.point(0.6, 0)
    }

    // this is the moving item containing the level and player
    Item {
        id: viewPort
        height: loader.height
        width: loader.width
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        x: player.x > offsetBeforeScrollingStarts ? offsetBeforeScrollingStarts
                                                    - player.x : 0 //使游戏界面向左移动

        PhysicsWorld {
            id: physicsWorld
            gravity: Qt.point(0, 25)
            debugDrawVisible: false // enable this for physics debugging
            z: 1000

            onPreSolve: {
                //this is called before the Box2DWorld handles contact events
                var entityA = contact.fixtureA.getBody().target
                var entityB = contact.fixtureB.getBody().target
                if (entityB.entityType === "platform"
                        && entityA.entityType === "player"
                        && entityA.y + entityA.height > entityB.y) {
                    //by setting enabled to false, they can be filtered out completely
                    //-> disable cloud platform collisions when the player is below the platform
                    contact.enabled = false
                }
            }
        }

        //        Level1{

        //        }
        Loader {
            id: loader
            //            z: 2
            source: activeFileName != "" ? "../levels/" + activeFileName : ""
            onLoaded: {
                item.width = gameScene.width
                item.height = gameScene.height
            }
        }

        Player {
            id: player
            x: 20
            y: 100
        }
        Bullet {
            id: bl
            row: -10
            column: -10
        }

        ResetSensor {
            id: resetSensor
            width: player.width
            height: 5
            x: player.x
            anchors.bottom: viewPort.bottom
            // if the player collides with the reset sensor, he goes back to the start
            onContact: {
                pop.play()
                //                restartPlayer()
                gameScene.player.x = 20
                gameScene.player.y = 100
                if (gameInfo.lifeNumber > 0) {
                    gameInfo.lifeNumberDecrease()
                    //                    lifeNumber = lifeNumber - 1
                    //                    if (lifeNumber == 0) {
                    //                        gameOver()
                    //                    }
                }
            }

            Rectangle {
                anchors.fill: resetSensor
                color: "yellow"
                opacity: 0.5
            }
        }
    }

    Timer {
        id: gameTimer
        running: activeFileName != "" && gameIsOver == false
        repeat: true
        onTriggered: {
            if (gameInfo.time > 0)
                gameInfo.timeDecrease()
        }
    }

    //    Rectangle {
    //        anchors.right: parent.right
    //        anchors.bottom: parent.bottom
    //        height: 50
    //        width: 150
    //        color: "blue"
    //        opacity: 0.4
    //        visible: false

    //        Rectangle {
    //            anchors.centerIn: parent
    //            width: 1
    //            height: parent.height
    //            color: "white"
    //        }
    //        MultiPointTouchArea {
    //            anchors.fill: parent
    //            onPressed: {
    //                if (touchPoints[0].x < width / 2)
    //                    controller.xAxis = -1
    //                else
    //                    controller.xAxis = 1
    //            }
    //            onUpdated: {
    //                if (touchPoints[0].x < width / 2)
    //                    controller.xAxis = -1
    //                else
    //                    controller.xAxis = 1
    //            }
    //            onReleased: controller.xAxis = 0
    //        }
    //    }

    //    Rectangle {
    //        // same as the above input control
    //        //visible: !system.desktopPlatform
    //        //enabled: visible
    //        anchors.left: parent.left
    //        anchors.bottom: parent.bottom
    //        height: 100
    //        width: 100
    //        color: "green"
    //        opacity: 0.4

    //        Text {
    //            anchors.centerIn: parent
    //            text: "jump"
    //            color: "white"
    //            font.pixelSize: 9
    //        }
    //        MouseArea {
    //            anchors.fill: parent
    //            onPressed: player.jump()
    //        }
    //    }
    Keys.forwardTo: controller
    TwoAxisController {
        id: controller
        onInputActionPressed: {
            //            console.debug("key pressed actionName " + actionName)
            if (actionName == "up") {
                player.jump()
            }
            if (actionName == "down") {
                bl.sent()
            }
        }
    }
}
