/*
  second window that is shown
  includes:
    (completed) levels
  */

import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Window 2.1
import QtMultimedia 5.5
import QtQuick.Layouts 1.2
Item {
    id: myLevelScreen
    property SystemPalette palette: SystemPalette { }
    property int buttonWidth: Screen.width/3
    property int buttonHeight: 100
    Component.onCompleted: {
        //backgroundMusic.play();
        console.log("myLevelScreen wordt aangemaakt")
    }

    Component{
        id: theGameScreen
        GameScreen{
        }

    }


    property var startWindow: Window {
        //visibility: Window.Maximized
        color: palette.window
        title: "Octupus Mayhem"


        Column{
            anchors.centerIn: parent
            spacing: 15

            Button{
                id:level1_Button
                text:"Level_1"
                width: buttonWidth
                height: buttonHeight
                onClicked: {
                    //game.visible = true;
                    soundEffects.source = "Bubbles.wav"
                    soundEffects.play()
                    pageLoader.sourceComponent = theGameScreen

                    }

                }

            Button{
                id:level2_Button
                text:"Level_1"
                width: buttonWidth
                height: buttonHeight
                onClicked: {
                    //game.visible = true;
                    soundEffects.source = "Bubbles.wav"
                    soundEffects.play()
                    pageLoader.sourceComponent = theGameScreen

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

            onReturner:{
                pageLoader.sourceComponent= null
                console.log("Source is empty")
            }
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

