import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Window 2.0
Rectangle{
    id: screenWindow
    property int stage: 0
    property int numStages: 2
    property int offset: buttonNext.height
    property bool ballExplained: false
    property QtObject test
    // color:"white"
    color: "transparent"
    width: Screen.width
    height: Screen.height
    visible: {stage <= numStages}

    Rectangle{
        id:instructionWindow
        color:"white"
        width: Screen.width/4
        height: Screen.height/4
        visible: {stage <= numStages}

        Component.onCompleted: {
            instructionWindow.anchors.left = parent.left;
            instructionWindow.anchors.bottom = parent.bottom;
            instructionWindow.anchors.leftMargin = (Screen.width/2 - instructionWindow.width/2);
            instructionWindow.anchors.bottomMargin = (Screen.height/2 - instructionWindow.height/2);
            myGameScreen.setPopupWindowForTutorial(1);
        }
        Text{
            id:instructionText
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: offset
            text: "Welcome to the first tutorial!"
        }
        Button{
            id:buttonNext
            visible: {stage <= numStages}
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: offset
            text:"Volgende"
            onClicked: {
                updateInstructions();
            }
        }

    }
    function updateInstructions(){
        switch(stage){
        case(0):
            stage++;
            instructionWindow.anchors.leftMargin = 100;
            instructionText.text = "STAP 1/3\nDeze rode paal toont het doel van het spel aan.\nde kwallen hebben jou hulp nodig om op deze hoogte te kunnen zwemmen";
            break;
        case(1):
            stage++;
            instructionWindow.anchors.leftMargin = 100;
            instructionText.text = "STAP 2/3\nDe grijze paal is de kwallenlift.\nklik op de bol om de hoogte te veranderen";
            buttonNext.visible = false;
            break;
        case(numStages):
            if(ballExplained){
                stage++;
                instructionWindow.anchors.leftMargin = 100;
                if(myGameScreen.clickedSource != null)
                    instructionText.text = "Thank you for completing the first tutorial!";;
            }
            break;
        default:
            instructionWindow.anchors.leftMargin = (Screen.width/2 - instructionWindow.width/2);
            instructionWindow.anchors.bottomMargin = (Screen.height/2 - instructionWindow.height/2);
            break;
        }
    }
    function checkBallclicked(){
        if(ballExplained==false){
            if(myGameScreen.clickedSource != null){
                ballExplained = true;
                //buttonNext.visible = true;
                instructionWindow.anchors.leftMargin = 100;
                instructionWindow.anchors.bottomMargin = 150;
                instructionText.text = "STAP 3/3\nHeel goed! \nKlik op de knoppen om de hoogte te matchen";
            }
        }
    }
}

