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
    property real zCenter: z

    property bool switchIsOpen: false
    /* angle depending on wire (0, 90, 180, 270)*/
    property real orientationAngle: 0
    property real testAngle: 0
    property var clickableBals

    property var oldRotationAngle: 0
    /* angle for opening/closing switch */
    property real rotationAngle: 0
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
    QQ2.Behavior on zCenter{
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
        QQ2.Component.onCompleted: {
            bal1.switchNr = theSwitch.switchNr;
            console.log("set  bal switchNr " + bal2.switchNr)
        }
        id:bal1
        xVal: theSwitch.x
        yVal: theSwitch.yMax
        zVal: theSwitch.z


    }
    BalSwitch{
        QQ2.Component.onCompleted: {
            bal2.switchNr = theSwitch.switchNr;
            console.log("set  bal switchNr " + bal2.switchNr)

        }
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
    }
    Entity{
        components: [toFinal, finalTrans]
        Transform{
            id: finalTrans

            translation:{
                //                Qt.vector3d(x - length/2 + janx , yMax +jany,z)

                switch(orientationAngle){
                case(0):
                    Qt.vector3d(xCenter + length/2 , yCenter,zCenter)
                    break;
                case(90):
                    Qt.vector3d(xCenter, yCenter,zCenter - length/2)
                    break;
                case(180):
                    Qt.vector3d(xCenter - length/2 ,yCenter,zCenter)
                    break;
                case(270):
                    Qt.vector3d(xCenter, yCenter,zCenter + length/2)
                    break;
                default:
                    break;

                }
            }
            rotation: {

                switch(orientationAngle){
                case(0):
                    fromAxisAndAngle(Qt.vector3d(0, 0, 1), -rotationAngle - 90)
                    break;
                case(90):
                    fromAxisAndAngle(Qt.vector3d(1, 0, 0), -rotationAngle - 90)
                    break;
                case(180):
                    fromAxisAndAngle(Qt.vector3d(0, 0, 1), rotationAngle - 90)
                    break;
                case(270):
                    fromAxisAndAngle(Qt.vector3d(1, 0, 0),  rotationAngle - 90)
                    break;
                default:
                    break;

                }
            }
        }


        Entity{
            id:toFinal
            components: [somesh,theTrans]

            Transform{
                id: theTrans

                rotation: {
                    switch(orientationAngle){
                    case(0):
                        fromAxisAndAngle(Qt.vector3d(0, 1, 0),0)
                        break;
                    case(90):
                        fromAxisAndAngle(Qt.vector3d(0, 1, 0),90)
                        break;
                    case(180):
                        fromAxisAndAngle(Qt.vector3d(0, 1, 0),0)
                        break;
                    case(270):
                        fromAxisAndAngle(Qt.vector3d(0, 1, 0), 90)
                        break;
                    default:
                        break;
                    }
                }
            }

            //fromAxisAndAngle(Qt.vector3d(0, 1, 0), rotationAngle - 90)
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
                    rotation: {
                        fromAxisAndAngle(Qt.vector3d(0, 0, 1), 0)
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
        }
    }


    function openRotate(){

        switch(orientationAngle){
        case(0):
            theSwitch.xCenter = theSwitch.xCenter - length/2
            break;
        case(90):
            theSwitch.zCenter = theSwitch.zCenter + length/2
            break;
        case(180):
            theSwitch.xCenter = theSwitch.xCenter + length/2
            break;
        case(270):
            heSwitch.zCenter = theSwitch.zCenter - length/2
            break;
        default:
            break;

        }
        //theSwitch.xCenter = theSwitch.xCenter + length/2
        theSwitch.yCenter = theSwitch.yCenter + length/2
        theSwitch.rotationAngle =  theSwitch.rotationAngle - 90
        switchIsOpen =true;
    }

    function closeRotate(){
        switch(orientationAngle){
        case(0):
            theSwitch.xCenter = theSwitch.xCenter + length/2
            break;
        case(90):
            theSwitch.zCenter = theSwitch.zCenter - length/2
            break;
        case(180):
            theSwitch.xCenter = theSwitch.xCenter - length/2
            break;
        case(270):
            heSwitch.zCenter = theSwitch.zCenter + length/2
            break;
        default:
            break;

        }
        //theSwitch.xCenter = theSwitch.xCenter - length/2
        theSwitch.yCenter = theSwitch.yCenter - length/2
        theSwitch.rotationAngle =  theSwitch.rotationAngle + 90
        switchIsOpen = false;
    }


}





