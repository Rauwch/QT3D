/*
  2d overlay on top of 3d world (Scene3D)
  includes the buttons that adjust the properties (increase/decrease height)
  */
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
        width: 300
        height: 150
        spacing: 10
        visible: showBox

        //button that allows for height to be edited
        //trying to increase the speed here as well
        Button {
            id: increaseHeight
            text: "Increase height!"
            width: 300
            height: 50
            onClicked:{
                console.log("ervoor" + myLinker.getMySpeed());
                myLinker.setMySpeed(myLinker.getMySpeed()+1000);
                console.log("erna" + myLinker.getMySpeed());
                myLinker.setMyHeight(myLinker.getMyHeight()+1);
            }
        }

        Button{
            id: decreaseHeight
            text: "Decrease height!"
            width: 300
            height: 50
            onClicked: myLinker.setMyHeight(myLinker.getMyHeight()-1)
        }
    }

    //creates one Linker object
    Linker{
        id: myLinker
        Component.onCompleted: {
            console.log("linker in gamescreen")
        }
    }




}
