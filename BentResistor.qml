import Qt3D.Core 2.0
import Qt3D.Render 2.0
import QtQuick 2.3 as QQ2
import Calc 1.0



Entity{
    id: theBentResistor
    property real s: 1 //bepaald dikte vd weerstand, afhankelijk van weestandswaarde
    property real l: 1 //bepaald lengte vd weerstand, afhankelijk van spanning over weerstand

    //Variablen voor posistie
    property real x: 0
    property real y: 0
    property real z: 0

    //Variable voor hoek.
    property real a: 90 //Hoek volgens z as,bepaald door spanning over weerstand
    property real orientationAngle: 0 //Hoek volgens y as, bepaald door plaatsing weerstand
    property real localVar: 50
    property real bendIntensity: 2
    property real numBends: 10

    property var bends: []

    property var clickableBal
    property var xtest
    property var ytest
    property var ztest
    property bool clickable: false
    property var resistorNr

    Calculator{
        id: localCalc
    }
    QQ2.QtObject{
        id:o
        //Variables for spawning objects
        property var bendFactory
        property var balFactory


    }
    QQ2.Component.onCompleted: {
        makeBends();
        if(clickable)
            createBal();
        else
            console.log("no clickable bal")
    }

    function printBends(){
        console.log("inside printBends");
        console.log("num Bends: " + numBends);
        for(var i=0; i<numBends; i++){
            console.log(" s " + bends[i].s + " l " + bends[i].l +" x " + bends[i].x +" y " + bends[i].y +" z " + bends[i].z +" a " + bends[i].a +" OA " + bends[i].orientationAngle);
        }
    }

    function deleteBends(){
        updateBends();
        updateBal();
    }

    function updateBends(){
        for(var i=0; i<numBends; i++){
            if(i%2 == 0){
                bends[i].a = ((theBentResistor.a)+localVar);
                bends[i].y = theBentResistor.y + (localCalc.calcSin(theBentResistor.l,theBentResistor.a-90)*(i/numBends));
                bends[i].z = (theBentResistor.z + (-(localCalc.getRealSin(theBentResistor.orientationAngle))*(localCalc.calcCos(theBentResistor.l,theBentResistor.a-90)*(i/numBends))));
            }
            else{
                bends[i].a = ((theBentResistor.a)-localVar);
                bends[i].y = theBentResistor.bends[i-1].y + localCalc.calcSin(localCalc.calcLength(theBentResistor.l/numBends,localVar),theBentResistor.a+localVar-90);
                bends[i].z = (theBentResistor.bends[i-1].z + (-(localCalc.getRealSin(theBentResistor.orientationAngle))*(localCalc.calcCos(localCalc.calcLength(theBentResistor.l/numBends,localVar),theBentResistor.a+localVar-90))));
            }
            bends[i].l = localCalc.calcLength(theBentResistor.l/numBends,localVar);
        }
    }

    function makeBends(){
        o.bendFactory= Qt.createComponent("Resistor.qml");
        for(var i=0; i<numBends; i++){
            var bend;
            if(i%2 == 0){

                bend = o.bendFactory.createObject(null,{"s": theBentResistor.s,
                                                      "l":localCalc.calcLength(theBentResistor.l/numBends,localVar),
                                                      "x":theBentResistor.x,
                                                      "y":theBentResistor.y + (localCalc.calcSin(theBentResistor.l,theBentResistor.a-90)*(i/numBends)),
                                                      "z":(theBentResistor.z + ((-1)*(localCalc.getRealSin(theBentResistor.orientationAngle))*(localCalc.calcCos(theBentResistor.l,theBentResistor.a-90)*(i/numBends)))),
                                                      "a":(theBentResistor.a+localVar),
                                                      "orientationAngle":theBentResistor.orientationAngle});
            }
            else{
                bend = o.bendFactory.createObject(null,{"s": theBentResistor.s,
                                                      "l":localCalc.calcLength(theBentResistor.l/numBends,localVar),
                                                      "x":theBentResistor.x,
                                                      "y":theBentResistor.bends[i-1].y + localCalc.calcSin(localCalc.calcLength(theBentResistor.l/numBends,localVar),theBentResistor.a+localVar-90),
                                                      "z":(theBentResistor.bends[i-1].z + ((-1)*(localCalc.getRealSin(theBentResistor.orientationAngle))*(localCalc.calcCos(localCalc.calcLength(theBentResistor.l/numBends,localVar),theBentResistor.a+localVar-90)))),
                                                      "a":(theBentResistor.a-localVar),
                                                      "orientationAngle":theBentResistor.orientationAngle});
            }
            bend.parent=theBentResistor.parent;
            theBentResistor.bends[i]=bend;
            if(i == numBends-1){
                xtest = theBentResistor.bends[i].x;
                ytest = theBentResistor.y + (localCalc.calcSin(theBentResistor.l,theBentResistor.a-90));
                ztest = (theBentResistor.z + ((-1)*(localCalc.getRealSin(theBentResistor.orientationAngle))*(localCalc.calcCos(theBentResistor.l,theBentResistor.a-90)*(i/numBends))));
            }
        }
    }
    function createBal() {
        o.balFactory = Qt.createComponent("ResistorBal.qml");
        theBentResistor.clickableBal = o.balFactory.createObject(theBentResistor,{"xVal": xtest,"yVal":  ytest, "zVal": ztest});

        if (o.balFactory === null) {
            // Error Handling
            console.log("Error creating object");
        }
    }
    function updateBal(){
        if(clickable){
            clickableBal.yVal = theBentResistor.y + (localCalc.calcSin(theBentResistor.l,theBentResistor.a-90));
        }
    }
}



