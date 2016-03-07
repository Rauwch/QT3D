/*
  class that handles 2d overlay of game
  this includes all buttons/ indicators that show up during the game
*/
import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Window 2.0
import QtQuick.Scene3D 2.0
import Link 1.0
import Lvl 1.0
import Calc 1.0

Item {
    id: myGameScreen
    property bool showBox
    property real speedoMeter: 0
    property int speedLevel
    property int numClicks: 0
    property string archerSource
    //signal returner()
    signal speedupdate(var newSpeed)
    anchors.fill: parent
    Component.onDestruction: console.log("gamescreen destroyed")

    Component.onCompleted: {
        console.log("GameScreen wordt aangemaakt");
    }


    Scene3D{
        id: ourScene3D
        anchors.fill: parent
        focus: true
        aspects: ["input"]

        World3D { id: world }
    }

    Column{
        anchors.left: parent.left
        Button{

            id: returnButton
            width: Screen.width/15
            height: Screen.height/15
            text:"Return"
            onClicked: {
                soundEffects.source = "Bubbles.wav";
                soundEffects.play();
                //need this destroy first to not crash program
                world.destroyCamera();
                pageLoader.source = "";
                pageLoader.source = "LevelScreen.qml";
                console.log("world is destroyed");
            }

        }
        Button{

            id: retryButton
            width: Screen.width/15
            height: Screen.height/15
            text:"Retry"
            onClicked: {
                soundEffects.source = "Bubbles.wav";
                soundEffects.play();
                //need this destroy first to not crash program
                world.destroyCamera();
                //ourScene3D.destroy();
                pageLoader.source = "";
                pageLoader.source = "GameScreen.qml";
                console.log("world is destroyed");
            }

        }
    }
    TextField{
        id: counter
        text: "number of clicks: " + numClicks
        anchors.right: parent.right
        anchors.top: speedo.bottom
        readOnly: true
        font.pixelSize: 30
    }


    Image{
        id:speedo
        source: "speedo.png"
        anchors.right: parent.right
    }
    Image{
        id:currentGoal
        source: "speedGoal.png"
        anchors.centerIn: speedo
        rotation: 90

    }
    Image{
        id: archer
        source: archerSource
        anchors.centerIn: speedo
        rotation: speedoMeter
    }

    //2d box where setting can be edited
    Column{
        id: textBox
        visible: showBox
        anchors.bottom: parent.bottom

        //button that allows for height to be edited
        Button{
            id: increaseHeight
            width: Screen.width/15
            height: Screen.height/15
            text: "Increase height!"
            onClicked: {
                myLinker.height = myLinker.height + 1;
                myLinker.speed = myLinker.speed + 500;
                speedupdate(myLinker.speed);
                speedoMeter = speedoMeter + 45/2;
                numClicks = numClicks + 1;
                updateAnimation();
                if((myLinker.speed - 500) <= 0){
                    decreaseHeight.visible = false;
                    increaseHeight.parent.anchors.bottomMargin = Screen.height/15;

                }
                else{
                    decreaseHeight.visible = true;
                    increaseHeight.parent.anchors.bottomMargin = 0;

                }

            }
        }

        Button{
            id: decreaseHeight
            width: Screen.width/15
            height: Screen.height/15
            text: "Decrease height!"

            onClicked: {
                myLinker.height = myLinker.height - 1;
                myLinker.speed = myLinker.speed - 500;
                speedupdate(myLinker.speed);
                speedoMeter = speedoMeter - 45/2;
                numClicks = numClicks + 1;
                updateAnimation();
                if((myLinker.speed - 500) <= 0){
                    visible = false;
                    increaseHeight.parent.anchors.bottomMargin = Screen.height/15;

                }
                else{
                    visible = true;
                    increaseHeight.parent.anchors.bottomMargin = 0;


                }

            }

        }
    }
    Calculator{
        id: calculator
    }


    Linker{
        id: myLinker
        speed: 2000
    }

    function updateAnimation(){
//        world.checkMatch();
//        archerSource = world.theArchSource;
//        if(world.lvlCompleted){
//            popupWindow.visible= true;
//            continueBtn.visible= (myLevels.getCurrentLevel() < myLevels.amountOfLevels);
//            myLevels.setAmountOfStars(numClicks);
//        }
    }

    Rectangle{
        id: popupWindow
        height: Screen.height
        width: Screen.width
        visible: false
        Text{
            id:congratsText
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top : parent.top
            anchors.topMargin: Screen.height/10
            text: "Congratulations!\nYou have successfully completed the level!"
            font.pixelSize: 60
        }

        Row{
            anchors.centerIn: parent
            spacing: Screen.width/20
            Button{
                id: continueBtn
                height: Screen.height/10
                width: Screen.width/5
                text: "Continue"
                onClicked: {
                    soundEffects.source = "Bubbles.wav";
                    soundEffects.play();
                    myLevels.setCurrentLevel(myLevels.getCurrentLevel()+1);
                    world.destroyCamera();
                    pageLoader.source = "";
                    pageLoader.source = "GameScreen.qml";

                    console.log("world is destroyed");
                }
            }
            Button{
                height: Screen.height/10
                width: Screen.width/5
                text: "Select level"
                onClicked: {
                    soundEffects.source = "Bubbles.wav";
                    soundEffects.play();
                    world.destroyCamera();
                    pageLoader.source = "LevelScreen.qml";
                    console.log("world is destroyed");
                }

            }
            Button{
                height: Screen.height/10
                width: Screen.width/5
                text: "Restart level"
                onClicked: {
                    soundEffects.source = "Bubbles.wav";
                    soundEffects.play();
                    world.destroyCamera();
                    pageLoader.source = "";
                    pageLoader.source = "GameScreen.qml";
                    console.log("world is destroyed");
                }
            }
        }
    }



}


