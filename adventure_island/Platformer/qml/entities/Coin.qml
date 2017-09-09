import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: coin
    property int row: 0
    property int column: 0
    x: row * gameScene.gridSize
    y: level.height - (column + 1) * gameScene.gridSize
    width: gameScene.gridSize
    height: gameScene.gridSize
    visible: player.x === coin.x ? false : true
    //visible: false
    //    Rectangle{
    //        id:cr
    //        color:"green"
    //        width: 32
    //        height: 32
    //        anchors.fill:parent

    //    }
    Image {
        width: 20
        height: 20
        source: "../../assets/coldImg/powerup/leveldot_green_perfect-0.png"
    }

    BoxCollider {
        anchors.fill: parent
        collisionTestingOnlyMode: true
        fixture.onBeginContact: {
            var otherEntity = other.getBody().target

            if (otherEntity.entityType === "player") {
                eat.play()
                gameScene.gameInfo.coinNumberAdd()
                removeEntity()
            }
        }
    }
}
