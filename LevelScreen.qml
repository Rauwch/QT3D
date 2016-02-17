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
Item {
    id: myLevelScreen
    //signal thereturner()
    Component.onDestruction: console.log("levelscreen destroyed")

    Component.onCompleted: console.log("mylevelscreen wordt aangemaakt")
        Column{
            anchors.centerIn: parent
            spacing: 15

            Button{
                id:level1
                text:"level 1"
                width: buttonWidth
                height: buttonHeight
                onClicked: {
                    //game.visible = true;
                    soundEffects.source = "Bubbles.wav";
                    soundEffects.play();
                    pageLoader.source = "GameScreen.qml";

                    }

                }


            Button{
                id:level2
                text:"level 2"
                width: buttonWidth
                height: buttonHeight

                onClicked: {
                    soundEffects.source = "Bubbles.wav";
                    soundEffects.play();
                }
            }

        }
}

