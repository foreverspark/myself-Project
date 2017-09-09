import QtQuick 2.0
import VPlay 2.0
import "../common"

SceneBase {
    id: startScene
    width: 480
    height: 320

    signal playPressed

    Image {
        id: bg
        source: "../../assets/coldImg/bg/frame.png" //第一个图片
        anchors.fill: parent
    }

    Image {
        id: cloud
        source: "../../assets/coldImg/bg/cloud.png"
        anchors.top: gameScene.gameWindowAnchorItem.top
        anchors.topMargin: 50
        anchors.left: gameScene.gameWindowAnchorItem.left
        anchors.leftMargin: 200
    }

    Column {
        anchors.centerIn: parent
        spacing: 10
        MenuButton {
            id: play
            radius: 30
            text: "Play"
            onClicked: {
                playPressed()
            }
        }

        MenuButton {
            id: quit
            radius: 30
            text: "Qiut"
            onClicked: Qt.quit()
        }
    }

    PauseMusicButton {
        anchors.top: parent.gameWindowAnchorItem.top
        anchors.topMargin: 10
        anchors.right: parent.gameWindowAnchorItem.right
        anchors.rightMargin: 10
    }
}
