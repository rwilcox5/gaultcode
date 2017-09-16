import QtQuick 2.0
import VPlay 2.0
import "../common" as Common

Common.LevelBase {
    id: level1
    levelName: "Level1"


    turnCards: createCards([[11,1],[7,2],[2,3],[3,2],[3,1],[2,2]])
    stackCards: createStack(["king","back","ace","back"])
    property var col1Cards: createCards([[5,1],[4,2]])
    property var col2Cards: createCards([])
    property var col3Cards: createCards([[5,3,0],[7,3,0],[8,1,0],[5,2],[4,1]])
    property var col4Cards: createCards([[4,3,0],[6,3,0],[8,3,0],[9,1,0]])
    property var col5Cards: createCards([])
    property var col6Cards: createCards([])
    property var col7Cards: createCards([])

    colCards: [col1Cards,col2Cards,col3Cards,col4Cards,col5Cards,col6Cards,col7Cards]
    turnSpot: 0
    turnDisplay: 3




}
