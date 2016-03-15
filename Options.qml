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
    id: allOptions
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
                console.log("musicbool : " + myStartScreen.musicBool);
//                theSwitch.checked = myStartScreen.musicBool;
//                if(backgroundMusic.playing())
//                    theSwitch.checked = true;
                    //theSwitch.on = true;
            }

//            Switch{
//                id: theSwitch
//                //checked: allOptions.parent.musicBool
//                property bool on: false
//                visible: false
//            }

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
                checked: myStartScreen.musicBool
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
                    if(myStartScreen.musicBool){
                        backgroundMusic.stop();
                        myStartScreen.musicBool = false;
                    }
                    else{
                        backgroundMusic.play();
                        myStartScreen.musicBool = true;
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
                checked: myStartScreen.soundBool
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
                //this part definitely doesn't work as intended
                //problem partly being that it has effect on the music (if this gets muted, so does the music)
                onClicked:{
                    if(myStartScreen.soundBool){
                        soundEffects.source = "";
                        myStartScreen.soundBool = false;
                    }
                    else{
                        soundEffects.source = "Bubbles.wav";
                        myStartScreen.soundBool = true;
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
