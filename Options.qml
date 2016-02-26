/*
  options page that includes sound / music
  */

import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Window 2.1
import QtQuick.Layouts 1.2
import QtQuick.Controls.Styles 1.4
Item {

    Column{
        anchors.centerIn: parent
        height: Screen.height/2
        id: options
        spacing: 10


        Row{
            id:musicButtons
            spacing: 20
            //width: Screen.width/3
            //height: Screen.height/4
            Rectangle {
                width: Screen.width/6
                height: 100
                //anchors.centerIn: parent
                border.width:  2
                border.color: "#063e79"
                radius: 10
                gradient: Gradient {
                    GradientStop { position: 0 ; color: "#2589f4" }
                    GradientStop { position: 1 ; color: "#0b6fda" }
                }
            Text{
                anchors.centerIn: parent
                text: "Background Music"
                renderType: Text.NativeRendering
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: "Helvetica"
                font.pointSize: 20
                color: "black"
            }
            }
            Button{
                width: 100
                height: 100
                style: ButtonStyle {
                    background: Rectangle {
                        border.width: 2
                        border.color: "#063e79"
                        radius: 10
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: "#2589f4" }
                            GradientStop { position: 1 ; color: "#0b6fda" }
                        }
                    }
                    label: Text {
                        renderType: Text.NativeRendering
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Helvetica"
                        font.pointSize: 20
                        color: "black"
                        text:"On"
                    }
                }
                onClicked: {
                    backgroundMusic.play();
                }
            }

            Button{
                width: 100
                height: 100
                style: ButtonStyle {
                    background: Rectangle {
                        border.width: 2
                        border.color: "#063e79"
                        radius: 10
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: "#2589f4" }
                            GradientStop { position: 1 ; color: "#0b6fda" }
                        }
                    }
                    label: Text {
                        renderType: Text.NativeRendering
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Helvetica"
                        font.pointSize: 20
                        color: "black"
                        text:"Off"
                    }

                }
                onClicked: {
                    backgroundMusic.stop();
                }
            }
        }

        Row {
            id:soundEffectsButton
            spacing: 20
            Rectangle {
                width: Screen.width/6
                height: 100
                border.width:  2
                border.color: "#063e79"
                radius: 10
                gradient: Gradient {
                    GradientStop { position: 0 ; color: "#2589f4" }
                    GradientStop { position: 1 ; color: "#0b6fda" }
                }
            Text{
                text: "Sound Effects"
                anchors.centerIn: parent
                renderType: Text.NativeRendering
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: "Helvetica"
                font.pointSize: 20
                color: "black"
            }
}
            Button{
                width: 100
                height: 100
                style: ButtonStyle {
                    background: Rectangle {
                        border.width: 2
                        border.color: "#063e79"
                        radius: 10
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: "#2589f4" }
                            GradientStop { position: 1 ; color: "#0b6fda" }
                        }

                    }
                    label: Text {
                        renderType: Text.NativeRendering
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Helvetica"
                        font.pointSize: 20
                        color: "black"
                        text:"On"
                    }

                }
                onClicked: {
                    soundEffects.volume = 1.0;
                }
            }

            Button{
                width: 100
                height: 100
                style: ButtonStyle {
                    background: Rectangle {
                        border.width: 2
                        border.color: "#063e79"
                        radius: 10
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: "#2589f4" }
                            GradientStop { position: 1 ; color: "#0b6fda" }
                        }
                    }
                    label: Text {
                        renderType: Text.NativeRendering
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Helvetica"
                        font.pointSize: 20
                        color: "black"
                        text:"Off"
                    }

                }
                onClicked: {
                    soundEffects.volume = 0.0;
                }
            }
        }
    }
    Button{
        id: theReturnButton
        width: Screen.width/15
        height: Screen.height/15
        style: ButtonStyle {
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
