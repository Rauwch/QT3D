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
import Lvl 1.0
Item {
    id: myStartScreen
    property SystemPalette palette: SystemPalette { }
    property int buttonWidth: Screen.width/3
    property int buttonHeight: 100
    signal test()
    Component.onDestruction: console.log("startscreen destroyed")
    Component.onCompleted: {
        //backgroundMusic.play();
        console.log("myStartScreen wordt aangemaakt");

    }


    property var startWindow: Window {
        //visibility: Window.Maximized
        color: palette.window
        title: "Octupus Mayhem"


        Column{
            id: theColumn
            anchors.centerIn: parent
            spacing: 15

            Button{
                id:levelsButton
                text:"Levels"
                width: buttonWidth
                height: buttonHeight
                onClicked: {
                    //game.visible = true;
                    soundEffects.source = "Bubbles.wav";
                    soundEffects.play() ;
                    theColumn.visible = false;
                    //startscreen doesn't get deleted because it wasn't created by the pageloader
                    pageLoader.source = "LevelScreen.qml";


                    }

                }


            Button{
                id:optionsButton
                text:"Options"
                width: buttonWidth
                height: buttonHeight

                onClicked: {
                    soundEffects.source = "Bubbles.wav"
                    soundEffects.play()
                }
            }
            Button{
                id:creditsButton
                text:"Credits"
                width: buttonWidth
                height: buttonHeight

                onClicked: {
                    soundEffects.source = "Bubbles.wav"
                    soundEffects.play()
                    theColumn.visible = false;
                    pageLoader.source = "Credits.qml";
                }
            }
        }
        SoundEffect{
            id: soundEffects
            //source:"Bubbles.wav"
        }

        Loader{
            id: pageLoader
            anchors.fill: parent
            asynchronous: true
            visible: status == Loader.Ready

        }
        property var emptySource
        Connections{
            target: pageLoader.item
            Component.onDestruction: console.log(" page loader destroyed")

//            onTest:{
//                pageLoader.source= "LevelScreen.qml";
//                console.log("Source is empty");
//            }
        }


        MediaPlayer{
            id:backgroundMusic
            source:"backgroundMusic.wav"
            //autoPlay: true
            volume: 0.5
            loops: Audio.Infinite
        }
    }




    property var splashWindow: Splash {
        onTimeout: {
            startWindow.visible = true;
            startWindow.visibility = Window.Maximized
    }

}
}

