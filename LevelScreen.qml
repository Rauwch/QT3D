/*
  window that lets user choose a level
  */

import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Window 2.1
import QtMultimedia 5.5
import QtQuick.Layouts 1.2
import Link 1.0
import Lvl 1.0
import QtQuick.Controls.Styles 1.4

Item {
    id: myLevelScreen
    property int buttonWidth: Screen.width/8
    property int buttonHeight: Screen.height/8
    Component.onDestruction: console.log("levelscreen destroyed")

    Component.onCompleted: {
        console.log("mylevelscreen wordt aangemaakt");
    }
    Grid{
        anchors.centerIn: parent
        rows: 3
        spacing: 30
        //
        Repeater{
            id: levelRepeater
            model:myLevels.amountOfLevels
            delegate:
                Rectangle{

                Component.onCompleted:
                {
                    if( myLevels.getAmountOfStars(index) > 0 || myLevels.getAmountOfStars(index-1) )
                    {
                        levelMouse.enabled = true;
                        lockImage.visible = false;
                    }
                    else{
                        levelMouse.enabled = false;
                        levelText.visible = false;
                        lockImage.visible = true;
                    }
                    if(!levelMouse.enabled)
                    {
                        color = "grey";
                    }
                }

                border.width: 2

                border.color: "#063e79"
                gradient: Gradient {
                    GradientStop { position: 0 ; color: "#2589f4" }
                    GradientStop { position: 1 ; color: "#0b6fda" }
                }
                radius: 10


            //border.width: 3
            Text{
                id: levelText
                anchors.centerIn: parent
                text: "Level "+ (index+1)
                //font.pixelSize: 30
                renderType: Text.NativeRendering
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: "Helvetica"
                font.pointSize: 20
                color: "black"
            }
            Image{
                id:lockImage
                anchors.centerIn: parent
                height: parent.height
                width: parent.width-parent.width/2
                source: "lock.png"
            }

            width: buttonWidth
            height: buttonHeight
            MouseArea{
                id: levelMouse
                anchors.fill: parent

                onClicked: {
                    //game.visible = true;
                    myLevels.setCurrentLevel(index + 1);
                    soundEffects.source = "Bubbles.wav";
                    soundEffects.play();
                    pageLoader.source = "GameScreen.qml";
                }
            }

            Grid{
                anchors.verticalCenter: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                Repeater{
                    id: starRepeater
                    // this is the index from the button assigned by the top repeater
                    model: myLevels.getAmountOfStars(index)
                    delegate:
                        Image{

                        source: "starfish.png";
                        width: 70;
                        height: 70;
                    }
                }
            }
        }
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
        soundEffects.source = "Bubbles.wav";
        soundEffects.play();
        theColumn.visible= true;
        pageLoader.source = "";

    }

}
}

