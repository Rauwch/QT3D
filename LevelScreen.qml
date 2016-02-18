/*
  first window that is shown
  includes:
    game, options, credits
  */

import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Window 2.1
import QtMultimedia 5.5
import QtQuick.Layouts 1.2
import Link 1.0
import Lvl 1.0
Item {
    id: myLevelScreen
    property int buttonWidth: Screen.width/10
    property int buttonHeight: 100
    //signal thereturner()
    Component.onDestruction: console.log("levelscreen destroyed")

    Component.onCompleted: {
        console.log("mylevelscreen wordt aangemaakt");
        console.log("Numbers of levels " + myLevels.amountOfLevels);
    }
        Grid{
            anchors.centerIn: parent
            rows:2
            spacing: 20

            Repeater{
                id: levelRepeater
                model:myLevels.amountOfLevels
                delegate:
                    Button{
                    text: "Level "+ (index+1)
                    width: buttonWidth
                    height: buttonHeight
                }
            }

//            Button{
//                id:level1
//                text:"level 1"
//                width: buttonWidth
//                height: buttonHeight
//                onClicked: {
//                    //game.visible = true;
//                    soundEffects.source = "Bubbles.wav";
//                    soundEffects.play();
//                    pageLoader.source = "GameScreen.qml";

//                    }

//                }


//            Button{
//                id:level2
//                text:"level 2"
//                width: buttonWidth
//                height: buttonHeight

//                onClicked: {
//                    soundEffects.source = "Bubbles.wav";
//                    soundEffects.play();
//                }
//            }

        }
}

