import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import QtQuick 2.2 as QQ2


Entity{
    id:theSwitch
    property var switchNr
    //Positie variablen
    property real x: 0
    property real xCenter: x
    property real yMax: 0
    property real yMin: 0
    property real yCenter: yMax
    property real z: 0

    property bool switchIsOpen: false
    /* angle depending on wire (0, 90, 180, 270)*/
    property real orientationAngle: 0
    property var clickableBals

    property var oldRotationAngle: 0
    /* angle for opening/closing switch */
    property real rotationAngle: 90
    property int length: 5

    QQ2.Behavior on xCenter{
        QQ2.NumberAnimation{
            alwaysRunToEnd: true
            duration: 500
            easing.type: "InOutSine"
        }
    }

    QQ2.Behavior on yCenter{
        QQ2.NumberAnimation{
            alwaysRunToEnd: true
            duration: 500
            easing.type: "InOutSine"
        }
    }

    QQ2.Behavior on rotationAngle{
        QQ2.NumberAnimation{
            alwaysRunToEnd: true
            duration: 500
            easing.type: "InOutSine"
        }
    }

    QQ2.Component.onCompleted: {

    }
    BalSwitch{
        id:bal1
        xVal: theSwitch.x
        yVal: theSwitch.yMax
        zVal: theSwitch.z
        switchNr: switchNr

    }
    BalSwitch{
        id:bal2
        xVal: {

            switch (theSwitch.orientationAngle){
            case(0):
                x + length;
                break;
            case(180):
                x - length;
                break;
            default:
                x
            }
        }
        yVal: theSwitch.yMin

        zVal:{
            switch(orientationAngle){
            case(90):
                z - length;
                break;
            case(270):
                z + length;
                break;

            default:
                z
            }
        }
        switchNr: switchNr
    }

    Entity{
        //            //Basismodel bron
        id:somesh
        components: [mesh,trans,material]

        CylinderMesh {
            id:mesh
            length: theSwitch.length
            radius: 1
        }


        Transform{
            id:trans
            //translation: Qt.vector3d(0, 0.5, 0)
            translation:{
                //                Qt.vector3d(x - length/2 + janx , yMax +jany,z)
                Qt.vector3d(xCenter - length/2 , yCenter,z)

                //                switch(orientationAngle){
                //                case(0):
                //                    console.log("JAN case0");
                //                    //Qt.vector3d(Math.cos(theSwitch.rotationAngle*180/Math.PI)*length+x,Math.sin(theSwitch.rotationAngle*180/Math.PI)*length+ymax, z)
                //                    //Qt.vector3d(x + length/2 , yMax,z)
                //                    Qt.vector3d(x + length/2 , yMax,z)

                //                    break;
                //                case(90):
                //                    console.log("JAN case1");

                //                    Qt.vector3d(x, yMax,z - length/2)
                //                    break;
                //                case(180):
                //                    console.log("JAN case2");

                //                    //Qt.vector3d(-Math.cos(theSwitch.rotationAngle*180/Math.PI)*length/2 + x,Math.sin(theSwitch.rotationAngle*180/Math.PI)*length/2+yMax, z)
                //                    //Qt.vector3d(x - length/2 , yMax,z)
                //                    Qt.vector3d(x , yMax + length/2,z)
                //                    break;
                //                case(270):
                //                    console.log("JAN case3");

                //                    Qt.vector3d(x, yMax,z + length/2)
                //                    break;
                //                default:

                //                }
            }


            rotation: {
                fromAxisAndAngle(Qt.vector3d(0, 0, 1), -180 + rotationAngle + janAngle);

                //                switch(orientationAngle){
                //                case 0:
                //                case 180:
                //                    fromAxisAndAngle(Qt.vector3d(0, 0, 1), -90 + rotationAngle - 90)
                //                    break;
                //                case 90:
                //                case 270:
                //                    fromAxisAndAngle(Qt.vector3d(0, 1, 1), rotationAngle - 90)
                //                }

            }


        }
        property Material material: DiffuseMapMaterial {
            id: theMaterial
            diffuse: "Switch.jpg"
            ambient: Qt.rgba( 1, 1, 1, 1.0 )
            specular: Qt.rgba( 1, 1, 1, 1.0 )
            shininess: 0
        }
    }
    function openRotate(){
        theSwitch.xCenter = theSwitch.xCenter + length/2
        theSwitch.yCenter = theSwitch.yCenter + length/2
        theSwitch.rotationAngle =  theSwitch.rotationAngle - 90
        switchIsOpen =true;
    }

    function closeRotate(){
        theSwitch.xCenter = theSwitch.xCenter - length/2
        theSwitch.yCenter = theSwitch.yCenter - length/2
        theSwitch.rotationAngle =  theSwitch.rotationAngle + 90
        switchIsOpen = false;
    }


}




