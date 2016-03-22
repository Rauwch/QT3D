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
        color: "#FFFFFF"
        width: (instructionText.paintedWidth + 40)
        height: (instructionText.paintedHeight + buttonNext.height + 30)

        border.width: 4
        border.color: "black"
        radius: 10
        visible: {stage <= numStages}
        gradient: Gradient {
            GradientStop { position: 0 ; color: "#D3D3D3" }
            GradientStop { position: 1 ; color: "#FFFFFF" }
        }

        Component.onCompleted: {
            setInstructionText();
        }
        Text{
            id:instructionText
            //anchors.leftMargin: 3
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            font.family: "Helvetica"
            font.pointSize: 12
        }
        Button{
            id:buttonNext
            visible: {stage <= numStages}
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: instructionText.bottom
            anchors.topMargin: 5
            style: ButtonStyle {
                label: Text {
                    text:"Volgende"
                    font.family: "Helvetica"
                    font.pointSize: 15
                }
                background: Rectangle {
                    border.width: 2
                    border.color: "black"
                    radius: 4
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: "#D3D3D3" }
                        GradientStop { position: 1 ; color: "#FFFFFF" }
                    }
                }
            }
            onClicked: {
                updateInstructions();
            }
        }

    }
    function setInstructionText(){
        switch(numberOfLevel){
        case(1):
            instructionWindow.anchors.centerIn = screenWindow;
            //instructionText.text = "Welcome to the first tutorial!";
            instructionText.text = "Welkom bij de 1ste oefening!";
            break;
        case(2):
            instructionWindow.anchors.centerIn = screenWindow;
            //instructionText.text = "Welcome to the second tutorial!";
            instructionText.text = "Welkom bij de 2de oefening!";
            break;
        case(3):
            instructionWindow.anchors.centerIn = screenWindow;
            //instructionText.text = "Welcome to the third tutorial!";
            instructionText.text = "Welkom bij de 3de oefening!";
            break;
        case(4):
            instructionWindow.anchors.centerIn = screenWindow;
            //instructionText.text = "Welcome to the fourth tutorial!";
            instructionText.text = "Welkom bij de 4de oefening!";
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
    function unAnchors(){
        instructionWindow.anchors.centerIn = undefined;
        instructionWindow.anchors.left = undefined;
        instructionWindow.anchors.top = undefined;
        instructionWindow.anchors.bottom = undefined;
        instructionWindow.anchors.right = undefined;
        instructionWindow.anchors.verticalCenter = undefined;
        instructionWindow.anchors.horizontalCenter = undefined;

    }

    function updateInstructionsLvlOne(){
        switch(stage){
        case(0):
            stage++;
            unAnchors();
            instructionWindow.anchors.horizontalCenter = screenWindow.horizontalCenter;
            instructionWindow.anchors.top = screenWindow.top;
            instructionWindow.anchors.topMargin = Screen.height/20
            instructionText.text = "<h3>STAP 1/3</h3><br></br>Deze <b>paarse paal</b> toont het <b>doel</b> van het spel aan.<br></br>De kwallen hebben jouw hulp nodig om op deze hoogte te kunnen zwemmen.";
            break;
        case(1):
            stage++;
            unAnchors();
            instructionWindow.anchors.verticalCenter = screenWindow.verticalCenter;
            instructionWindow.anchors.left = screenWindow.left;
            instructionWindow.anchors.leftMargin = Screen.width/20;
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
            unAnchors();
            instructionWindow.anchors.horizontalCenter = screenWindow.horizontalCenter;
            instructionWindow.anchors.top = screenWindow.top;
            instructionWindow.anchors.topMargin = Screen.height/5
            instructionText.text = "<h3>STAP 1/4</h3>Deze dikke <b>gele lijn</b> toont aan welke kwallen jouw hulp nodig hebben.";
            break;
        case(1):
            stage++;
            instructionWindow.anchors.topMargin = Screen.height/20
            instructionWindow.anchors.horizontalCenterOffset = Screen.width/10
            instructionText.text = "<h3>STAP 2/4</h3>De grootte van de <b>roze kwallen</b> en hun <b>grijs doel</b> staan hier aangeduid.";
            break;
        case(2):
            stage++;
            unAnchors();
            instructionWindow.anchors.verticalCenter = screenWindow.verticalCenter;
            instructionWindow.anchors.left = screenWindow.left;
            instructionWindow.anchors.leftMargin = Screen.width/20;
            instructionText.text = "<h3>STAP 3/4</h3>Je kan de <b>grootte van de kwallen</b> aanpassen <br></br>door de <b>hoogte van de lift</b> te veranderen.<br></br><u>Klik op de bol</u> van de lift en probeer het zelf.";
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
            unAnchors();
            instructionWindow.anchors.horizontalCenter = screenWindow.horizontalCenter;
            instructionWindow.anchors.top = screenWindow.top;
            instructionWindow.anchors.topMargin = Screen.height/20;
            instructionWindow.anchors.horizontalCenterOffset = Screen.width/8;
            instructionText.text = "<h3>STAP 1/4</h3>Deze <b>grijze kwal</b> toont dus <b>het doel</b> aan.";
            break;
        case(1):
            stage++;
            unAnchors();
            instructionWindow.anchors.verticalCenter = screenWindow.verticalCenter;
            instructionWindow.anchors.right = screenWindow.right;
            instructionWindow.anchors.rightMargin = Screen.width/10;
            instructionText.text = "<h3>STAP 2/4</h3>Kwallen gaan door de<br></br>paarse buizen naar beneden.<br></br>Hoe <b>scherper de bochten</b>, <br>hoe <b>kleiner de kwallen</b> moeten <br></br>zijn om erdoor te kunnen.";
            break;
        case(2):
            stage++;
            instructionText.text = "<h3>STAP 3/4</h3><u>Klik op de bal</u> om de scherpte<br></br>van de bochten aan te passen.";
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
            unAnchors();
            instructionWindow.anchors.horizontalCenter = screenWindow.horizontalCenter;
            instructionWindow.anchors.horizontalCenterOffset = Screen.width/8;
            instructionWindow.anchors.top = screenWindow.top;
            instructionWindow.anchors.topMargin = Screen.height/10;
            instructionText.text = "<h3>STAP 1/4</h3><b>Een grote kwal</b> kan splitsen<br></br> in <b>twee kleinere kwallen</b>.";
            break;
        case(1):
            stage++;
            unAnchors();
            instructionWindow.anchors.bottom = screenWindow.bottom;
            instructionWindow.anchors.bottomMargin = Screen.height/15;
            instructionWindow.anchors.left = screenWindow.left;
            instructionWindow.anchors.leftMargin = Screen.width/8;
            instructionText.text = "<h3>STAP 2/4</h3><b>Twee kleinere kwallen</b> kunnen samenvoegen<br></br> tot <b>een grote kwal</b>.";
            break;
        case(2):
            stage++;
            instructionText.text = "<h3>STAP 3/4</h3>Kijk nu wat er gebeurt als je <br></br>de scherpte van de bochten aanpast.";
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
                    unAnchors();
                    instructionWindow.anchors.bottom = screenWindow.bottom;
                    instructionWindow.anchors.bottomMargin = Screen.width/10;
                    instructionWindow.anchors.left = screenWindow.left;
                    instructionWindow.anchors.leftMargin = Screen.width/20;
                    instructionText.text = "<h3>STAP 3/3</h3>Heel goed! <br></br>Klik op de knoppen om de hoogte te matchen.";
                    break;
                case(2):
                    ballExplained = true;
                    unAnchors();
                    instructionWindow.anchors.bottom = screenWindow.bottom;
                    instructionWindow.anchors.bottomMargin = Screen.width/10;
                    instructionWindow.anchors.left = screenWindow.left;
                    instructionWindow.anchors.leftMargin = Screen.width/20;
                    instructionText.text = "<h3>STAP 4/4</h3>Heel goed! <br></br>Klik op de knoppen om de hoogte aan te passen.";
                    break;
                case(3):
                    ballExplained = true;
                    unAnchors();
                    instructionWindow.anchors.bottom = screenWindow.bottom;
                    instructionWindow.anchors.bottomMargin = Screen.width/10;
                    instructionWindow.anchors.left = screenWindow.left;
                    instructionWindow.anchors.leftMargin = Screen.width/20;
                    instructionText.text = "<h3>STAP 4/4</h3>Heel goed! <br></br>Klik op de knoppen om de bochten aan te passen.";
                    break;
                case(4):
                    ballExplained = true;
                    unAnchors();
                    instructionWindow.anchors.bottom = screenWindow.bottom;
                    instructionWindow.anchors.bottomMargin = Screen.width/10;
                    instructionWindow.anchors.left = screenWindow.left;
                    instructionWindow.anchors.leftMargin = Screen.width/20;
                    instructionText.text = "<h3>STAP 4/4</h3>Heel goed! <br></br>Probeer nu de inktvissen op de <br></br>dikke lijn de juiste grootte te geven.";
                    break;
                }


            }
        }
    }
    function setTextInvis(){
        instructionWindow.visible=false;
    }
}

