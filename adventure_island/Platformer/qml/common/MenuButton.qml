import QtQuick 2.0
import VPlay 2.0

Rectangle {
    id: menuButton

    property alias text: buttonText.text
    property alias font: buttonText.font

    width: buttonText.width + paddingHorizontal * 2
    height: buttonText.height + paddingVertical * 2

    color: "lightBlue"
    radius: 20

    property int paddingHorizontal: 10
    property int paddingVertical: 5

    signal clicked

    Text {
        id: buttonText
        anchors.centerIn: parent
        font.pixelSize: 20
        color: "black"
    }

    //    Image {
    //        id: image
    //        source: "../../assets/img/edit-undo.svg"
    //        width: menuButton.width
    //        height: menuButton.height
    //    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: parent.clicked()
        onPressed: parent.opacity = 0.5
        //        onEntered: parent.color = "blue"
        //        onExited: parent.color = "yellow"
        onReleased: parent.opacity = 1
    }
}
