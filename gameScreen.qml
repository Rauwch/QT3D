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
    property bool showPopup: false
    property bool showLeaderboardEntry: true
    property bool checkBoard: false
    property bool playingAnimation: false
    property int jellyPixelHeight
    property int jellyPixelWidth
    property int jellySize: 0

    property int clickedSource: -1
    property int prevClickedSource: -1
    property int clickedRes
    property int clickedSwitch
    property int numClicks: 0
    property int highScore: 0

    signal loaded
    anchors.fill: parent

    Component.onCompleted: {

        // #crash# out of memory after
        console.log("GameScreen is complteded");
        console.log("current level" + myLevels.getCurrentLevel()) ;
        setPopupWindowForTutorial(myLevels.getCurrentLevel());
        if(myLevels.getCurrentLevel() === 1 || myLevels.getCurrentLevel() === 4 || myLevels.getCurrentLevel()  === 7 || myLevels.getCurrentLevel() === 13 || myLevels.getCurrentLevel() === 15){
            console.log("tutorial");
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
        Component.onCompleted: {
            console.log("tutTimer is completed");
        }
        interval: 2000
        running: false
        repeat: false
        onTriggered: tutorialScreen.visible = true
    }

    property Calculator calculator: Calculator{
        Component.onCompleted: {
            console.log("calculator is completed");
            world.generator.completed();
        }
    }

    Timer{
        Component.onCompleted: {
            console.log("delayTimer is completed");
        }
        id:delayTimer
        interval: 500
        repeat: false
        onTriggered: {
            //increaseHeightAction.enabled = true;
            //decreaseHeightAction.enabled = true;
            //increaseResistorAction.enabled = true;
            //decreaseResistorAction.enabled = true;
            changeSwitchAction.enabled =true;
        }

    }

    /* put the 3D world in the GameScreen */
    Scene3D{
        Component.onCompleted: {
            console.log("ourScene3D is completed");
        }
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
        Component.onCompleted: {
            console.log("alpha is completed");
        }
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

        Component.onCompleted: {
            console.log("return row is completed");
        }
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
                //need this destroy first to not crash program
                //world.destroyCamera();
                console.log("world is destroyed");
                pageLoader.source = "";
                pageLoader.source = "GameScreen.qml";

            }

        }
    }
    TextField{
        Component.onCompleted: {
            console.log("counter is completed");
        }
        id: counter
        anchors.horizontalCenter: myGameScreen.horizontalCenter
        anchors.bottom: myGameScreen.bottom
        //visible: false
        text: "aantal kliks: " + myGameScreen.numClicks
        readOnly: true
        font.pixelSize: 30
    }
    TextField{
        id: counterHighScore
        //visible: false
        Component.onCompleted:
        {
            console.log("counterHigh is completed");
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
        Component.onCompleted: {
            console.log("Tutorial is completed");
        }
        id: tutorialScreen
        anchors.left: parent.left
        anchors.bottom: parent.bottom
    }

    Image{
        Component.onCompleted: {
            console.log("jellyGoal is completed");
        }
        id:jellyGoal
        source: "jellyGoal.png"

    }

    Image{
        Component.onCompleted: {
            console.log("jelly is completed");
        }
        id:jelly
        source: "jelly.png"

    }

    Button{
        Component.onCompleted: {
            console.log("rotate camera is completed");
        }
        id:rotateCamera

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10

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
    Rectangle{
        Component.onCompleted: {
            console.log("resistorMenu is completed");
        }
        id: resistorMenu
        height: resistorMenuCol.height + 70
        width:  resistorMenuCol.width+20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.rightMargin: 20
        radius: 4
        anchors.right: parent.right
        visible: showRes

        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            id: schuifafText
            text: "Schuifaf"
            renderType: Text.NativeRendering
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "Helvetica"
            font.pointSize: 20
            color: "black"
        }
        Column{
            id: resistorMenuCol
            visible: showRes
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            spacing: 10

            Button{
                id: resistorAt4
                width: height + 80
                height: resistorAngle4.height + 20
                onClicked: setResistorMenu(4)
                Image{
                    id:resistorAt4Image
                    anchors.fill: parent
                    source: "t0096_0.png"
                    visible: false
                }

                Image{
                    id: resistorAngle4
                    source: "angle20.png"
                    anchors.centerIn: parent
                    height: Screen.height/13
                    width: height
                }

//                Text{
//                    anchors.centerIn: parent
//                    id: resistorAt4Text
//                    text: "Niveau 5"
//                    renderType: Text.NativeRendering
//                    verticalAlignment: Text.AlignVCenter
//                    horizontalAlignment: Text.AlignHCenter
//                    font.family: "Helvetica"
//                    font.pointSize: 20
//                    color: "black"
//                }


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


            }
            Button{
                id: resistorAt3
                width: height + 80
                height: resistorAngle3.height + 20
                onClicked:setResistorMenu(3)
                Image{
                    id:resistorAt3Image
                    anchors.fill: parent
                    source: "t0096_0.png"
                    visible: false
                }
                Image{
                    id: resistorAngle3
                    source: "angle50.png"
                    anchors.centerIn: parent
                    height: Screen.height/12
                    width: height
                }
//                Text{
//                    anchors.centerIn: parent
//                    id: resistorAt3Text
//                    text: "Niveau 4"
//                    renderType: Text.NativeRendering
//                    verticalAlignment: Text.AlignVCenter
//                    horizontalAlignment: Text.AlignHCenter
//                    font.family: "Helvetica"
//                    font.pointSize: 20
//                    color: "black"
//                }
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


            }
            Button{
                id: resistorAt2
                width: height + 80
                height: resistorAngle2.height + 20
                onClicked:setResistorMenu(2)
                Image{
                    id:resistorAt2Image
                    anchors.fill: parent
                    source: "t0096_0.png"
                    visible: false
                }
                Image{
                    id: resistorAngle2
                    source: "angle80.png"
                    anchors.centerIn: parent
                    height: Screen.height/12
                    width: height
                }
//                Text{
//                    anchors.centerIn: parent
//                    id: resistorAt2Text
//                    text: "Niveau 3"
//                    renderType: Text.NativeRendering
//                    verticalAlignment: Text.AlignVCenter
//                    horizontalAlignment: Text.AlignHCenter
//                    font.family: "Helvetica"
//                    font.pointSize: 20
//                    color: "black"
//                }
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


            }
            Button{
                id: resistorAt1
                width: height + 80
                height: resistorAngle1.height + 20
                onClicked:setResistorMenu(1)
                Image{
                    id:resistorAt1Image
                    anchors.fill: parent
                    source: "t0096_0.png"
                    visible: false
                }
                Image{
                    id: resistorAngle1
                    source: "angle110.png"
                    anchors.centerIn: parent
                    height: Screen.height/12
                    width: height
                }
//                Text{
//                    anchors.centerIn: parent
//                    id: resistorAt1Text
//                    text: "Niveau 2"
//                    renderType: Text.NativeRendering
//                    verticalAlignment: Text.AlignVCenter
//                    horizontalAlignment: Text.AlignHCenter
//                    font.family: "Helvetica"
//                    font.pointSize: 20
//                    color: "black"
//                }
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

            }
            Button{
                id: resistorAt0
                width: height + 80
                height: resistorAngle0.height + 20
                onClicked: setResistorMenu(0)
                Image{
                    id:resistorAt0Image
                    anchors.fill: parent
                    source: "t0096_0.png"
                    visible: false
                }
                Image{
                    id: resistorAngle0
                    source: "angle0.png"
                    anchors.centerIn: parent
                    height: Screen.height/12
                    width: height
                }
//                Text{
//                    anchors.centerIn: parent
//                    id: resistorAt0Text
//                    text: "Niveau 1"
//                    renderType: Text.NativeRendering
//                    verticalAlignment: Text.AlignVCenter
//                    horizontalAlignment: Text.AlignHCenter
//                    font.family: "Helvetica"
//                    font.pointSize: 20
//                    color: "black"
//                }
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
            }
        }
    }
    Rectangle{
        id: sourceMenu
        height: sourceMenuCol.height + 70
        width: sourceMenuCol.width+20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.rightMargin: 20
        radius: 4
        anchors.right: parent.right
        visible: showBox
        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            id: liftText
            text: "Lift " + (clickedSource+1)
            renderType: Text.NativeRendering
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "Helvetica"
            font.pointSize: 20
            color: "black"
        }

        Column{
            id: sourceMenuCol
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            spacing: 10

            Button{
                id: sourceAt4
                width: sourceAt4Text.width + 20
                height: Screen.height/15
                onClicked: setSourceMenu(4)

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
                Image{
                    id:sourceAt4Image
                    anchors.fill: parent
                    source: "poleTexture.png"
                    visible: false
                }
                Text{
                    anchors.centerIn: parent
                    id: sourceAt4Text
                    text: "Niveau 5"
                    renderType: Text.NativeRendering
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Helvetica"
                    font.pointSize: 20
                    color: "black"
                }




            }
            Button{
                id: sourceAt3
                width: sourceAt3Text.width + 20
                height: Screen.height/15
                onClicked:setSourceMenu(3)
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
                Image{
                    id:sourceAt3Image
                    anchors.fill: parent
                    source: "poleTexture.png"
                    visible: false
                }
                Text{
                    anchors.centerIn: parent
                    id: sourceAt3Text
                    text: "Niveau 4"
                    renderType: Text.NativeRendering
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Helvetica"
                    font.pointSize: 20
                    color: "black"
                }



            }
            Button{
                id: sourceAt2
                width: sourceAt2Text.width + 20
                height: Screen.height/15
                onClicked:setSourceMenu(2)
                Image{
                    id:sourceAt2Image
                    anchors.fill: parent
                    source: "poleTexture.png"
                    visible: false
                }
                Text{
                    anchors.centerIn: parent
                    id: sourceAt2Text
                    text: "Niveau 3"
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


            }
            Button{
                id: sourceAt1
                width: sourceAt1Text.width + 20
                height: Screen.height/15
                onClicked:setSourceMenu(1)
                Image{
                    id:sourceAt1Image
                    anchors.fill: parent
                    source: "poleTexture.png"
                    visible: false
                }
                Text{
                    anchors.centerIn: parent
                    id: sourceAt1Text
                    text: "Niveau 2"
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

            }
            Button{
                id: sourceAt0
                width: sourceAt0Text.width + 20
                height: Screen.height/15
                onClicked: setSourceMenu(0)
                Image{
                    id:sourceAt0Image
                    anchors.fill: parent
                    source: "poleTexture.png"
                    visible: false
                }
                Text{
                    anchors.centerIn: parent
                    id: sourceAt0Text
                    text: "Niveau 1"
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
            }
        }
    }


    /* toggle switch */
    Rectangle{
        Component.onCompleted: {
            console.log("switchMenu is completed");
        }
        id: switchMenu
        height: switchMenuCol.height + 70
        width:  switchMenuCol.width+20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.rightMargin: 20
        radius: 4
        anchors.right: parent.right
        visible: showSwitch

        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            id: brugText
            text: "Brug"
            renderType: Text.NativeRendering
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "Helvetica"
            font.pointSize: 20
            color: "black"
        }
        Column{
            id: switchMenuCol
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom : parent.bottom
            anchors.bottomMargin: 10
            spacing: 10
            Button{
                id: openSwitch
                width: openSwitchText.width + 20
                height: Screen.height/15
                visible: myGameScreen.showSwitch
                action: Action{id: openSwitchAction; enabled: true}

                Image{
                    id:switchOpenImage
                    anchors.fill: parent
                    source: "Switch.jpg"
                    visible: false
                }
                Text{
                    id: openSwitchText
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
                onClicked: openSwitchFunc();
            }
            Button{
                id: closeSwitch
                width: openSwitchText.width + 20
                height: Screen.height/15
                visible: myGameScreen.showSwitch
                action: Action{id: changeSwitchAction; enabled: true}
                Image{
                    id:switchCloseImage
                    anchors.fill: parent
                    source: "Switch.jpg"
                    visible: true
                }
                Text{
                    id: closeSwitchText
                    anchors.centerIn: parent
                    text: " Sluit Brug "
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
                onClicked: closeSwitchFunc();
            }
        }
    }


    Rectangle{

        Component.onCompleted: {
            console.log("Popup window is completed");
        }
        id: popupWindow
        anchors.horizontalCenter: parent.horizontalCenter
        height: Screen.height
        width: Screen.width/2
        visible: showPopup
        onVisibleChanged: {
            jelly.visible = false;
            jellyGoal.visible = false;
        }

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
            interval: 3000; running: false; repeat: false
            onTriggered: {
                showPopup = true;
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
                        if(myTextField.length!=0){

                            leaderLoader.item.myLevelboard.addEntry(myTextField.displayText, getStars(), numClicks );
                            leaderLoader.item.myLevelboard.writeLeaderBoard(myLevels.getCurrentLevel());
                            leaderLoader.source="";
                            leaderLoader.source="Leaderboard.qml";
                            showLeaderboardEntry = false;
                        }

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
        Component.onCompleted: {
            console.log("Loadingscreen is completed");
        }
        id: loading
    }

    //this are all the functions


    function openSwitchFunc(){
        numClicks++;
        calculator.openSwitch(clickedSwitch);
        world.generator.rotateOpenSwitch(clickedSwitch)
        calculator.solveLevel();
        world.generator.updateGoalPoles();
        delayTimer.start();

        switchOpenImage.visible = true;
        switchCloseImage.visible = false;
        if(calculator.checkGoals())
        {
            hideElements()
            myLevels.setAmountOfStars(numClicks,calculator.getTwoStar(), calculator.getThreeStar());
            checkLeaderboard()
            myTimer.start();
        }

        world.generator.updateLevel();
    }

    function setSwitchHighlight(){
        if(world.generator.getSwitchState(clickedSwitch))
        {
            switchOpenImage.visible = true;
        }
        else
            switchCloseImage.visible = true;
    }

    function closeSwitchMenu(){
        switchOpenImage.visible = false;
        switchCloseImage.visible = false;
    }

    function closeSwitchFunc(){

        numClicks++;
        calculator.closeSwitch(clickedSwitch);
        world.generator.rotateCloseSwitch(clickedSwitch)
        calculator.solveLevel();
        world.generator.updateGoalPoles();
        delayTimer.start();
        switchOpenImage.visible = false;
        switchCloseImage.visible = true;
        if(calculator.checkGoals())
        {
            hideElements()
            myLevels.setAmountOfStars(numClicks,calculator.getTwoStar(), calculator.getThreeStar());
            checkLeaderboard()
            myTimer.start();
        }

        world.generator.updateLevel();
    }

    function toggleSwitch(state)
    {
        changeSwitchAction.enabled= false;
        numClicks++;

        calculator.toggleSwitch(clickedSwitch);
        world.generator.toRotateSwitch(clickedSwitch);
        calculator.solveLevel();
        world.generator.updateGoalPoles();
        delayTimer.start();
        if(calculator.checkGoals())
        {
            hideElements();
            myLevels.setAmountOfStars(numClicks,calculator.getTwoStar(), calculator.getThreeStar());
            checkLeaderboard();
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
        //resistorBox.visible = false;
        //textBox.visible = false;
        sourceMenu.visible = false;
        resistorMenu.visible = false;
        switchMenu.visible = false;
        switchMenu.visible = false;
        //jelly.visible = false;
        //jellyGoal.visible = false;
        rotateCamera.visible = false;
        counter.visible = false;
        counterHighScore.visible = false;
        //changeSwitch.visible = false;
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

    function setText(tutorialLevel){
        switch(tutorialLevel){
        case(1):
            //congratsText.text = "Completed the first tutorial!";
            congratsText.text = "1ste oefening voltooid!";
            break;
        case(4):
            //congratsText.text = "Completed the second tutorial!";
            congratsText.text = "2de oefening voltooid!";
            break;
        case(7):
            //congratsText.text = "Completed the third tutorial!";
            congratsText.text = "3de oefening voltooid!";
            break;
        case(13):
            //congratsText.text = "Completed the fourth tutorial!";
            congratsText.text = "4de oefening voltooid!";
            break;
        case(15):
            //congratsText.text = "Completed the fourth tutorial!";
            congratsText.text = "5de oefening voltooid!";
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

    function setResistorMenu(clickedResistorArray){
        //console.log(" change resistor " + clickedRes + " place in array " + clickedResistorArray);
        calculator.adjustResistance(clickedRes, world.generator.getArrayValueOfResistor(clickedRes,clickedResistorArray));
        calculator.solveLevel();
        world.generator.changeRes(clickedRes,clickedResistorArray);
        resistorAt0Image.visible = false;
        resistorAt1Image.visible = false;
        resistorAt2Image.visible = false;
        resistorAt3Image.visible = false;
        resistorAt4Image.visible = false;
        //resistorAt0Text.color = "black"
        //resistorAt1Text.color = "black"
        //resistorAt2Text.color = "black"
        //resistorAt3Text.color = "black"
        //resistorAt4Text.color = "black"

        world.generator.setPositionInResArray(clickedRes,clickedResistorArray);
        switch ( clickedResistorArray)
        {
        case 0:
            resistorAt0Image.visible = true;
            //resistorAt0Text.color = "white"
            break;
        case 1:
            resistorAt1Image.visible = true;
            //resistorAt1Text.color = "white"
            break;
        case 2:
            resistorAt2Image.visible = true;
            //resistorAt2Text.color = "white"
            break;
        case 3:
            resistorAt3Image.visible = true;
            //resistorAt3Text.color = "white"
            break;
        case 4:
            resistorAt4Image.visible = true;
            //resistorAt4Text.color = "white"
            break;
        }

        // deze functie zou niet meer nodig zijn
        numClicks++;
        delayTimer.start();
        if(calculator.checkGoals()){
            hideElements();
            myTimer.start();
            myLevels.setAmountOfStars(numClicks,calculator.getTwoStar(), calculator.getThreeStar());
            checkLeaderboard();
        }
        world.generator.updateGoalPoles();
        world.generator.updateLevel();

        calculateSize();
    }


    function setResistorHighlight(){
        //console.log(" change resistor " + clickedRes);
        switch(world.generator.getPositionInResArray(clickedRes)){
        case (0):
            resistorAt0Image.visible = true;
            //resistorAt0Text.color = "white";
            break;
        case (1):
            resistorAt1Image.visible = true;
            //resistorAt1Text.color = "white";
            break;
        case (2):
            resistorAt2Image.visible = true;
            //resistorAt2Text.color = "white";

            break;
        case (3):
            resistorAt3Image.visible = true;
            //resistorAt3Text.color = "white";

            break;
        case (4):
            resistorAt4Image.visible = true;
            //resistorAt4Text.color = "white";

            break;
        default:
            break;
        }

    }
    function closeSourceMenu()
    {
        //console.log(" hide source Highligtht " + clickedSource);
        sourceAt0Image.visible = false;
        sourceAt1Image.visible = false;
        sourceAt2Image.visible = false;
        sourceAt3Image.visible = false;
        sourceAt4Image.visible = false;
    }

    function closeResistorMenu()
    {
        //console.log(" hide source Highligtht " + clickedSource);
        resistorAt0Image.visible = false;
        resistorAt1Image.visible = false;
        resistorAt2Image.visible = false;
        resistorAt3Image.visible = false;
        resistorAt4Image.visible = false;
        //resistorAt0Text.color = "black"
        //resistorAt1Text.color = "black"
        //resistorAt2Text.color = "black"
        //resistorAt3Text.color = "black"
        //resistorAt4Text.color = "black"

    }
    function setSourceHighlight()
    {
        //console.log(" source Highligtht " + clickedSource);
        switch(world.generator.getPositionInArray(clickedSource)){
        case (0):
            sourceAt0Image.visible = true;
            break;
        case (1):
            sourceAt1Image.visible = true;
            break;
        case (2):
            sourceAt2Image.visible = true;
            break;
        case (3):
            sourceAt3Image.visible = true;

            break;
        case (4):
            sourceAt4Image.visible = true;
            break;
        default:
            break;
        }
    }


    function setSourceMenu(clickedSourceArray){

        calculator.adjustVoltageAtSource(clickedSource,world.generator.getArrayValueOfSource(clickedSource,clickedSourceArray));
        calculator.solveLevel();
        sourceAt0Image.visible = false;
        sourceAt1Image.visible = false;
        sourceAt2Image.visible = false;
        sourceAt3Image.visible = false;
        sourceAt4Image.visible = false;
        world.generator.setPositionInArray(clickedSource,clickedSourceArray);
        switch ( clickedSourceArray)
        {
        case 0:
            sourceAt0Image.visible = true;
            break;

        case 1:
            sourceAt1Image.visible = true;
            break;

        case 2:
            sourceAt2Image.visible = true;
            break;
        case 3:
            sourceAt3Image.visible = true;
            break;
        case 4:
            sourceAt4Image.visible = true;
            break;
        }

        // deze functie zou niet meer nodig zijn
        numClicks++;
        delayTimer.start();
        if(calculator.checkGoals()){
            hideElements();
            myTimer.start();
            myLevels.setAmountOfStars(numClicks,calculator.getTwoStar(), calculator.getThreeStar());
            checkLeaderboard();
        }
        world.generator.updateGoalPoles();
        world.generator.updateLevel();

        calculateSize();
    }

}





