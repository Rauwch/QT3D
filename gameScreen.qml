import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Window 2.0
import QtQuick.Scene3D 2.0
import Link 1.0
Item {
    id: mainWindow
    property bool showBox
    width:800
    height:600


    Scene3D{
        anchors.fill: parent
        aspects: ["render", "logic"]
        focus: true

        World { id: world }
    }


    Rectangle{
        id: textBox
        width: 50
        height: 50
        visible: showBox

        Button{
            id: increaseHeight
            text: "CLICK ME!"
            onClicked: myLinker.setMyHeight(myLinker.getMyHeight()+1)
        }
    }
    Linker{
        id: myLinker
    }



}
