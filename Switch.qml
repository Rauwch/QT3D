import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import QtQuick 2.2 as QQ2


Entity{
    id:theSwitch
    property var switchNr
    //Positie variablen
    property real x: 0
    property real yMax: 0
    property real yMin: 0
    property real z: 0

    property real janSecondy: yMax
    property real janOldSecondy : 0
    property real janNewSecondy : 0
    property real janx : 0
    property real jany : 0
    property real janAngle: 0
    property real janOldx : 0
    property real janNewx: 0
    property real janOldy : 0
    property real janNewy : 0
    property real janOldAngle: 0
    property real janNewAngle: 0

    property bool switchIsOpen: false
    //angle depending on wire (0, 90, 180, 270)
    property real orientationAngle: 0
    //    property var clickableBals:[]
    property var clickableBals

    property var oldRotationAngle: 0
    //angle for opening/closing switch
    property var rotationAngle: 90
    property int length: 5


    QQ2.Component.onCompleted: {

    }
    QQ2.ParallelAnimation{
        id: switchAnimation
        running: false
        QQ2.PropertyAnimation{
            id: part1
            target: theSwitch
            easing.type: "InOutQuad"
            property: "janAngle"
            from: janOldAngle
            to: janNewAngle
            duration: 1000
        }
        QQ2.PropertyAnimation{
            id: part2
            target: theSwitch
            easing.type: "InOutQuad"
            property: "janx"
            from: janOldx
            to: janNewx
            duration: 1000
        }
        QQ2.PropertyAnimation{
            id: part3
            target: theSwitch
            easing.type: "InOutQuad"
            property: "jany"
            from: janOldy
            to: janNewy
            duration: 1000
        }
        QQ2.PropertyAnimation{
            id: part4
            target: theSwitch
            easing.type: "InOutQuad"
            property: "janSecondy"
            from: janOldSecondy
            to: janNewSecondy
            duration: 1000
        }
    }
    //    QQ2.Behavior on yMax{
    //        QQ2.NumberAnimation{
    //            duration: 1000
    //            easing.type: "InOutQuad"
    //        }
    //    }
    //    QQ2.Behavior on yMin{
    //        QQ2.NumberAnimation{
    //            duration: 1000
    //            easing.type: "InOutQuad"
    //        }
    //    }

    //    QQ2.NumberAnimation{
    //        id:switchIt
    //        target:theSwitch
    //        property: "rotationAngle"
    //        from: 180
    //        to:90
    //        duration: 1000
    //    }



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
            yVal: janSecondy

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
                Qt.vector3d(x- length/2 + janx , yMax +jany,z)

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

//    function updateBal(){

//        bal2.yVal = janSecondy;
//    }

    function rotateSwitch(){
        if(switchIsOpen){
            console.log("JAN first loop");
            janOldx = length/2;
            janOldy = length/2;
            janOldAngle = -90;

            janNewx = 0;
            janNewy = 0;
            janNewAngle = 0;

            janOldSecondy = 0;
             janNewSecondy = yMax;
//            janOldx = 0;
//            janOldy = 0;
//            janOldAngle = 0;

//            janNewx = -length/2;
//            janNewy = -length/2;
//            janNewAngle = 90;
        }
        else{
            console.log("JAN second loop");

            janOldx = 0;
            janOldy = 0;
            janOldAngle = 0;

            janNewx = length/2;
            janNewy = length/2;
            janNewAngle = -90;

            janOldSecondy = yMax;
             janNewSecondy = 0;
//            janOldx = -length/2;
//            janOldy = -length/2;
//            janOldAngle = 90;

//            janNewx = 0;
//            janNewy = 0;
//            janNewAngle = 0;
        }

        //        oldRotationAngle = 180;
        //        rotationAngle = 90;
        //updateBal();
        switchAnimation.running = true;
        switchIsOpen = !switchIsOpen;
        //switchIt.start();
    }


}




