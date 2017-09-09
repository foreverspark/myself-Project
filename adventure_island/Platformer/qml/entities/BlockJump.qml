import QtQuick 2.0
import VPlay 2.0


//为什么人受重力会落下，速度反向就上升，
//而砖受重力不会落下，速度反向不会上升？
TiledEntityBase {

    id: block
    entityType: "blockJump"

    //撞第一次，出现蘑菇。跳
    //撞第二次，蘑菇不出现，只是跳
    //这个用来判断是不是撞第一次
    property bool isFristCollider: true

    width: 32
    height: 32
    MultiResolutionImage {
        id: blockImage
        source: "../../assets/coldImg/struct/off.png"
    }

    BoxCollider {

        id: blockCollider

        //        anchors.fill:parent
        anchors.centerIn: parent
        bodyType: Body.Static

        //        active:!isCollider

        //这个让它无法站上去

        //静态的也无法掉下来

        //        collisionTestingOnlyMode: true
        //这行代码让物体不受重力，无法掉下来

        //这里要发生两次碰撞，一次是人和砖，一次是砖和蘑菇
        //但是只是结束了一次碰撞
        //异常就是撞完后，contacts = 2,不是1（人和地面接触的时候）
        //解决方案有两个
        //一个是蘑菇与砖碰撞的时候，让player.contacts--
        //一个是在撞完后，直接让player.contacts重置为0,失败
        fixture.onBeginContact: {
            var otherEntity = other.getBody().target        //想知道这个other是什么
            console.debug("begin...other is " + otherEntity)


            if (otherEntity.entityType === "player") {
                console.debug("contact platform begin" + player.contacts)

                // increase the number of active contacts the player has
                player.contacts++
            }

            //这里直接用id会不会出问题？
           /* if (player.y > myBlockJump.y)*/
            if(otherEntity.y > block.y){
                blockCollider.bodyType = Body.Dynamic

                blockCollider.linearVelocity.y = player.collider.linearVelocity.y - 250

                blockTimer.start()

                console.debug(
                            "collider block happen! "
                            + blockCollider.linearVelocity.y + player.contacts)
            }
        }

        //撞了之后砖块消失了，所以有不结束碰撞的情况发生！
        //而且那朵花会出来。
        fixture.onEndContact: {
            //            blockTimer.start()
            var otherEntity = other.getBody().target
            if (otherEntity.entityType === "player") {
                console.debug("contact platform end")

                // if the player leaves a platform, we decrease its number of active contacts
                player.contacts--

                //              player.contacts = 0   //这行并不起作用，难道是非法访问？
            }
            console.debug("collider block end!" + player.contacts)

            //            if( blockCollider.bodyType === Body.Static)
            //            {
            //                console.debug("now blockCollider type is static")
            //            }else{
            //                console.debug("now blockCollider type is Dysic")
            //            }
        }
    }

    Timer {
        id: blockTimer
        interval: 400
        onTriggered: {
            block.blockReset()

            //为什么直接在里面写不行，写个函数就可以了
            console.debug("time triggered")

            //想让它成为变量

            if(block.isFristCollider)
            {

            myMushroom.opacity = 1 //不透明

            myMushroom.isCanEat = true
            }

             block.isFristCollider = false

            //            idName.opacity = 1
            //            idName.isCanEat = true
            //            if (blockCollider.bodyType === Body.Static) {
            //                console.debug("time triggered blockCollider type is static")
            //            } else {
            //                console.debug("time triggered blockCollider type is Dysic")
            //            }
        }
    }

    //这里直接用id会不会出问题？
    function blockReset() {
        block.x = myBlockJump.row * gameScene.gridSize
        block.y = level.height - (myBlockJump.column + 1) * gameScene.gridSize
        blockCollider.bodyType = Body.Static //这条语句不起作用
        //        block
    }

    //    function setInnateId(innateName) {
    //        var idName = innateName

    //        idName.opacity = 1
    //        idName.isCanEat = true
    //    }
}
