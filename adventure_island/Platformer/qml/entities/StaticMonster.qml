import QtQuick 2.0
import VPlay 2.0
import "../common"

TiledEntityBase {
    id: staticMonster
    entityType: "staticMonster"

    //  size: 2
    Image {
        width: 20
        height: 20
        //        source: "../../assets/end/butterfly.png"
        //        source: "../../assets/coldImg/monster/walk-1.png"
        source: "../../assets/coldImg/monster/walk-0.png"
    }

    BoxCollider {
        anchors.fill: parent
        bodyType: Body.Static
        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if (otherEntity.entityType === "player") {
                player.contacts++
                player.x = 20
                player.y = 100
                pop.play()
                gameScene.gameInfo.lifeNumberDecrease()
            }
            if (otherEntity.entityType === "bullet") {

                bl.reset()
                removeEntity()
            }
        }
        fixture.onEndContact: {
            var otherEntity = other.getBody().target
            if (otherEntity.entityType === "player")
                player.contacts--
        }
    }
}
