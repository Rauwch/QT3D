import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Window 2.0
import QtQuick.Scene3D 2.0
import Link 1.0
Item {
    id: myGameScreen
    property bool showBox
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
        text:"Return"
        onClicked: {
            //game.visible = true;
            soundEffects.source = "Bubbles.wav";
            soundEffects.play();
            //need this destroy first to not crash program
            world.destroyCamera();
            ourScene3D.destroy();
            pageLoader.source = "LevelScreen.qml";

            //soundEffects.source = "Bubbles.wav";
            //soundEffects.play();
            console.log("before world is deleted");
            ourScene3D.focus=false;
            console.log("world is destroyed");
            //pageLoader.source = "LevelScreen.qml";
            }

    }
    Image{
        id:speedo
        source: "speedo.png"
        anchors.right: parent.right
    }

    Image{
        source: "archer.png"
        anchors.centerIn: speedo
        rotation: 45
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
            text: "Increase height!"
            onClicked: {
                myLinker.height = myLinker.height + 1;
                myLinker.speed = myLinker.speed + 2000;
                speedupdate(myLinker.speed);
            }
        }

        Button{
            id: decreaseHeight
            text: "Decrease height!"
            onClicked: {
                myLinker.height = myLinker.height - 1;
                myLinker.speed = myLinker.speed - 2000;
                speedupdate(myLinker.speed);
            }

        }
    }
    Linker{
        id: myLinker
        speed: 2000
    }



}
