import QtQuick 2.0
import VPlay 2.0

Item {
    width: 5 * gameScene.gridsize
    height: 3 * gameScene.gridSize
    Row {
        Column {
            Coin {
            }
        }
        Column {
            Coin {
            }
            spacing: 32
            Coin {
            }
        }
        Column {
            Coin {
            }
            spacing: 32
            Coin {
            }
            Coin {
            }
        }
    }
}
