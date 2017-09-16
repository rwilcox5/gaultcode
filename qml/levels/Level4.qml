import QtQuick 2.0
import VPlay 2.0
import "../common" as Common

Common.LevelBase {
    id: level4
    levelName: "Level4"


    turnCards: createCards([[10,1],[11,3],[8,3],[7,1],[10,0],[9,0],[9,2],[8,2],[8,0]])
    stackCards: createStack([5,5,7,7])
    property var col1Cards: createCards([[13,1],[12,3],[11,1],[10,3],[9,1]])
    property var col2Cards: createCards([[13,3],[12,0],[11,2]])
    property var col3Cards: createCards([[6,0,0],[6,1,0],[7,0]])
    property var col4Cards: createCards([[13,2,0],[12,1]])
    property var col5Cards: createCards([[13,0],[12,2],[11,0],[10,2]])
    property var col6Cards: createCards([[9,3],[8,1]])
    property var col7Cards: createCards([])

    colCards: [col1Cards,col2Cards,col3Cards,col4Cards,col5Cards,col6Cards,col7Cards]
    turnSpot: 0
    turnDisplay: 3




}
