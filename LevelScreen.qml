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
import Lvl 1.0
Item {
    id: myLevelScreen
    property int buttonWidth: Screen.width/8
    property int buttonHeight: Screen.height/8
    //signal thereturner()
    Component.onDestruction: console.log("levelscreen destroyed")

    Component.onCompleted: {
        console.log("mylevelscreen wordt aangemaakt");
        //console.log("Numbers of levels " + myLevels.amountOfLevels);
    }

    Levels{
        id:myLevels

    }
    Grid{
        anchors.centerIn: parent
        rows: 3
        spacing: 30
        //
        Repeater{
            id: levelRepeater
            model:myLevels.amountOfLevels
            delegate:
                Rectangle{

                Component.onCompleted:
                {


                    if( myLevels.getAmountOfStars(index) > 0 || myLevels.getAmountOfStars(index-1) )
                    {
                        levelMouse.enabled = true;
                        lockImage.visible = false;


                    }
                    else{
                        levelMouse.enabled = false;
                        levelText.visible = false;
                        lockImage.visible = true;
                    }
                    if(!levelMouse.enabled)
                    {
                        color = "grey";
                    }


                }

                border.width: 3
                radius: 10
                Text{
                    id: levelText
                    anchors.centerIn: parent
                    text: "Level "+ (index+1)
                    font.pixelSize: 30
                }
                Image{
                    id:lockImage
                    anchors.centerIn: parent
                    height: parent.height
                    width: parent.width-parent.width/2
                    source: "lock.png"
                }

                width: buttonWidth
                height: buttonHeight
                MouseArea{
                    id: levelMouse
                    anchors.fill: parent

                    onClicked: {
                        //game.visible = true;
                        soundEffects.source = "Bubbles.wav";
                        soundEffects.play();
                        pageLoader.source = "GameScreen.qml";
                    }
                }

                Grid{
                    anchors.verticalCenter: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    Repeater{
                        id: starRepeater
                        // this is the index from the button assigned by the top repeater
                        model: myLevels.getAmountOfStars(index)
                        delegate:
                            Image{

                            source: "yellowstar.png";
                            width: 50;
                            height: 50;
                        }
                    }
                }



            }
        }



    }
}

