import QtQuick 2.0
import VPlay 2.0

TiledEntityBase {
    id: monster

    entityType: "moveBird"

    property int dirction: 1
    property double speed: 100.0 //如果有重力的情况下， 它会飞上天的

    property int perTime: 5000

    property bool isRight: true

    //    SpriteSequenceVPlay {
    //        id: bird
    //        anchors.centerIn: parent

    //        SpriteVPlay {
    //            name:"rightBird"

    //            frameCount: 3
    //            frameRate: 10
    //            frameWidth: 34
    //            frameHeight: 24
    //            source: "../../assets/clodImg/monster/left-2.png"
    //        }

    //        SpriteVPlay{
    //            name:"leftBird"
    //            frameCount: 3
    //            frameRate: 10
    //            frameWidth: 34
    //            frameHeight: 24
    //            source: "../../assets/coldImg/monster/left-3.png"

    //        }
    //    }
    Image {

        id: bird
        source: isRight ? "../../assets/coldImg/monster/right-fish.png" : "../../assets/coldImg/monster/left-fish.png"
    }

    BoxCollider {
        id: boxCollider
        bodyType: Body.Dynamic
        force: Qt.point(speed * dirction, 0)
        anchors.fill: bird

        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if (otherEntity.entityType === "player") {
                player.contacts++
                if (!player.strong) {
                    player.x = 20
                    player.y = 100
                    pop.play()
                    gameScene.gameInfo.lifeNumberDecrease()
                }

                                else{
                                    player.contacts--            //这里碰撞会出问题，是不是销毁了就不在执行OnEndContact
                                    removeEntity()
                                }
                player.strong = false
            }else if(otherEntity.entityType === "bullet") {
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

    //我想让这个定时器每隔多少秒就响一次循环
    Timer {
        id: monsterTimer

        interval: perTime
        running: true

        repeat: true

        onTriggered: {

            boxCollider.body.linearVelocity = Qt.point(0, 0)
            monster.dirction *= -1
            var localForwardVector = boxCollider.body.toWorldVector(
                        Qt.point(monster.speed * monster.dirction, 0))
            boxCollider.body.applyLinearImpulse(
                        localForwardVector, boxCollider.body.getWorldCenter())

            if (boxCollider.linearVelocity.x > 0) {

                isRight = true
            } else {
                isRight = false
            }
        }
    }
}
