import QtQuick 2.0

Item {
    // this will be displayed in the GameScene
    property string levelName
    property var turnCards
    property var stackCards
    property var colCards
    property int turnSpot
    property int turnDisplay
    // this is emitted whenever the rectangle has been tapped successfully, the GameScene will listen to this signal and increase the score
    signal rectanglePressed


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
        function createStack(x){
            var i;
            for (i=0;i<4;i++){if (x[i]=='back'){x[i]=0;}}
            return [[x[0],'hearts'],[x[1],'diamonds'],[x[2],'clubs'],[x[3],'spades']]
        }

}


