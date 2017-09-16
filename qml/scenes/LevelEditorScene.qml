import VPlay 2.0
import QtQuick 2.0
import "../common"
import QtGraphicalEffects 1.0

import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.5
SceneBase {
    id:levelEditorScene

    // flag indicating if game is running
    property bool gameRunning: 0 == 0
    // width of card
    property int cardWidth: levelEditorScene.gameWindowAnchorItem.width/8.0
    property int deckMargin: (levelEditorScene.gameWindowAnchorItem.width-20.0-levelEditorScene.cardWidth)/23.0
    property int colMargin: (levelEditorScene.gameWindowAnchorItem.width-20.0-7*levelEditorScene.cardWidth)/6.0
    property int stackMargin: levelEditorScene.cardWidth/7.0
    property int cardHeight: levelEditorScene.cardWidth*726/500
    property int colHMargin: cardHeight/7.0
    property int colSelected: 0
    property int numSelected: 0
    property var redCards: theFunctions.createCards([[1,0],[2,0],[3,0],[4,0],[5,0],[6,0],[7,0],[8,0],[9,0],[10,0],[11,0],[12,0],[13,0],[1,1],[2,1],[3,1],[4,1],[5,1],[6,1],[7,1],[8,1],[9,1],[10,1],[11,1],[12,1],[13,1]])
    property var blackCards: theFunctions.createCards([[1,2],[2,2],[3,2],[4,2],[5,2],[6,2],[7,2],[8,2],[9,2],[10,2],[11,2],[12,2],[13,2],[1,3],[2,3],[3,3],[4,3],[5,3],[6,3],[7,3],[8,3],[9,3],[10,3],[11,3],[12,3],[13,3]])
    property var turnCards: []
    property var stackCards: [['back','hearts','white',0],['back','diamonds','white',0],['back','clubs','white',0],['back','spades','white',0]]
    property var colCards: [[],[],[],[],[],[],[]]
    property int turnDisplay: 0
    property int turnSpot: 0
    property var cardSelected: []
    property int cardReady: 0



    // set the name of the current level, this will cause the Loader to load the corresponding level
    function setLevel(fileName) {
        activeLevelFileName = fileName
    }

    // background
    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        color: "#dd94da"
    }


    // back button to leave scene
    MenuButton {
        id: menuButton
        text: 'Menu'
        anchors.left: levelEditorScene.gameWindowAnchorItem.left
        anchors.leftMargin: 100
        anchors.bottom: deckRow.top
        anchors.bottomMargin: 10
        onClicked: {
            backButtonPressed()
            activeLevel = undefined
            activeLevelFileName = ""
        }
    }
    MenuButton {
        text: 'Save'
        anchors.left: menuButton.right
        anchors.leftMargin: 10
        anchors.bottom: deckRow.top
        anchors.bottomMargin: 10
        onClicked: {
            theFunctions.saveLevel();
        }
    }
    Text {
        text: ""
        anchors.left: levelEditorScene.gameWindowAnchorItem.left
        anchors.leftMargin: 60
        anchors.bottom: deckRow.top
        anchors.bottomMargin: 10
    }


    // Deck
    Row {
            id: deckRow
            spacing: -cardWidth+deckMargin; // a simple layout do avoid overlapping
            anchors.left: levelEditorScene.gameWindowAnchorItem.left
            anchors.leftMargin: deckMargin
            anchors.bottom: redRow.top
            anchors.bottomMargin: 10

            Repeater {
                model: turnCards.length; // just define the number you want, can be a variable too
                delegate: Image {
                    sourceSize.width: 500
                    width: cardWidth
                    fillMode: Image.PreserveAspectFit
                    source: "../../assets/img/cards/"+turnCards[index][0]+'_of_'+turnCards[index][1]+'.png'

                }

            }
        }
    // Red Cards
    Row {
            id: redRow
            spacing: -cardWidth+deckMargin; // a simple layout do avoid overlapping
            anchors.left: levelEditorScene.gameWindowAnchorItem.left
            anchors.leftMargin: deckMargin
            anchors.bottom: blackRow.top
            anchors.bottomMargin: 10

            Repeater {
                model: redCards.length; // just define the number you want, can be a variable too
                delegate: Image {
                    sourceSize.width: 500
                    width: cardWidth
                    fillMode: Image.PreserveAspectFit
                    source: "../../assets/img/cards/"+redCards[index][0]+'_of_'+redCards[index][1]+'.png'
                    MouseArea {
                        anchors.fill: parent
                        // since the level is loaded in the levelEditorScene, and is therefore a child of the levelEditorScene, you could also access levelEditorScene.score here and modify it. But we want to keep the logic in the levelEditorScene rather than spreading it all over the place
                        onPressed: theFunctions.moveToGame(redCards[index],0)
                    }

                }

            }
        }
    // Black Cards
    Row {
            id: blackRow
            spacing: -cardWidth+deckMargin; // a simple layout do avoid overlapping
            anchors.left: levelEditorScene.gameWindowAnchorItem.left
            anchors.leftMargin: deckMargin
            anchors.bottom: levelEditorScene.gameWindowAnchorItem.bottom
            anchors.bottomMargin: 10

            Repeater {
                model: blackCards.length; // just define the number you want, can be a variable too
                delegate: Image {
                    sourceSize.width: 500
                    width: cardWidth
                    fillMode: Image.PreserveAspectFit
                    source: "../../assets/img/cards/"+blackCards[index][0]+'_of_'+blackCards[index][1]+'.png'
                    MouseArea {
                        anchors.fill: parent
                        // since the level is loaded in the levelEditorScene, and is therefore a child of the levelEditorScene, you could also access levelEditorScene.score here and modify it. But we want to keep the logic in the levelEditorScene rather than spreading it all over the place
                        onPressed: theFunctions.moveToGame(blackCards[index],1)
                    }

                }

            }
        }
    // Turn
    Image {
        id: turn1
        sourceSize.width: 500
        width: cardWidth
        fillMode: Image.PreserveAspectFit
        source: "../../assets/img/cards/back.png"
        anchors.left: levelEditorScene.gameWindowAnchorItem.left
        anchors.leftMargin: 10
        anchors.top: levelEditorScene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        MouseArea {
            anchors.fill: parent
            // since the level is loaded in the levelEditorScene, and is therefore a child of the levelEditorScene, you could also access levelEditorScene.score here and modify it. But we want to keep the logic in the levelEditorScene rather than spreading it all over the place
            onPressed: theFunctions.turnCard()
        }
    }
    Row {
            id: turnRow
            spacing: -cardWidth+deckMargin; // a simple layout do avoid overlapping
            anchors.left: turn1.right
            anchors.leftMargin: 10
            anchors.top: levelEditorScene.gameWindowAnchorItem.top
            anchors.topMargin: 10

            Repeater {
                model: turnDisplay; // just define the number you want, can be a variable too
                delegate:
                    RectangularGlow {
                            height: cardHeight
                            width: cardWidth
                           glowRadius: 3+turnCards[index+turnSpot][3]*3
                           spread: 0+turnCards[index+turnSpot][3]
                           color: turnCards[index+turnSpot][2]
                           cornerRadius: 3
                        Image {
                        sourceSize.width: 500
                        width: cardWidth
                        fillMode: Image.PreserveAspectFit
                        source: "../../assets/img/cards/"+turnCards[index+turnSpot][0]+'_of_'+turnCards[index+turnSpot][1]+'.png'
                        MouseArea {
                            anchors.fill: parent
                            // since the level is loaded in the levelEditorScene, and is therefore a child of the levelEditorScene, you could also access levelEditorScene.score here and modify it. But we want to keep the logic in the levelEditorScene rather than spreading it all over the place
                            onPressed: theFunctions.chooseTurn()
                        }

                    }
                        }


            }
        }


    // Stacks
    Row {
            id: stackRow
            spacing: stackMargin; // a simple layout do avoid overlapping
            anchors.right: levelEditorScene.gameWindowAnchorItem.right
            anchors.rightMargin: 10
            anchors.top: levelEditorScene.gameWindowAnchorItem.top
            anchors.topMargin: 10

            Repeater {
                model: 4; // just define the number you want, can be a variable too
                delegate: Image {
                    sourceSize.width: 500
                    width: cardWidth
                    fillMode: Image.PreserveAspectFit
                    source: "../../assets/img/cards/"+stackCards[index][0]+'_of_'+stackCards[index][1]+'.png'
                    MouseArea {
                        anchors.fill: parent
                        // since the level is loaded in the levelEditorScene, and is therefore a child of the levelEditorScene, you could also access levelEditorScene.score here and modify it. But we want to keep the logic in the levelEditorScene rather than spreading it all over the place
                        onPressed: theFunctions.moveUp(colSelected,index)
                    }

                }

            }
        }

    // Columns

    Column {
            id: col1
            spacing: -1*cardHeight+colHMargin; // a simple layout do avoid overlapping
            anchors.left: levelEditorScene.gameWindowAnchorItem.left
            anchors.leftMargin: 10
            anchors.top: turn1.bottom
            anchors.topMargin: 10
            Rectangle {
                width: cardWidth
                height: cardHeight-colHMargin
                color: "yellow"
                MouseArea {
                    anchors.fill: parent
                    // since the level is loaded in the levelEditorScene, and is therefore a child of the levelEditorScene, you could also access levelEditorScene.score here and modify it. But we want to keep the logic in the levelEditorScene rather than spreading it all over the place
                    onPressed: theFunctions.moveColumn(colSelected,1)
                }
            }
            Repeater {
                model: colCards[0].length; // just define the number you want, can be a variable too
                delegate:


                RectangularGlow {
                        height: cardHeight
                        width: cardWidth
                       glowRadius: 3+colCards[0][index][3]*3
                       spread: 0+colCards[0][index][3]
                       color: colCards[0][index][2]
                       cornerRadius: 3
                    MouseArea {
                        anchors.fill: parent
                        // since the level is loaded in the levelEditorScene, and is therefore a child of the levelEditorScene, you could also access levelEditorScene.score here and modify it. But we want to keep the logic in the levelEditorScene rather than spreading it all over the place
                        onPressed: theFunctions.moveColumn(colSelected,1)
                        }
                    Image {
                    anchors.centerIn: parent
                    sourceSize.width: 500
                    width: cardWidth
                    fillMode: Image.PreserveAspectFit
                    source: "../../assets/img/cards/"+colCards[0][index][0]+'_of_'+colCards[0][index][1]+'.png'
                    MouseArea {
                        anchors.fill: parent
                        // since the level is loaded in the levelEditorScene, and is therefore a child of the levelEditorScene, you could also access levelEditorScene.score here and modify it. But we want to keep the logic in the levelEditorScene rather than spreading it all over the place
                        onPressed: theFunctions.moveColumn(colSelected,1)
                    }
                    }
                    }



            }
        }
    Column {
            id: col2
            spacing: -1*cardHeight+colHMargin; // a simple layout do avoid overlapping
            anchors.left: col1.right
            anchors.leftMargin: colMargin
            anchors.top: col1.top
            anchors.topMargin: 0
            Rectangle {
                width: cardWidth
                height: cardHeight-colHMargin
                color: "yellow"
                MouseArea {
                    anchors.fill: parent
                    // since the level is loaded in the levelEditorScene, and is therefore a child of the levelEditorScene, you could also access levelEditorScene.score here and modify it. But we want to keep the logic in the levelEditorScene rather than spreading it all over the place
                    onPressed: theFunctions.moveColumn(colSelected,2)
                }
            }
            Repeater {
                model: colCards[1].length; // just define the number you want, can be a variable too
                delegate:

                    RectangularGlow {
                            height: cardHeight
                            width: cardWidth
                           glowRadius: 3+colCards[1][index][3]*3
                           spread: 0+colCards[1][index][3]
                           color: colCards[1][index][2]
                           cornerRadius: 3
                        MouseArea {
                            anchors.fill: parent
                            // since the level is loaded in the levelEditorScene, and is therefore a child of the levelEditorScene, you could also access levelEditorScene.score here and modify it. But we want to keep the logic in the levelEditorScene rather than spreading it all over the place
                            onPressed: theFunctions.moveColumn(colSelected,2)
                            }
                        Image {
                        anchors.centerIn: parent
                        sourceSize.width: 500
                        width: cardWidth
                        fillMode: Image.PreserveAspectFit
                        source: "../../assets/img/cards/"+colCards[1][index][0]+'_of_'+colCards[1][index][1]+'.png'
                        MouseArea {
                            anchors.fill: parent
                            // since the level is loaded in the levelEditorScene, and is therefore a child of the levelEditorScene, you could also access levelEditorScene.score here and modify it. But we want to keep the logic in the levelEditorScene rather than spreading it all over the place
                            onPressed: theFunctions.moveColumn(colSelected,2)
                        }
                        }
                        }
            }
        }
    Column {
            id: col3
            spacing: -1*cardHeight+colHMargin; // a simple layout do avoid overlapping
            anchors.left: col2.right
            anchors.leftMargin: colMargin
            anchors.top: col1.top
            anchors.topMargin: 0
            Rectangle {
                width: cardWidth
                height: cardHeight-colHMargin
                color: "yellow"
                MouseArea {
                    anchors.fill: parent
                    // since the level is loaded in the levelEditorScene, and is therefore a child of the levelEditorScene, you could also access levelEditorScene.score here and modify it. But we want to keep the logic in the levelEditorScene rather than spreading it all over the place
                    onPressed: theFunctions.moveColumn(colSelected,3)
                }
            }
            Repeater {
                model: colCards[2].length; // just define the number you want, can be a variable too
                delegate:
                    RectangularGlow {
                            height: cardHeight
                            width: cardWidth
                           glowRadius: 3+colCards[2][index][3]*3
                           spread: 0+colCards[2][index][3]
                           color: colCards[2][index][2]
                           cornerRadius: 3
                        MouseArea {
                            anchors.fill: parent
                            // since the level is loaded in the levelEditorScene, and is therefore a child of the levelEditorScene, you could also access levelEditorScene.score here and modify it. But we want to keep the logic in the levelEditorScene rather than spreading it all over the place
                            onPressed: theFunctions.moveColumn(colSelected,3)
                            }
                        Image {
                        anchors.centerIn: parent
                        sourceSize.width: 500
                        width: cardWidth
                        fillMode: Image.PreserveAspectFit
                        source: "../../assets/img/cards/"+colCards[2][index][0]+'_of_'+colCards[2][index][1]+'.png'
                        MouseArea {
                            anchors.fill: parent
                            // since the level is loaded in the levelEditorScene, and is therefore a child of the levelEditorScene, you could also access levelEditorScene.score here and modify it. But we want to keep the logic in the levelEditorScene rather than spreading it all over the place
                            onPressed: theFunctions.moveColumn(colSelected,3)
                        }
                        }
                        }
            }
        }
    Column {
            id: col4
            spacing: -1*cardHeight+colHMargin; // a simple layout do avoid overlapping
            anchors.left: col3.right
            anchors.leftMargin: colMargin
            anchors.top: col1.top
            anchors.topMargin: 0
            Rectangle {
                width: cardWidth
                height: cardHeight-colHMargin
                color: "yellow"
                MouseArea {
                    anchors.fill: parent
                    // since the level is loaded in the levelEditorScene, and is therefore a child of the levelEditorScene, you could also access levelEditorScene.score here and modify it. But we want to keep the logic in the levelEditorScene rather than spreading it all over the place
                    onPressed: theFunctions.moveColumn(colSelected,4)
                }
            }
            Repeater {
                model: colCards[3].length; // just define the number you want, can be a variable too
                delegate:

                    RectangularGlow {
                            height: cardHeight
                            width: cardWidth
                           glowRadius: 3+colCards[3][index][3]*3
                           spread: 0+colCards[3][index][3]
                           color: colCards[3][index][2]
                           cornerRadius: 3
                        MouseArea {
                            anchors.fill: parent
                            // since the level is loaded in the levelEditorScene, and is therefore a child of the levelEditorScene, you could also access levelEditorScene.score here and modify it. But we want to keep the logic in the levelEditorScene rather than spreading it all over the place
                            onPressed: theFunctions.moveColumn(colSelected,4)
                            }
                        Image {
                        anchors.centerIn: parent
                        sourceSize.width: 500
                        width: cardWidth
                        fillMode: Image.PreserveAspectFit
                        source: "../../assets/img/cards/"+colCards[3][index][0]+'_of_'+colCards[3][index][1]+'.png'
                        MouseArea {
                            anchors.fill: parent
                            // since the level is loaded in the levelEditorScene, and is therefore a child of the levelEditorScene, you could also access levelEditorScene.score here and modify it. But we want to keep the logic in the levelEditorScene rather than spreading it all over the place
                            onPressed: theFunctions.moveColumn(colSelected,4)
                        }
                        }
                        }
            }
        }
    Column {
            id: col5
            spacing: -1*cardHeight+colHMargin; // a simple layout do avoid overlapping
            anchors.left: col4.right
            anchors.leftMargin: colMargin
            anchors.top: col1.top
            anchors.topMargin: 0
            Rectangle {
                width: cardWidth
                height: cardHeight-colHMargin
                color: "yellow"
                MouseArea {
                    anchors.fill: parent
                    // since the level is loaded in the levelEditorScene, and is therefore a child of the levelEditorScene, you could also access levelEditorScene.score here and modify it. But we want to keep the logic in the levelEditorScene rather than spreading it all over the place
                    onPressed: theFunctions.moveColumn(colSelected,5)
                }
            }
            Repeater {
                model: colCards[4].length; // just define the number you want, can be a variable too
                delegate:
                    RectangularGlow {
                            height: cardHeight
                            width: cardWidth
                           glowRadius: 3+colCards[4][index][3]*3
                           spread: 0+colCards[4][index][3]
                           color: colCards[4][index][2]
                           cornerRadius: 3
                        MouseArea {
                            anchors.fill: parent
                            // since the level is loaded in the levelEditorScene, and is therefore a child of the levelEditorScene, you could also access levelEditorScene.score here and modify it. But we want to keep the logic in the levelEditorScene rather than spreading it all over the place
                            onPressed: theFunctions.moveColumn(colSelected,5)
                            }
                        Image {
                        anchors.centerIn: parent
                        sourceSize.width: 500
                        width: cardWidth
                        fillMode: Image.PreserveAspectFit
                        source: "../../assets/img/cards/"+colCards[4][index][0]+'_of_'+colCards[4][index][1]+'.png'
                        MouseArea {
                            anchors.fill: parent
                            // since the level is loaded in the levelEditorScene, and is therefore a child of the levelEditorScene, you could also access levelEditorScene.score here and modify it. But we want to keep the logic in the levelEditorScene rather than spreading it all over the place
                            onPressed: theFunctions.moveColumn(colSelected,5)
                        }
                        }
                        }
            }
        }
    Column {
            id: col6
            spacing: -1*cardHeight+colHMargin; // a simple layout do avoid overlapping
            anchors.left: col5.right
            anchors.leftMargin: colMargin
            anchors.top: col1.top
            anchors.topMargin: 0
            Rectangle {
                width: cardWidth
                height: cardHeight-colHMargin
                color: "yellow"
                MouseArea {
                    anchors.fill: parent
                    // since the level is loaded in the levelEditorScene, and is therefore a child of the levelEditorScene, you could also access levelEditorScene.score here and modify it. But we want to keep the logic in the levelEditorScene rather than spreading it all over the place
                    onPressed: theFunctions.moveColumn(colSelected,6)
                }
            }

            Repeater {
                model: colCards[5].length; // just define the number you want, can be a variable too
                delegate:
                    RectangularGlow {
                            height: cardHeight
                            width: cardWidth
                           glowRadius: 3+colCards[5][index][3]*3
                           spread: 0+colCards[5][index][3]
                           color: colCards[5][index][2]
                           cornerRadius: 3
                        MouseArea {
                            anchors.fill: parent
                            // since the level is loaded in the levelEditorScene, and is therefore a child of the levelEditorScene, you could also access levelEditorScene.score here and modify it. But we want to keep the logic in the levelEditorScene rather than spreading it all over the place
                            onPressed: theFunctions.moveColumn(colSelected,6)
                            }
                        Image {
                        anchors.centerIn: parent
                        sourceSize.width: 500
                        width: cardWidth
                        fillMode: Image.PreserveAspectFit
                        source: "../../assets/img/cards/"+colCards[5][index][0]+'_of_'+colCards[5][index][1]+'.png'
                        MouseArea {
                            anchors.fill: parent
                            // since the level is loaded in the levelEditorScene, and is therefore a child of the levelEditorScene, you could also access levelEditorScene.score here and modify it. But we want to keep the logic in the levelEditorScene rather than spreading it all over the place
                            onPressed: theFunctions.moveColumn(colSelected,6)
                        }
                        }
                        }
            }
        }

    Column {
            id: col7
            spacing: -1*cardHeight+colHMargin; // a simple layout do avoid overlapping
            anchors.left: col6.right
            anchors.leftMargin: colMargin
            anchors.top: col1.top
            anchors.topMargin: 0
            Rectangle {
                width: cardWidth
                height: cardHeight-colHMargin
                color: "yellow"
                MouseArea {
                    anchors.fill: parent
                    // since the level is loaded in the levelEditorScene, and is therefore a child of the levelEditorScene, you could also access levelEditorScene.score here and modify it. But we want to keep the logic in the levelEditorScene rather than spreading it all over the place
                    onPressed: theFunctions.moveColumn(colSelected,7)
                }
            }
            Repeater {
                model: colCards[6].length; // just define the number you want, can be a variable too
                delegate:
                    RectangularGlow {
                            height: cardHeight
                            width: cardWidth
                           glowRadius: 3+colCards[6][index][3]*3
                           spread: 0+colCards[6][index][3]
                           color: colCards[6][index][2]
                           cornerRadius: 3
                        MouseArea {
                            anchors.fill: parent
                            // since the level is loaded in the levelEditorScene, and is therefore a child of the levelEditorScene, you could also access levelEditorScene.score here and modify it. But we want to keep the logic in the levelEditorScene rather than spreading it all over the place
                            onPressed: theFunctions.moveColumn(colSelected,7)
                            }
                        Image {
                        anchors.centerIn: parent
                        sourceSize.width: 500
                        width: cardWidth
                        fillMode: Image.PreserveAspectFit
                        source: "../../assets/img/cards/"+colCards[6][index][0]+'_of_'+colCards[6][index][1]+'.png'
                        MouseArea {
                            anchors.fill: parent
                            // since the level is loaded in the levelEditorScene, and is therefore a child of the levelEditorScene, you could also access levelEditorScene.score here and modify it. But we want to keep the logic in the levelEditorScene rather than spreading it all over the place
                            onPressed: theFunctions.moveColumn(colSelected,7)
                        }
                        }
                        }
            }
        }
    TextArea {
        id: cardInfo
        width: 480
        visible: false
        font.pointSize: 5
        font.family: "Times New Roman"
        text:
            "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo cosnsequat. ";
    }

    // load levels at runtime
    Loader {
        id: loader
        source: activeLevelFileName != "" ? "../levels/" + activeLevelFileName : ""
        onLoaded: {
            // reset the score
            score = 0
            // since we did not define a width and height in the level item itself, we are doing it here
            item.width = levelEditorScene.width
            item.height = levelEditorScene.height
            // store the loaded level as activeLevel for easier access
            activeLevel = item
        }
    }

    // we connect the levelEditorScene to the loaded level
    Connections {
        // only connect if a level is loaded, to prevent errors
        target: activeLevel !== undefined ? activeLevel : null
        // increase the score when the rectangle is clicked
        onRectanglePressed: {
            // only increase score when game is running
            if(gameRunning) {
                score++
            }
        }

    }

    Item {
        id: theFunctions
        function moveColumn(x,y) {
            if (cardReady==1){
                console.log(cardSelected);
                var newArray = colCards;
                newArray[y-1]= newArray[y-1].concat(cardSelected);
                colCards = newArray;
                removeCard(cardSelected[0]);
                cardReady = 0;

            }
            else{
                var newArray = colCards;
                var i;
                var nback = 0;

                for (i=0;i<newArray[y-1].length;i++){
                    if (newArray[y-1][i][0]=='back'){
                        nback++;
                    }
                }
                if (nback<newArray[y-1].length){
                    newArray[y-1][nback]=newArray[y-1][nback].concat([newArray[y-1][nback][0]]);
                    newArray[y-1][nback][0]= 'back';
                    newArray[y-1][nback][2]= 'white';
                }
                else{
                    for (i=0;i<newArray[y-1].length;i++){
                        newArray[y-1][i][0]=newArray[y-1][i][4];
                        if (newArray[y-1][i][1]=='clubs' || newArray[y-1][i][1]=='spades'){newArray[y-1][i][2]='black';}
                        else {newArray[y-1][i][2]='red';}
                        newArray[y-1][i]=newArray[y-1][i].slice(0,4);

                    }

                }
                colCards = newArray;
            }
        }
        function moveUp(x){
            if (cardReady==1){
                var newArray = stackCards;
                var naIndex = 0;
                if (cardSelected[0][1]=='hearts'){naIndex = 0;}
                if (cardSelected[0][1]=='diamonds'){naIndex = 1;}
                if (cardSelected[0][1]=='clubs'){naIndex = 2;}
                if (cardSelected[0][1]=='spades'){naIndex = 3;}

                var scValue = 0;
                if (stackCards[naIndex][0]=='ace'){scValue = 1;}
                else if (stackCards[naIndex][0]=='jack'){scValue = 11;}
                else if (stackCards[naIndex][0]=='queen'){scValue = 12;}
                else if (stackCards[naIndex][0]=='king'){scValue = 13;}
                else if (stackCards[naIndex][0]=='back'){scValue = 0;}
                else {scValue = stackCards[naIndex][0];}

                var csValue = 0;
                if (cardSelected[0][0]=='ace'){csValue = 1;}
                else if (cardSelected[0][0]=='jack'){csValue = 11;}
                else if (cardSelected[0][0]=='queen'){csValue = 12;}
                else if (cardSelected[0][0]=='king'){csValue = 13;}
                else {csValue = cardSelected[0][0];}
                console.log(scValue);
                console.log(csValue);
                console.log(naIndex);

                var i;
                var removeAll = 0;
                var removeCards = [];
                for (i=scValue+1;i<csValue+1;i++){
                    var ii;
                    var iValue;

                    if (i==1) {iValue = 'ace';}
                    else if (i==11) {iValue = 'jack';}
                    else if (i==12) {iValue = 'queen';}
                    else if (i==13) {iValue = 'king';}
                    else {iValue = i;}
                    for (ii=0;ii<redCards.length;ii++){
                    if (redCards[ii][0]==iValue && redCards[ii][1]==cardSelected[0][1] ){removeAll++; removeCards=removeCards.concat([redCards[ii]]);}
                    }
                    for (ii=0;ii<blackCards.length;ii++){
                    if (blackCards[ii][0]==iValue && blackCards[ii][1]==cardSelected[0][1] ){removeAll++; removeCards=removeCards.concat([blackCards[ii]]);}
                    }
                }
                if (removeAll==csValue-scValue){
                newArray[naIndex]=cardSelected[0];
                stackCards = newArray;
                for (i=0;i<removeCards.length;i++){removeCard(removeCards[i]);}
                }
                cardReady = 0;
            }
        }
        function turnCard(){
            if (cardReady==1){
                var newArray = turnCards;
                newArray= newArray.concat(cardSelected);
                turnCards = newArray;
                console.log(cardSelected);
                removeCard(cardSelected[0]);
                cardReady = 0;
            }
        }
        function chooseTurn(){
            colSelected = 8;
            var newArray = turnCards;
            newArray[turnSpot+turnDisplay-1][3]=.3;
            turnCards = newArray;
        }
        function createCards(x){
            var i;
            var newArray = [];
            for (i=0;i<x.length;i++){
                if (x[i][0]==1){x[i][0]='ace';}
                if (x[i][0]==11){x[i][0]='jack';}
                if (x[i][0]==12){x[i][0]='queen';}
                if (x[i][0]==13){x[i][0]='king';}
                if (x[i].length>2){
                    if (x[i][1]==0){newArray = newArray.concat([createCard(x[i][0],'hearts',x[i][2])]);}
                    if (x[i][1]==1){newArray = newArray.concat([createCard(x[i][0],'diamonds',x[i][2])]);}
                    if (x[i][1]==2){newArray = newArray.concat([createCard(x[i][0],'clubs',x[i][2])]);}
                    if (x[i][1]==3){newArray = newArray.concat([createCard(x[i][0],'spades',x[i][2])]);}

                }
                else{
                    if (x[i][1]==0){newArray = newArray.concat([createCard(x[i][0],'hearts')]);}
                    if (x[i][1]==1){newArray = newArray.concat([createCard(x[i][0],'diamonds')]);}
                    if (x[i][1]==2){newArray = newArray.concat([createCard(x[i][0],'clubs')]);}
                    if (x[i][1]==3){newArray = newArray.concat([createCard(x[i][0],'spades')]);}
                }
            }
            return newArray
        }
        function createCard(x,y,z){
            if (z=== undefined){
                z=1;
            }

            if (z==0){
                return ['back',y,'white',0,x];
            }
            else{
                if (y=='clubs' || y=='spades'){
                return [x,y,'black',0];
                }
                else {
                   return [x,y,'red',0];
                }
            }


        }
        function moveToGame(x,y){
            cardSelected= [x];
            cardReady = 1;

        }
        function removeCard(x){
            if (x[1]=='hearts'){var newArray = redCards;
                var i;
                for (i=0;i<newArray.length;i++){if (newArray[i][1]=='hearts' && newArray[i][0]==x[0]){newArray = newArray.slice(0,i).concat(newArray.slice(i+1,newArray.length));}}
                redCards = newArray;
            }
            if (x[1]=='diamonds'){var newArray = redCards;
                var i;
                for (i=0;i<newArray.length;i++){if (newArray[i][1]=='diamonds' && newArray[i][0]==x[0]){newArray = newArray.slice(0,i).concat(newArray.slice(i+1,newArray.length));}}
                redCards = newArray;
            }
            if (x[1]=='clubs'){var newArray = blackCards;
                var i;
                for (i=0;i<newArray.length;i++){if (newArray[i][1]=='clubs' && newArray[i][0]==x[0]){newArray = newArray.slice(0,i).concat(newArray.slice(i+1,newArray.length));}}
                blackCards = newArray;
            }
            if (x[1]=='spades'){var newArray = blackCards;
                var i;
                for (i=0;i<newArray.length;i++){if (newArray[i][1]=='spades' && newArray[i][0]==x[0]){newArray = newArray.slice(0,i).concat(newArray.slice(i+1,newArray.length));}}
                blackCards = newArray;
            }

        }

        function saveLevel(){
            cardInfo.visible = true;
            var stackString = 'stackCards: createStack([';
            var i;
            for (i=0;i<4;i++){
                if (stackCards[i][0]=='back' || stackCards[i][0]=='ace' || stackCards[i][0]=='jack' || stackCards[i][0]=='queen' || stackCards[i][0]=='king' ){stackString = stackString+'"'+stackCards[i][0].toString()+'"';}
                else{stackString = stackString+stackCards[i][0].toString();}
                if (i==3){stackString = stackString+'])';}
                else{stackString = stackString+',';}
            }
            var c1String = '';

            var ii;
            for (ii=0;ii<7;ii++){
                c1String = c1String+'\nproperty var col'+(ii+1).toString()+'Cards: createCards([';
                for (i=0;i<colCards[ii].length;i++){
                    if (colCards[ii][i][0]=='back'){
                        var cardValue = 0;
                        if (colCards[ii][i][4]=='ace'){cardValue = 1;}
                        else if (colCards[ii][i][4]=='jack'){cardValue = 11;}
                        else if (colCards[ii][i][4]=='queen'){cardValue = 12;}
                        else if (colCards[ii][i][4]=='king'){cardValue = 13;}
                        else {cardValue = colCards[ii][i][4];}
                        var cardSuit = 0;
                        if (colCards[ii][i][1]=='hearts'){cardSuit = 0;}
                        if (colCards[ii][i][1]=='diamonds'){cardSuit = 1;}
                        if (colCards[ii][i][1]=='clubs'){cardSuit = 2;}
                        if (colCards[ii][i][1]=='spades'){cardSuit = 3;}
                        c1String = c1String+'['+cardValue.toString()+','+cardSuit.toString()+','+'0]';
                    }
                    else {
                        var cardValue = 0;
                        if (colCards[ii][i][0]=='ace'){cardValue = 1;}
                        else if (colCards[ii][i][0]=='jack'){cardValue = 11;}
                        else if (colCards[ii][i][0]=='queen'){cardValue = 12;}
                        else if (colCards[ii][i][0]=='king'){cardValue = 13;}
                        else {cardValue = colCards[ii][i][0];}
                        var cardSuit = 0;
                        if (colCards[ii][i][1]=='hearts'){cardSuit = 0;}
                        if (colCards[ii][i][1]=='diamonds'){cardSuit = 1;}
                        if (colCards[ii][i][1]=='clubs'){cardSuit = 2;}
                        if (colCards[ii][i][1]=='spades'){cardSuit = 3;}
                        c1String = c1String+'['+cardValue.toString()+','+cardSuit.toString()+']';
                    }
                    if (i<colCards[ii].length-1){c1String=c1String+',';}
                    else {c1String=c1String+'])';}
                }
                if (colCards[ii].length == 0){c1String=c1String+'])';}
            }
            var turnString = '';
            turnString = turnString+'turnCards: createCards([';
            for (i=0;i<turnCards.length;i++){
                if (turnCards[i][0]=='back'){
                    var cardValue = 0;
                    if (turnCards[i][4]=='ace'){cardValue = 1;}
                    else if (turnCards[i][4]=='jack'){cardValue = 11;}
                    else if (turnCards[i][4]=='queen'){cardValue = 12;}
                    else if (turnCards[i][4]=='king'){cardValue = 13;}
                    else {cardValue = turnCards[i][4];}
                    var cardSuit = 0;
                    if (turnCards[i][1]=='hearts'){cardSuit = 0;}
                    if (turnCards[i][1]=='diamonds'){cardSuit = 1;}
                    if (turnCards[i][1]=='clubs'){cardSuit = 2;}
                    if (turnCards[i][1]=='spades'){cardSuit = 3;}
                    turnString = turnString+'['+cardValue.toString()+','+cardSuit.toString()+','+'0]';
                }
                else {
                    var cardValue = 0;
                    if (turnCards[i][0]=='ace'){cardValue = 1;}
                    else if (turnCards[i][0]=='jack'){cardValue = 11;}
                    else if (turnCards[i][0]=='queen'){cardValue = 12;}
                    else if (turnCards[i][0]=='king'){cardValue = 13;}
                    else {cardValue = turnCards[i][0];}
                    var cardSuit = 0;
                    if (turnCards[i][1]=='hearts'){cardSuit = 0;}
                    if (turnCards[i][1]=='diamonds'){cardSuit = 1;}
                    if (turnCards[i][1]=='clubs'){cardSuit = 2;}
                    if (turnCards[i][1]=='spades'){cardSuit = 3;}
                    turnString = turnString+'['+cardValue.toString()+','+cardSuit.toString()+']';
                }
                if (i<turnCards.length-1){turnString=turnString+',';}
                else {turnString=turnString+'])';}
            }
            if (turnCards.length == 0){turnString=turnString+'])';}


            cardInfo.text = turnString+'\n'+stackString+c1String;
            console.log([1,1,11111111,111111,111111,111,11,1,1,1,1,1,1,1111111111111111111,1,11111111111111111111111,11111111,11111111,11111,11111,11111,111,11111111,11111111111,111111111,1111111,111,1111111111,1111111111,1111111111111,1111111111,1111111111111,11111111111111]);
        }

    }


}
