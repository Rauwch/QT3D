/*
  options page that includes sound / music
  */

import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Window 2.1
import QtQuick.Layouts 1.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4

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
            Component.onCompleted: {
                if(backgroundMusic.playing())
                    theSwitch.on = true;
            }

            Switch{
                id: theSwitch
                property bool on: false
                visible: false
            }

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
            Switch{
                implicitWidth: 400
                implicitHeight: 100
                style: SwitchStyle {
                    groove: Rectangle {
                            implicitWidth: 200
                            implicitHeight: 100
                            radius: 10
                            border.width:  2
                            border.color: "#063e79"
                            gradient: Gradient {
                                GradientStop { position: 0 ; color: "#2589f4" }
                                GradientStop { position: 1 ; color: "#0b6fda" }
                            }
                    }
                }

                onClicked:{
                    if(checked){
                        backgroundMusic.play();
                    }
                    if(!checked){
                        backgroundMusic.stop();
                    }
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
            Switch{
                implicitWidth: 400
                implicitHeight: 100
                style: SwitchStyle {
                    groove: Rectangle {
                            implicitWidth: 200
                            implicitHeight: 100
                            radius: 10
                            border.width:  2
                            border.color: "#063e79"
                            gradient: Gradient {
                                GradientStop { position: 0 ; color: "#2589f4" }
                                GradientStop { position: 1 ; color: "#0b6fda" }
                            }
                    }

                }

                onClicked:{
                    if(checked){
                        soundEffects.volume = 1.0;
                    }
                    if(!checked){
                        soundEffects.volume = 0.0;
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
