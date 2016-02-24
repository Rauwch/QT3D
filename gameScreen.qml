import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Window 2.0
import QtQuick.Scene3D 2.0
import Link 1.0

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
        //aspects: ["render", "logic"]
        aspects: ["input"]

        World { id: world }
    }

    //    Button{
    //        id: backButton
    //        text: "Return"
    //        anchors.right: parent

    //    }
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
            //ourScene3D.destroy();
            pageLoader.source = "LevelScreen.qml";

            //soundEffects.source = "Bubbles.wav";
            //soundEffects.play();
            //ourScene3D.focus=false;
            console.log("world is destroyed");
            //pageLoader.source = "LevelScreen.qml";
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
        width: 100
        height: 50
        spacing: 10
        visible: showBox



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
            }

        }
    }
    Linker{
        id: myLinker
        speed: 2000
    }
    //    SequentialAnimation on speedoMeter {
    //        id:speedoAnimation
    //        loops: Animation.Infinite
    //        running: true
    //            PropertyAnimation{ from:speedoMeter+1; to: speedoMeter - 1; duration: 100;}
    //            PropertyAnimation{ from:speedoMeter-1; to: speedoMeter + 1 ; duration: 100;}

    //    }

    function updateAnimation(){
        //        speedoAnimation.stop();
        //        speedoAnimation.start();
        world.checkMatch();
        archerSource = world.theArchSource;
        if(world.lvlCompleted){
            popupWindow.visible= true;
        }
    }
    //    applicationWindow{

    //    }
    Rectangle{
        id: popupWindow
        height: Screen.height
        width: Screen.width
        visible: false
        Row{
            anchors.centerIn: parent
            spacing: Screen.width/20
        Button{
            height: Screen.height/10
            width: Screen.width/5
//            anchors.left: parent.left
//            anchors.leftMargin: Screen.width/10
//            anchors.verticalCenter: parent.verticalCenter
            text: "Continue"
            onClicked: {
                soundEffects.source = "Bubbles.wav";
                soundEffects.play();
                world.destroyCamera();
                pageLoader.source = "";
                pageLoader.source = "GameScreen.qml";
                console.log("world is destroyed");
            }
            }
        Button{
            height: Screen.height/10
            width: Screen.width/5
//            anchors.right: parent.right
//            anchors.rightMargin: Screen.width/10
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
            //anchors.centerIn: parent
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


