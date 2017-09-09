import QtQuick 2.0
import VPlay 2.0

TiledEntityBase {
  id: block2
  entityType: "block2"

  size: 1 // must be >= 2 and even (2,4,6,...), because we got a sprite for the start, one for the end and 2 center sprites that are only repeatable if both are used

  Row {
    id: tileRow
    Tile {
      pos: "left"
      image: "../../assets/coldImg/struct/full-1.png"
    }
    Repeater {
      model: size-1
      Tile {
        pos: "mid"

        image: "../../assets/coldImg/struct/full-0.png"
      }
    }

  }



  BoxCollider {
    id: collider
    anchors.fill: parent
    bodyType: Body.Static

    fixture.onBeginContact: {
      var otherEntity = other.getBody().target
      if(otherEntity.entityType === "player") {
        console.debug("contact block2 begin")
        console.log("player.contacs",player.contacts)



        // increase the number of active contacts the player has
        player.contacts++
        crash.play()
      }
//      if (otherEntity.entityType === "bullet") {
//          bl.reset()
//      }
    }

    fixture.onEndContact: {
      var otherEntity = other.getBody().target
      if(otherEntity.entityType === "player") {
        console.debug("contact block2 end")

        // if the player leaves a platform, we decrease its number of active contacts
        player.contacts--
          console.log("player.contacs",player.contacts)

      }
    }
  }
}
