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
    property real localVar: 12

    property var bends: []

    //    QQ2.Component.onCompleted: {
    //        console.log("complete before");

    //        makeBends();
    //        console.log("complete after");

    //    }
    Calculator{
        id: localCalc
    }
    QQ2.QtObject{
        id:o
        //Variables for spawning objects
        property var bendFactory
    }

    function makeBends(){
        o.bendFactory= Qt.createComponent("Resistor.qml");
        //        console.log("inside makeBends");
        //        console.log(" s " + theBentResistor.s);
        //        console.log(" l " + localCalc.calcLength(theBentResistor.l/6,localVar));
        //        console.log(" x " + theBentResistor.x);
        //        console.log(" y " + theBentResistor.y);
        //        console.log(" z " + theBentResistor.z);
        //        console.log(" a " + (theBentResistor.a+localVar));
        //        console.log(" OA " + theBentResistor.orientationAngle);
        //        //var bend = o.bendFactory.createObject(null,{"s": theBentResistor.s,"l":localCalc.calcLength(theBentResistor.l/6,localVar),"x":theBentResistor.x,"y":theBentResistor.y,"z":theBentResistor.z,"a":theBentResistor.a+localVar,"orientationAngle":theBentResistor.orientationAngle});
        //        for(var i=0; i<2; i++){
        //            var bend = o.bendFactory.createObject(null,{"s": theBentResistor.s,"l":(localCalc.calcLength(theBentResistor.l/6,localVar)),"x":theBentResistor.x,"y":theBentResistor.y,"z":theBentResistor.z,"a":(theBentResistor.a+localVar),"orientationAngle":(theBentResistor.orientationAngle)});

        //            //var bend = o.bendFactory.createObject(null,{"s": 100,"l":9,"x":5,"y":0,"z":-15,"a":163,"orientationAngle":270});
        //            console.log("after var bend");
        //            bend.parent=theBentResistor.parent;
        //            theBentResistor.bends[i]=bend;
        //            console.log("size array " + theBentResistor.bends.length);
        //            console.log(i + " s " + theBentResistor.bends[i].s);
        //            console.log(i + " l " + theBentResistor.bends[i].l);
        //            console.log(i + " x1 " + theBentResistor.bends[i].x);
        //            console.log(i + " y " + theBentResistor.bends[i].y);
        //            console.log(i + " z " + theBentResistor.bends[i].z);
        //            console.log(i + " a " + theBentResistor.bends[i].a);
        //            console.log(i + " OA " + theBentResistor.bends[i].orientationAngle);
        //        }
        //    }

        for(var i=0; i<6; i++){
            var bend;

            if(i%2 == 0){
                bend = o.bendFactory.createObject(null,{"s": theBentResistor.s,
                                                      "l":localCalc.calcLength(theBentResistor.l/6,localVar),
                                                      "x":theBentResistor.x,
                                                      "y":theBentResistor.y + (localCalc.calcSin(theBentResistor.l,theBentResistor.a-90)*(i/2)/3),
                                                      "z":theBentResistor.z + (localCalc.calcCos(theBentResistor.l,theBentResistor.a-90)*(i/2)/3),
                                                      "a":theBentResistor.a+localVar,
                                                      "orientationAngle":theBentResistor.orientationAngle});
                console.log("even: " + i);
            }
            else{
                //                console.log(i + " y " + theBentResistor.bends[i].y);
                //                console.log(i + " y " + theBentResistor.bends[i-1].y);

                bend = o.bendFactory.createObject(null,{"s": theBentResistor.s,
                                                      "l":localCalc.calcLength(theBentResistor.l/6,localVar),
                                                      "x":theBentResistor.x,
                                                      "y":theBentResistor.bends[i-1].y + localCalc.calcSin(theBentResistor.l,theBentResistor.a+localVar-90),
                                                      "z":theBentResistor.bends[i-1].z + localCalc.calcCos(theBentResistor.l,theBentResistor.a+localVar-90),
                                                      "a":theBentResistor.a-localVar,
                                                      "orientationAngle":theBentResistor.orientationAngle});
                console.log("odd: " + i);
            }

            console.log("after var bend");

            bend.parent=theBentResistor.parent;
            theBentResistor.bends[i]=bend;
            console.log("SIZE OF BENDS " + bends.length);
            console.log(i + " y " + theBentResistor.bends[i].y);

            console.log("end make bends");
        }
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


