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
    property int buttonWidth: Screen.width/10
    property int buttonHeight: 100
    property int localIndex:0
    property int janIndex:0
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
//        Repeater{
//            id: levelRepeater
//            model:myLevels.amountOfLevels
//            delegate:
//                Button{
//                Component.onCompleted: {
//                    //console.log("This is local index "+ localIndex );
//                    localIndex = janIndex;

//                    //console.log("added local "+ localIndex );

//                }
//                text: "Level "+ (index+1)
//                width: buttonWidth
//                height: buttonHeight
//                onClicked: {
//                    //game.visible = true;
//                    soundEffects.source = "Bubbles.wav";
//                    soundEffects.play();
//                    pageLoader.source = "GameScreen.qml";
//                }
//                Grid{
//                    anchors.verticalCenter: parent.bottom
//                    anchors.horizontalCenter: parent.horizontalCenter
//                    Repeater{
//                        Component.onCompleted: {
//                            console.log("KIJK NAAR HIER MIJ ZO")
//                            if(localIndex < (myLevels.amountOfLevels-1))
//                            {
//                                janIndex = janIndex + 1;
//                                //localIndex = localIndex + 1;
//                            }
//                        }

//                        id: starRepeater
//                        model: myLevels.getAmountOfStars(localIndex)
//                        delegate:
//                            Image{
//                            Component.onCompleted:{

//                                console.log("Star is completed" + localIndex);
//                            }
//                            source: "yellowstar.png";
//                            width: 50;
//                            height: 50;
//                        }
//                    }
//                }



//            }
//        }
        Repeater{
            id: levelRepeater
            model:myLevels.amountOfLevels
            delegate:
                Button{
                text: "Level "+ (index+1)
                width: buttonWidth
                height: buttonHeight
                onClicked: {
                    //game.visible = true;
                    soundEffects.source = "Bubbles.wav";
                    soundEffects.play();
                    pageLoader.source = "GameScreen.qml";
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

