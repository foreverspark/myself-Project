import QtQuick 2.0
import VPlay 2.0

import "../common"

TiledEntityBase {
    id: ground
    entityType: "ground"

    //    width: tileRow.width * 0.7
    size: 2 // must be >= 2, because we got a sprite for the start, one for the end and a repeatable center sprite

    Row {
        id: tileRow

        //        Image:"../../assets/coldImg/plantfrom/ground.png"
        Tile {
            pos: "left"
            image: "../../assets/coldImg/plantfrom/ground.png"
        }
        Repeater {
            model: size - 2
            Tile {
                pos: "mid"
                image: "../../assets/coldImg/plantfrom/ground.png"
            }
        }
        Tile {
            pos: "right"
            image: "../../assets/coldImg/plantfrom/ground.png"
        }
    }

    //    Image {
    //        id: gound
    //        source: "../../assets/coldImg/plantfrom/ground.png"
    //    }
    BoxCollider {
        anchors.fill: parent
        bodyType: Body.Static
        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if (otherEntity.entityType === "player")
                player.contacts++
        }
        fixture.onEndContact: {
            var otherEntity = other.getBody().target
            if (otherEntity.entityType === "player")
                player.contacts--
        }
    }
}
