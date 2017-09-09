import QtQuick 2.0
import VPlay 2.0

TiledEntityBase{
    id:blockJumpOnly
    entityType: "blockJumpOnly"

    width: 32
    height:32

    MultiResolutionImage{
        id:blockImage
        source: "../../assets/coldImg/struct/off.png"
    }

    BoxCollider{
        id:blockCollider

        anchors.centerIn: parent
        bodyType: Body.Static

        fixture.onBeginContact: {
            var otherEntity = other.getBody().target

            console.debug("begin...other is " + otherEntity)

            if(otherEntity.entityType === "player"){
                player.contacts++
                console.debug("collider with player, and contacts is "+ player.contacts)

                if(otherEntity.y > blockJumpOnly.y)
                {

                    blockCollider.bodyType = Body.Dynamic
                    blockCollider.linearVelocity.y = player.collider.linearVelocity.y -250
                    blockTimer.start()
                }
            }
        }

        //为什么执行了计时器，这个函数就不再执行了，这个函数的执行条件是什么！
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

                player.contacts--
                console.debug("collider with player end, contacts is "+ player.contacts)

        }
    }

    function blockReset(){
        blockJumpOnly.x = blockJumpOnly.row * gameScene.gridSize
        blockJumpOnly.y = level.height - (blockJumpOnly.column + 1) * gameScene.gridSize
        blockCollider.bodyType = Body.Static
    }

}
