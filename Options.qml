import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Window 2.1

Item {
    Button{
        id: bikiniButton
        text:"Bikini Botton"
        width: Screen.width/15
        height: Screen.height/15
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: width/2
        onClicked: {
            soundEffects.source = "Bubbles.wav";
            soundEffects.play();


            myStartScreen.backgroundVisible = true;
        }
    }
    Button{
        id: noBikiniButton
        text:"Bikini Bottoff"
        width: Screen.width/15
        height: Screen.height/15
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -width/2
        onClicked: {
            soundEffects.source = "Bubbles.wav";
            soundEffects.play();


            myStartScreen.backgroundVisible = false;
        }
    }


    Button{
        id: theReturnButton
        //anchors.horizontalCenter: creditsText.horizontalCenter
        //anchors.verticalCenter: parent.verticalCenter
        //anchors.verticalCenterOffset: 150
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
