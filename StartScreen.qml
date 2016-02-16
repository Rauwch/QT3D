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
QtObject {
    id: mainWindow
    property SystemPalette palette: SystemPalette { }
    property int buttonWidth: Screen.width/3
    property int buttonHeight: 50
    Component.onCompleted: {
        //backgroundMusic.play();
    }

    property var startWindow: Window {
        //visibility: Window.Maximized
        color: palette.window
        title: "Octupus Mayhem"


        Column{
            anchors.centerIn: parent
            spacing: 15

            Button{
                id:levelsButton
                text:"Game"
                width: buttonWidth
                height: buttonHeight
                onClicked: {
                    //game.visible = true;
                    soundEffects.source = "Bubbles.wav"
                    soundEffects.play()
                    //pageLoader.source = "LoadingScreen.qml"
                    pageLoader.source = "GameScreen.qml"

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

