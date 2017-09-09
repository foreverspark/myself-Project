import QtQuick 2.0
import VPlay 2.0

TiledEntityBase {

    id: mushroom

    entityType: "mushroom"

    property bool collected: false


     property bool isCanEat: false             //是可以吃，可见即可吃

    Image {
        id: mushroomImage
        source: "../../assets/coldImg/powerup/ice_flower-0.png"
        visible: !collected
    }
    CircleCollider {
        radius: 13
        anchors.fill: parent

        active: !collected

        //不能碰撞，当蘑菇被收藏
        bodyType: Body.Static
        collisionTestingOnlyMode: true

        fixture.onBeginContact: {
            var otherEntity = other.getBody().target

            if (otherEntity.entityType === "player") {
                if(isCanEat)
                {
                    eat.play()
                    //                gameScene.coinNumber = gameScene.coinNumber + 1
                    player.isEatMushroom = true
                    player.strong = true

                    //因为在player.qml中不能访问Mushroom 的id，所以也得不到它的property:collected
                    //所以在这里这样用
                    removeEntity()
                    collected = true
                }
            }
            if (otherEntity.entityType === "blockJump") {
                player.contacts--
            }
        }
    }



    function mushroomCollect() {
        mushroom.collected = true
    }

    function reset() {
        mushroom.collected = false
    }
}
