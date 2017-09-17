import QtQuick 2.0
import VPlay 2.0
import "../common" as Common

Common.LevelBase {
    id: level7
    levelName: "Level7"


    turnCards: createCards([[9,2],[7,0],[1,2],[13,1],[6,3],[11,1],[7,3],[12,0],[3,1],[1,0],[4,1],[6,0],[9,3],[12,2],[1,3],[10,3],[13,0],[6,1],[3,3],[11,0],[11,2],[10,2],[3,0],[2,2]])
    stackCards: createStack(["back","back","back","back"])
    property var col1Cards: createCards([[8,1]])
    property var col2Cards: createCards([[5,0,0],[5,1]])
    property var col3Cards: createCards([[7,2,0],[4,2,0],[8,2]])
    property var col4Cards: createCards([[2,3,0],[2,1,0],[13,2,0],[12,3]])
    property var col5Cards: createCards([[8,3,0],[10,1,0],[1,1,0],[2,0,0],[8,0]])
    property var col6Cards: createCards([[7,1,0],[4,0,0],[12,1,0],[6,2,0],[3,2,0],[5,2]])
    property var col7Cards: createCards([[10,0,0],[5,3,0],[11,3,0],[9,1,0],[4,3,0],[9,0,0],[13,3]])

    colCards: [col1Cards,col2Cards,col3Cards,col4Cards,col5Cards,col6Cards,col7Cards]
    turnSpot: 0
    turnDisplay: 3




}
