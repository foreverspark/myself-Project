import QtQuick 2.0
import VPlay 2.0

EntityBase {
    property int column: 0
    property int row: 0
    x: row * gameScene.gridSize
    y: (level.height - (column + 1) * gameScene.gridSize) - 100

    width: 6
    height: 100
    Rectangle {
        id: r
        width: 6
        height: 132
        color: "gray"
        //achors.fill:parent
    }
}
