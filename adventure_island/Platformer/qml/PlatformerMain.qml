import VPlay 2.0
import QtQuick 2.0
import "scenes"
import game.info 1.0

GameWindow {
    id: gameWindow

    screenWidth: 800
    screenHeight: 500

    property string currentLevelFileName

    EntityManager {
        id: entityManager
    }

    MenuScene {
        id: menuScene
        onPlayPressed: {
            gameWindow.state = "levelScene"
        }
        onBackButtonPressed: nativeUtils.displayMessageBox(
                                 "Really qiut the game?", "", 2)
        Connections {
            target: nativeUtils
            onMessageBoxFinished: {
                if (accepted && gameWindow.activeScene === menuScene)
                    Qt.quit()
            }
        }
    }

    GameScene {
        id: gameScene
        onBackButtonPressed: {
            gameWindow.state = "levelScene"
            //            gameScene.opacity = 0
            gameScene.restartPlayer()
        }
        gameInfo.onTimeEnded: {
            gameWindow.state = "finalScene"
            currentLevelFileName = gameScene.activeFileName
            console.log("current file is: " + currentLevelFileName)
            gameScene.setLevel("")
        }
        gameInfo.onGameOver: {
            gameWindow.state = "finalScene"
            currentLevelFileName = gameScene.activeFileName
            console.log("current file is: " + currentLevelFileName)
            gameScene.restartPlayer()
            gameScene.setLevel("")
        }
    }

    LevelScene {
        id: levelScene
        onBackButtonPressed: gameWindow.state = "menuScene"
        onLevelPressed: {
            //selectedLevelFileName是信号levelPressed的参数
            gameWindow.state = "gameScene"
            gameScene.setLevel(selectedLevelFileName)
            gameScene.restartPlayer()
        }
    }

    FinalScene {
        id: finalScene
        onReselectLevelButtonPressed: {
            gameWindow.state = "levelScene"
        }
        //        onRestartButtonPressed: {
        //            gameWindow.state = "gameScene"
        //            console.log("current file is: " + currentLevelFileName)
        //            console.log("the activeFileName is: " + gameScene.activeFileName)
        //            gameScene.setLevel(currentLevelFileName)
        //            gameScene.restartPlayer()
        //        }
        onQuitButtonPressed: Qt.quit()
    }

    state: "menuScene"
    activeScene: menuScene

    states: [
        State {
            name: "menuScene"
            PropertyChanges {
                target: menuScene
                opacity: 1
            }
            PropertyChanges {
                target: gameWindow
                activeScene: menuScene
            }
        },
        State {
            name: "gameScene"
            PropertyChanges {
                target: gameScene
                opacity: 1
            }
            PropertyChanges {
                target: gameWindow
                activeScene: gameScene
            }
        },
        State {
            name: "levelScene"
            PropertyChanges {
                target: levelScene
                opacity: 1
            }
            PropertyChanges {
                target: gameWindow
                activeScene: levelScene
            }
        },
        State {
            name: "PauseScene"
            PropertyChanges {
                target: pauseScene
                opacity: 1
            }
            PropertyChanges {
                target: gameWindow
                activeScene: pauseScene
            }
        },
        State {
            name: "finalScene"
            PropertyChanges {
                target: finalScene
                opacity: 1
            }
            PropertyChanges {
                target: gameWindow
                activeScene: finalScene
            }
        }
    ]
}
