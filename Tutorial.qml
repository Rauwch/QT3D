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
    property int textFontSize: 10
    property int buttonFontSize:10
    property int buttonHeight
    property int screenType:0 //1==tablet
    property QtObject test
    color: "transparent"
    width: Screen.width
    height: Screen.height
    visible: false

    Rectangle{
        id:instructionWindow
        color: "#FFFFFF"
        width: (instructionText.paintedWidth + 40)
        height: (instructionText.paintedHeight + buttonNext.height + 50)

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
            font.pointSize: textFontSize
        }
        Button{

            id:buttonNext
            visible: {stage <= numStages}
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: instructionText.bottom
            anchors.topMargin: 10
            height: buttonHeight
            width: nextText.width + 20
            Text {
                id:nextText
                anchors.centerIn: parent
                text:"Volgende"
                verticalAlignment: Text.AlignVCenter
                //anchors.verticalCenter: buttonNext.verticalCenter
                font.family: "Helvetica"
                font.pointSize: buttonFontSize
            }
            style: ButtonStyle {
                background: Rectangle {
                    border.width: control.activeFocus ? 4 : 2

                    border.color: "#063e79"
                    radius: 10
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: control.pressed ? "#479af5" : "#2589f4" }
                        GradientStop { position: 1 ; color: control.pressed ? "#2589f4" : "#0b6fda" }
                    }
                }
            }
            onClicked: {
                updateInstructions();
            }
        }

    }
    function setInstructionText(){
        var physScreenSize = myGameScreen.getPhysicalScreenWidth();
        //console.log("screensize: " + physScreenSize);
        if(physScreenSize >= 300){
            textFontSize = 12;
            buttonFontSize = 15;
            buttonHeight = 50;
        }
        else if(physScreenSize >= 200){
            textFontSize = 15;
            buttonFontSize = 18;
        }
        else{
            textFontSize = 18;
            buttonFontSize = 21;
            buttonHeight = 90;
            screenType = 1;

        }
        //console.log("fontsize " + instructionText.font.pointSize);

        switch(numberOfLevel){
        case(1):
            instructionWindow.anchors.centerIn = screenWindow;
            //instructionText.text = "Welcome to the first tutorial!";
            instructionText.text = "Welkom bij de 1ste oefening!";
            break;
        case(4):
            instructionWindow.anchors.centerIn = screenWindow;
            //instructionText.text = "Welcome to the second tutorial!";
            instructionText.text = "Welkom bij de 2de oefening!";
            break;
        case(7):
            instructionWindow.anchors.centerIn = screenWindow;
            //instructionText.text = "Welcome to the third tutorial!";
            instructionText.text = "Welkom bij de 3de oefening!";
            break;
        case(13):
            instructionWindow.anchors.centerIn = screenWindow;
            //instructionText.text = "Welcome to the fourth tutorial!";
            instructionText.text = "Welkom bij de 4de oefening!";
            break;

        case(15):
            instructionWindow.anchors.centerIn = screenWindow;
            //instructionText.text = "Welcome to the fifth tutorial!";
            instructionText.text = "Welkom bij de 5de oefening!";
            break;
        }
    }
    function updateInstructions(){
        switch(numberOfLevel){
        case(1):
            numStages = 2;
            updateInstructionsLvlOne();
            break;
        case(4):
            numStages = 3;
            updateInstructionsLvlTwo();
            break;
        case(7):
            numStages = 3;
            updateInstructionsLvlThree();
            break;
        case(13):
            numStages = 3;
            updateInstructionsLvlFour();
            break;
        case(15):
            numStages = 1;
            updateInstructionsLvlFive();
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
            if(screenType == 1){
                instructionWindow.anchors.horizontalCenterOffset = Screen.width/4;
            }
            instructionWindow.anchors.top = screenWindow.top;
            instructionWindow.anchors.topMargin = Screen.height/20
            instructionText.text = "<strong><u>STAP 1/3</u></strong><br></br>Deze <b>rode paal</b> toont het <b>doel</b> van het spel aan.<br></br>De kwallen hebben jouw hulp nodig om op deze <b>hoogte</b> te kunnen zwemmen.";
            if(screenType == 1){
                instructionText.text = "<strong><u>STAP 1/3</u></strong><br></br>Deze <b>rode paal</b> toont<br></br>het <b>doel</b> van het spel aan.<br></br>De kwallen hebben jouw<br></br>hulp nodig om op deze<br></br><b>hoogte</b> te kunnen zwemmen.";
            }
            break;
        case(1):
            stage++;
            unAnchors();
            instructionWindow.anchors.verticalCenter = screenWindow.verticalCenter;
            instructionWindow.anchors.left = screenWindow.left;
            instructionWindow.anchors.leftMargin = Screen.width/20;
            instructionText.text = "<strong><u>STAP 2/3</u></strong><br></br>De <b>grijze paal</b> is de <b>kwallenlift</b>.<br></br><i>Klik op de bol</i> om het lift menu te openen";
            if(screenType == 1){
                instructionText.text = "<strong><u>STAP 2/3</u></strong><br></br>De <b>grijze paal</b> is de <b>kwallenlift</b>.<br></br><i>Klik op de bol</i> om het <br></br>lift menu te openen";
            }
            buttonNext.visible = false;
            instructionWindow.height = instructionText.paintedHeight + 50;

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
            if(screenType==1){
                instructionWindow.anchors.topMargin = Screen.height/15

            }
            instructionText.text = "<strong><u>STAP 1/4</u></strong><br></br>De dikke <b>rode lijn</b> toont aan welke kwallen jouw hulp nodig hebben.";
            break;
        case(1):
            stage++;
            instructionWindow.anchors.topMargin = Screen.height/20
            instructionWindow.anchors.horizontalCenterOffset = Screen.width/10
            instructionText.text = "<strong><u>STAP 2/4</u></strong><br></br>Deze kwallen moeten even groot worden als de <b>grijze kwal</b>.";
            break;
        case(2):
            stage++;
            unAnchors();
            instructionWindow.anchors.verticalCenter = screenWindow.verticalCenter;
            instructionWindow.anchors.left = screenWindow.left;
            instructionWindow.anchors.leftMargin = Screen.width/20;
            instructionText.text = "<strong><u>STAP 3/4</u></strong><br></br>Je kan de <b>grootte van de kwallen</b> aanpassen <br></br>door de <b>hoogte van de lift</b> te veranderen.<br></br><i>Klik op de bol</i> van de lift en probeer het zelf.";
            if(screenType == 1){
                instructionText.text = "<strong><u>STAP 3/4</u></strong><br></br>Je kan de <b>grootte van</b><br></br><b>de kwallen</b> aanpassen <br></br>door de <b>hoogte van</b><br></br><b>de lift</b> te veranderen.<br></br><i>Klik op de bol</i> van de lift<br></br>en probeer het zelf.";
            }
            buttonNext.visible = false;
            instructionWindow.height = instructionText.paintedHeight + 30;
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
            instructionText.text = "<strong><u>STAP 1/4</u></strong><br></br>Deze <b>grijze kwal</b> toont dus de <b>gewenste grootte</b>.";
            break;
        case(1):
            stage++;
            unAnchors();
            instructionWindow.anchors.verticalCenter = screenWindow.verticalCenter;
            instructionWindow.anchors.right = screenWindow.right;
            if(screenType !== 1){
                instructionWindow.anchors.rightMargin = Screen.width/10;
            }
            instructionText.text = "<strong><u>STAP 2/4</u></strong><br></br>Kwallen gaan door de<br></br>paarse buizen naar beneden.<br></br>Hoe <b>scherper de bochten</b>, <br>hoe <b>kleiner de kwallen</b> moeten <br></br>zijn om erdoor te kunnen.";
            break;
        case(2):
            stage++;
            instructionText.text = "<strong><u>STAP 3/4</u></strong><br></br><i>Klik op de bal</i> om de scherpte<br></br>van de bochten aan te passen.";
            buttonNext.visible = false;
            instructionWindow.height = instructionText.paintedHeight + 30;
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
            instructionWindow.anchors.horizontalCenterOffset = Screen.width/6;
            instructionWindow.anchors.top = screenWindow.top;
            if(screenType !== 1){
                instructionWindow.anchors.horizontalCenterOffset = Screen.width/8;
                instructionWindow.anchors.topMargin = Screen.height/10;
            }
            instructionText.text = "<strong><u>STAP 1/4</u></strong><br></br><b>Een grote kwal</b> kan splitsen<br></br> in <b>twee kleinere kwallen</b>.";
            break;
        case(1):
            stage++;
            unAnchors();
            instructionWindow.anchors.bottom = screenWindow.bottom;
            instructionWindow.anchors.bottomMargin = Screen.height/15;
            instructionWindow.anchors.left = screenWindow.left;
            instructionWindow.anchors.leftMargin = Screen.width/8;
            if(screenType == 1){
                instructionWindow.anchors.leftMargin = Screen.width/24;
            }
            instructionText.text = "<strong><u>STAP 2/4</u></strong><br></br><b>Twee kleinere kwallen</b> kunnen<br></br>samenvoegen tot <b>een grote kwal</b>.";
            break;
        case(2):
            stage++;
            instructionText.text = "<strong><u>STAP 3/4</u></strong><br></br>Pas nu <br></br>de scherpte van de bochten aanpast.";
            buttonNext.visible = false;
            instructionWindow.height = instructionText.paintedHeight + 30;
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

    function updateInstructionsLvlFive(){

        switch(stage){
        case(0):
            stage++;
            unAnchors();
            instructionWindow.anchors.horizontalCenter = screenWindow.horizontalCenter;
            instructionWindow.anchors.horizontalCenterOffset = Screen.width/6;
            instructionWindow.anchors.top = screenWindow.top;
            if(screenType !== 1){
                instructionWindow.anchors.horizontalCenterOffset = Screen.width/8;
                instructionWindow.anchors.topMargin = Screen.height/10;
            }
            instructionText.text = "<strong><u>STAP 1/2</u></strong><br></br>Dit is <b>een brug</b> die <b>open</b> en <b>toe</b> kan<br></br> Klik op een van de de ballen om<br></br> de <b>brug menu</b> te openen.";
            buttonNext.visible = false;
            instructionWindow.height = instructionText.paintedHeight + 50;
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
            if(myGameScreen.showSwitch == true){
                buttonNext.visible = false;
                instructionWindow.height = 132*(screenType+1);;
                ballExplained = true;
                unAnchors();
                instructionWindow.anchors.bottom = screenWindow.bottom;
                instructionWindow.anchors.bottomMargin = Screen.width/20;
                instructionWindow.anchors.right = screenWindow.right;
                instructionWindow.anchors.rightMargin = Screen.width/4;
                instructionText.text = "<strong><u>STAP 2/2</u></strong><br></br>Heel goed! <br></br><i>Klik op de knoppen</i> om<br></br>de brug te veranderen.";
            }
            if((myGameScreen.clickedSource != null)){
                switch(numberOfLevel){
                case(1):
                    buttonNext.visible = false;
                    instructionWindow.height = 132*(screenType+1);
                    ballExplained = true;
                    unAnchors();
                    instructionWindow.anchors.bottom = screenWindow.bottom;
                    instructionWindow.anchors.bottomMargin = Screen.width/20;
                    instructionWindow.anchors.right = screenWindow.right;
                    instructionWindow.anchors.rightMargin = Screen.width/8;
                    instructionText.text = "<strong><u>STAP 3/3</u></strong><br></br>Heel goed! <br></br><i>Klik op de knoppen</i> om<br></br>het niveau te veranderen.";
                    break;
                case(4):
                    buttonNext.visible = false;
                    instructionWindow.height = 132*(screenType+1);;
                    ballExplained = true;
                    unAnchors();
                    instructionWindow.anchors.bottom = screenWindow.bottom;
                    instructionWindow.anchors.bottomMargin = Screen.width/20;
                    instructionWindow.anchors.right = screenWindow.right;
                    instructionWindow.anchors.rightMargin = Screen.width/8;
                    instructionText.text = "<strong><u>STAP 4/4</u></strong><br></br>Heel goed! <br></br><i>Klik op de knoppen</i> om<br></br>het niveau te veranderen.";
                    break;
                case(7):
                    buttonNext.visible = false;
                    instructionWindow.height = 132*(screenType+1);
                    ballExplained = true;
                    unAnchors();
                    instructionWindow.anchors.bottom = screenWindow.bottom;
                    instructionWindow.anchors.bottomMargin = Screen.width/20;
                    instructionWindow.anchors.right = screenWindow.left;
                    instructionWindow.anchors.rightMargin = Screen.width/8;
                    instructionText.text = "<strong><u>STAP 4/4</u></strong><br></br>Heel goed! <br></br><i>Klik op de knoppen</i> om<br></br>de bochten te veranderen.";
                    break;
                case(13):
                    buttonNext.visible = false;
                    instructionWindow.height = 132*(screenType+1);
                    ballExplained = true;
                    unAnchors();
                    instructionWindow.anchors.bottom = screenWindow.bottom;
                    instructionWindow.anchors.bottomMargin = Screen.width/20;
                    instructionWindow.anchors.right = screenWindow.right;
                    instructionWindow.anchors.rightMargin = Screen.width/8;
                    instructionText.text = "<strong><u>STAP 4/4</u></strong><br></br>Heel goed! <br></br>Probeer nu de kwallen op de <br></br>rode lijn de juiste grootte te geven.";
                    if(screenType == 1){
                        instructionText.text = "<strong><u>STAP 4/4</u></strong><br></br>Heel goed! <br></br>Probeer nu de kwallen<br></br>op de rode lijn<br></br>de juiste grootte te geven.";
                    }
                    break;
//                case(15):
//                    buttonNext.visible = false;
//                    instructionWindow.height = 132*(screenType+1);;
//                    ballExplained = true;
//                    unAnchors();
//                    instructionWindow.anchors.bottom = screenWindow.bottom;
//                    instructionWindow.anchors.bottomMargin = Screen.width/20;
//                    instructionWindow.anchors.right = screenWindow.right;
//                    instructionWindow.anchors.rightMargin = Screen.width/8;
//                    instructionText.text = "<strong><u>STAP 2/2</u></strong><br></br>Heel goed! <br></br><i>Klik op de knoppen</i> om<br></br>de brug te veranderen.";
//                    break;
                    //add new case
                }


            }
        }
    }
    function setTextInvis(){
        instructionWindow.visible=false;
    }

    function getPhysicalScreenWidth(){
        if( calculator.getPhysicalScreenWidth() === 0){
            console.log("ERROR: physical screen width is equal to 0")
        }
        return calculator.getPhysicalScreenWidth();
    }
}

