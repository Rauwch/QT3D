import QtQuick 2.5
import QtQuick.Controls 1.2
import QtQuick.Window 2.0
import QtQuick.Controls.Styles 1.4
Rectangle{
    id: screenWindow
    property int stage: 0
    property int numStages: 2
    property int offset: buttonNext.height
    property bool ballExplained: false
    property int numberOfLevel: 1
    property QtObject test
    color: "transparent"
    width: Screen.width
    height: Screen.height
    visible: {stage <= numStages}

    TextMetrics {
        id: textMetrics
        font.family: "Arial"
        font.pixelSize: 50

    }
    Rectangle{
        id:instructionWindow
        color:"white"
        width: Screen.width/3
        height: instructionText.height + buttonNext.height + 30
        visible: {stage <= numStages}

        Component.onCompleted: {
            myGameScreen.setPopupWindowForTutorial(numberOfLevel);
            setInstructionText();
        }
        Text{
            id:instructionText
            width: parent.width
            wrapMode: Text.WordWrap
            anchors.leftMargin: 3
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
        }
        Button{
            id:buttonNext
            visible: {stage <= numStages}
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: instructionText.bottom
            anchors.topMargin: 5
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
            instructionText.text = "Welcome to the first tutorial!";
            break;
        case(2):
            instructionWindow.anchors.left = screenWindow.left;
            instructionWindow.anchors.bottom = screenWindow.bottom;
            instructionWindow.anchors.leftMargin = (Screen.width/2 - instructionWindow.width/2);
            instructionWindow.anchors.bottomMargin = (Screen.height/2 - instructionWindow.height/2);
            instructionText.text = "Welcome to the second tutorial!";
            break;
        case(3):
            instructionWindow.anchors.right = screenWindow.right;
            instructionWindow.anchors.bottom = screenWindow.bottom;
            instructionWindow.anchors.rightMargin = (Screen.width/2 - instructionWindow.width/2);
            instructionWindow.anchors.bottomMargin = (Screen.height/2 - instructionWindow.height/2);
            instructionText.text = "Welcome to the third tutorial!";
            break;
        case(4):
            instructionWindow.anchors.right = screenWindow.right;
            instructionWindow.anchors.bottom = screenWindow.bottom;
            instructionWindow.anchors.rightMargin = (Screen.width/2 - instructionWindow.width/2);
            instructionWindow.anchors.bottomMargin = (Screen.height/2 - instructionWindow.height/2);
            instructionText.text = "Welcome to the fourth tutorial!";
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
        case(3):
            numStages = 3;
            updateInstructionsLvlThree();
            break;
        case(4):
            numStages = 3;
            updateInstructionsLvlFour();
            break;
        }
    }
    function updateInstructionsLvlOne(){

        switch(stage){
        case(0):
            stage++;
            instructionWindow.anchors.bottomMargin = Screen.height*4/5;
            instructionWindow.anchors.leftMargin = Screen.width/2 - instructionWindow.width/2;
            instructionText.text = "<h3>STAP 1/3</h3><br></br>Deze <b>paarse paal</b> toont het <b>doel</b> van het spel aan.<br></br>De kwallen hebben jouw hulp nodig om op deze hoogte te kunnen zwemmen.";
            break;
        case(1):
            stage++;
            instructionWindow.anchors.bottomMargin = (Screen.height/2 - instructionWindow.height/2);
            instructionWindow.anchors.leftMargin = 100;
            instructionText.text = "<h3>STAP 2/3</h3><br></br>De <b>grijze paal</b> is de <b>kwallenlift</b>.<br></br><u>Klik op de bol</u> om de hoogte te veranderen";
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
            instructionWindow.anchors.leftMargin = Screen.width*3/5 - instructionWindow.width/2;
            instructionWindow.anchors.bottomMargin = Screen.height*2/3;
            instructionText.text = "<h3>STAP 1/4</h3>Deze dikke <b>gele lijn</b> toont aan welke kwallen jou hulp nodig hebben.";
            break;
        case(1):
            stage++;
            instructionWindow.anchors.leftMargin = Screen.width*3/5 - instructionWindow.width/2;
            instructionWindow.anchors.bottomMargin = (Screen.height*9/10 - instructionWindow.height/2);
            instructionText.text = "<h3>STAP 2/4</h3>De grootte van de <b>roze kwallen</b> en hun <b>grijs doel</b> staan hier aangeduid.";
            break;
        case(2):
            stage++;
            instructionWindow.anchors.leftMargin = 100;
            instructionWindow.anchors.bottomMargin = (Screen.height/2 - instructionWindow.height/2);
            instructionText.text = "<h3>STAP 3/4</h3>Je kan de <b>grootte van de kwallen</b> aanpassen door de <b>hoogte van de lift</b> te veranderen.<br></br><u>Klik op de bol</u> van de lift en probeer het zelf.";
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
    function updateInstructionsLvlThree(){

        switch(stage){
        case(0):
            stage++;
            instructionWindow.anchors.rightMargin = Screen.width*2/5 - instructionWindow.width/2;
            instructionWindow.anchors.bottomMargin = (Screen.height*9/10 - instructionWindow.height/2);
            instructionText.text = "<h3>STAP 1/4</h3>Deze kwal toont dus aan hoe groot hij moet worden.";
            break;
        case(1):
            stage++;
            instructionWindow.anchors.bottomMargin = (Screen.height/2 - instructionWindow.height/2);
            instructionWindow.anchors.rightMargin =  Screen.width*1/5 - instructionWindow.width/2;
            instructionText.text = "<h3>STAP 2/4</h3>Kwallen gaan door de paarse buizen naar beneden<br></br>Hoe <b>scherper de bochten</b>, hoe <b>kleiner de kwallen</b> moeten zijn om erdoor te kunnen.";
            break;
        case(2):
            stage++;
            instructionText.text = "<h3>STAP 3/4</h3><u>Klik op de bal</u> om de scherpte van de bochten aan te passen.";
            buttonNext.visible = false;
            break;
        case(numStages):
            if(ballExplained){
                stage++;
                instructionText.text = "Thank you for completing the third tutorial!";
            }
            break;
        default:
            instructionWindow.anchors.leftMargin = (Screen.width/2 - instructionWindow.width/2);
            instructionWindow.anchors.bottomMargin = (Screen.height/2 - instructionWindow.height/2);
            break;
        }
    }
    function updateInstructionsLvlFour(){

        switch(stage){
        case(0):
            stage++;
            instructionWindow.anchors.rightMargin = Screen.width*2/5 - instructionWindow.width/2;
            instructionWindow.anchors.bottomMargin = (Screen.height*9/10 - instructionWindow.height/2);
            instructionText.text = "<h3>STAP 1/4</h3>Vanboven zien we wat er gebeurt als een kwal zijn pad in 2 deelt<br></br>De grote kwal wordt <b>gesplitst in twee kleinere kwallen</b>.";
            break;
        case(1):
            stage++;
            instructionWindow.anchors.rightMargin = Screen.width*5/6 - instructionWindow.width/2;
            instructionWindow.anchors.bottomMargin = (Screen.height/2 - instructionWindow.height/2);
            instructionText.text = "<h3>STAP 2/4</h3>Vanonder zien we wat er gebeurt als de paden van 2 kwallen bij elkaar komen<br></br>De twee kleine kwallen <b>maken samen één grote kwal</b>.";
            break;
        case(2):
            stage++;
            instructionText.text = "<h3>STAP 3/4</h3>Kijk nu wat er gebeurt als je de scherpte van de bochten aanpast";
            buttonNext.visible = false;
            break;
        case(numStages):
            if(ballExplained){
                stage++;
                instructionText.text = "Thank you for completing the fourth tutorial!";
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
                    instructionText.text = "<h3>STAP 3/3</h3>Heel goed! <br></br>Klik op de knoppen om de hoogte te matchen.";
                    break;
                case(2):
                    ballExplained = true;
                    instructionWindow.anchors.rightMargin = Screen.width - instructionWindow.width - 100;
                    instructionWindow.anchors.bottomMargin = 150;
                    instructionText.text = "<h3>STAP 4/4</h3>Heel goed! <br></br>Klik op de knoppen om de hoogte aan te passen.";
                    break;
                case(3):
                    ballExplained = true;
                    instructionWindow.anchors.rightMargin = Screen.width - instructionWindow.width - 100;
                    instructionWindow.anchors.bottomMargin = 150;
                    instructionText.text = "<h3>STAP 4/4</h3>Heel goed! <br></br>Klik op de knoppen om de bochten aan te passen.";
                    break;
                case(4):
                    ballExplained = true;
                    instructionWindow.anchors.rightMargin = Screen.width - instructionWindow.width - 100;
                    instructionWindow.anchors.bottomMargin = 150;
                    instructionText.text = "<h3>STAP 4/4</h3>Heel goed! <br></br>Probeer nu de inktvissen op de dikke lijn de juiste grootte te geven.";
                    break;
                }


            }
        }
    }
}

