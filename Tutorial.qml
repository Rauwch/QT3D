import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Window 2.0
Rectangle{
    id: screenWindow
    property int stage: 0
    property int numStages: 2
    property int offset: buttonNext.height
    property bool ballExplained: false
    property int numberOfLevel: 1
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
//            instructionWindow.anchors.left = screenWindow.left;
//            instructionWindow.anchors.bottom = screenWindow.bottom;
//            instructionWindow.anchors.leftMargin = (Screen.width/2 - instructionWindow.width/2);
//            instructionWindow.anchors.bottomMargin = (Screen.height/2 - instructionWindow.height/2);
            myGameScreen.setPopupWindowForTutorial(numberOfLevel);
            setInstructionText();
        }
        Text{
            id:instructionText
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: offset
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
    function setInstructionText(){
        switch(numberOfLevel){
        case(1):
            instructionWindow.anchors.left = screenWindow.left;
            instructionWindow.anchors.bottom = screenWindow.bottom;
            instructionWindow.anchors.leftMargin = (Screen.width/2 - instructionWindow.width/2);
            instructionWindow.anchors.bottomMargin = (Screen.height/2 - instructionWindow.height/2);
            instructionText.text = "Welcome to the first tutorial!"
            break;
        case(2):
            instructionWindow.anchors.right = screenWindow.right;
            instructionWindow.anchors.bottom = screenWindow.bottom;
            instructionWindow.anchors.rightMargin = (Screen.width/2 - instructionWindow.width/2);
            instructionWindow.anchors.bottomMargin = (Screen.height/2 - instructionWindow.height/2);
            instructionText.text = "Welcome to the second tutorial"
            break;
        }
    }
    function updateInstructions(){
        switch(numberOfLevel){
        case(1):
            numStages = 2;
            updateInstructionsLvlOne();
            break;
        case(2):
            numStages = 3;
            updateInstructionsLvlTwo();
            break;
        }
    }
    function updateInstructionsLvlOne(){

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
                    instructionText.text = "Thank you for completing the first tutorial!";
            }
            break;
        default:
            instructionWindow.anchors.leftMargin = (Screen.width/2 - instructionWindow.width/2);
            instructionWindow.anchors.bottomMargin = (Screen.height/2 - instructionWindow.height/2);
            break;
        }
    }
    function updateInstructionsLvlTwo(){

        switch(stage){
        case(0):
            stage++;
            instructionWindow.anchors.rightMargin = 150;
            instructionText.text = "STAP 1/4\nDeze inktvis toont aan hoe groot hij moet worden";
            break;
        case(1):
            stage++;
            instructionWindow.anchors.rightMargin = 150;
            instructionText.text = "STAP 2/4\nInktvissen gaan door de paarse buizen naar beneden";
            break;
        case(2):
            stage++;
            instructionWindow.anchors.rightMargin = 150;
            instructionText.text = "STAP 3/4\nKlik op de bal om de scherpte van de bochten aan te passen";
            buttonNext.visible = false;
            break;
        case(numStages):
            if(ballExplained){
                stage++;
                    instructionText.text = "Thank you for completing the second tutorial!";
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
                switch(numberOfLevel){
                case(1):
                    ballExplained = true;
                    instructionWindow.anchors.leftMargin = 100;
                    instructionWindow.anchors.bottomMargin = 150;
                    instructionText.text = "STAP 3/3\nHeel goed! \nKlik op de knoppen om de hoogte te matchen";
                    break;
                case(2):
                    ballExplained = true;
                    instructionWindow.anchors.rightMargin = Screen.width - instructionWindow.width - 100;
                    instructionWindow.anchors.bottomMargin = 150;
                    instructionText.text = "STAP 4/4\nHeel goed! \nKlik op de knoppen om de bochten aan te passen";
                    break;
                }
            }
        }
    }
}

