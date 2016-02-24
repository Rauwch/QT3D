/*
  to be implemented: names of designers, etc
  */
import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Window 2.1
import QtQuick.Controls.Styles 1.4



Item {
    Rectangle {
        width: Screen.width/3
        height: Screen.height/4
        anchors.centerIn: parent
        border.width:  2
        border.color: "#063e79"
        radius: 10
        gradient: Gradient {
            GradientStop { position: 0 ; color: "#2589f4" }
            GradientStop { position: 1 ; color: "#0b6fda" }
        }

        Text{
            id:creditsText
            anchors.centerIn: parent
            text: "Developers:\n\nAnton \"The Bugwhisperer\" Rauws\nJan \"Qt-pie\" van Thillo"
            font.pointSize: 20

        }
    }
    Button{
        id: theReturnButton
        //anchors.horizontalCenter: creditsText.horizontalCenter
        //anchors.verticalCenter: parent.verticalCenter
        //anchors.verticalCenterOffset: 150
        //width: creditsText.width
        width: Screen.width/15
        height: Screen.height/15
        style: ButtonStyle {
            id:styleButton
            background: Rectangle {
                //implicitWidth: 100
                //implicitHeight: 25
                border.width: 2
                border.color: "#063e79"
                radius: 10
                gradient: Gradient {
                    GradientStop { position: 0 ; color: "#2589f4" }
                    GradientStop { position: 1 ; color: "#0b6fda" }
                }
            }

        }
        Image{
            source: "backIcon.png"
            height: 3*parent.height/4
            width: 3*parent.width/4
            anchors.centerIn: parent
        }
        onClicked: {
            soundEffects.source = "Bubbles.wav";
            soundEffects.play();
            theColumn.visible= true;
            pageLoader.source = "";

        }

    }
}

