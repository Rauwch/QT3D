/* creates a BentResistor out of several resistor objects and a resistorBal*/
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import QtQuick 2.3 as QQ2
import Calc 1.0



Entity{
    id: theBentResistor
    property real s: 1 /* determines the width of the resistor parts and depends on resistance value */
    property real l: 1 /* determines the length of the resistor parts and depends on the voltage */

    //Variablen voor posistie
    property real x: 0
    property real y: 0
    property real z: 0

    property real yPrev
    property real zPrev
    //Variable voor hoek.
    property real a: 90 //Hoek volgens z as,bepaald door spanning over weerstand
    property real orientationAngle: 0 //Hoek volgens y as, bepaald door plaatsing weerstand
    property real angleOfBends: 50
    property real bendIntensity: 2
    property real numBends: 10
    property real flatLength

    property var bends: []
    property var oldbends: []

    property var clickableBal

    property var xBal
    property var yBal
    property var zBal

    property bool clickable: false
    property var resistorNr

    /* used to calculate the position of all the parts,
    in the future might create a different c++ file */
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
    }
    /* function is needed to animate properly */
    function storeBends(){
        for(var i=0; i<numBends; i++){

            bends[i].lprev = oldbends[i].l;
            bends[i].aprev = oldbends[i].a;
            bends[i].yprev = oldbends[i].y;
            bends[i].zprev = oldbends[i].z;
            bends[i].lnew = bends[i].l;
            bends[i].anew = bends[i].a;
            bends[i].ynew = bends[i].y;
            bends[i].znew = bends[i].z;
            bends[i].activateAnimation();
        }
    }

//    function deleteBends(){
//        updateBends();
//        updateBal();
//    }

    /* usefulness needs testing */
    function updateOldBends(){
        for(var i=0; i<numBends; i++){
            oldbends[i].a = bends[i].a;
            oldbends[i].y = bends[i].y;
            oldbends[i].z = bends[i].z;
            oldbends[i].l  = bends[i].l;
        }
    }

    /* solving the positioning of the parts of the resistor using trigonometry */
    function updateBends(){

        for(var i=0; i<numBends; i++){

            if(i%2 == 0){
                bends[i].a = ((theBentResistor.a)+angleOfBends);
                bends[i].y = theBentResistor.y + (localCalc.calcSin(theBentResistor.l,theBentResistor.a-90)*(i/numBends));
                bends[i].z = (theBentResistor.z + (-(localCalc.getRealSin(theBentResistor.orientationAngle))*(localCalc.calcCos(theBentResistor.l,theBentResistor.a-90)*(i/numBends))));
                bends[i].l = localCalc.calcLength(theBentResistor.l/numBends,angleOfBends);
                yPrev = bends[i].y;
                zPrev = bends[i].z;
            }
            else{
                bends[i].a = ((theBentResistor.a)-angleOfBends);
                bends[i].y = yPrev + localCalc.calcSin(localCalc.calcLength(theBentResistor.l/numBends,angleOfBends),theBentResistor.a+angleOfBends-90);
                bends[i].z = zPrev + (-(localCalc.getRealSin(theBentResistor.orientationAngle))*(localCalc.calcCos(localCalc.calcLength(theBentResistor.l/numBends,angleOfBends),theBentResistor.a+angleOfBends-90)));
                bends[i].l = localCalc.calcLength(theBentResistor.l/numBends,angleOfBends);
            }

            if(theBentResistor.a == 90){
                if(i==0){
                    bends[i].z = (theBentResistor.z );
                    bends[i].a = ((theBentResistor.a));
                    bends[i].y = theBentResistor.y;
                    bends[i].l = -flatLength;
                }
            }
        }
    }

    function makeBends(){
        flatLength = theBentResistor.l * localCalc.getRealCos(theBentResistor.a-90);
        o.bendFactory= Qt.createComponent("Resistor.qml");
        for(var i=0; i<numBends; i++){
            var bend;
            if(i%2 == 0){

                bend = o.bendFactory.createObject(null,{"s": theBentResistor.s,
                                                      "l":localCalc.calcLength(theBentResistor.l/numBends,angleOfBends),
                                                      "x":theBentResistor.x,
                                                      "y":theBentResistor.y + (localCalc.calcSin(theBentResistor.l,theBentResistor.a-90)*(i/numBends)),
                                                      "z":(theBentResistor.z + ((-1)*(localCalc.getRealSin(theBentResistor.orientationAngle))*(localCalc.calcCos(theBentResistor.l,theBentResistor.a-90)*(i/numBends)))),
                                                      "a":(theBentResistor.a+angleOfBends),
                                                      "orientationAngle":theBentResistor.orientationAngle});
            }
            else {
                bend = o.bendFactory.createObject(null,{"s": theBentResistor.s,
                                                      "l":localCalc.calcLength(theBentResistor.l/numBends,angleOfBends),
                                                      "x":theBentResistor.x,
                                                      "y":theBentResistor.bends[i-1].y + localCalc.calcSin(localCalc.calcLength(theBentResistor.l/numBends,angleOfBends),theBentResistor.a+angleOfBends-90),
                                                      "z":(theBentResistor.bends[i-1].z + ((-1)*(localCalc.getRealSin(theBentResistor.orientationAngle))*(localCalc.calcCos(localCalc.calcLength(theBentResistor.l/numBends,angleOfBends),theBentResistor.a+angleOfBends-90)))),
                                                      "a":(theBentResistor.a-angleOfBends),
                                                      "orientationAngle":theBentResistor.orientationAngle});
            }
            bend.parent=theBentResistor.parent;
            theBentResistor.bends[i]=bend;
            var oldbend;
            oldbend = o.bendFactory.createObject(null,{"s": 0,
                                                     "l":0,
                                                     "x":0,
                                                     "y":0,
                                                     "z":0,
                                                     "a":0,
                                                     "orientationAngle":0});
            theBentResistor.oldbends[i]=oldbend;

            /* at the end, set xBal, yBal, zBal to get the proper positioning of the clickable ball */
            if(i == numBends-1){
                xBal = theBentResistor.bends[i].x;
                yBal = theBentResistor.y + (localCalc.calcSin(theBentResistor.l,theBentResistor.a-90));
                zBal = (theBentResistor.z + ((-1)*(localCalc.getRealSin(theBentResistor.orientationAngle))*(localCalc.calcCos(theBentResistor.l,theBentResistor.a-90)*(i/numBends))));
            }
        }
    }
    function createBal() {
        o.balFactory = Qt.createComponent("ResistorBal.qml");
        theBentResistor.clickableBal = o.balFactory.createObject(theBentResistor,{"xVal": xBal,"yVal":  yBal, "zVal": zBal});

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



