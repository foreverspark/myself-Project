import QtQuick 2.0
import VPlay 2.0


//这个是重构过的可以撞出冰花的砖块
//没有测试过

TiledEntityBase{
    id:blockJumpFlower
    entityType: "blockJumpFlower"

    property bool isFirstCollide: true
    width:32
    height:32

    MultiResolutionImage{
        id:blockImage
        source: "../../assets/coldImg/struct/on.png"     //full-1.png
    }


    Mushroom{
        id:blockMushroom
        row:blockJumpFlower.row
        column: blockJumpFlower.column + 1

        anchors.left:blockJumpFlower.left
        opacity: 0     //透明

    }

    BoxCollider{
        id:blockCollider

        anchors.centerIn: parent
        bodyType: Body.Static

        fixture.onBeginContact: {
            var otherEntity = other.getBody().target

            if(otherEntity.entityType === "player"){
                player.contacts++
                console.debug("collider with player, and contacts is "+ player.contacts)

                if(otherEntity.y > blockJumpFlower.y)
                {

                    blockCollider.bodyType = Body.Dynamic
                    blockCollider.linearVelocity.y = player.collider.linearVelocity.y -250
                    blockTimer.start()
                }
            }
        }

        fixture.onEndContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "player"){
                player.contacts--
                console.debug("collider with player end, contacts is "+ player.contacts)
            }
        }
    }

    Timer{
        id:blockTimer
        interval: 400
        onTriggered: {
            blockJumpOnly.blockReset()
            if(blockJumpFlower.isFirstCollide)
            {
                blockMushroom.opacity = 1
                blockMushroom.isCanEat = true
            }
            blockJumpFlower.isFirstCollide = false
        }
    }

    function blockReset(){
        blockJumpFlower.x = blockJumpFlower.row * gameScene.gridSize
        blockJumpFlower.y = level.height - (blockJumpFlower.column + 1) * gameScene.gridSize
        blockCollider.bodyType = Body.Static
    }
    }
}
