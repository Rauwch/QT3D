import Qt3D.Core 2.0
import Qt3D.Render 2.0
import QtQuick 2.2 as QQ2
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
    property real localVar: 40
    Calculator{
        id: localCalc
    }

    Resistor{
        id: resistor1
        s: theBentResistor.s
        //l: localCalc.calcLength(theBentResistor.l/2,theBentResistor.a+10-90)
        l: localCalc.calcLength(theBentResistor.l/6,localVar)

        x: theBentResistor.x
        y: theBentResistor.y
        z: theBentResistor.z
        a: theBentResistor.a+localVar
        orientationAngle: theBentResistor.orientationAngle
    QQ2.Component.onCompleted: {
        console.log(" Resistor1" );
        console.log(" l " + theBentResistor.l/2);
        console.log(" l " + localCalc.calcLength(theBentResistor.l/2,localVar));
        console.log(" x " + theBentResistor.x);
        console.log(" y " + theBentResistor.y);
        console.log(" z " + theBentResistor.z);
        console.log(" a " + theBentResistor.a+localVar);
    }

    }
    Resistor{
        id: resistor2
        s: theBentResistor.s
        l: resistor1.l
        x: theBentResistor.x
        y: resistor1.y+localCalc.calcSin(resistor1.l,theBentResistor.a+localVar-90)
        z: resistor1.z+localCalc.calcCos(resistor1.l,theBentResistor.a+localVar-90)
        a: theBentResistor.a-localVar
        orientationAngle: theBentResistor.orientationAngle
        QQ2.Component.onCompleted: {
            console.log(" Resistor2" );
            console.log(" x " + theBentResistor.x);
            console.log(" y " + theBentResistor.y+localCalc.calcSin(resistor1.l,theBentResistor.a+localVar-90));
            console.log(" z " + theBentResistor.z+localCalc.calcCos(resistor1.l,theBentResistor.a+localVar-90));
            console.log(" a " + theBentResistor.a+localVar);
        }

    }
    Resistor{
        id: resistor3
        s: theBentResistor.s
        l: resistor1.l
        x: theBentResistor.x
        y: resistor1.y+(localCalc.calcSin(theBentResistor.l,theBentResistor.a-90)/3)
        z: resistor1.z+(localCalc.calcCos(theBentResistor.l,theBentResistor.a-90)/3)
        a: theBentResistor.a+localVar
        orientationAngle: theBentResistor.orientationAngle
        QQ2.Component.onCompleted: {
            console.log(" Resistor2" );
            console.log(" x " + theBentResistor.x);
            console.log(" y " + theBentResistor.y+localCalc.calcSin(resistor1.l,theBentResistor.a+localVar-90));
            console.log(" z " + theBentResistor.z+localCalc.calcCos(resistor1.l,theBentResistor.a+localVar-90));
            console.log(" a " + theBentResistor.a+localVar);
        }

    }
    Resistor{
        id: resistor4
        s: theBentResistor.s
        l: resistor3.l
        x: theBentResistor.x
        y: resistor3.y+localCalc.calcSin(resistor1.l,theBentResistor.a+localVar-90)
        z: resistor3.z+localCalc.calcCos(resistor1.l,theBentResistor.a+localVar-90)
        a: theBentResistor.a-localVar
        orientationAngle: theBentResistor.orientationAngle
        QQ2.Component.onCompleted: {
            console.log(" Resistor2" );
            console.log(" x " + theBentResistor.x);
            console.log(" y " + theBentResistor.y+localCalc.calcSin(resistor1.l,theBentResistor.a+localVar-90));
            console.log(" z " + theBentResistor.z+localCalc.calcCos(resistor1.l,theBentResistor.a+localVar-90));
            console.log(" a " + theBentResistor.a+localVar);
        }

    }
    Resistor{
        id: resistor5
        s: theBentResistor.s
        l: resistor1.l
        x: theBentResistor.x
        y: resistor1.y+(localCalc.calcSin(theBentResistor.l,theBentResistor.a-90)*2/3)
        z: resistor1.z+(localCalc.calcCos(theBentResistor.l,theBentResistor.a-90)*2/3)
        a: theBentResistor.a+localVar
        orientationAngle: theBentResistor.orientationAngle
        QQ2.Component.onCompleted: {
            console.log(" Resistor2" );
            console.log(" x " + theBentResistor.x);
            console.log(" y " + theBentResistor.y+localCalc.calcSin(resistor1.l,theBentResistor.a+localVar-90));
            console.log(" z " + theBentResistor.z+localCalc.calcCos(resistor1.l,theBentResistor.a+localVar-90));
            console.log(" a " + theBentResistor.a+localVar);
        }

    }
    Resistor{
        id: resistor6
        s: theBentResistor.s
        l: resistor1.l
        x: theBentResistor.x
        y: resistor5.y+localCalc.calcSin(resistor1.l,theBentResistor.a+localVar-90)
        z: resistor5.z+localCalc.calcCos(resistor1.l,theBentResistor.a+localVar-90)
        a: theBentResistor.a-localVar
        orientationAngle: theBentResistor.orientationAngle
        QQ2.Component.onCompleted: {
            console.log(" Resistor2" );
            console.log(" x " + theBentResistor.x);
            console.log(" y " + theBentResistor.y+localCalc.calcSin(resistor1.l,theBentResistor.a+localVar-90));
            console.log(" z " + theBentResistor.z+localCalc.calcCos(resistor1.l,theBentResistor.a+localVar-90));
            console.log(" a " + theBentResistor.a+localVar);
        }

    }

}
