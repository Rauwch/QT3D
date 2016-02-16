
import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Window 2.0
import QtQuick.Scene3D 2.0
import Link 1.0
Item {
    id: mainWindow
    property bool showBox
    anchors.fill: parent



    Scene3D{
        anchors.fill: parent
        focus: true
        aspects: ["render", "logic"]
        World { id: world }
    }

    //2d box where setting can be edited
    Column{
        id: textBox
        width: 100
        height: 50
        spacing: 10
        visible: showBox

        //button that allows for height to be edited
        Button {
            id: increaseHeight
            text: "Increase height!"

            onClicked: myLinker.setMyHeight(myLinker.getMyHeight()+1)
        }

        Button{
            id: decreaseHeight
            text: "Decrease height!"
            onClicked: myLinker.setMyHeight(myLinker.getMyHeight()-1)
        }
    }
    Linker{
        id: myLinker
    }



}
