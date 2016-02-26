/*
  options page that includes sound / music
  */

import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Window 2.1
import QtQuick.Layouts 1.2


Item {

    Column{
        anchors.centerIn: parent
        id: options
        spacing: 10
        Row{
            id:musicButtons
            spacing: 20
            Text{
                text: "Background Music"
            }

            Button{
                text:"On"

                onClicked: {
                    backgroundMusic.play();
                }
            }

            Button{
                text:"Off"

                onClicked: {
                    backgroundMusic.stop();
                }
            }
        }

        Row {
            id:soundEffectsButton
            spacing: 20

            Text{
                text: "Sound Effects"
            }

            Button{
                text:"On"

                onClicked: {
                    soundEffects.volume = 1.0;
                }
            }

            Button{
                text:"Off"
                onClicked: {
                    soundEffects.volume = 0.0;
                }
            }
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
