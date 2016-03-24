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
    property bool showSwitch
    property bool showTutorial: true
    property bool showLeaderboardEntry: true
    property bool checkBoard: false

    property real speedoMeter: 0
    property int speedLevel
    property int numClicks: 0
    property bool playingAnimation: false
    property int jellyPixelHeight
    property int jellyPixelWidth
    property string archerSource
    property int clickedSource
    property int clickedRes
    property int highScore: 0
    property int clickedSwitch

    property int angleOfArrow: 0
    property var jellySize: 0

    //was helvetica
    property string fontfam: "Arial"
    property int fontSize: 20

    anchors.fill: parent
    Component.onDestruction: console.log("gamescreen destroyed")

    Component.onCompleted: {
        //calculator.printScreenInfo();

        console.log("GameScreen wordt aangemaakt");
        setPopupWindowForTutorial(myLevels.getCurrentLevel());

        if(myLevels.getCurrentLevel() <= 4){
            tutorialScreen.numberOfLevel = myLevels.getCurrentLevel();
            //tutorialScreen.visible = true;
            tutTimer.start();
            rotateCamera.visible = false;
        }
        else{
            //tutorialScreen.visible = false;
            rotateCamera.visible = true;
        }
    }


    property Timer tutTimer: Timer{
        interval: 2000; running: false; repeat: false
        onTriggered: tutorialScreen.visible = true;
    }

    property Calculator calculator: Calculator{

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
    Button{
        id:alpha
        width: Screen.width;
        height: Screen.height;
        visible: false;
        style: ButtonStyle {
            background: Rectangle {
                color: "black"
                opacity: 0.7
            }
        }
    }



    Row{
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 10
        anchors.topMargin: 10
        spacing: 10
        Button{

            id: returnButton
            width: Screen.width/15
            height: width
            //text:"Return"
            style: ButtonStyle {
                background: Rectangle {
                    //implicitWidth: 100
                    //implicitHeight: 25
                    border.width: 2
                    border.color: "black"
                    radius: width*0.5
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: Qt.rgba(243/255,103/255,170/255,1) }
                        GradientStop { position: 1 ; color: Qt.rgba(255/255,177/255,214/255,1) }
                    }
                }
            }
            Image{
                source: "backArrow.png"
                height: parent.height/2
                width: parent.width/2
                anchors.centerIn: parent
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
            height: width
            style: ButtonStyle {
                background: Rectangle {
                    //implicitWidth: 100
                    //implicitHeight: 25
                    border.width: 2
                    border.color: "black"
                    radius: width*0.5
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: Qt.rgba(243/255,103/255,170/255,1) }
                        GradientStop { position: 1 ; color: Qt.rgba(255/255,177/255,214/255,1) }
                    }
                }
            }

            Image{
                source: "retry2.png"
                height: parent.height/2
                width: parent.width/2
                anchors.centerIn: parent
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
        anchors.horizontalCenter: myGameScreen.horizontalCenter
        anchors.bottom: myGameScreen.bottom
        readOnly: true
        font.pixelSize: 30
    }
    TextField{
        id: counterHighScore
        text: "Highscore: " + highScore
        anchors.horizontalCenter: myGameScreen.horizontalCenter
        anchors.bottom: counter.top
        readOnly: true
        font.pixelSize: 30
        Component.onCompleted:
        {
            if(highScore == 0){
                text = "Highscore: /"
            }
        }
    }

    Tutorial{
        id: tutorialScreen
        anchors.left: parent.left
        anchors.bottom: parent.bottom
    }

    Image{
        id:jellyGoal
        source: "jellyGoal.png"
        scale: 1
    }

    Image{
        id:jelly
        source: "jelly.png"

    }

    Button{
        id:rotateCamera
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        width: Screen.width/15
        height: Screen.height/15
        style: ButtonStyle {
            background: Rectangle {
                //implicitWidth: 100
                //implicitHeight: 25
                border.width: 2
                border.color: "black"
                radius: 5
                gradient: Gradient {
                    GradientStop { position: 0 ; color: Qt.rgba(243/255,103/255,170/255,1) }
                    GradientStop { position: 1 ; color: Qt.rgba(255/255,177/255,214/255,1) }
                }
            }
        }
        Image{
            source: "rotateCamera.png"
            height: parent.height*2/3
            width: parent.width*2/3
            anchors.centerIn: parent
        }

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
                text: "Verhoog Lift"
                renderType: Text.NativeRendering
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: fontfam
                font.pointSize: fontSize
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
                world.generator.switchClicked = false;
                world.generator.updateLevel();
                numClicks = numClicks + 1;

                if(calculator.checkGoals())
                    myTimer.start();
                //popupWindow.visible = calculator.checkGoals();
                world.generator.updateGoalPoles();
                if(calculator.checkGoals())
                {
                    myLevels.setAmountOfStars(numClicks,calculator.getTwoStar(), calculator.getThreeStar());
                    checkLeaderboard()

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
                text: "Verlaag Lift"
                renderType: Text.NativeRendering
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: fontfam
                font.pointSize: fontSize
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
                world.generator.switchClicked = false;
                world.generator.updateLevel();
                calculateSize();
                numClicks = numClicks + 1;
                if(calculator.checkGoals())
                    myTimer.start();
                world.generator.updateGoalPoles();
                if(calculator.checkGoals())
                {
                    myLevels.setAmountOfStars(numClicks,calculator.getTwoStar(), calculator.getThreeStar());
                    checkLeaderboard()
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
        spacing: 10
        //button that allows for height to be edited
        Button{
            id: increaseResistor
            width: increaseResText.width + 20
            height: Screen.height/15
            Text{
                anchors.centerIn: parent
                id: increaseResText
                text: "Vergroot bochten"
                renderType: Text.NativeRendering
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: fontfam
                font.pointSize: fontSize
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
                calculator.adjustResistance(clickedRes, calculator.getStepOfResistor(clickedRes));
                world.generator.increaseRes();
                calculator.solveLevel();
                //console.log("Voltage at the source after click: " + calculator.getVoltageAtSource(clickedSource));
                //world.generator.buildLevel();
                world.generator.switchClicked = false;
                world.generator.updateLevel();
                calculateSize();
                numClicks = numClicks + 1;
                //console.log("The angle is: " + angleOfArrow);
                if(calculator.checkGoals())
                    myTimer.start();
                if(calculator.checkGoals())
                {
                    myLevels.setAmountOfStars(numClicks,calculator.getTwoStar(), calculator.getThreeStar());
                    checkLeaderboard()
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
            width: increaseResText.width+20
            height: Screen.height/15
            Text{
                anchors.centerIn: parent
                id: decreaseResText
                text: "Verklein bochten"
                renderType: Text.NativeRendering
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: fontfam
                font.pointSize: fontSize
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
                //calculator.adjustVoltageAtSource(clickedSource,-calculator.getStepOfSource(clickedSource));
                calculator.adjustResistance(clickedRes, -calculator.getStepOfResistor(clickedRes));
                //console.log("step: " + (-calculator.getStepOfResistor(clickedRes)));
                numClicks = numClicks + 1;
                world.generator.decreaseRes();
                calculator.solveLevel();
                world.generator.switchClicked = false;
                world.generator.updateLevel();
                calculateSize();
                if(calculator.checkGoals())
                    myTimer.start();
                if(calculator.checkGoals())
                {
                    myLevels.setAmountOfStars(numClicks,calculator.getTwoStar(), calculator.getThreeStar());
                    checkLeaderboard()

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

    Column{
        id: switchBox
        visible: showSwitch
        anchors.bottom: parent.bottom
        spacing: 10
        //button that allows for height to be edited
        Button{
            id: changeSwitch
            width: changeSwitchText.width + 20
            height: Screen.height/15
            Text{
                anchors.centerIn: parent
                id: changeSwitchText
                text: " Open Brug "
                renderType: Text.NativeRendering
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: fontfam
                font.pointSize: fontSize
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
                //world.generator.switchClicked = !world.generator.switchClicked;

                toggleSwitch();

                numClicks = numClicks + 1;
                if(calculator.checkGoals())
                    myTimer.start();
                if(calculator.checkGoals())
                {
                    myLevels.setAmountOfStars(numClicks,calculator.getTwoStar(), calculator.getThreeStar());
                    checkLeaderboard()
                }
            }
        }
    }

    function setText(tutorialLevel){
        switch(tutorialLevel){
        case(1):
            //congratsText.text = "Completed the first tutorial!";
            congratsText.text = "1ste oefening voltooid!";
            break;
        case(2):
            //congratsText.text = "Completed the second tutorial!";
            congratsText.text = "2de oefening voltooid!";
            break;
        case(3):
            //congratsText.text = "Completed the third tutorial!";
            congratsText.text = "3de oefening voltooid!";
            break;
        case(4):
            //congratsText.text = "Completed the fourth tutorial!";
            congratsText.text = "4de oefening voltooid!";
            break;
        default:
            congratsText.text = "Level Cleared!";
            break;
        }
    }

    Rectangle{
        id: popupWindow
        height: Screen.height
        width: Screen.width/2
        anchors.horizontalCenter: parent.horizontalCenter
        visible: false

        Image
        {
            id: background
            anchors.centerIn: parent
            width: Screen.width/2
            height: Screen.height
            fillMode: Image.PreserveAspectCrop
            source: "bikiniBottom.jpg"
        }

        Timer {
            id:myTimer
            interval: 1500; running: false; repeat: false
            onTriggered: {
                hideElements()
                popupWindow.visible = true;
                alpha.visible= true;
                starRepeater.model = getStars();
            }
        }
        Text{
            id:congratsText
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top : parent.top
            anchors.topMargin: Screen.height/15
            text: "Proficiat!\nJe hebt het level uitgespeeld!"
            font.pixelSize: 50
        }

        Row{
            id:starRow
            anchors.top: congratsText.bottom;
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            Repeater{
                id: starRepeater
                // this is the index from the button assigned by the top repeater
                model: 0
                delegate:
                    Image{
                    source: "starfish.png";
                    width: Screen.width/15;
                    height: width;
                }
            }
        }

        Row{
            id: theButtons
            anchors.bottom: popupWindow.bottom
            anchors.bottomMargin: Screen.height/12
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: Screen.width/20
            Button{
                width: Screen.width/15
                height: width
                style: ButtonStyle {
                    background: Rectangle {
                        //implicitWidth: 100
                        //implicitHeight: 25
                        border.width: 2
                        border.color: "black"
                        radius: width*0.5
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: Qt.rgba(243/255,103/255,170/255,1) }
                            GradientStop { position: 1 ; color: Qt.rgba(255/255,177/255,214/255,1) }
                        }
                    }
                }
                Image{
                    source: "retry2.png"
                    height: parent.height/2
                    width: parent.width/2
                    anchors.centerIn: parent
                }

                onClicked: {
                    //soundEffects.source = "Bubbles.wav";
                    soundEffects.play();
                    world.destroyCamera();
                    pageLoader.source = "";
                    pageLoader.source = "GameScreen.qml";
                    console.log("world is destroyed");
                }
            }

            Button{

                width: Screen.width/15
                height: width
                style: ButtonStyle {
                    background: Rectangle {
                        //implicitWidth: 100
                        //implicitHeight: 25
                        border.width: 2
                        border.color: "black"
                        radius: width*0.5
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: Qt.rgba(243/255,103/255,170/255,1) }
                            GradientStop { position: 1 ; color: Qt.rgba(255/255,177/255,214/255,1) }
                        }
                    }
                }

                onClicked: {
                    //soundEffects.source = "Bubbles.wav";
                    soundEffects.play();
                    world.destroyCamera();
                    pageLoader.source = "LevelScreen.qml";
                    console.log("world is destroyed");
                }

                Image{
                    source: "levels.png"
                    height: parent.height/2
                    width: parent.width/2
                    anchors.centerIn: parent
                }

            }

            Button{
                id: continueBtn
                //text: "Continue"
                width: Screen.width/15
                height: width
                style: ButtonStyle {
                    background: Rectangle {
                        //implicitWidth: 100
                        //implicitHeight: 25
                        border.width: 2
                        border.color: "black"
                        radius: width*0.5
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: Qt.rgba(243/255,103/255,170/255,1) }
                            GradientStop { position: 1 ; color: Qt.rgba(255/255,177/255,214/255,1) }
                        }
                    }
                }
                onClicked: {
                    //soundEffects.source = "Bubbles.wav";
                    soundEffects.play();
                    myLevels.setCurrentLevel(myLevels.getCurrentLevel()+1);
                    world.destroyCamera();
                    pageLoader.source = "";
                    pageLoader.source = "GameScreen.qml";

                    console.log("world is destroyed");
                }

                Image{
                    source: "continue.png"
                    height: parent.height/2
                    width: parent.width/2
                    anchors.centerIn: parent
                }
            }

        }

        Loader
        {
            id:leaderLoader

            anchors.top : starRow.bottom
            anchors.topMargin: 50
            anchors.horizontalCenter: popupWindow.horizontalCenter;

            source: "Leaderboard.qml"
            Row{
                id: buttonRow

                anchors.top:leaderLoader.item.bottom
                anchors.topMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter

                visible: {checkLeaderboard() && showLeaderboardEntry}

                TextField{
                    id:myTextField

                    width: popupWindow.width/2
                    height: Screen.height/12
                    placeholderText : "Geef hier je naam in"
                    font.family: fontfam
                    font.pointSize: fontSize
                    style: TextFieldStyle {
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

                    width:Screen.height/12
                    height:Screen.height/12
                    onClicked: {
                        //console.log("this is the text: " + myTextField.displayText);
                        leaderLoader.item.myLevelboard.addEntry(myTextField.displayText, getStars(), numClicks );
                        leaderLoader.item.myLevelboard.writeLeaderBoard(myLevels.getCurrentLevel());
                        leaderLoader.source="";
                        leaderLoader.source="Leaderboard.qml";
                        showLeaderboardEntry = false;
                    }
                    Image{
                        anchors.centerIn: parent
                        source: "confirm.png"
                        height: parent.height*2/3
                        width: height
                    }
                }

            }
        }
    }


    //this are all the functions

    function toggleSwitch()
    {
        if(changeSwitchText.text === " Open Brug "){
            changeSwitchText.text = " Sluit Brug ";
        }
        else{
            changeSwitchText.text = " Open Brug ";
        }

        calculator.toggleSwitch(clickedSwitch);
        world.generator.toRotateSwitch(clickedSwitch);
        calculator.solveLevel();
        world.generator.updateLevel();

    }

    function calculateSize(){
        var Icurrent = calculator.getCurrentInGoalWire();
        var Igoal = calculator.getGoalinGoalWire();
        var size = 0;
        if(Igoal !== 0){
            size = Icurrent/Igoal;
            if(Icurrent > Igoal){
                size=(Icurrent-((Icurrent-Igoal)/6*5))/Igoal;
            }
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
        jellyGoal.height = jellyGoal.paintedHeight*4/5;
        jellyGoal.width = jellyGoal.paintedWidth*4/5;
        jellyPixelHeight = jellyGoal.height;
        jellyPixelWidth = jellyGoal.width;
        //        jellyPixelHeight = jelly.paintedHeight;
        //        jellyPixelWidth = jelly.paintedWidth;
        updateJellyAnchors();
    }

    function setVisibilityJellies(){
        if(calculator.getCurrentInGoalWire() === 0){
            jelly.visible = false;
            jellyGoal.visible = false;

        }
        else{
            jelly.visible = true;
            jellyGoal.visible = true;
        }
    }

    function setPopupWindowForTutorial(tutorialLevel){
        setText(tutorialLevel);
        switch(tutorialLevel){
        case(1):
            world.cameraAngle = 5*Math.PI/4;
            break;

        case(2):
            world.cameraAngle = 5*Math.PI/4;
            break;

        case(3):
            world.cameraAngle = 5*Math.PI/4;
            break;

        case(4):
            world.cameraAngle = 5*Math.PI/4;
            break;
        default:
            world.cameraAngle = 5*Math.PI/4;
            break;

        }
    }
    function hideElements(){
        retryButton.visible = false;
        returnButton.visible = false;
        resistorBox.visible = false;
        textBox.visible = false;
        jelly.visible = false;
        jellyGoal.visible = false;
        rotateCamera.visible = false;
        counter.visible = false;
        switchBox.visible = false;
        tutorialScreen.setTextInvis();

    }

    function checkLeaderboard()
    {
        //console.log(" amount of leaderboard entries: " +leaderLoader.item.myLevelboard.getAmountOfEntries())
        if(leaderLoader.item.myLevelboard.getAmountOfEntries()< 5)
        {
            //checkBoard = true;
            return true;

        }
        else if(leaderLoader.item.myLevelboard.getLowestEntry() > numClicks)
        {
            //checkBoard = true;
            return true;
        }
        //checkBoard = false;
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

    function setHighScore( score)
    {
        highScore = score;
    }

    function updateTutorial(){
        tutorialScreen.checkBallclicked();
    }
    function getPhysicalScreenWidth(){
        if( calculator.getPhysicalScreenWidth() === 0){
            console.log("ERROR: physical screen width is equal to 0")
        }
        return calculator.getPhysicalScreenWidth();
    }



}





