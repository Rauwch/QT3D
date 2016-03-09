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
    property real localVar: 60
    property real numBends: 14

    property var bends: []

    property var clickableBal
    property var xtest
    property var ytest
    property var ztest

    Calculator{
        id: localCalc
    }
    QQ2.QtObject{
        id:o
        //Variables for spawning objects
        property var bendFactory
        property var balFactory


    }
    function printBends(){
        console.log("inside printBends");
        console.log("num Bends: " + numBends);
        for(var i=0; i<numBends; i++){
            console.log(" s " + bends[i].s + " l " + bends[i].l +" x " + bends[i].x +" y " + bends[i].y +" z " + bends[i].z +" a " + bends[i].a +" OA " + bends[i].orientationAngle);
        }
    }

    function updateBends(){
        for(var i=0; i<numBends; i++){

            if(i%2 == 0){
                bends[i].a = ((theBentResistor.a)+localVar);
                bends[i].y = theBentResistor.y + (localCalc.calcSin(theBentResistor.l,theBentResistor.a-90)*(i/numBends));
                bends[i].z = theBentResistor.z + (localCalc.calcCos(theBentResistor.l,theBentResistor.a-90)*(i/numBends));
            }
            else{
                bends[i].a = ((theBentResistor.a)-localVar);
                bends[i].y = theBentResistor.bends[i-1].y + localCalc.calcSin(localCalc.calcLength(theBentResistor.l/numBends,localVar),theBentResistor.a+localVar-90);
                bends[i].z = theBentResistor.bends[i-1].z + localCalc.calcCos(localCalc.calcLength(theBentResistor.l/numBends,localVar),theBentResistor.a+localVar-90);
            }
            bends[i].l = localCalc.calcLength(theBentResistor.l/numBends,localVar);

        }

        //            if(i%2 == 0){
        //                bends[i].s = theBentResistor.s;
        //                bends[i].l = localCalc.calcLength(theBentResistor.l/numBends,localVar);
        //                bends[i].x = theBentResistor.x;
        //                bends[i].y = theBentResistor.y + (localCalc.calcSin(theBentResistor.l,theBentResistor.a-90)*(i/numBends));
        //                bends[i].z = theBentResistor.z + (localCalc.calcCos(theBentResistor.l,theBentResistor.a-90)*(i/numBends));
        //                bends[i].a = theBentResistor.a+localVar;
        //                bends[i].orientationAngle = theBentResistor.orientationAngle;
        //            }
        //            else{
        //                bends[i].s = theBentResistor.s;
        //                bends[i].l = localCalc.calcLength(theBentResistor.l/numBends,localVar);
        //                bends[i].x = theBentResistor.x;
        //                bends[i].y = theBentResistor.bends[i-1].y + localCalc.calcSin(localCalc.calcLength(theBentResistor.l/numBends,localVar),theBentResistor.a+localVar-90);
        //                bends[i].z = theBentResistor.bends[i-1].z + localCalc.calcCos(localCalc.calcLength(theBentResistor.l/numBends,localVar),theBentResistor.a+localVar-90);
        //                bends[i].a = theBentResistor.a-localVar;
        //                bends[i].orientationAngle = theBentResistor.orientationAngle;                }
        //        }
        updateBal();
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
                                                      "z":theBentResistor.z + (localCalc.calcCos(theBentResistor.l,theBentResistor.a-90)*(i/numBends)),
                                                      "a":theBentResistor.a+localVar,
                                                      "orientationAngle":theBentResistor.orientationAngle});
                console.log("even: " + i);
            }
            else{
                bend = o.bendFactory.createObject(null,{"s": theBentResistor.s,
                                                      "l":localCalc.calcLength(theBentResistor.l/numBends,localVar),
                                                      "x":theBentResistor.x,
                                                      "y":theBentResistor.bends[i-1].y + localCalc.calcSin(localCalc.calcLength(theBentResistor.l/numBends,localVar),theBentResistor.a+localVar-90),
                                                      "z":theBentResistor.bends[i-1].z + localCalc.calcCos(localCalc.calcLength(theBentResistor.l/numBends,localVar),theBentResistor.a+localVar-90),
                                                      "a":theBentResistor.a-localVar,
                                                      "orientationAngle":theBentResistor.orientationAngle});
                console.log("odd: " + i);
            }


            bend.parent=theBentResistor.parent;
            theBentResistor.bends[i]=bend;
            console.log("SIZE OF BENDS " + bends.length);
            if(i == numBends/2){
                xtest = theBentResistor.bends[i].x;
                ytest = theBentResistor.bends[i].y;
                ztest = theBentResistor.bends[i].z;
                console.log("xtest" + xtest);
                console.log("ytest" + ytest);
                console.log("ztest" + ztest);
                createBal(xtest, ytest, ztest);
            }
        }
    }
    function createBal(balx, baly, balz) {
        o.balFactory = Qt.createComponent("ResistorBal.qml");
        theBentResistor.clickableBal = o.balFactory.createObject(theBentResistor,{"xVal": balx,"yVal":  baly, "zVal": balz});

        if (o.balFactory === null) {
            // Error Handling
            console.log("Error creating object");
        }
    }
    function updateBal(){
        clickableBal.yVal = theBentResistor.bends[numBends/2].y;
        clickableBal.zVal = theBentResistor.bends[numBends/2].z;
    }
}

//}
//}
//    Resistor{
//        id: resistor1
//        s:100
//        l:3.3
//        x:5
//        y:0
//        z:-15
//        a:163
//        orientationAngle:270
//        QQ2.Component.onCompleted: {
//            console.log(" Resistor1" );
//            console.log(" l " + theBentResistor.l/2);
//            console.log(" l " + localCalc.calcLength(theBentResistor.l/2,localVar));
//            console.log(" x " + theBentResistor.x);
//            console.log(" y " + theBentResistor.y);
//            console.log(" z " + theBentResistor.z);
//            console.log(" a " + theBentResistor.a+localVar);
//        }

//    }

//}
//    Resistor{
//        id: resistor2
//        s: theBentResistor.s
//        l: resistor1.l
//        x: theBentResistor.x
//        y: resistor1.y+localCalc.calcSin(resistor1.l,theBentResistor.a+localVar-90)
//        z: resistor1.z+localCalc.calcCos(resistor1.l,theBentResistor.a+localVar-90)
//        a: theBentResistor.a-localVar
//        orientationAngle: theBentResistor.orientationAngle
//        QQ2.Component.onCompleted: {
//            console.log(" Resistor2" );
//            console.log(" x " + theBentResistor.x);
//            console.log(" y " + theBentResistor.y+localCalc.calcSin(resistor1.l,theBentResistor.a+localVar-90));
//            console.log(" z " + theBentResistor.z+localCalc.calcCos(resistor1.l,theBentResistor.a+localVar-90));
//            console.log(" a " + theBentResistor.a+localVar);
//        }

//    }
//    Resistor{
//        id: resistor3
//        s: theBentResistor.s
//        l: resistor1.l
//        x: theBentResistor.x
//        y: resistor1.y+(localCalc.calcSin(theBentResistor.l,theBentResistor.a-90)/3)
//        z: resistor1.z+(localCalc.calcCos(theBentResistor.l,theBentResistor.a-90)/3)
//        a: theBentResistor.a+localVar
//        orientationAngle: theBentResistor.orientationAngle
//        QQ2.Component.onCompleted: {
//            console.log(" Resistor2" );
//            console.log(" x " + theBentResistor.x);
//            console.log(" y " + theBentResistor.y+localCalc.calcSin(resistor1.l,theBentResistor.a+localVar-90));
//            console.log(" z " + theBentResistor.z+localCalc.calcCos(resistor1.l,theBentResistor.a+localVar-90));
//            console.log(" a " + theBentResistor.a+localVar);
//        }

//    }
//    Resistor{
//        id: resistor4
//        s: theBentResistor.s
//        l: resistor3.l
//        x: theBentResistor.x
//        y: resistor3.y+localCalc.calcSin(resistor1.l,theBentResistor.a+localVar-90)
//        z: resistor3.z+localCalc.calcCos(resistor1.l,theBentResistor.a+localVar-90)
//        a: theBentResistor.a-localVar
//        orientationAngle: theBentResistor.orientationAngle
//        QQ2.Component.onCompleted: {
//            console.log(" Resistor2" );
//            console.log(" x " + theBentResistor.x);
//            console.log(" y " + theBentResistor.y+localCalc.calcSin(resistor1.l,theBentResistor.a+localVar-90));
//            console.log(" z " + theBentResistor.z+localCalc.calcCos(resistor1.l,theBentResistor.a+localVar-90));
//            console.log(" a " + theBentResistor.a+localVar);
//        }

//    }
//    Resistor{
//        id: resistor5
//        s: theBentResistor.s
//        l: resistor1.l
//        x: theBentResistor.x
//        y: resistor1.y+(localCalc.calcSin(theBentResistor.l,theBentResistor.a-90)*2/3)
//        z: resistor1.z+(localCalc.calcCos(theBentResistor.l,theBentResistor.a-90)*2/3)
//        a: theBentResistor.a+localVar
//        orientationAngle: theBentResistor.orientationAngle
//        QQ2.Component.onCompleted: {
//            console.log(" Resistor2" );
//            console.log(" x " + theBentResistor.x);
//            console.log(" y " + theBentResistor.y+localCalc.calcSin(resistor1.l,theBentResistor.a+localVar-90));
//            console.log(" z " + theBentResistor.z+localCalc.calcCos(resistor1.l,theBentResistor.a+localVar-90));
//            console.log(" a " + theBentResistor.a+localVar);
//        }

//    }
//    Resistor{
//        id: resistor6
//        s: theBentResistor.s
//        l: resistor1.l
//        x: theBentResistor.x
//        y: resistor5.y+localCalc.calcSin(resistor1.l,theBentResistor.a+localVar-90)
//        z: resistor5.z+localCalc.calcCos(resistor1.l,theBentResistor.a+localVar-90)
//        a: theBentResistor.a-localVar
//        orientationAngle: theBentResistor.orientationAngle
//        QQ2.Component.onCompleted: {
//            console.log(" Resistor2" );
//            console.log(" x " + theBentResistor.x);
//            console.log(" y " + theBentResistor.y+localCalc.calcSin(resistor1.l,theBentResistor.a+localVar-90));
//            console.log(" z " + theBentResistor.z+localCalc.calcCos(resistor1.l,theBentResistor.a+localVar-90));
//            console.log(" a " + theBentResistor.a+localVar);
//        }

//    }


