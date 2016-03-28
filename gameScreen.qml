/*
  class that handles 2d overlay of game
  this includes all buttons/ indicators that show up during the game
*/
import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtQuick.Scene3D 2.0
import QtQuick.Controls.Styles 1.4

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
    property bool playingAnimation: false
    property int jellyPixelHeight
    property int jellyPixelWidth
    property int jellySize: 0

    property int clickedSource
    property int clickedRes
    property int clickedSwitch
    property int numClicks: 0
    property int highScore: 0

    signal loaded
    anchors.fill: parent

    Component.onCompleted: {
        console.log("GameScreen wordt aangemaakt");
        setPopupWindowForTutorial(myLevels.getCurrentLevel());

        if(myLevels.getCurrentLevel() <= 4){
            tutorialScreen.numberOfLevel = myLevels.getCurrentLevel();
            tutTimer.start();
            rotateCamera.visible = false;
        }
        else
        {
            rotateCamera.visible = true;
        }
    }
    Component.onDestruction: {
        console.log("gamescreen destroyed");
    }


    property Timer tutTimer: Timer{
        interval: 2000
        running: false
        repeat: false
        onTriggered: tutorialScreen.visible = true
    }

    property Calculator calculator: Calculator{

    }

    /* put the 3D world in the GameScreen */
    Scene3D{
        id: ourScene3D
        anchors.fill: parent
        focus: true
        aspects: "input"

        World3D{
            id: world
        }
    }



    /* makes the background blackish when you finish a level */
    Button{
        id:alpha
        anchors.fill: parent
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
            style: ButtonStyle {
                background: Rectangle {

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
                soundEffects.play();
                //need this destroy first to not crash program
                //world.destroyCamera();
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
                soundEffects.play();
                //need this destroy first to not crash program
                //world.destroyCamera();
                console.log("world is destroyed");
                pageLoader.source = "";
                pageLoader.source = "GameScreen.qml";

            }

        }
    }
    TextField{
        id: counter
        anchors.horizontalCenter: myGameScreen.horizontalCenter
        anchors.bottom: myGameScreen.bottom

        text: "aantal kliks: " + myGameScreen.numClicks
        readOnly: true
        font.pixelSize: 30
    }
    TextField{
        id: counterHighScore
        Component.onCompleted:
        {
            if(myGameScreen.highScore == 0)
                text = "Highscore: /"
        }
        anchors.horizontalCenter: myGameScreen.horizontalCenter
        anchors.bottom: counter.top

        text: "Highscore: " + myGameScreen.highScore
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
            anchors.centerIn: parent

            source: "rotateCamera.png"
            height: parent.height*2/3
            width: parent.width*2/3
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

    /* increase and decrease the height of a source */
    Column{
        id: textBox
        anchors.bottom: parent.bottom
        visible: myGameScreen.showBox
        spacing: 10
        /* increase height button */
        Button{
            id: increaseHeight
            width: increaseText.width + 20
            height: Screen.height/15
            Text{
                id: increaseText
                anchors.centerIn: parent
                text: "Verhoog Lift"
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
            onClicked: increaseSourceButton();
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
            onClicked: decreaseSourceButton();
        }
    }

    Column{
        id: resistorBox
        anchors.bottom: parent.bottom
        visible: myGameScreen.showRes
        spacing: 10
        /* increase the value of the resistor */
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
            onClicked: increaseResistorButton();
        }

        Button{
            id: decreaseResistor
            width: increaseResText.width+20
            height: Screen.height/15
            Text{
                id: decreaseResText
                anchors.centerIn: parent
                text: "Verklein bochten"
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
            onClicked: decreaseResistorButton();
        }
    }




    /* toggle switch */
    Button{
        id: changeSwitch
        anchors.bottom: parent.bottom
        width: changeSwitchText.width + 20
        height: Screen.height/15
        visible: myGameScreen.showSwitch
        Text{
            id: changeSwitchText
            anchors.centerIn: parent
            text: " Open Brug "
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
        onClicked: toggleSwitch();
    }


    Rectangle{
        id: popupWindow
        anchors.horizontalCenter: parent.horizontalCenter
        height: Screen.height
        width: Screen.width/2
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

                    soundEffects.play();
                    //world.destroyCamera();
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
                width: Screen.width/15
                height: width
                style: ButtonStyle {
                    background: Rectangle {
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
                    soundEffects.play();
                    myLevels.setCurrentLevel(myLevels.getCurrentLevel()+1);
                    world.destroyCamera();
                    pageLoader.source = "";
                    pageLoader.source = "GameScreen.qml";
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

                visible: {myGameScreen.checkLeaderboard() && myGameScreen.showLeaderboardEntry}

                TextField{
                    id:myTextField

                    width: popupWindow.width/2
                    height: Screen.height/12
                    placeholderText : "Geef hier je naam in"
                    font.family: "Helvetica"
                    font.pointSize: 20
                    maximumLength: 10
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

    LoadingScreen{
        id: loading
    }

    //this are all the functions
    function toggleSwitch()
    {
        numClicks++;

        if(changeSwitchText.text === " Open Brug "){
            changeSwitchText.text = " Sluit Brug ";
        }
        else{
            changeSwitchText.text = " Open Brug ";
        }

        calculator.toggleSwitch(clickedSwitch);
        world.generator.toRotateSwitch(clickedSwitch);
        calculator.solveLevel();
        world.generator.updateGoalPoles();
        if(calculator.checkGoals())
        {
            hideElements()
            myLevels.setAmountOfStars(numClicks,calculator.getTwoStar(), calculator.getThreeStar());
            checkLeaderboard()
            myTimer.start();
        }

        world.generator.updateLevel();
    }
    /* Represents the goal current and the present current by the size of the jellyfishes */
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
        jelly.height = jellyPixelHeight*size;
        jelly.width = jellyPixelWidth * size;
        updateJellyAnchors();
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

    /* set the goalJelly and the jelly in the right corner of the screen */
    function initializeJellies(){
        jellyGoal.height = jellyGoal.paintedHeight*4/5;
        jellyGoal.width = jellyGoal.paintedWidth*4/5;
        jellyPixelHeight = jellyGoal.height;
        jellyPixelWidth = jellyGoal.width;
        updateJellyAnchors();
    }

    /* If the level has a current goal, the Jelly and Goal Jelly are shown */
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

    function setPopupWindowForTutorial(tutorialLevel)
    {
        setText(tutorialLevel);
        world.cameraAngle = 5*Math.PI/4;
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
        changeSwitch.visible = false;
        tutorialScreen.setTextInvis();

    }

    function showElements(){
        retryButton.visible = true;
        returnButton.visible = true;
        counter.visible = true;
        counterHighScore.visible = true;

//        jelly.visible = true;
//        jellyGoal.visible = true;
        //rotateCamera.visible = true;
        counter.visible = true;
        //changeSwitch.visible = true;

    }
    /* function returns if the textfield to enter a new entry in the leaderLoader, should be shown */
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

    /* function returns the amount stars earned */
    function getStars()
    {
        if(calculator.getThreeStar() >=  numClicks){
            return 3;
        }
        else if(calculator.getTwoStar() >= numClicks){
            return 2;
        }
        else
            return 1;
    }
    function updateTutorial(){
        tutorialScreen.checkBallclicked();
    }

    function increaseSourceButton()
    {
        calculator.adjustVoltageAtSource(clickedSource,calculator.getStepOfSource(clickedSource));
        calculator.solveLevel();
        world.generator.increaseVolt(clickedSource);
        numClicks++;
        if(calculator.checkGoals()){
            hideElements();
            myTimer.start();
            myLevels.setAmountOfStars(numClicks,calculator.getTwoStar(), calculator.getThreeStar());
            checkLeaderboard();
        }
        world.generator.updateGoalPoles();
        world.generator.updateLevel();
        if(world.generator.sources[clickedSource].heightIntensity >= 4){
            increaseHeight.visible = false;
        }
        if(world.generator.sources[clickedSource].heightIntensity >= 1){
            decreaseHeight.visible = true;
            increaseHeight.parent.anchors.bottomMargin = 0;
        }
        calculateSize();

    }

    function decreaseSourceButton(){
        calculator.adjustVoltageAtSource(clickedSource,-calculator.getStepOfSource(clickedSource));
        calculator.solveLevel();
        world.generator.decreaseVolt(clickedSource);
        numClicks++;

        if(calculator.checkGoals())
        {
            hideElements();
            myTimer.start();
            myLevels.setAmountOfStars(numClicks,calculator.getTwoStar(), calculator.getThreeStar());
            checkLeaderboard();
        }
        world.generator.updateGoalPoles();
        world.generator.updateLevel();
        if(world.generator.sources[0].heightIntensity <= 0){
            increaseHeight.parent.anchors.bottomMargin = Screen.height/15;
            decreaseHeight.visible = false;

        }
        if(world.generator.sources[0].heightIntensity <= 3){
            increaseHeight.visible = true;
        }
        calculateSize();

    }

    function increaseResistorButton(){
        calculator.adjustResistance(clickedRes, calculator.getStepOfResistor(clickedRes));
        world.generator.increaseRes(clickedRes);
        calculator.solveLevel();
        calculateSize();
        numClicks++;
        if(calculator.checkGoals())
        {
            hideElements()
            myTimer.start();
            myLevels.setAmountOfStars(numClicks,calculator.getTwoStar(), calculator.getThreeStar());
            checkLeaderboard()
        }
        world.generator.updateLevel();
        if(world.generator.resistors[0].bendIntensity >= 4){
            increaseResistor.visible = false;
        }
        if(world.generator.resistors[0].bendIntensity >= 1){
            decreaseResistor.visible = true;
            increaseResistor.parent.anchors.bottomMargin = 0;
        }

    }

    function decreaseResistorButton(){
        calculator.adjustResistance(clickedRes, -calculator.getStepOfResistor(clickedRes));
        numClicks++;
        world.generator.decreaseRes(clickedRes);
        calculator.solveLevel();
        calculateSize();

        if(calculator.checkGoals())
        {
            hideElements()
            myTimer.start();
            myLevels.setAmountOfStars(numClicks,calculator.getTwoStar(), calculator.getThreeStar());
            checkLeaderboard()
        }
        world.generator.updateLevel();
        if(world.generator.resistors[0].bendIntensity <= 0){
            increaseResistor.parent.anchors.bottomMargin = Screen.height/15;
            decreaseResistor.visible = false;
        }
        if(world.generator.resistors[0].bendIntensity <= 3){
            increaseResistor.visible = true;
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
    function getPhysicalScreenWidth(){
        if( calculator.getPhysicalScreenWidth() === 0){
            console.log("ERROR: physical screen width is equal to 0")
        }
        return calculator.getPhysicalScreenWidth();
    }
}





