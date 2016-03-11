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
    property bool showRes
    property real speedoMeter: 0
    property int speedLevel
    property int numClicks: 0

    property string archerSource
    property int clickedSource
    property int clickedRes

    property int angleOfArrow: 0
    //signal returner()
    //signal sizeupdate()
    anchors.fill: parent
    Component.onDestruction: console.log("gamescreen destroyed")

    Component.onCompleted: {
        console.log("GameScreen wordt aangemaakt");
        //calculateArrow();

    }

    function calculateArrow(){
        var Igoal = calculator.getCurrentInGoalWire();
        var Icurrent = calculator.getGoalinGoalWire();
        var angle;
        console.log("Voor berekening Angle" + (Igoal-Icurrent)/(Igoal))
        angle = ((Igoal-Icurrent)/(Icurrent))*300+90
        angleOfArrow = angle;
        console.log("DIT IS DE HOEK: " + angle)
    }


    Scene3D{
        id: ourScene3D
        anchors.fill: parent
        focus: true
        aspects: "input"

        //        TestWorld{
        //            id: world
        //        }

        World3D{
            id: world
        }
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
    }
    Image{
        id: archer
        source: "archerG.png"
        anchors.centerIn: speedo
        rotation: angleOfArrow
    }
    Button{
        id:rotateCamera
        anchors.top: counter.bottom
        anchors.horizontalCenter: counter.horizontalCenter
        onClicked:
        {
            animation.start()

        }
    }

    NumberAnimation
    {
        id: animation
        target: world
        property: "cameraAngle"
        from: world.cameraAngle
        to: world.cameraAngle+15/180*Math.PI;
        duration: 10000
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
                //console.log("Voltage at the source before click: " + calculator.getVoltageAtSource(clickedSource));
                //console.log("this is the source that is clicked: " + clickedSource);
                calculator.adjustVoltageAtSource(clickedSource,calculator.getStepOfSource(clickedSource));
                calculator.solveLevel();
                //console.log("Voltage at the source after click: " + calculator.getVoltageAtSource(clickedSource));
                //world.generator.buildLevel();
                //sizeupdate();
                world.generator.updateLevel();
                numClicks = numClicks + 1;
                popupWindow.visible = calculator.checkGoals();
                world.generator.updateGoalPoles();
                if(calculator.checkGoals())
                {
                    myLevels.setAmountOfStars(numClicks,calculator.getTwoStar(), calculator.getThreeStar());
                    myLevels.refreshTextFile();
                }


                calculateArrow();
                console.log("The angle is: " + angleOfArrow);
                //                myLinker.height = myLinker.height + 1;
                //                myLinker.speed = myLinker.speed + 500;
                //                speedupdate(myLinker.speed);
                //                speedoMeter = speedoMeter + 45/2;
                //                numClicks = numClicks + 1;
                //                updateAnimation();
                //                if((myLinker.speed - 500) <= 0){
                //                    decreaseHeight.visible = false;
                //                    increaseHeight.parent.anchors.bottomMargin = Screen.height/15;

                //                }
                //                else{
                //                    decreaseHeight.visible = true;
                //                    increaseHeight.parent.anchors.bottomMargin = 0;

                //                }

            }
        }

        Button{
            id: decreaseHeight
            width: Screen.width/15
            height: Screen.height/15
            text: "Decrease height!"

            onClicked: {
                calculator.adjustVoltageAtSource(clickedSource,-calculator.getStepOfSource(clickedSource));
                calculator.solveLevel();

                world.generator.updateLevel();
                calculateArrow();
                numClicks = numClicks + 1;
                popupWindow.visible = calculator.checkGoals();
                world.generator.updateGoalPoles();
                if(calculator.checkGoals())
                {
                    myLevels.setAmountOfStars(numClicks,calculator.getTwoStar(), calculator.getThreeStar());
                    myLevels.refreshTextFile();
                }

                //                myLinker.height = myLinker.height - 1;
                //                myLinker.speed = myLinker.speed - 500;
                //                speedupdate(myLinker.speed);
                //                speedoMeter = speedoMeter - 45/2;
                //                numClicks = numClicks + 1;
                //                updateAnimation();
                //                if((myLinker.speed - 500) <= 0){
                //                    visible = false;
                //                    increaseHeight.parent.anchors.bottomMargin = Screen.height/15;

                //                }
                //                else{
                //                    visible = true;
                //                    increaseHeight.parent.anchors.bottomMargin = 0;


                //                }

            }

        }
    }

    Column{
        id: resistorBox
        visible: showRes
        anchors.bottom: parent.bottom

        //button that allows for height to be edited
        Button{
            id: increaseResistor
            width: Screen.width/15
            height: Screen.height/15
            text: "Increase bends!"
            onClicked: {
                //console.log("Voltage at the source before click: " + calculator.getVoltageAtSource(clickedSource));
                //console.log("this is the source that is clicked: " + clickedSource);
                //calculator.adjustVoltageAtSource(clickedSource,calculator.getStepOfSource(clickedSource));
                calculator.adjustResistance(clickedRes, calculator.getStepOfResistor(clickedRes));
                world.generator.increaseRes();
                calculator.solveLevel();
                //console.log("Voltage at the source after click: " + calculator.getVoltageAtSource(clickedSource));
                //world.generator.buildLevel();
                world.generator.updateLevel();
                calculateArrow();
                numClicks = numClicks + 1;
                console.log("The angle is: " + angleOfArrow);
                popupWindow.visible = calculator.checkGoals();
                if(calculator.checkGoals())
                {
                    myLevels.setAmountOfStars(numClicks,calculator.getTwoStar(), calculator.getThreeStar());
                    myLevels.refreshTextFile();
                }
                if(world.generator.resistors[0].bendIntensity >= 4){
                    visible = false;
                }
                if(world.generator.resistors[0].bendIntensity >= 1){
                    decreaseResistor.visible = true;
                    increaseResistor.parent.anchors.bottomMargin = 0;

                }
            }
        }

        Button{
            id: decreaseResistor
            width: Screen.width/15
            height: Screen.height/15
            text: "Decrease bends!"

            onClicked: {
                //calculator.adjustVoltageAtSource(clickedSource,-calculator.getStepOfSource(clickedSource));
                calculator.adjustResistance(clickedRes, -calculator.getStepOfResistor(clickedRes));
                console.log("step: " + (-calculator.getStepOfResistor(clickedRes)));
                numClicks = numClicks + 1;
                world.generator.decreaseRes();
                calculator.solveLevel();
                world.generator.updateLevel();
                calculateArrow();
                popupWindow.visible = calculator.checkGoals();
                if(calculator.checkGoals())
                {
                    myLevels.setAmountOfStars(numClicks,calculator.getTwoStar(), calculator.getThreeStar());
                    myLevels.refreshTextFile();
                }
                if(world.generator.resistors[0].bendIntensity <= 0){
                    increaseResistor.parent.anchors.bottomMargin = Screen.height/15;
                    visible = false;

                }
                if(world.generator.resistors[0].bendIntensity <= 3){
                    increaseResistor.visible = true;
                }
            }

        }
    }
    Calculator{
        id: calculator
    }


    //    Linker{
    //        id: myLinker
    //        speed: 2000
    //    }

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


