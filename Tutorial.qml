import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Window 2.0
Rectangle{
    id: instructionWindow
    property int stage: 0
    property int numStages: 3
    property int offset: buttonNext.height
    color:"white"
    width: Screen.width/4
    height: Screen.height/4
    visible: {stage <= numStages}

    Rectangle{
        id:start
        width: parent.width
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        visible: {stage <= numStages}

        Component.onCompleted: {
            instructionWindow.anchors.leftMargin = (Screen.width/2 - instructionWindow.width/2)
            instructionWindow.anchors.bottomMargin = (Screen.height/2 - instructionWindow.height/2)
        }
        Text{
            id:instructionText
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: offset
            text: "Welcome to the tutorial!"
        }
        Button{
            id:buttonNext
            visible: {stage <= numStages}
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: offset
            text:"Volgende"
            onClicked: {
                stage++;
                switch(stage){
                case(1):
                    instructionWindow.anchors.leftMargin = 100;
                    instructionText.text = "stage 1";
                    break;
                case(2):
                    instructionWindow.anchors.leftMargin = 100;
                    instructionText.text = "stage 2";
                    break;
                case(numStages):
                    instructionWindow.anchors.leftMargin = 100;
                    instructionText.text = "Thank you for completing the tutorial!";
                    break;
                default:
                    instructionWindow.anchors.leftMargin = (Screen.width/2 - instructionWindow.width/2);
                    instructionWindow.anchors.bottomMargin = (Screen.height/2 - instructionWindow.height/2);
                    break;
                }
            }
        }

    }
}

