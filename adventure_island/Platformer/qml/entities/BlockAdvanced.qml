import QtQuick 2.0
import VPlay 2.0

TiledEntityBase {
    id: blockAdvanced
    entityType: "blockAdvanced"
    signal changepositon
    property alias type: collider.bodyType
    property int iniy: 0
    property alias vspeed:collider.linearVelocity.y
    property alias hspeed:collider.linearVelocity.x
//    property int oldcontacs: 0

    size: 1 // must be >= 2 and even (2,4,6,...), because we got a sprite for the start, one for the end and 2 center sprites that are only repeatable if both are used

    Row {
        id: tileRow
        Tile {
            pos: "left"
            image: "../../assets/coldImg/struct/on.png"
        }
        Repeater {
            model: size-1
            Tile {
                pos: "mid"
                image: "../../assets/coldImg/struct/on.png"
            }
        }

    }



    BoxCollider {
        id: collider
        anchors.fill: parent
        bodyType: Body.Static
        fixedRotation: true
        bullet: true
        sleepingAllowed: false
        force: Qt.point(0,25)


        fixture.onBeginContact: {
            //player.contacs++
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "player") {


                console.debug("contacts blockAdvanced begin")

                if(otherEntity.y+otherEntity.height >= blockAdvanced.y&&(otherEntity.x > blockAdvanced.x-10 && otherEntity.x < blockAdvanced.x + 8) ){
                    collider.bodyType = Body.Dynamic
                    changepositon()

                }



                // increase the number of active contacts the player has
                player.contacts++
                console.log("player.contacs",player.contacts)
                player.contacts--

            }
            if (otherEntity.entityType === "bullet") {
                bl.reset()
            }

        }

        fixture.onEndContact: {
            console.log("end")
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "player") {
                console.debug("contact blockAdvanced end",player.contacs)

                // if the player leaves a platform, we decrease its number of active contacts
            }
        }
    }
}
