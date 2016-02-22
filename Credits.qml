/*
  to be implemented: names of designers, etc
  */
import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Window 2.1


Item {
    Text{
        id:creditsText
        anchors.centerIn: parent
        text: "Top Sea Men:\n\nAnton \"The Bugwhisperer\" Rauws\nJan \"Qt-pie\" van Thillo"
        font.pixelSize: 30

    }
    Button{
        id: theReturnButton
        //anchors.horizontalCenter: creditsText.horizontalCenter
        //anchors.verticalCenter: parent.verticalCenter
        //anchors.verticalCenterOffset: 150
        //width: creditsText.width
        width: Screen.width/15
        height: Screen.height/15
        text:"Return"
        onClicked: {
            soundEffects.source = "Bubbles.wav";
            soundEffects.play();
            theColumn.visible= true;
            pageLoader.source = "";

            }

    }
}
