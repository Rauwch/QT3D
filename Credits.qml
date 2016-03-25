/*
    page with credits (our names)
   */
import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Window 2.1
import QtQuick.Controls.Styles 1.4

Item {
    Rectangle {
        anchors.centerIn: parent
        width: Screen.width/3
        height: Screen.height/4
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
            //text: "Developers:\n\nAnton \"The Bugwhisperer\" Rauws\nJan \"Qt-pie\" van Thillo"
            text: "Ontwikkelaars:\n\nAnton Rauws\nJan van Thillo"
            font.pointSize: 20
        }
    }
    Button{
        id: theReturnButton
        width: Screen.width/15
        height: Screen.height/15
        style: ButtonStyle {
            id:styleButton
            background: Rectangle {
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
            soundEffects.play();
            theColumn.visible= true;
            /* making the source empty will destroy the previous loaded page */
            pageLoader.source = "";
        }
    }
}

