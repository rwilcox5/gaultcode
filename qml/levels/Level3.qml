import QtQuick 2.0
import VPlay 2.0
import "../common" as Common

Common.LevelBase {
    id: level3
    levelName: "Level3"


    turnCards: createCards([[4,2],[7,3],[10,3],[6,1],[8,1],[6,2],[7,0],[9,3]])
    stackCards: createStack([3,5,2,5])
    property var col1Cards: createCards([[13,2],[12,1],[11,3],[10,1],[9,2],[8,0],[7,2]])
    property var col2Cards: createCards([[13,1],[12,3],[11,1],[10,2],[9,0],[8,3]])
    property var col3Cards: createCards([[13,3],[12,0],[11,2],[10,0]])
    property var col4Cards: createCards([[13,0],[12,2],[11,0]])
    property var col5Cards: createCards([[6,0,0],[5,2],[4,0],[3,2]])
    property var col6Cards: createCards([[9,1],[8,2],[7,1],[6,3],[5,0]])
    property var col7Cards: createCards([])

    colCards: [col1Cards,col2Cards,col3Cards,col4Cards,col5Cards,col6Cards,col7Cards]
    turnSpot: 0
    turnDisplay: 3




}
