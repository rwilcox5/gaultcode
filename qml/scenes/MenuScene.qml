import VPlay 2.0
import QtQuick 2.0
import "../common"

SceneBase {
    id: menuScene

    // signal indicating that the selectLevelScene should be displayed
    signal selectLevelPressed
    // signal indicating that the creditsScene should be displayed
    signal creditsPressed
    signal editorPressed

    // background
    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        color: "#47688e"
    }

    // the "logo"
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 30
        font.pixelSize: 30
        color: "#e9e9e9"
        text: "Mission Solitaire"
    }

    // menu
    Column {
        anchors.centerIn: parent
        spacing: 10
        MenuButton {
            text: "Level Up"
            onClicked: selectLevelPressed()
        }
        MenuButton {
            text: "Game On"
            onClicked: creditsPressed()
        }
        MenuButton {
            text: "Level Editor"
            onClicked: editorPressed()
        }
    }

    // a little V-Play logo is always nice to have, right?
    Image {
        source: "../../assets/img/vplay-logo.png"
        width: 60
        height: 60
        anchors.right: menuScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.bottom: menuScene.gameWindowAnchorItem.bottom
        anchors.bottomMargin: 10
    }
}
