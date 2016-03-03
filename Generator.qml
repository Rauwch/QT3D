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

    QQ2.QtObject{

        id:o

        //Variables for spawning objects
        property var sourceFactory
        property var resistorFactory
        property var wireFactory
        property var poleFactory



    }


    QQ2.Component.onCompleted: {
        console.log("this is the current level: " + myLevels.getCurrentLevel() );
        calculator.readFile(":/assets/Levels/inputfile_" + myLevels.getCurrentLevel() + ".sj");
        buildLevel(); //Bouw Circuit
    }

    function buildLevel(){


        calculator.solveLevel();


        o.sourceFactory=Qt.createComponent("Source.qml");
        o.resistorFactory=Qt.createComponent("Resistor.qml");
        o.wireFactory=Qt.createComponent("Wire.qml");
        o.poleFactory=Qt.createComponent("Pole.qml");


        //create goals
        //nodes
        //voltages
        //current
        //calculate and save values
        //maybe use new function "getNumberOfGoalSources"
        for(var i=0;i<calculator.getNumberOfSources();i++){
            console.log("amount of sources " + calculator.getNumberOfSources());

            var negNode = calculator.nodeMAtSource(i);
            //check if voltage showGoal is on
            //if not, object doesn't have to be created
            var source = o.sourceFactory.createObject(null,{"s":calculator.getVoltageAtSource(i),"x":calculator.getXCoordOfSource(i)*root.sf,"z":-calculator.getYCoordOfSource(i)*root.sf,"y":calculator.voltageAtNode(negNode)});
            source.parent=root.parent;
            root.sources[i]=source;
        }

        //create sources using the "initial" values instead of the "solution" values
        for(var i=0;i<calculator.getNumberOfSources();i++){
            var negNode = calculator.nodeMAtSource(i);
            //"s":calculator.getVoltageAtSource(i)
                //needs a new calculation based on initial values
            //"x":calculator.getXCoordOfSource(i)*root.sf
                //can stay the same
            //"z":-calculator.getYCoordOfSource(i)*root.sf
                //can stay the same
            //"y":calculator.voltageAtNode(negNode)})
                //needs a new calculation based on initial values
            var source = o.sourceFactory.createObject(null,{"s":calculator.getVoltageAtSource(i),"x":calculator.getXCoordOfSource(i)*root.sf,"z":-calculator.getYCoordOfSource(i)*root.sf,"y":calculator.voltageAtNode(negNode)});
            source.parent=root.parent;
            root.sources[i]=source;

        }

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
                                                              "l":length,
                                                              "s":calculator.resistanceAtResistor(i),
                                                              "x":calculator.getXCoordOfResistor(i)*root.sf,
                                                              "z":-calculator.getYCoordOfResistor(i)*root.sf,
                                                              "y":minVolt,
                                                              "orientationAngle":90*(calculator.getAngleOfResistor(i)-1)});

            resistor.parent=root.parent;
            root.resistors[i]=resistor;
            console.log("Current trough resistor: ", i ,calculator.getCurrentofResistor(i));

        }



        //add wires TODO make automatisch
        //create wires
        for(i=0;i<calculator.getNumberOfWires();i++){



            var wire = o.wireFactory.createObject(null,{"x":calculator.getXCoordOfWire(i)*root.sf,
                                                      "z":-calculator.getYCoordOfWire(i)*root.sf,
                                                      "y":calculator.voltageAtNode(calculator.getNodeOfWire(i)),
                                                      "l":calculator.getLengthOfWire(i)*root.sf,
                                                      "orientationAngle":90*(calculator.getAngleOfWire(i)-1),
                                                      "eSize": calculator.getCurrentofWire(i),
                                                      "sf":root.sf});
            wire.parent=root.parent;
            root.wires[i]=wire;
            console.log("Current trough Wire at pos : ", calculator.getXCoordOfWire(i),calculator.getYCoordOfWire(i),calculator.getCurrentofWire(i));

        }
        //create poles
        var j = 0
        for(i=0;i<calculator.getNumberOfWires();i++){
            console.log("orientationangle: " + 90*(calculator.getAngleOfWire(i)-1));
            var pole;
            pole = o.poleFactory.createObject(null, {"x":calculator.getXCoordOfWire(i)*root.sf,
                                                      "z":-calculator.getYCoordOfWire(i)*root.sf,
                                                      "y":calculator.voltageAtNode(calculator.getNodeOfWire(i))});
            console.log("x: " + calculator.getXCoordOfWire(i)*root.sf);
            console.log("z: " + -calculator.getYCoordOfWire(i)*root.sf);
            console.log("y: " + calculator.voltageAtNode(calculator.getNodeOfWire(i)));

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
                                                  "y":calculator.voltageAtNode(calculator.getNodeOfWire(i))});
            pole.parent=root.parent;
            root.poles[j]=pole;
            j++;
        }


    }


}




