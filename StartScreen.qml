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
import QtQuick.Controls.Styles 1.4


import Lvl 1.0
Item {
    id: myStartScreen
    property SystemPalette palette: SystemPalette { }
    property int buttonWidth: Screen.width/3
    property int buttonHeight: 100
    property bool backgroundVisible: true
    property bool musicBool: false
    property bool soundBool: true
    signal test()
    Component.onDestruction: console.log("startscreen destroyed")
    Component.onCompleted: {
        console.log("myStartScreen wordt aangemaakt");
        //startWindow.visibility = Window.FullScreen;
        startWindow.visibility = Window.Maximized;

    }
    Levels{
        id:myLevels
    }

    property var startWindow: Window {
        color: palette.window
        title: "Jellyfields"
        visible:  true
        Image{
            id: bikiniImg
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: "bikiniBottom.jpg"
        }


        Column{
            id: theColumn
            anchors.centerIn: parent
            spacing: 15

            Button{
                id:levelsButton
                text:"Levels"
                width: buttonWidth
                height: buttonHeight
                style: ButtonStyle {
                    id:styleButton
                    background: Rectangle {
                        border.width: control.activeFocus ? 4 : 2

                        border.color: "#063e79"
                        radius: 10
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: control.pressed ? "#479af5" : "#2589f4" }
                            GradientStop { position: 1 ; color: control.pressed ? "#2589f4" : "#0b6fda" }
                        }
                    }
                    label: Text {
                        renderType: Text.NativeRendering
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Helvetica"
                        font.pointSize: 20
                        color: "black"
                        text: control.text
                    }
                }

                onClicked: {
                    soundEffects.play() ;
                    theColumn.visible = false;
                    pageLoader.source = "LevelScreen.qml";


                }

            }


            Button{
                id:optionsButton
                //text:"Options"
                text:"Opties"
                width: buttonWidth
                height: buttonHeight
                style: ButtonStyle {
                    id:styleButton
                    background: Rectangle {
                        border.width: control.activeFocus ? 4 : 2
                        border.color: "#063e79"
                        radius: 10
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: control.pressed ? "#479af5" : "#2589f4" }
                            GradientStop { position: 1 ; color: control.pressed ? "#2589f4" : "#0b6fda" }
                        }
                    }
                    label: Text {
                        renderType: Text.NativeRendering
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Helvetica"
                        font.pointSize: 20
                        color: "black"
                        text: control.text
                    }
                }
                onClicked: {
                    soundEffects.play();
                    theColumn.visible = false;
                    pageLoader.source = "Options.qml";
                }
            }
            Button{
                id:creditsButton
                //text:"Credits"
                text:"Ontwikkelaars"
                width: buttonWidth
                height: buttonHeight
                style: ButtonStyle {
                    id:styleButton
                    background: Rectangle {
                        border.width: control.activeFocus ? 4 : 2

                        border.color: "#063e79"
                        radius: 10
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: control.pressed ? "#479af5" : "#2589f4" }
                            GradientStop { position: 1 ; color: control.pressed ? "#2589f4" : "#0b6fda" }
                        }
                    }
                    label: Text {
                        renderType: Text.NativeRendering
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Helvetica"
                        font.pointSize: 20
                        color: "black"
                        text: control.text
                    }
                }
                onClicked: {
                    soundEffects.play();
                    theColumn.visible = false;
                    pageLoader.source = "Credits.qml";
                }
            }

            Button{
                id:stopButton
                //text:"Quit"
                text:"Afsluiten"
                width: buttonWidth
                height: buttonHeight
                style: ButtonStyle {
                    background: Rectangle {
                        border.width: control.activeFocus ? 4 : 2
                        border.color: "#063e79"
                        radius: 10
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: control.pressed ? "#479af5" : "#2589f4" }
                            GradientStop { position: 1 ; color: control.pressed ? "#2589f4" : "#0b6fda" }
                        }
                    }
                    label: Text {
                        renderType: Text.NativeRendering
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Helvetica"
                        font.pointSize: 20
                        color: "black"
                        text: control.text
                    }
                }
                onClicked: {
                    startWindow.close();
                }
            }
        }
        SoundEffect{
            id: soundEffects
            source:"Bubbles.wav"
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

        }
        MediaPlayer{
            id:backgroundMusic
            source:"backgroundMusic.wav"
            volume: 1
            loops: Audio.Infinite
        }
    }
}

