/*
  class that handles 2d overlay of game
  this includes all buttons/ indicators that show up during the game
*/
import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Window 2.0
import QtQuick.Scene3D 2.0
import QtQuick.Controls.Styles 1.4
import Link 1.0
import Lvl 1.0
import Calc 1.0


Item {
    id: myGameScreen
    property bool showBox
    property bool showRes
    property bool showTutorial: true
    property bool showLeaderboardEntry: true
    property real speedoMeter: 0
    property int speedLevel
    property int numClicks: 0
    property bool playingAnimation: false
    property int jellyPixelHeight
    property int jellyPixelWidth
    property string archerSource
    property int clickedSource
    property int clickedRes

    property int angleOfArrow: 0
    property var jellySize: 0
    //signal returner()
    //signal sizeupdate()
    anchors.fill: parent
    Component.onDestruction: console.log("gamescreen destroyed")

    Component.onCompleted: {
        console.log("GameScreen wordt aangemaakt");
        if(myLevels.getCurrentLevel() <= 4){
            setPopupWindowForTutorial(myLevels.getCurrentLevel());
            tutorialScreen.numberOfLevel = myLevels.getCurrentLevel();
            tutorialScreen.visible = true;
        }
        else{
            tutorialScreen.visible = false;
        }
    }


    Scene3D{
        id: ourScene3D
        anchors.fill: parent
        focus: true
        aspects: "input"

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
            style: ButtonStyle {
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 25
                    border.width: control.activeFocus ? 2 : 1
                    border.color: "#888"
                    radius: 4
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                        GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                    }
                }
            }
            onClicked: {
                //soundEffects.source = "Bubbles.wav";
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
            style: ButtonStyle {
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 25
                    border.width: control.activeFocus ? 2 : 1
                    border.color: "#888"
                    radius: 4
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                        GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                    }
                }
            }
            onClicked: {
                //soundEffects.source = "Bubbles.wav";
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
        text: "aantal kliks: " + numClicks
        anchors.right: parent.right
        anchors.top: jellyGoal.bottom
        readOnly: true
        font.pixelSize: 30
    }

    Tutorial{
        id: tutorialScreen
        anchors.left: parent.left
        anchors.bottom: parent.bottom
    }

    Image{
        id:jellyGoal
        source: "jellyGoal.png"
        //        anchors.right: myGameScreen.right
        //        anchors.rightMargin: 50
        scale: 1
    }

    Image{
        id:jelly
        source: "jelly.png"
        //        anchors.right: myGameScreen.right

    }

    Button{
        id:rotateCamera
        anchors.top: counter.bottom
        anchors.horizontalCenter: counter.horizontalCenter
        onPressedChanged: {
            if(playingAnimation){
                playingAnimation=false;
                world.dontChangeCamera();
            }
            else{
                playingAnimation=true;
                world.changeCamera();
            }
        }
    }

    //2d box where setting can be edited
    Column{
        id: textBox
        visible: showBox
        anchors.bottom: parent.bottom
        spacing: 10
        //button that allows for height to be edited
        Button{
            id: increaseHeight
            width: increaseText.width + 20
            height: Screen.height/15
            Text{
                anchors.centerIn: parent
                id: increaseText
                text: "verhoog lift"
                renderType: Text.NativeRendering
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: "Helvetica"
                font.pointSize: 20
                color: "black"
            }
            style: ButtonStyle {
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 25
                    border.width: control.activeFocus ? 2 : 1
                    border.color: "#888"
                    radius: 4
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                        GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                    }
                }
            }
            onClicked: {
                //console.log("Voltage at the source before click: " + calculator.getVoltageAtSource(clickedSource));
                //console.log("this is the source that is clicked: " + clickedSource);
                calculator.adjustVoltageAtSource(clickedSource,calculator.getStepOfSource(clickedSource));
                calculator.solveLevel();
                world.generator.increaseVolt();

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

                }
                if(world.generator.sources[0].heightIntensity >= 4){
                    visible = false;
                }
                if(world.generator.sources[0].heightIntensity >= 1){
                    decreaseHeight.visible = true;
                    increaseHeight.parent.anchors.bottomMargin = 0;
                }
                calculateSize();
            }
        }

        Button{
            id: decreaseHeight
            width: increaseText.width + 20
            height: Screen.height/15
            Text{
                anchors.centerIn: parent
                id: decreaseText
                text: "Verlaag lift"
                renderType: Text.NativeRendering
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: "Helvetica"
                font.pointSize: 20
                color: "black"
            }
            style: ButtonStyle {
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 25
                    border.width: control.activeFocus ? 2 : 1
                    border.color: "#888"
                    radius: 4
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                        GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                    }
                }
            }
            onClicked: {
                calculator.adjustVoltageAtSource(clickedSource,-calculator.getStepOfSource(clickedSource));
                calculator.solveLevel();
                world.generator.decreaseVolt();

                world.generator.updateLevel();
                calculateSize();
                numClicks = numClicks + 1;
                popupWindow.visible = calculator.checkGoals();
                world.generator.updateGoalPoles();
                if(calculator.checkGoals())
                {
                    myLevels.setAmountOfStars(numClicks,calculator.getTwoStar(), calculator.getThreeStar());

                }
                if(world.generator.sources[0].heightIntensity <= 0){
                    increaseHeight.parent.anchors.bottomMargin = Screen.height/15;
                    visible = false;

                }
                if(world.generator.sources[0].heightIntensity <= 3){
                    increaseHeight.visible = true;
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
                calculateSize();
                numClicks = numClicks + 1;
                //console.log("The angle is: " + angleOfArrow);
                popupWindow.visible = calculator.checkGoals();
                if(calculator.checkGoals())
                {
                    myLevels.setAmountOfStars(numClicks,calculator.getTwoStar(), calculator.getThreeStar());

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
                //console.log("step: " + (-calculator.getStepOfResistor(clickedRes)));
                numClicks = numClicks + 1;
                world.generator.decreaseRes();
                calculator.solveLevel();
                world.generator.updateLevel();
                calculateSize();
                popupWindow.visible = calculator.checkGoals();
                if(calculator.checkGoals())
                {
                    myLevels.setAmountOfStars(numClicks,calculator.getTwoStar(), calculator.getThreeStar());
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



    Rectangle{
        id: popupWindow
        height: Screen.height
        width: Screen.width
        visible: false
        function setText(tutorialLevel){
            switch(tutorialLevel){
            case(1):
                congratsText.text = "Thank you for completing the first tutorial!";
                break;
            default:
                congratsText.text = "Congratulations!\nYou have successfully completed the level!";

            }
        }

        Text{
            id:congratsText
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top : parent.top
            anchors.topMargin: Screen.height/12
            text: "Congratulations!\nYou have successfully completed the level!"
            font.pixelSize: 60
        }

        Row{
            id: theButtons
            anchors.top : congratsText.bottom
            anchors.topMargin:  50
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: Screen.width/20
            Button{
                id: continueBtn
                height: Screen.height/10
                width: Screen.width/5
                text: "Continue"
                onClicked: {
                    //soundEffects.source = "Bubbles.wav";
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
                    //soundEffects.source = "Bubbles.wav";
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
                    //soundEffects.source = "Bubbles.wav";
                    soundEffects.play();
                    world.destroyCamera();
                    pageLoader.source = "";
                    pageLoader.source = "GameScreen.qml";
                    console.log("world is destroyed");
                }
            }
        }


        //        Leaderboard{
        //            id: theLeaderboard
        //            Component.onCompleted: {
        //                console.log(" lowest entry: " + theLeaderboard.myLevelboard.getLowestEntry())
        //            }

        //            //            anchors.top: theButtons.bottom;
        //            //            anchors.horizontalCenter: popupWindow.Center
        //            //            anchors.topMargin: 50
        //            anchors.top : theButtons.bottom
        //            anchors.topMargin: 50
        //            anchors.horizontalCenter: parent.horizontalCenter
        //        }

        Loader
        {
            id:leaderLoader
            source: "Leaderboard.qml"
            anchors.top : theButtons.bottom
            anchors.topMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter;

            Row{
                id: buttonRow
                anchors.top:leaderLoader.item.bottom
                anchors.topMargin: 50

                anchors.horizontalCenter: parent.horizontalCenter
                visible: {checkLeaderboard() && showLeaderboardEntry}
                TextField{
                    id:myTextField
                    width: 100
                    placeholderText : "Geef hier je naam in"
                    style: TextFieldStyle {
                        textColor: "black"
                        background: Rectangle {
                            radius: 2
                            implicitWidth: 100
                            implicitHeight: 24
                            border.color: "#333"
                            border.width: 1
                        }
                    }
                }
                Button{
                    onClicked: {
                        //console.log("this is the text: " + myTextField.displayText);
                        leaderLoader.item.myLevelboard.addEntry(myTextField.displayText, getStars(), numClicks );
                        leaderLoader.item.myLevelboard.writeLeaderBoard(myLevels.getCurrentLevel());
                        leaderLoader.source="";
                        leaderLoader.source="Leaderboard.qml";
                        showLeaderboardEntry = false;
                    }

                }
            }
        }




        //        Row{
        //            id: buttonRow
        //            anchors.top:filler.bottom
        //            anchors.topMargin: 50

        //            anchors.horizontalCenter: parent.horizontalCenter
        //            visible: {checkLeaderboard() && showLeaderboardEntry}
        //            TextField{
        //                id:myTextField
        //                width: 100
        //                placeholderText : "Geef hier je naam in"
        //                style: TextFieldStyle {
        //                    textColor: "black"
        //                    background: Rectangle {
        //                        radius: 2
        //                        implicitWidth: 100
        //                        implicitHeight: 24
        //                        border.color: "#333"
        //                        border.width: 1
        //                    }
        //                }
        //            }
        //            Button{
        //                onClicked: {
        //                    console.log("this is the text: " + myTextField.displayText);
        //                    leaderLoader.item.myLevelboard.addEntry(myTextField.displayText, getStars(), numClicks );
        //                    leaderLoader.item.myLevelboard.writeLeaderBoard(myLevels.getCurrentLevel());
        //                    leaderLoader.source="";
        //                    leaderLoader.source="Leaderboard.qml";
        //                    showLeaderboardEntry = false;
        //                }

        //            }
        //        }







    }

    //this are all the functions



    function calculateSize(){
        var Icurrent = calculator.getCurrentInGoalWire();
        var Igoal = calculator.getGoalinGoalWire();
        var size;
        size = Icurrent/Igoal;
        if(Icurrent > Igoal){
            size=(Icurrent-((Icurrent-Igoal)/4*3))/Igoal;
        }

        //jelly.scale = size;
        console.log("Icurrent = " + Icurrent + " Igoal = " + Igoal + "   SIZe " + size);
        jelly.height = jellyPixelHeight*size;
        jelly.width = jellyPixelWidth * size;
        updateJellyAnchors();
        //        jelly.anchors.right = undefined;
        //        jelly.anchors.right = myGameScreen.right;
    }
    function updateJellyAnchors(){
        //jellygoal is bigger than twice the jelly
        if(jellyGoal.width >= 2*jelly.width){
            jellyGoal.anchors.right = myGameScreen.right;
            jelly.anchors.right = myGameScreen.right;

            jellyGoal.anchors.rightMargin = 0;
            jelly.anchors.rightMargin = 0;

            jelly.anchors.top=undefined;
            jellyGoal.anchors.bottom=undefined;
            jellyGoal.anchors.top=myGameScreen.top;
            jelly.anchors.bottom=jellyGoal.bottom;

        }

        //jellygoal is bigger than the jelly
        else if(jellyGoal.width >= jelly.width){
            jellyGoal.anchors.right = myGameScreen.right;
            jellyGoal.anchors.rightMargin = (jelly.width - jellyGoal.width/2);
            jelly.anchors.right = myGameScreen.right;

            jelly.anchors.rightMargin = 0;

            jelly.anchors.top=undefined;
            jellyGoal.anchors.bottom=undefined;
            jellyGoal.anchors.top=myGameScreen.top;
            jelly.anchors.bottom=jellyGoal.bottom;
        }

        else if(jellyGoal.width <= jelly.width){
            jellyGoal.anchors.right = myGameScreen.right;
            jellyGoal.anchors.rightMargin = (jelly.width - jellyGoal.width/2);
            jelly.anchors.right = myGameScreen.right;

            jelly.anchors.rightMargin = 0;

            jellyGoal.anchors.top=undefined;
            jelly.anchors.bottom=undefined;
            jelly.anchors.top=myGameScreen.top;
            jellyGoal.anchors.bottom=jelly.bottom;
        }


    }

    function initializeJellies(){
        jellyPixelHeight = jelly.paintedHeight;
        jellyPixelWidth = jelly.paintedWidth;
        updateJellyAnchors();
    }

    function setPopupWindowForTutorial(tutorialLevel){
        popupWindow.setText(tutorialLevel);
    }

    function checkLeaderboard()
    {
        if(leaderLoader.item.myLevelboard.getAmountOfEntries()< 5)
        {
            return true;
        }
        else if(leaderLoader.item.myLevelboard.getLowestEntry() > numClicks)
        {
            return true;
        }
        return false;
    }

    function getStars()
    {
        if(calculator.getThreeStar() >=  numClicks)
            return 3;

        else if(calculator.getTwoStar() >= numClicks)
            return 2;
        else
            return 1;
    }

    function updateTutorial(){
        tutorialScreen.checkBallclicked();
    }



}





