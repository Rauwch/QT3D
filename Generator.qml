import Qt3D.Core 2.0
import Qt3D.Logic 2.0
import QtQuick 2.3 as QQ2


//Object dat verantwoordelijk is voor bouwen van circuits
Entity{
    id:root

    //size of each coordinate step
    property real sf:5

    //arrays for components
    property var sources:[]
    property var resistors :[]
    property var wires: []
    property var poles: []
    property var goals: []
    property var switches:[]
    property var bendValues: []

    QQ2.QtObject{

        id:o

        //Variables for spawning objects
        property var sourceFactory
        property var resistorFactory
        property var wireFactory
        property var poleFactory
        property var goalFactory
        property var switchFactory
    }


    QQ2.Component.onCompleted: {
        console.log("this is the current level: " + myLevels.getCurrentLevel() );
        calculator.readFile(":/assets/Levels/inputfile_" + myLevels.getCurrentLevel() + ".sj");
        console.log("read in level");
        initializeBendsArray();
        initializeLevel();
        calculator.updateResistors();
        calculator.updateSources();
        buildLevel(); //Bouw Circuit
    }

    function initializeLevel(){
        console.log("INSIDE INITIALIZE LEVEL")
        calculator.solveLevel();
        console.log("INSIDE INITIALIZE LEVEL")
        for( var i =0;i < calculator.getNumberOfGoals();i++)
        {
            //console.log("amount of goals " + calculator.getNumberOfGoals());
            //console.log( "i = " + i + "   node number " + calculator.nodeAtGoal(i));

            calculator.setVoltageAtGoal(i,calculator.voltageAtNode(calculator.nodeAtGoal(i)));
            //console.log("amount of current goals: " + calculator.currentGoals.size());
        }
        calculator.setCurrentsOfWires();
        calculator.storeCurrentGoals();
        //console.log("INSIDE INITIALIZE LEVEL")

    }


    function buildLevel()
    {
        calculator.solveLevel();
        myGameScreen.initializeJellies();
        console.log("before calculate size");
        myGameScreen.calculateSize();
        console.log("before factories");
        o.sourceFactory=Qt.createComponent("Source.qml");
        o.resistorFactory=Qt.createComponent("BentResistor.qml");
        o.wireFactory=Qt.createComponent("Wire.qml");
        o.poleFactory=Qt.createComponent("Pole.qml");
        o.goalFactory= Qt.createComponent("GoalPole.qml");
        o.switchFactory= Qt.createComponent("Switch.qml");


        //create goals
        //nodes
        //voltages
        //current
        //calculate and save values
        //maybe use new function "getNumberOfGoalSources"
        for(var i=0;i<calculator.getNumberOfSources();i++){
            //console.log("amount of sources " + calculator.getNumberOfSources());

            var negNode = calculator.nodeMAtSource(i);
            //check if voltage showGoal is on
            //if not, object doesn't have to be created
            var source = o.sourceFactory.createObject(null,{"sourceNr": i,"s":calculator.getVoltageAtSource(i),
                                                          "x":calculator.getXCoordOfSource(i)*root.sf,
                                                          "z":-calculator.getYCoordOfSource(i)*root.sf,
                                                          "y":calculator.voltageAtNode(negNode),
                                                          "clickable": calculator.getSourceIsVariable(i),
                                                          "eSize": calculator.getCurrentofWire(i)});
            source.parent=root.parent;
            root.sources[i]=source;
            //root.sources[i].checkClickable();
        }

        //console.log("After build sources");

        //create sources using the "initial" values instead of the "solution" values
        //        for(var i=0;i<calculator.getNumberOfSources();i++){
        //            var negNode = calculator.nodeMAtSource(i);
        //            //"s":calculator.getVoltageAtSource(i)
        //                //needs a new calculation based on initial values
        //            //"x":calculator.getXCoordOfSource(i)*root.sf
        //                //can stay the same
        //            //"z":-calculator.getYCoordOfSource(i)*root.sf
        //                //can stay the same
        //            //"y":calculator.voltageAtNode(negNode)})
        //                //needs a new calculation based on initial values
        //            var source = o.sourceFactory.createObject(null,{"s":calculator.getVoltageAtSource(i),"x":calculator.getXCoordOfSource(i)*root.sf,"z":-calculator.getYCoordOfSource(i)*root.sf,"y":calculator.voltageAtNode(negNode)});
        //            source.parent=root.parent;
        //            root.sources[i]=source;

        //        }

        //TODO Probleem met angle oplossen
        //create resistors
        for( var i=0;i<calculator.getNumberOfResistors();i++){


            var minVolt = Math.min(calculator.voltageAtNode(calculator.node1AtResistor(i)),calculator.voltageAtNode(calculator.node2AtResistor(i)));
            var maxVolt = Math.max(calculator.voltageAtNode(calculator.node1AtResistor(i)),calculator.voltageAtNode(calculator.node2AtResistor(i)));


            //Hoek van de weerstand
            var angle = Math.atan2(root.sf,(minVolt-maxVolt));


            //Lengte van de weerstand
            var length = Math.abs(((maxVolt-minVolt))/Math.cos(angle));



            var resistor = o.resistorFactory.createObject(null,{"a":(angle*180/Math.PI),
                                                              "resistorNr": i,
                                                              "l":length,
                                                              "s":calculator.resistanceAtResistor(i),
                                                              "x":calculator.getXCoordOfResistor(i)*root.sf,
                                                              "z":-calculator.getYCoordOfResistor(i)*root.sf,
                                                              "y":minVolt,
                                                              "clickable": calculator.getResistorIsVariable(i),
                                                              "orientationAngle":90*(calculator.getAngleOfResistor(i)-1) });

            resistor.parent=root.parent;
            root.resistors[i]=resistor;
            root.resistors[i].makeBends();


            //console.log("Current trough resistor: ", i ,calculator.getCurrentofResistor(i));

        }
        // create switches
        for(i = 0; i < calculator.getNumberOfSwitches(); i++)
        {
            console.log("building a switch");
            maxVolt = Math.max(calculator.voltageAtNode(calculator.node1AtSwitch(i)),calculator.voltageAtNode(calculator.node2AtSwitch(i)));
            var mySwitch;

            console.log("switch x: " + calculator.getXCoordOfSwitch(i) + " y: " + calculator.getYCoordOfSwitch(i))
            console.log("maxVolt: " + maxVolt);
            mySwitch = o.switchFactory.createObject(null,{"switchNr": i,
                                                        "x": calculator.getXCoordOfSwitch(i)*root.sf,
                                                        "z": -calculator.getYCoordOfSwitch(i)*root.sf,
                                                        "y": maxVolt,
                                                        "orientationAngle": 90*(calculator.getAngleOfSwitch(i)-1)
                                                    });
            //console.log("after creating a switch");
            //mySwitch.createBal();
            mySwitch.parent=root.parent;
            root.switches[i]=mySwitch;

        }
        //console.log("After build resistors");



        //add wires TODO make automatisch
        //create wires
        for(i=0;i<calculator.getNumberOfWires();i++){


            var test = 1;
            //console.log("ZEROANDONE: " + calculator.getGoalCurrent(i));
            var wire = o.wireFactory.createObject(null,{"x":calculator.getXCoordOfWire(i)*root.sf,
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
            //console.log("Current trough Wire at pos : ", calculator.getXCoordOfWire(i),calculator.getYCoordOfWire(i),calculator.getCurrentofWire(i));

        }
        //console.log("After build wires");
        //create poles
        var j = 0
        for(i=0;i<calculator.getNumberOfWires();i++)
        {
            //console.log("orientationangle: " + 90*(calculator.getAngleOfWire(i)-1));
            var pole;
            pole = o.poleFactory.createObject(null, {"x":calculator.getXCoordOfWire(i)*root.sf,
                                                  "z":-calculator.getYCoordOfWire(i)*root.sf,
                                                  "y":calculator.voltageAtNode(calculator.getNodeOfWire(i)),
                                                  "nodeOfWire": calculator.getNodeOfWire(i)});

            //console.log("POLEEEE value is " + calculator.getXCoordOfWire(i) +"       POLEEEE value is " + calculator.getYCoordOfWire(i) )
            //            console.log("x: " + calculator.getXCoordOfWire(i)*root.sf);
            //            console.log("z: " + -calculator.getYCoordOfWire(i)*root.sf);
            //            console.log("y: " + calculator.voltageAtNode(calculator.getNodeOfWire(i)));

            pole.parent=root.parent;
            root.poles[j]=pole;
            j++;
            //orientationangle
            var xDif= 0;
            var zDif= 0;
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
            //console.log("POLEEEE value is " + calculator.getXCoordOfWire(i) +"       POLEEEE value is " + calculator.getYCoordOfWire(i) )
            pole.parent=root.parent;
            root.poles[j]=pole;
            j++;
        }
        // create goal poles
        for (i = 0; i<calculator.getNumberOfGoals(); i++)
        {
            var goalPole;
            goalPole = o.goalFactory.createObject(null,{"x":calculator.getXCoordOfGoal(i)*root.sf,
                                                      "z":-calculator.getYCoordOfGoal(i)*root.sf,
                                                      "y":calculator.getVoltageAtGoal(i)});
            //console.log("xgoal value is " + calculator.getXCoordOfGoal(i) +"       ygoal value is " + calculator.getYCoordOfGoal(i) )
            //console.log("goal value is " + calculator.getVoltageAtGoal(i));
            goalPole.parent=root.parent;
            root.goals[i]=goalPole;
        }


    }
    function updateGoalPoles(){
        for(var i = 0; i<goals.length; i++){
            if( calculator.getMatch(i)){
                goals[i].setGreen();
            }
            else{
                goals[i].setRed();
            }
        }
    }

    function initializeBendsArray(){
        bendValues[0] = 0;
        bendValues[1] = 35;
        bendValues[2] = 50;
        bendValues[3] = 65;
        bendValues[4] = 75;
    }

    function increaseRes(){
        //console.log("intensity " + resistors[0].bendIntensity)
        resistors[0].bendIntensity = resistors[0].bendIntensity + 1;
        resistors[0].localVar = bendValues[resistors[0].bendIntensity];

    }
    function decreaseRes(){
        resistors[0].bendIntensity = resistors[0].bendIntensity - 1;
        resistors[0].localVar = bendValues[resistors[0].bendIntensity];

    }
    function increaseVolt(){
        sources[0].heightIntensity = sources[0].heightIntensity + 1;
        //resistors[0].localVar = bendValues[resistors[0].bendIntensity];

    }
    function decreaseVolt(){
        sources[0].heightIntensity = sources[0].heightIntensity - 1;
        //resistors[0].localVar = bendValues[resistors[0].bendIntensity];

    }

    //update level function
    function updateLevel(){
        //console.log("inside update level");
        //console.log("grote van sources: " + sources.length);
        for( var i= 0; i <sources.length; i++)
        {
            sources[i].s = calculator.getVoltageAtSource(i);
            sources[i].y = calculator.voltageAtNode(calculator.nodeMAtSource(i));
            sources[i].eSize = calculator.getCurrentofWire(i)
            sources[i].updateBal();;
        }

        for( i= 0; i <resistors.length; i++)
        {

            var minVolt = Math.min(calculator.voltageAtNode(calculator.node1AtResistor(i)),calculator.voltageAtNode(calculator.node2AtResistor(i)));
            var maxVolt = Math.max(calculator.voltageAtNode(calculator.node1AtResistor(i)),calculator.voltageAtNode(calculator.node2AtResistor(i)));


            //Hoek van de weerstand
            var angle = Math.atan2(root.sf,(minVolt-maxVolt));


            //Lengte van de weerstand
            var length = Math.abs(((maxVolt-minVolt))/Math.cos(angle));

            resistors[i].a = angle*180/Math.PI;
            resistors[i].l = length;
            resistors[i].s = calculator.resistanceAtResistor(i);
            resistors[i].x = calculator.getXCoordOfResistor(i)*root.sf;
            resistors[i].z = -calculator.getYCoordOfResistor(i)*root.sf;
            resistors[i].y = minVolt;
            resistors[i].updateBends();
            resistors[i].printBends();
            resistors[i].deleteBends();


        }
        //console.log("groote van wires: " + wires.length)
        for(  i= 0; i <wires.length; i++)
        {
            wires[i].y = calculator.voltageAtNode(calculator.getNodeOfWire(i));
            //console.log("Current through goals wire: " + calculator.getCurrentofWire(i) + "Voltage at node " );
            wires[i].eSize = calculator.getCurrentofWire(i)*1000;
            //console.log("AMOUNT OF ELECTRONS FROM A WIRE" + wires[i].electrons.length)
            for(var j = 0; j < wires[i].electrons.length; j++)
            {
                //console.log("amount of electrons ");
                wires[i].electrons[j].s = calculator.getCurrentofWire(i);
            }

            wires[i].printeSize();
        }
        for( i = 0; i < poles.length; i++)
        {
            poles[i].y = calculator.voltageAtNode(poles[i].nodeOfWire);
        }



    }


}




