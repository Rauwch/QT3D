import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Window 2.0
Rectangle{
    id: window
    property int stage: 0
    property int xVal: 0
    property int yVal: 0

    Component.onCompleted: {
        //anchors.centerIn = parent
    }
    color:"white"

    width: Screen.width/4
    height: Screen.height/4
    anchors.leftMargin: xVal
    anchors.bottomMargin: yVal
    Column{
        id:start
        visible: {0 == stage}

        spacing:30
        Text{
            id:welcomeMessage
            text:"Welkom in Kwallen Mayhem"
        }
        Button{
            id:welcomeButton
            text:"Volgende"
            onClicked: {
                window.anchors.leftMargin += 50;
                stage++;
            }
        }
    }

    Column{
        id:increaseSource
        visible:{1 == stage}
        spacing: 30
        Image{

        }
        Text{
            text: "tadaaaa"

        }
    }
}

