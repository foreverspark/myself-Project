import QtQuick 2.0
import VPlay 2.0

MenuButton {
    id: musicButton
    radius: 10
    width: 20
    height: 20

    property string musicIconFileName: "audio-volume-high.svg"

    Image {
        source: "../../assets/img/" + musicIconFileName
        anchors.fill: parent
    }
    onClicked: {
        if (musicIconFileName == "audio-volume-muted.svg") {
            gameScene.bgMusic.play()
            musicIconFileName = "audio-volume-high.svg"
        } else if (musicIconFileName == "audio-volume-high.svg") {
            musicIconFileName = "audio-volume-muted.svg"
            gameScene.bgMusic.pause()
        }
    }
}
