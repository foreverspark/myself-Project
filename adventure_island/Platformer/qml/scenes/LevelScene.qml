import QtQuick 2.0
import VPlay 2.0
import "../common"

SceneBase {
    id: levelScene

    signal levelPressed(string selectedLevelFileName)

    property int levelIndex: 2
    signal levelAdded

    MenuButton {
        text: "Back"
        anchors.left: parent.gameWindowAnchorItem.left
        anchors.leftMargin: 10
        anchors.top: parent.gameWindowAnchorItem.top
        anchors.topMargin: 10
        onClicked: {
            backButtonPressed()
        }
        z: 1
    }

    Image {
        id: name
        source: "../../assets/coldImg/bg/nightsky.png"       //第二个图片

        anchors.fill: parent
    }
    Grid {
        anchors.centerIn: parent
        spacing: 10
        columns: 5
        MenuButton {
            text: "1"
            width: 50
            height: 50
            color: "lightBlue"
            onClicked: {
                levelPressed("Level1.qml")
            }
        }
        Repeater {
            model: 12
            MenuButton {
                text: index + 2
                width: 50
                height: 50
                opacity: 0.7
                enabled: false
                onClicked: {
                    levelPressed("")
                }
                Image {
                    width: 25
                    height: 25
                    id: lockImage
                    source: "../../assets/img/document-encrypted.svg"
                    anchors.centerIn: parent
                }
            }
        }
    }
}
