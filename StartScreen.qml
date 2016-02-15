import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtMultimedia 5.5
import QtQuick.Layouts 1.2
QtObject {
    id: mainWindow
    property SystemPalette palette: SystemPalette { }
    Component.onCompleted: {
        //backgroundMusic.play();
    }

    property var startWindow: Window {
        width: Screen.width
        height: Screen.height
        color: palette.window
        title: "Control Window"

        GridLayout{

            Button{
                id:levelsButton
                text:"Game"
                onClicked: {
                    //game.visible = true;
                    soundEffects.source = "Bubbles.wav"
                    soundEffects.play()

                    pageLoader.source = "GameScreen.qml"

                }

            }
            Button{
                id:optionsButton
                text:"Options"
                onClicked: {
                    soundEffects.source = "Bubbles.wav"
                    soundEffects.play()
                }
            }
            Button{
                id:creditsButton
                text:"Credits"
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

//        GameScreen{
//            id:game
//            anchors.fill: parent
//            visible: false
//        }
        MediaPlayer{
            id:backgroundMusic
            source:"backgroundMusic.wav"
            //autoPlay: true
            loops: Audio.Infinite
        }
    }



    property var splashWindow: Splash {
        onTimeout: startWindow.visible = true
    }

}

