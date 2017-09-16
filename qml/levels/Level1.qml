import QtQuick 2.0
import VPlay 2.0
import "../common" as Common

Common.LevelBase {
    id: level1
    levelName: "Level1"


    turnCards: createCards([[11,0],[4,2],[4,1],[5,2],[5,3],[3,1],[1,1],[1,0],[10,3],[3,2],[2,2],[10,0],[2,1],[5,0],[12,2],[10,2],[12,0],[4,0],[11,2],[6,3],[9,0],[8,2],[1,2],[3,0]])
    stackCards: createStack(["back","back","back","back"])
    property var col1Cards: createCards([[6,0]])
    property var col2Cards: createCards([[7,1,0],[8,3]])
    property var col3Cards: createCards([[7,2,0],[6,2,0],[2,0]])
    property var col4Cards: createCards([[9,1,0],[7,0,0],[7,3,0],[9,3]])
    property var col5Cards: createCards([[8,1,0],[8,0,0],[13,1,0],[13,0,0],[11,3]])
    property var col6Cards: createCards([[13,3,0],[1,3,0],[2,3,0],[3,3,0],[4,3,0],[12,3]])
    property var col7Cards: createCards([[12,1,0],[11,1,0],[10,1,0],[6,1,0],[9,2,0],[13,2,0],[5,1]])

    colCards: [col1Cards,col2Cards,col3Cards,col4Cards,col5Cards,col6Cards,col7Cards]
    turnSpot: 0
    turnDisplay: 3




}
