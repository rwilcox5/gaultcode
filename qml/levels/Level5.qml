import QtQuick 2.0
import VPlay 2.0
import "../common" as Common

Common.LevelBase {
    id: level5
    levelName: "Level5"


    turnCards: createCards([[10,3],[6,3],[8,3],[7,0],[12,0],[9,1],[7,2],[13,2]])
    stackCards: createStack([5,4,6,5])
    property var col1Cards: createCards([[13,1],[12,3],[11,0],[10,2]])
    property var col2Cards: createCards([[13,3],[12,1],[11,2],[10,0],[9,2],[8,0]])
    property var col3Cards: createCards([[9,0,0],[8,2,0],[7,1]])
    property var col4Cards: createCards([[5,1,0],[6,0,0],[11,3],[10,1],[9,3],[8,1],[7,3],[6,1]])
    property var col5Cards: createCards([[13,0],[12,2],[11,1]])
    property var col6Cards: createCards([])
    property var col7Cards: createCards([])

    colCards: [col1Cards,col2Cards,col3Cards,col4Cards,col5Cards,col6Cards,col7Cards]
    turnSpot: 0
    turnDisplay: 3




}
