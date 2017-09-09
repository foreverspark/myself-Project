import QtQuick 2.0
import VPlay 2.0
import "../common"

TiledEntityBase {
    id: moveMonster

    entityType: "moveMonster"

    //  size: 2
    //    Image {
    //        id: img
    //        width: 20
    //        height: 20
    //        source: "../../assets/img/bird_0.png"
    //    }
    AnimatedSpriteVPlay {
        id: sprite
        frameCount: 3
        frameRate: 10
        frameWidth: 34
        frameHeight: 24
        source: "../../assets/coldImg/monster/right-fish.png"
    }

    BoxCollider {
        id: mmb
        width: 20
        height: 20
        anchors.fill: parent
        bodyType: Body.Static
        //linearVelocity:Qt.point(300,0)
        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if (otherEntity.entityType === "player") {
                player.contacts++
                player.x = 20
                player.y = 100
                pop.play()
            }
        }
        fixture.onEndContact: {
            var otherEntity = other.getBody().target
            if (otherEntity.entityType === "player")
                player.contacts--
        }
    }

    MovementAnimation {
        target: sprite
        property: "x"
        minPropertyValue: 19 * 32 + 32 * 5
        running: true
        velocity: 100 //向右移动的速度
        onLimitReached: {
            if (moveMonster.x == 19 * 32 + 32 * 5)
                velocity = -100
            else if (moveMonster.x == 19 * 32) {
                velocity = 100
            }
        }
    }
    //    SequentialAnimation {
    //        running: sprite
    //        loops: Animation.Infinite
    //        NumberAnimation {
    //            target: rectangle
    //            duration: 1500
    //            property: "anchor.horizontalCenterOffset"
    //        }
    //    }
}
