import VPlay 2.0
import QtQuick 2.0
import "../common"
import QtGraphicalEffects 1.0
SceneBase {
    id:gameScene
    // the filename of the current level gets stored here, it is used for loading the
    property string activeLevelFileName
    // the currently loaded level gets stored here
    property variant activeLevel
    // score
    property int score: 0
    // countdown shown at level start
    property int countdown: 0
    // flag indicating if game is running
    property bool gameRunning: 0 == 0
    // width of card
    property int cardWidth: gameScene.gameWindowAnchorItem.width/8.0
    property int deckMargin: (gameScene.gameWindowAnchorItem.width-20.0-gameScene.cardWidth)/23.0
    property int colMargin: (gameScene.gameWindowAnchorItem.width-20.0-7*gameScene.cardWidth)/6.0
    property int stackMargin: gameScene.cardWidth/7.0
    property int cardHeight: gameScene.cardWidth*726/500
    property int colHMargin: cardHeight/7.0
    property int colSelected: 0
    property int numSelected: 0



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
        text: score
        anchors.left: gameScene.gameWindowAnchorItem.left
        anchors.leftMargin: 160
        anchors.bottom: deckRow.top
        anchors.bottomMargin: 10
        onClicked: {
            backButtonPressed()
            activeLevel = undefined
            activeLevelFileName = ""
        }
    }
    Text {
        text: ""
        anchors.left: gameScene.gameWindowAnchorItem.left
        anchors.leftMargin: 60
        anchors.bottom: deckRow.top
        anchors.bottomMargin: 10
    }


    // Deck
    Row {
            id: deckRow
            spacing: -cardWidth+deckMargin; // a simple layout do avoid overlapping
            anchors.left: gameScene.gameWindowAnchorItem.left
            anchors.leftMargin: deckMargin
            anchors.bottom: gameScene.gameWindowAnchorItem.bottom
            anchors.bottomMargin: 10

            Repeater {
                model: activeLevel.turnCards.length; // just define the number you want, can be a variable too
                delegate: Image {
                    sourceSize.width: 500
                    width: cardWidth
                    fillMode: Image.PreserveAspectFit
                    source: "../../assets/img/cards/"+activeLevel.turnCards[index][0]+'_of_'+activeLevel.turnCards[index][1]+'.png'

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
        anchors.left: gameScene.gameWindowAnchorItem.left
        anchors.leftMargin: 10
        anchors.top: gameScene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        MouseArea {
            anchors.fill: parent
            // since the level is loaded in the gameScene, and is therefore a child of the gameScene, you could also access gameScene.score here and modify it. But we want to keep the logic in the gameScene rather than spreading it all over the place
            onPressed: theFunctions.turnCard()
        }
    }
    Row {
            id: turnRow
            spacing: -cardWidth+deckMargin; // a simple layout do avoid overlapping
            anchors.left: turn1.right
            anchors.leftMargin: 10
            anchors.top: gameScene.gameWindowAnchorItem.top
            anchors.topMargin: 10

            Repeater {
                model: activeLevel.turnDisplay; // just define the number you want, can be a variable too
                delegate:
                    RectangularGlow {
                            height: cardHeight
                            width: cardWidth
                           glowRadius: 3+activeLevel.turnCards[index+activeLevel.turnSpot][3]*3
                           spread: 0+activeLevel.turnCards[index+activeLevel.turnSpot][3]
                           color: activeLevel.turnCards[index+activeLevel.turnSpot][2]
                           cornerRadius: 3
                        Image {
                        sourceSize.width: 500
                        width: cardWidth
                        fillMode: Image.PreserveAspectFit
                        source: "../../assets/img/cards/"+activeLevel.turnCards[index+activeLevel.turnSpot][0]+'_of_'+activeLevel.turnCards[index+activeLevel.turnSpot][1]+'.png'
                        MouseArea {
                            anchors.fill: parent
                            // since the level is loaded in the gameScene, and is therefore a child of the gameScene, you could also access gameScene.score here and modify it. But we want to keep the logic in the gameScene rather than spreading it all over the place
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
            anchors.right: gameScene.gameWindowAnchorItem.right
            anchors.rightMargin: 10
            anchors.top: gameScene.gameWindowAnchorItem.top
            anchors.topMargin: 10

            Repeater {
                model: 4; // just define the number you want, can be a variable too
                delegate: Image {
                    sourceSize.width: 500
                    width: cardWidth
                    fillMode: Image.PreserveAspectFit
                    source: "../../assets/img/cards/"+activeLevel.stackCards[index][0]+'_of_'+activeLevel.stackCards[index][1]+'.png'
                    MouseArea {
                        anchors.fill: parent
                        // since the level is loaded in the gameScene, and is therefore a child of the gameScene, you could also access gameScene.score here and modify it. But we want to keep the logic in the gameScene rather than spreading it all over the place
                        onPressed: theFunctions.moveUp(colSelected,index)
                    }

                }

            }
        }

    // Columns

    Column {
            id: col1
            spacing: -1*cardHeight+colHMargin; // a simple layout do avoid overlapping
            anchors.left: gameScene.gameWindowAnchorItem.left
            anchors.leftMargin: 10
            anchors.top: turn1.bottom
            anchors.topMargin: 10
            Rectangle {
                width: cardWidth
                height: cardHeight-colHMargin
                color: "#00000000"
                MouseArea {
                    anchors.fill: parent
                    // since the level is loaded in the gameScene, and is therefore a child of the gameScene, you could also access gameScene.score here and modify it. But we want to keep the logic in the gameScene rather than spreading it all over the place
                    onPressed: theFunctions.moveColumn(colSelected,1)
                }
            }
            Repeater {
                model: activeLevel.colCards[0].length; // just define the number you want, can be a variable too
                delegate:


                RectangularGlow {
                        height: cardHeight
                        width: cardWidth
                       glowRadius: 3+activeLevel.colCards[0][index][3]*3
                       spread: 0+activeLevel.colCards[0][index][3]
                       color: activeLevel.colCards[0][index][2]
                       cornerRadius: 3
                    MouseArea {
                        anchors.fill: parent
                        // since the level is loaded in the gameScene, and is therefore a child of the gameScene, you could also access gameScene.score here and modify it. But we want to keep the logic in the gameScene rather than spreading it all over the place
                        onPressed: theFunctions.moveColumn(colSelected,1)
                        }
                    Image {
                    anchors.centerIn: parent
                    sourceSize.width: 500
                    width: cardWidth
                    fillMode: Image.PreserveAspectFit
                    source: "../../assets/img/cards/"+activeLevel.colCards[0][index][0]+'_of_'+activeLevel.colCards[0][index][1]+'.png'
                    MouseArea {
                        anchors.fill: parent
                        // since the level is loaded in the gameScene, and is therefore a child of the gameScene, you could also access gameScene.score here and modify it. But we want to keep the logic in the gameScene rather than spreading it all over the place
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
                color: "#00000000"
                MouseArea {
                    anchors.fill: parent
                    // since the level is loaded in the gameScene, and is therefore a child of the gameScene, you could also access gameScene.score here and modify it. But we want to keep the logic in the gameScene rather than spreading it all over the place
                    onPressed: theFunctions.moveColumn(colSelected,2)
                }
            }
            Repeater {
                model: activeLevel.colCards[1].length; // just define the number you want, can be a variable too
                delegate:

                    RectangularGlow {
                            height: cardHeight
                            width: cardWidth
                           glowRadius: 3+activeLevel.colCards[1][index][3]*3
                           spread: 0+activeLevel.colCards[1][index][3]
                           color: activeLevel.colCards[1][index][2]
                           cornerRadius: 3
                        MouseArea {
                            anchors.fill: parent
                            // since the level is loaded in the gameScene, and is therefore a child of the gameScene, you could also access gameScene.score here and modify it. But we want to keep the logic in the gameScene rather than spreading it all over the place
                            onPressed: theFunctions.moveColumn(colSelected,2)
                            }
                        Image {
                        anchors.centerIn: parent
                        sourceSize.width: 500
                        width: cardWidth
                        fillMode: Image.PreserveAspectFit
                        source: "../../assets/img/cards/"+activeLevel.colCards[1][index][0]+'_of_'+activeLevel.colCards[1][index][1]+'.png'
                        MouseArea {
                            anchors.fill: parent
                            // since the level is loaded in the gameScene, and is therefore a child of the gameScene, you could also access gameScene.score here and modify it. But we want to keep the logic in the gameScene rather than spreading it all over the place
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
                color: "#00000000"
                MouseArea {
                    anchors.fill: parent
                    // since the level is loaded in the gameScene, and is therefore a child of the gameScene, you could also access gameScene.score here and modify it. But we want to keep the logic in the gameScene rather than spreading it all over the place
                    onPressed: theFunctions.moveColumn(colSelected,3)
                }
            }
            Repeater {
                model: activeLevel.colCards[2].length; // just define the number you want, can be a variable too
                delegate:
                    RectangularGlow {
                            height: cardHeight
                            width: cardWidth
                           glowRadius: 3+activeLevel.colCards[2][index][3]*3
                           spread: 0+activeLevel.colCards[2][index][3]
                           color: activeLevel.colCards[2][index][2]
                           cornerRadius: 3
                        MouseArea {
                            anchors.fill: parent
                            // since the level is loaded in the gameScene, and is therefore a child of the gameScene, you could also access gameScene.score here and modify it. But we want to keep the logic in the gameScene rather than spreading it all over the place
                            onPressed: theFunctions.moveColumn(colSelected,3)
                            }
                        Image {
                        anchors.centerIn: parent
                        sourceSize.width: 500
                        width: cardWidth
                        fillMode: Image.PreserveAspectFit
                        source: "../../assets/img/cards/"+activeLevel.colCards[2][index][0]+'_of_'+activeLevel.colCards[2][index][1]+'.png'
                        MouseArea {
                            anchors.fill: parent
                            // since the level is loaded in the gameScene, and is therefore a child of the gameScene, you could also access gameScene.score here and modify it. But we want to keep the logic in the gameScene rather than spreading it all over the place
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
                color: "#00000000"
                MouseArea {
                    anchors.fill: parent
                    // since the level is loaded in the gameScene, and is therefore a child of the gameScene, you could also access gameScene.score here and modify it. But we want to keep the logic in the gameScene rather than spreading it all over the place
                    onPressed: theFunctions.moveColumn(colSelected,4)
                }
            }
            Repeater {
                model: activeLevel.colCards[3].length; // just define the number you want, can be a variable too
                delegate:

                    RectangularGlow {
                            height: cardHeight
                            width: cardWidth
                           glowRadius: 3+activeLevel.colCards[3][index][3]*3
                           spread: 0+activeLevel.colCards[3][index][3]
                           color: activeLevel.colCards[3][index][2]
                           cornerRadius: 3
                        MouseArea {
                            anchors.fill: parent
                            // since the level is loaded in the gameScene, and is therefore a child of the gameScene, you could also access gameScene.score here and modify it. But we want to keep the logic in the gameScene rather than spreading it all over the place
                            onPressed: theFunctions.moveColumn(colSelected,4)
                            }
                        Image {
                        anchors.centerIn: parent
                        sourceSize.width: 500
                        width: cardWidth
                        fillMode: Image.PreserveAspectFit
                        source: "../../assets/img/cards/"+activeLevel.colCards[3][index][0]+'_of_'+activeLevel.colCards[3][index][1]+'.png'
                        MouseArea {
                            anchors.fill: parent
                            // since the level is loaded in the gameScene, and is therefore a child of the gameScene, you could also access gameScene.score here and modify it. But we want to keep the logic in the gameScene rather than spreading it all over the place
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
                color: "#00000000"
                MouseArea {
                    anchors.fill: parent
                    // since the level is loaded in the gameScene, and is therefore a child of the gameScene, you could also access gameScene.score here and modify it. But we want to keep the logic in the gameScene rather than spreading it all over the place
                    onPressed: theFunctions.moveColumn(colSelected,5)
                }
            }
            Repeater {
                model: activeLevel.colCards[4].length; // just define the number you want, can be a variable too
                delegate:
                    RectangularGlow {
                            height: cardHeight
                            width: cardWidth
                           glowRadius: 3+activeLevel.colCards[4][index][3]*3
                           spread: 0+activeLevel.colCards[4][index][3]
                           color: activeLevel.colCards[4][index][2]
                           cornerRadius: 3
                        MouseArea {
                            anchors.fill: parent
                            // since the level is loaded in the gameScene, and is therefore a child of the gameScene, you could also access gameScene.score here and modify it. But we want to keep the logic in the gameScene rather than spreading it all over the place
                            onPressed: theFunctions.moveColumn(colSelected,5)
                            }
                        Image {
                        anchors.centerIn: parent
                        sourceSize.width: 500
                        width: cardWidth
                        fillMode: Image.PreserveAspectFit
                        source: "../../assets/img/cards/"+activeLevel.colCards[4][index][0]+'_of_'+activeLevel.colCards[4][index][1]+'.png'
                        MouseArea {
                            anchors.fill: parent
                            // since the level is loaded in the gameScene, and is therefore a child of the gameScene, you could also access gameScene.score here and modify it. But we want to keep the logic in the gameScene rather than spreading it all over the place
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
                color: "#00000000"
                MouseArea {
                    anchors.fill: parent
                    // since the level is loaded in the gameScene, and is therefore a child of the gameScene, you could also access gameScene.score here and modify it. But we want to keep the logic in the gameScene rather than spreading it all over the place
                    onPressed: theFunctions.moveColumn(colSelected,6)
                }
            }

            Repeater {
                model: activeLevel.colCards[5].length; // just define the number you want, can be a variable too
                delegate:
                    RectangularGlow {
                            height: cardHeight
                            width: cardWidth
                           glowRadius: 3+activeLevel.colCards[5][index][3]*3
                           spread: 0+activeLevel.colCards[5][index][3]
                           color: activeLevel.colCards[5][index][2]
                           cornerRadius: 3
                        MouseArea {
                            anchors.fill: parent
                            // since the level is loaded in the gameScene, and is therefore a child of the gameScene, you could also access gameScene.score here and modify it. But we want to keep the logic in the gameScene rather than spreading it all over the place
                            onPressed: theFunctions.moveColumn(colSelected,6)
                            }
                        Image {
                        anchors.centerIn: parent
                        sourceSize.width: 500
                        width: cardWidth
                        fillMode: Image.PreserveAspectFit
                        source: "../../assets/img/cards/"+activeLevel.colCards[5][index][0]+'_of_'+activeLevel.colCards[5][index][1]+'.png'
                        MouseArea {
                            anchors.fill: parent
                            // since the level is loaded in the gameScene, and is therefore a child of the gameScene, you could also access gameScene.score here and modify it. But we want to keep the logic in the gameScene rather than spreading it all over the place
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
                color: "#00000000"
                MouseArea {
                    anchors.fill: parent
                    // since the level is loaded in the gameScene, and is therefore a child of the gameScene, you could also access gameScene.score here and modify it. But we want to keep the logic in the gameScene rather than spreading it all over the place
                    onPressed: theFunctions.moveColumn(colSelected,7)
                }
            }
            Repeater {
                model: activeLevel.colCards[6].length; // just define the number you want, can be a variable too
                delegate:
                    RectangularGlow {
                            height: cardHeight
                            width: cardWidth
                           glowRadius: 3+activeLevel.colCards[6][index][3]*3
                           spread: 0+activeLevel.colCards[6][index][3]
                           color: activeLevel.colCards[6][index][2]
                           cornerRadius: 3
                        MouseArea {
                            anchors.fill: parent
                            // since the level is loaded in the gameScene, and is therefore a child of the gameScene, you could also access gameScene.score here and modify it. But we want to keep the logic in the gameScene rather than spreading it all over the place
                            onPressed: theFunctions.moveColumn(colSelected,7)
                            }
                        Image {
                        anchors.centerIn: parent
                        sourceSize.width: 500
                        width: cardWidth
                        fillMode: Image.PreserveAspectFit
                        source: "../../assets/img/cards/"+activeLevel.colCards[6][index][0]+'_of_'+activeLevel.colCards[6][index][1]+'.png'
                        MouseArea {
                            anchors.fill: parent
                            // since the level is loaded in the gameScene, and is therefore a child of the gameScene, you could also access gameScene.score here and modify it. But we want to keep the logic in the gameScene rather than spreading it all over the place
                            onPressed: theFunctions.moveColumn(colSelected,7)
                        }
                        }
                        }
            }
        }

    // load levels at runtime
    Loader {
        id: loader
        source: activeLevelFileName != "" ? "../levels/" + activeLevelFileName : ""
        onLoaded: {
            // reset the score
            score = 0
            // since we did not define a width and height in the level item itself, we are doing it here
            item.width = gameScene.width
            item.height = gameScene.height
            // store the loaded level as activeLevel for easier access
            activeLevel = item
        }
    }

    // we connect the gameScene to the loaded level
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
            if (activeLevel.turnCards.length>activeLevel.turnSpot+activeLevel.turnDisplay-1){
                if (activeLevel.turnSpot+activeLevel.turnDisplay>0){
                    var newArray = activeLevel.turnCards;
                    newArray[activeLevel.turnSpot+activeLevel.turnDisplay-1][3]=0;
                    activeLevel.turnCards = newArray;
                }
            }
            if (x==0){
                if (activeLevel.colCards[y-1].length>0){
                colSelected = y;

                    var i;
                    var newArray = activeLevel.colCards;
                    var includeCard = 0
                 if (newArray[y-1][newArray[y-1].length-1][0]!='back'){
                     for (i=0;i<newArray[y-1].length;i++){
                         if (newArray[y-1][i][0]!='back'){
                             var ii;
                             for (ii=0;ii<7;ii++){if (newArray[ii].length==0){if ('king'==newArray[y-1][i][0]){includeCard=1;}} else {if (( (newArray[ii][newArray[ii].length-1][0]==2 && 'ace'==newArray[y-1][i][0]) || (newArray[ii][newArray[ii].length-1][0]=='king' && 'queen'==newArray[y-1][i][0]) || (newArray[ii][newArray[ii].length-1][0]=='queen' && 'jack'==newArray[y-1][i][0]) ||(newArray[ii][newArray[ii].length-1][0]=='jack' && 10==newArray[y-1][i][0]) || newArray[ii][newArray[ii].length-1][0]==newArray[y-1][i][0]+1) && newArray[ii][newArray[ii].length-1][2]!=newArray[y-1][i][2]){includeCard = 1;}}}
                            if (includeCard==1){newArray[y-1][i][3]=.3; numSelected++;}
                         }

                     }
                     if (numSelected == 0){newArray[y-1][newArray[y-1].length-1][3]=.3; numSelected++;}
                     activeLevel.colCards = newArray;
                }
                 else{
                     newArray[y-1][newArray[y-1].length-1][0]=newArray[y-1][newArray[y-1].length-1][4];
                     if (newArray[y-1][newArray[y-1].length-1][1]=='clubs' || newArray[y-1][newArray[y-1].length-1][1]=='spades'){newArray[y-1][newArray[y-1].length-1][2]='black';}
                     else{newArray[y-1][newArray[y-1].length-1][2]='red';}
                     activeLevel.colCards = newArray;
                     colSelected = 0;
                 }
                }
            }
            else if (x==8){
                var lastCard = activeLevel.turnCards[activeLevel.turnSpot+activeLevel.turnDisplay-1];
                if (activeLevel.colCards[y-1].length>0){
                    var colCard = activeLevel.colCards[y-1][activeLevel.colCards[y-1].length-1];
                    console.log(lastCard);
                    console.log(colCard);
                if (lastCard[0]==colCard[0]-1 || (lastCard[0]=='ace' && colCard[0]==2) || (lastCard[0]==10 && colCard[0]=='jack') || (lastCard[0]=='jack' && colCard[0]=='queen') || (lastCard[0]=='queen' && colCard[0]=='king')){
                    if (lastCard[1]=='spades' || lastCard[1]=='clubs'){
                        if (colCard[1]=='hearts' || colCard[1]=='diamonds'){
                            var newArray = activeLevel.colCards;
                            newArray[y-1] = newArray[y-1].concat([lastCard]);
                            activeLevel.colCards = newArray;
                            newArray = activeLevel.turnCards;
                            newArray.splice(activeLevel.turnSpot+activeLevel.turnDisplay-1,1);
                            activeLevel.turnDisplay--;
                            activeLevel.turnCards = newArray;
                        }
                    }
                    else {
                            if (colCard[1]=='spades' || colCard[1]=='clubs'){
                                var newArray = activeLevel.colCards;
                                newArray[y-1] = newArray[y-1].concat([lastCard]);
                                activeLevel.colCards = newArray;
                                newArray = activeLevel.turnCards;
                                newArray.splice(activeLevel.turnSpot+activeLevel.turnDisplay-1,1);
                                activeLevel.turnDisplay--;
                                activeLevel.turnCards = newArray;
                            }
                    }
                }
                }
                else {
                    if (lastCard[0]=='king'){
                        var newArray = activeLevel.colCards;
                        newArray[y-1] = newArray[y-1].concat([lastCard]);
                        activeLevel.colCards = newArray;
                        newArray = activeLevel.turnCards;
                        newArray.splice(activeLevel.turnSpot+activeLevel.turnDisplay-1,1);
                        activeLevel.turnDisplay--;
                        activeLevel.turnCards = newArray;
                    }
                }
                colSelected = 0;
                numSelected = 0;
                var i;
                var ii;
                var newArray = activeLevel.colCards;
                for (ii=0;ii<7;ii++){
                     for (i=3;i<newArray[ii].length;i++){
                    newArray[ii][i][3]=0;
                     }
                 }
                activeLevel.colCards = newArray;
            }
            else{
                if (activeLevel.colCards[x-1].length>0){
                    var lastCard = activeLevel.colCards[x-1][activeLevel.colCards[x-1].length-numSelected];
                    if (activeLevel.colCards[y-1].length>0){
                        var colCard = activeLevel.colCards[y-1][activeLevel.colCards[y-1].length-1];
                        console.log(numSelected);
                        console.log(lastCard);
                        console.log(colCard);
                        if (lastCard[0]==colCard[0]-1 || (lastCard[0]=='ace' && colCard[0]==2) || (lastCard[0]==10 && colCard[0]=='jack') || (lastCard[0]=='jack' && colCard[0]=='queen') || (lastCard[0]=='queen' && colCard[0]=='king')){
                        if (lastCard[1]=='spades' || lastCard[1]=='clubs'){
                            if (colCard[1]=='hearts' || colCard[1]=='diamonds'){
                                var newArray = activeLevel.colCards;
                                for (i=0;i<numSelected;i++){newArray[y-1] = newArray[y-1].concat([activeLevel.colCards[x-1][activeLevel.colCards[x-1].length-numSelected+i]]);}

                                newArray[x-1] = newArray[x-1].slice(0,activeLevel.colCards[x-1].length-numSelected);
                                activeLevel.colCards = newArray;
                            }
                        }
                        else {
                                if (colCard[1]=='spades' || colCard[1]=='clubs'){
                                    var newArray = activeLevel.colCards;
                                    for (i=0;i<numSelected;i++){newArray[y-1] = newArray[y-1].concat([activeLevel.colCards[x-1][activeLevel.colCards[x-1].length-numSelected+i]]);}
                                    newArray[x-1] = newArray[x-1].slice(0,activeLevel.colCards[x-1].length-numSelected);
                                    activeLevel.colCards = newArray;
                                }
                        }
                    }
                    }
                    else {
                        if (lastCard[0]=='king'){
                            var newArray = activeLevel.colCards;
                            for (i=0;i<numSelected;i++){newArray[y-1] = newArray[y-1].concat([activeLevel.colCards[x-1][activeLevel.colCards[x-1].length-numSelected+i]]);}
                            newArray[x-1] = newArray[x-1].slice(0,activeLevel.colCards[x-1].length-numSelected);
                            activeLevel.colCards = newArray;
                        }
                    }
                }
                colSelected = 0;
                numSelected = 0;
                var i;
                var ii;
                var newArray = activeLevel.colCards;
                for (ii=0;ii<7;ii++){
                     for (i=0;i<newArray[ii].length;i++){
                    newArray[ii][i][3]=0;
                     }
                 }
                activeLevel.colCards = newArray;
           }
        }
        function moveUp(x){
            if (activeLevel.turnCards.length>activeLevel.turnSpot+activeLevel.turnDisplay-1){
                if (activeLevel.turnSpot+activeLevel.turnDisplay>0){
                    var newArray = activeLevel.turnCards;
                    newArray[activeLevel.turnSpot+activeLevel.turnDisplay-1][3]=0;
                    activeLevel.turnCards = newArray;
                }
            }
            if (x==0){
            }
            else if (x==8){
                var lastCard = activeLevel.turnCards[activeLevel.turnSpot+activeLevel.turnDisplay-1];
                var y = 0;
                if (lastCard[1]=='hearts'){y = 0;}
                if (lastCard[1]=='diamonds'){y = 1;}
                if (lastCard[1]=='clubs'){y = 2;}
                if (lastCard[1]=='spades'){y = 3;}
                var newArray = activeLevel.stackCards;
                if ((newArray[y][0]==0 && lastCard[0]=='ace') || newArray[y][0]==lastCard[0]-1 || (newArray[y][0]=='ace' && lastCard[0]==2) || (newArray[y][0]==10 && lastCard[0]=='jack') || (newArray[y][0]=='jack' && lastCard[0]=='queen')|| (newArray[y][0]=='queen' && lastCard[0]=='king')){
                    newArray[y] = lastCard;
                    activeLevel.stackCards = newArray;
                    newArray = activeLevel.turnCards;
                    newArray.splice(activeLevel.turnSpot+activeLevel.turnDisplay-1,1);
                    activeLevel.turnDisplay--;
                    activeLevel.turnCards = newArray;
                }
            }
            else {
                var lastCard = activeLevel.colCards[x-1][activeLevel.colCards[x-1].length-1];
                var y = 0;
                if (lastCard[1]=='hearts'){y = 0;}
                if (lastCard[1]=='diamonds'){y = 1;}
                if (lastCard[1]=='clubs'){y = 2;}
                if (lastCard[1]=='spades'){y = 3;}
                var newArray = activeLevel.stackCards;
                if ((newArray[y][0]==0 && lastCard[0]=='ace') || newArray[y][0]==lastCard[0]-1 || (newArray[y][0]=='ace' && lastCard[0]==2) || (newArray[y][0]==10 && lastCard[0]=='jack') || (newArray[y][0]=='jack' && lastCard[0]=='queen')|| (newArray[y][0]=='queen' && lastCard[0]=='king')){
                    newArray[y] = lastCard;
                    activeLevel.stackCards = newArray;
                    newArray = activeLevel.colCards
                    newArray[x-1]=newArray[x-1].slice(0,newArray[x-1].length-1);
                    activeLevel.colCards = newArray
                }
                var i;
                var ii;
                var newArray = activeLevel.colCards;
                for (ii=0;ii<7;ii++){
                     for (i=0;i<newArray[ii].length;i++){
                    newArray[ii][i][3]=0;
                     }
                 }
                numSelected = 0;
                activeLevel.colCards = newArray;
            }
            colSelected=0;
        }
        function turnCard(){
            if (activeLevel.turnSpot+activeLevel.turnDisplay<activeLevel.turnCards.length-2){
            activeLevel.turnSpot+=activeLevel.turnDisplay;
            activeLevel.turnDisplay = 3;
            }
            else if (activeLevel.turnSpot+activeLevel.turnDisplay==activeLevel.turnCards.length){
                activeLevel.turnSpot = 0;
                activeLevel.turnDisplay = 3;
            }
            else {
                activeLevel.turnSpot+=activeLevel.turnDisplay;
                activeLevel.turnDisplay = activeLevel.turnCards.length-(activeLevel.turnSpot);
            }

        }
        function chooseTurn(){
            colSelected = 8;
            var newArray = activeLevel.turnCards;
            newArray[activeLevel.turnSpot+activeLevel.turnDisplay-1][3]=.3;
            activeLevel.turnCards = newArray;
        }

    }






}
