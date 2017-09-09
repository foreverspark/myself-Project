import QtQuick 2.0
import VPlay 2.0
import "../common"

SceneBase {
    id: pauseScene

    //    width: 200
    //    height: 200
    signal reselectLevelButtonPressed
    signal quitButtonPressed
    signal restartButtonPressed

    Image {
        anchors.fill: parent
        source: "../../assets/coldImg/bg/oiltux.jpg"
        z: -1
    }

    FontLoader {
        id: fontType
        source: "assets/font/amazon.ttf"
    }


    //    Text {
    //        id: text
    //        text: "Success"
    //        anchors.centerIn: parent.gameWindowAnchorItem
    //        font.family: fontType.name
    //        font.pixelSize: 50
    //    }
    Column {
        spacing: 10
        anchors.centerIn: parent
        //        MenuButton {
        //            color: "lightBlue"
        //            text: "Restart"
        //            font.pixelSize: 10
        //            onClicked: {
        //                restartButtonPressed()
        //            }
        //        }
        MenuButton {
            color: "lightBlue"
            text: "Quit Game"
            font.pixelSize: 10
            onClicked: {
                quitButtonPressed()
            }
        }
        MenuButton {
            color: "lightBlue"
            font.pixelSize: 10
            text: "Reselect Level"
            onClicked: {
                reselectLevelButtonPressed()
            }
        }
    }
}
