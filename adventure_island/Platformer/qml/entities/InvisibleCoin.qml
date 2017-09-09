import QtQuick 2.0
import VPlay 2.0

TiledEntityBase {

    id: invisibleCoin

    entityType: "invisibleCoin"

    Image {
        id: invisibleImage
        source: "../../assets/coldImg/powerup/ice_flower-0.png"
        visible: false     //不能看见。只是用来处理bug加的
    }
    CircleCollider {
        radius: 13
        anchors.fill: parent

        //        active: !collected

        //不能碰撞，当蘑菇被收藏
        bodyType: Body.Static
        collisionTestingOnlyMode: true

        fixture.onBeginContact: {
            var otherEntity = other.getBody().target

            //            if (otherEntity.entityType === "player") {
            //                eat.play()
            //                //                gameScene.coinNumber = gameScene.coinNumber + 1
            //                player.isEatMushroom = true

            //                //因为在player.qml中不能访问Mushroom 的id，所以也得不到它的property:collected
            //                //所以在这里这样用
            //                removeEntity()
            //                            collected = true
            //            }
            //            if(myMushroom.collected)         //因为蘑菇吃了被销毁，这个为null，无法检测,也可以用Null来检测
            if (player.isEatMushroom) {
                if (otherEntity.entityType === "blockJump") {
                    player.contacts--
                    console.debug(
                                "invisble collider, this is " + player.contact)
                }
            }
        }
    }
}
