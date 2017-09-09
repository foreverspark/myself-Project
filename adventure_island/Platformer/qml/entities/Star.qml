import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: star
    entityType: "star"
    property int column: 0
    property int row: 0
    x: row * gameScene.gridSize
    y: level.height - (column + 1) * gameScene.gridSize
    width: gameScene.gridSize
    height: gameScene.gridSize

    signal eatStar

    Image {
        width: 20
        height: 20
        source: "../../assets/coldImg/powerup/star-0.png"
    }
    BoxCollider {
        anchors.fill: parent
        collisionTestingOnlyMode: true
        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            // if the player hits the sensor, we emit a signal which will be used to reset the player
            if (otherEntity.entityType === "player") {
                removeEntity()
                eatstar.play()
                gameScene.gameInfo.starNumberAdd()
            }
        }
    }
}
