import VPlay 2.0
import QtQuick 2.0
import "../common"

SceneBase {
    id: selectLevelScene

    // signal indicating that a level has been selected
    signal levelPressed(string selectedLevel)

    // background
    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        color: "#ece468"
    }

    // back button to leave scene
    MenuButton {
        text: "Back"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: selectLevelScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: selectLevelScene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        onClicked: backButtonPressed()
    }

    // levels to be selected
    Grid {
        anchors.centerIn: parent
        spacing: 10
        columns: 5
        MenuButton {
            text: "1"
            width: 50
            height: 50
            onClicked: {
                levelPressed("Level1.qml")
            }
        }
        MenuButton {
            text: "2"
            width: 50
            height: 50
            onClicked: {
                levelPressed("Level2.qml")
            }
        }
        MenuButton {
            text: "3"
            width: 50
            height: 50
            onClicked: {
                levelPressed("Level3.qml")
            }
        }
        MenuButton {
            text: "4"
            width: 50
            height: 50
            onClicked: {
                levelPressed("Level4.qml")
            }
        }
        MenuButton {
            text: "5"
            width: 50
            height: 50
            onClicked: {
                levelPressed("Level5.qml")
            }
        }
        MenuButton {
            text: "6"
            width: 50
            height: 50
            onClicked: {
                levelPressed("Level6.qml")
            }
        }
        MenuButton {
            text: "7"
            width: 50
            height: 50
            onClicked: {
                levelPressed("Level7.qml")
            }
        }
        MenuButton {
            text: "8"
            width: 50
            height: 50
            onClicked: {
                levelPressed("Level8.qml")
            }
        }
        MenuButton {
            text: "9"
            width: 50
            height: 50
            onClicked: {
                levelPressed("Level9.qml")
            }
        }
        MenuButton {
            text: "10"
            width: 50
            height: 50
            onClicked: {
                levelPressed("Level10.qml")
            }
        }
        MenuButton {
            text: "11"
            width: 50
            height: 50
            onClicked: {
                levelPressed("Level11.qml")
            }
        }
        MenuButton {
            text: "12"
            width: 50
            height: 50
            onClicked: {
                levelPressed("Level12.qml")
            }
        }
        MenuButton {
            text: "13"
            width: 50
            height: 50
            onClicked: {
                levelPressed("Level13.qml")
            }
        }
        Repeater {
            model: 10
            MenuButton {
                text: " "
                width: 50
                height: 50
            }
        }
    }
}
