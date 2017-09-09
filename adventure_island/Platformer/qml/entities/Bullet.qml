import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: bullet
    entityType: "bullet"
    width: 50
    height: 50

    // add some aliases for easier access to those properties from outside
    property alias collider: collider
    property alias horizontalVelocity: collider.linearVelocity.x
    property alias verticalVelocity: collider.linearVelocity.y

    property int startx: 0
    property int endx: 0

    property int column: 0
    property int row: 0

    function sent() {
        collider.bodyType = Body.Dynamic
        bullet.x = player.x + 20
        bullet.y = player.y
    }
    function reset() {
        bullet.x = -50

        collider.bodyType = Body.Static
    }

    x: row * gameScene.gridSize
    y: level.he1ght - (column + 1) * gameScene.gridSize

    // here you could use a SpriteSquenceVPlay to animate your player
    MultiResolutionImage {
        source: "../../assets/coldImg/bullet/egg.png"
    }

    BoxCollider {
        id: collider
        height: parent.height
        width: 30
        anchors.horizontalCenter: parent.horizontalCenter
        //anchors.fill:parent
        // this collider must be dynamic because we are moving it by applying forces and impulses
        bodyType: Body.Static // this is the default value but I wanted to mention it ;)
        fixedRotation: true // we are running, not rolling...
        bullet: true // for super accurate collision detection, use this sparingly, because it's quite performance greedy
        sleepingAllowed: false
        // apply the horizontal value of the TwoAxisController as force to move the player left and right
        force: Qt.point(1000, 0)
        // limit the horizontal velocity
        onLinearVelocityChanged: {
            if (linearVelocity.x > 100)
                linearVelocity.x = 100
            if (linearVelocity.x < -100)
                linearVelocity.x = -100
        }
    }

    Timer {
        id: updateTimer
        // set this interval as high as possible to improve performance, but as low as needed so it still looks good
        interval: 10
        running: true
        repeat: true
        onTriggered: {
            if (collider.linearVelocity.x > 400)
                collider.linearVelocity.x = 400
            if (collider.linearVelocity.x < -100)
                collider.linearVelocity.x = -100
            //bullet.y = player.y
            startx = player.x + 100
            endx = startx + 100

            //        if(bullet.horizontalVelocity===0){
            //            bullet.reset()
            //        }
            if (bullet.x < startx /*-7&&bullet.x<startx+7*/) {
                bullet.horizontalVelocity = 100
                collider.force = Qt.point(1000, 0)
            }
            if (bullet.x > endx /*-7&&bullet.x < endx +7*/) {
                //            bullet.horizontalVelocity = -100
                //            collider.force=Qt.point(-1000,0)
                bullet.reset()
            }
            //            if (bullet.horizontalVelocity === 0) {
            //                removeEntity()
            //            }
        }
    }
}
