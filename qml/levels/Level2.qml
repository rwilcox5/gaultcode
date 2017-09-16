import QtQuick 2.0
import VPlay 2.0
import "../common" as Common

Common.LevelBase {
    id: level2
    levelName: "Level2"


    turnCards: createCards([[2,0],[4,0],[7,3],[1,3],[13,1],[4,1],[11,0],[12,0],[1,2],[3,3],[10,2],[3,1],[12,1],[10,0],[12,2],[2,3],[11,2],[2,1],[5,0],[5,1],[3,2],[13,2],[4,2],[3,0]])
    stackCards: createStack(["ace","ace","back","back"])
    property var col1Cards: createCards([[9,3]])
    property var col2Cards: createCards([[13,0,0],[2,2]])
    property var col3Cards: createCards([[11,3,0],[10,3,0],[8,3]])
    property var col4Cards: createCards([[7,0,0],[8,0,0],[9,0,0],[6,0]])
    property var col5Cards: createCards([[4,3,0],[6,3,0],[5,3,0],[6,1]])
    property var col6Cards: createCards([[5,2,0],[6,2,0],[7,2,0],[9,2,0],[8,2,0],[12,3]])
    property var col7Cards: createCards([[8,1,0],[7,1,0],[9,1,0],[10,1,0],[11,1,0],[13,3]])

    colCards: [col1Cards,col2Cards,col3Cards,col4Cards,col5Cards,col6Cards,col7Cards]
    turnSpot: 0
    turnDisplay: 3




}
