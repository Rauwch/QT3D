import Qt3D.Core 2.0
import Qt3D.Logic 2.0
import QtQuick 2.3 as QQ2


//Object dat verantwoordelijk is voor bouwen van circuits
Entity{
    id:root
    //size of each coordinate step
    property real sf:5

    /* all the arrays where all the 3D components are stored */
    property var sources:[]
    property var resistors :[]
    property var wires: []
    property var poles: []
    property var goals: []
    property var switches:[]
    property var bendValues: [0,35,50,65,75]

    property bool switchClicked: false

    QQ2.QtObject{
        id:o

        /* all object factories */
        property var sourceFactory
        property var resistorFactory
        property var wireFactory
        property var poleFactory
        property var goalFactory
        property var switchFactory
    }



    function completed() {
        console.log("generator completed");
        console.log("this is the current level: " + myLevels.getCurrentLevel() );
        myGameScreen.calculator.readFile(":/assets/Levels/inputfile_" + myLevels.getCurrentLevel() + ".sj");
        initializeLevel();
        calculator.updateResistors();
        calculator.updateSources();
        buildLevel();
    }

    /* set all the values of the goals */
    function initializeLevel(){
        myGameScreen.calculator.solveLevel();
        for( var i =0;i < myGameScreen.calculator.getNumberOfGoals();i++)
        {
            myGameScreen.calculator.setVoltageAtGoal(i,myGameScreen.calculator.voltageAtNode(myGameScreen.calculator.nodeAtGoal(i)));
        }
        myGameScreen.calculator.setCurrentsOfWires();
        myGameScreen.calculator.storeCurrentGoals();
    }

    /* create the 3D world */
    function buildLevel()
    {
        var source,resistor, mySwitch, wire, pole, goalPole;
        var negNode;
        var maxVolt, minVolt, angle ,length;
        var xDif, zDif, polePosition;


        myGameScreen.calculator.solveLevel();
        myGameScreen.initializeJellies();
        myGameScreen.setVisibilityJellies();
        myGameScreen.calculateSize();



        /* initialize all factoris */
        o.sourceFactory=Qt.createComponent("Source.qml");
        o.resistorFactory=Qt.createComponent("BentResistor.qml");
        o.wireFactory=Qt.createComponent("Wire.qml");
        o.poleFactory=Qt.createComponent("Pole.qml");
        o.goalFactory= Qt.createComponent("GoalPole.qml");
        o.switchFactory= Qt.createComponent("Switch.qml");

        /* build all the sources in the level */
        for(var i=0;i<calculator.getNumberOfSources();i++){
            negNode = calculator.nodeMAtSource(i);
            source = o.sourceFactory.createObject(null,{"sourceNr": i,
                                                      "s":calculator.getVoltageAtSource(i),
                                                      "x":calculator.getXCoordOfSource(i)*root.sf,
                                                      "z":-calculator.getYCoordOfSource(i)*root.sf,
                                                      "y":calculator.voltageAtNode(negNode),
                                                      "clickable": calculator.getSourceIsVariable(i),
                                                      "eSize": calculator.getCurrentofWire(i)});
            source.parent=root.parent;
            source.setButtonValues(calculator.getInitialOfSource(i), calculator.getStepOfSource(i), calculator.getButtonDiffOfSource(i));
            root.sources[i]=source;
        }

        /* build all the resistors */
        for( i=0;i<calculator.getNumberOfResistors();i++){

            /*calculate the voltage at the top and bottom of the resistor */
            minVolt = Math.min(calculator.voltageAtNode(calculator.node1AtResistor(i)),calculator.voltageAtNode(calculator.node2AtResistor(i)));
            maxVolt = Math.max(calculator.voltageAtNode(calculator.node1AtResistor(i)),calculator.voltageAtNode(calculator.node2AtResistor(i)));

            /* Angle of the resistor */
            angle = Math.atan2(root.sf,(minVolt-maxVolt));

            //Lengte van de weerstand
            length = Math.abs(((maxVolt-minVolt))/Math.cos(angle));

            resistor = o.resistorFactory.createObject(null,{"a":(angle*180/Math.PI),
                                                          "resistorNr": i,
                                                          "l":length,
                                                          "s":calculator.resistanceAtResistor(i),
                                                          "x":calculator.getXCoordOfResistor(i)*root.sf,
                                                          "z":-calculator.getYCoordOfResistor(i)*root.sf,
                                                          "y":minVolt,
                                                          "clickable": calculator.getResistorIsVariable(i),
                                                          "orientationAngle":90*(calculator.getAngleOfResistor(i)-1) });

            resistor.parent=root.parent;
            resistor.setButtonValues(calculator.getInitialOfResistor(i),calculator.getStepOfResistor(i),calculator.getButtonDiffOfResistor(i));
            root.resistors[i]=resistor;
            root.resistors[i].makeBends();
        }


        /* build all the switches */
        for(i = 0; i < calculator.getNumberOfSwitches(); i++)
        {
            maxVolt = Math.max(calculator.voltageAtNode(calculator.node1AtSwitch(i)),calculator.voltageAtNode(calculator.node2AtSwitch(i)));
            minVolt = Math.min(calculator.voltageAtNode(calculator.node1AtSwitch(i)),calculator.voltageAtNode(calculator.node2AtSwitch(i)));

            mySwitch = o.switchFactory.createObject(null,{"switchNr": i,
                                                        "x": calculator.getXCoordOfSwitch(i)*root.sf,
                                                        "z": -calculator.getYCoordOfSwitch(i)*root.sf,
                                                        "yMax": maxVolt,
                                                        "yMin": minVolt,
                                                        "orientationAngle": 90*(calculator.getAngleOfSwitch(i)-1)});

            mySwitch.parent=root.parent;
            root.switches[i]=mySwitch;

        }

        /*build all the wires*/
        for(i=0;i<calculator.getNumberOfWires();i++)
        {
            wire = o.wireFactory.createObject(null,{"x":calculator.getXCoordOfWire(i)*root.sf,
                                                  "z":-calculator.getYCoordOfWire(i)*root.sf,
                                                  "y":calculator.voltageAtNode(calculator.getNodeOfWire(i)),
                                                  "l":calculator.getLengthOfWire(i)*root.sf,
                                                  "orientationAngle":90*(calculator.getAngleOfWire(i)-1),
                                                  "eSize": calculator.getCurrentofWire(i),
                                                  "sf":root.sf,
                                                  "isGoal":calculator.getGoalCurrent(i)});
            wire.parent=root.parent;
            root.wires[i]=wire;
            root.wires[i].spawnElectrons();
        }

        /*Build all the poles */
        polePosition = 0
        for(i=0; i<calculator.getNumberOfWires(); i++)
        {

            pole = o.poleFactory.createObject(null, {"x":calculator.getXCoordOfWire(i)*root.sf,
                                                  "z":-calculator.getYCoordOfWire(i)*root.sf,
                                                  "y":calculator.voltageAtNode(calculator.getNodeOfWire(i)),
                                                  "nodeOfWire": calculator.getNodeOfWire(i)});
            pole.parent=root.parent;
            root.poles[polePosition]=pole;
            polePosition++;
            //orientationangle
            xDif= 0;
            zDif= 0;
            switch(90*(calculator.getAngleOfWire(i)-1)){
            case(0):
                xDif = calculator.getLengthOfWire(i)*root.sf;
                break;
            case(90):
                zDif = -calculator.getLengthOfWire(i)*root.sf;
                break;
            case(180):
                xDif = -calculator.getLengthOfWire(i)*root.sf;
                break;
            case(270):
                zDif = calculator.getLengthOfWire(i)*root.sf;
                break;
            default:
                break;

            }
            pole = o.poleFactory.createObject(null, {"x":calculator.getXCoordOfWire(i)*root.sf + xDif,
                                                  "z":-calculator.getYCoordOfWire(i)*root.sf + zDif,
                                                  "y":calculator.voltageAtNode(calculator.getNodeOfWire(i)),
                                                  "nodeOfWire": calculator.getNodeOfWire(i)});

            pole.parent=root.parent;
            root.poles[polePosition]=pole;
            polePosition++;
        }
        /* build all goal poles */
        for (i = 0; i<calculator.getNumberOfGoals(); i++)
        {
            goalPole = o.goalFactory.createObject(null,{"x":calculator.getXCoordOfGoal(i)*root.sf,
                                                      "z":-calculator.getYCoordOfGoal(i)*root.sf,
                                                      "y":calculator.getVoltageAtGoal(i)});

            goalPole.parent=root.parent;
            root.goals[i]=goalPole;
        }
    }

    /* if the voltage in a node is the same as the goal voltage, the GoalPole will color green */
    function updateGoalPoles(){
        for( var i = 0; i< goals.length; i++){
            if( calculator.getMatch(i)){
                goals[i].setGreen();
            }
            else{
                goals[i].setRed();
            }
        }
    }
    function changeRes(resNr, pos)
    {
        resistors[resNr].bendIntensity = pos;
        resistors[resNr].angleOfBends = bendValues[resistors[resNr].bendIntensity]
    }

    function increaseRes(resNr){
        resistors[resNr].bendIntensity = resistors[resNr].bendIntensity + 1;
        resistors[resNr].angleOfBends = bendValues[resistors[resNr].bendIntensity];
    }
    function decreaseRes(resNr){
        resistors[resNr].bendIntensity = resistors[resNr].bendIntensity - 1;
        resistors[resNr].angleOfBends = bendValues[resistors[resNr].bendIntensity];
    }
    function increaseVolt(sourceNr){
        sources[sourceNr].heightIntensity = sources[sourceNr].heightIntensity + 1;
    }
    function decreaseVolt(sourceNr){
        sources[sourceNr].heightIntensity = sources[sourceNr].heightIntensity - 1;
    }


    /* update the 3D objects in the world */
    function updateLevel(){
        var minVolt, maxVolt, angle, length;
        var Icurrent, Igoal;
        /*update sources */
        for( var i= 0; i <sources.length; i++)
        {
            sources[i].s = calculator.getVoltageAtSource(i);
            sources[i].y = calculator.voltageAtNode(calculator.nodeMAtSource(i));
        }

        /* update resistors */
        for( i= 0; i <resistors.length; i++)
        {
            minVolt = Math.min(calculator.voltageAtNode(calculator.node1AtResistor(i)),calculator.voltageAtNode(calculator.node2AtResistor(i)));
            maxVolt = Math.max(calculator.voltageAtNode(calculator.node1AtResistor(i)),calculator.voltageAtNode(calculator.node2AtResistor(i)));

            /*Angle of the resistor */
            angle = Math.atan2(root.sf,(minVolt-maxVolt));

            /*Length of the resistor */
            length = Math.abs(((maxVolt-minVolt))/Math.cos(angle));

            resistors[i].updateOldBends();
            resistors[i].a = angle*180/Math.PI;
            resistors[i].l = length;
            resistors[i].s = calculator.resistanceAtResistor(i);
            resistors[i].x = calculator.getXCoordOfResistor(i)*root.sf;
            resistors[i].z = -calculator.getYCoordOfResistor(i)*root.sf;
            resistors[i].y = minVolt;
            resistors[i].updateBends();
            resistors[i].storeBends();
            resistors[i].updateBal();
        }

        /* update wires */
        for(  i= 0; i <wires.length; i++)
        {
            wires[i].y = calculator.voltageAtNode(calculator.getNodeOfWire(i));
            if(wires[i].isGoal)
            {
                Icurrent = calculator.getCurrentInGoalWire();
                Igoal = calculator.getGoalinGoalWire();
                if(Icurrent === Igoal)
                {
                    wires[i].match = true;
                    wires[i].toColor();
                }
            }
            wires[i].eSize = calculator.getCurrentofWire(i)*1000;
            for(var j = 0; j < wires[i].electrons.length; j++)
            {
                wires[i].electrons[j].s = calculator.getCurrentofWire(i);
            }
        }

        /* update poles */
        for( i = 0; i < poles.length; i++)
        {
            poles[i].y = calculator.voltageAtNode(poles[i].nodeOfWire);
        }

        /* update switches */

        for( i = 0; i < switches.length; i++)
        {
            maxVolt = Math.max(calculator.voltageAtNode(calculator.node1AtSwitch(i)),calculator.voltageAtNode(calculator.node2AtSwitch(i)));
            minVolt = Math.min(calculator.voltageAtNode(calculator.node1AtSwitch(i)),calculator.voltageAtNode(calculator.node2AtSwitch(i)));

            switches[i].yMax =maxVolt;
            switches[i].yMin =minVolt;
            if(switches[i].switchIsOpen)
                switches[i].yCenter = switches[i].yMax + switches[i].length/2
            else
                switches[i].yCenter = switches[i].yMax
        }
    }

    /* to rotate the switch */

    function rotateOpenSwitch(switchNr)
    {
        if(!switches[switchNr].switchIsOpen)
        switches[switchNr].openRotate();
    }

    function rotateCloseSwitch(switchNr)
    {
        if(switches[switchNr].switchIsOpen)
        switches[switchNr].closeRotate();
    }

    function  toRotateSwitch(switchNr)
    {
        if(switches[switchNr].switchIsOpen)
            switches[switchNr].closeRotate();
        else
            switches[switchNr].openRotate();
    }

    function getArrayValueOfSource(sourceNr,pos)
    {
        return sources[sourceNr].buttonValues[pos];
    }

    function getArrayValueOfResistor(resNr,pos)
    {
        return resistors[resNr].buttonValues[pos];
    }

    function getPositionInArray(sourceNr)
    {
        return sources[sourceNr].positionInArray;
    }

    function getPositionInResArray(resNr)
    {
        return resistors[resNr].positionInArray;
    }
}




