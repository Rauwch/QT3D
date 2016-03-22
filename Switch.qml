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
    property real orientationAngle: 0
    //    property var clickableBals:[]
    property var clickableBals

    property int length: 5


    QQ2.Component.onCompleted: {

    }

    QQ2.Behavior on yMax{
        QQ2.NumberAnimation{
            duration: 1000
            easing.type: "InOutQuad"
        }
    }
    QQ2.Behavior on yMin{
        QQ2.NumberAnimation{
            duration: 1000
            easing.type: "InOutQuad"
        }
    }

    QQ2.NumberAnimation{

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
        yVal: yMin

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
                switch(orientationAngle){
                case(0):
                    Qt.vector3d(x + length/2 , yMax,z)
                    break;
                case(90):
                    Qt.vector3d(x, yMax,z - length/2)
                    break;
                case(180):
                    Qt.vector3d(x - length/2 , yMax,z)
                    break;
                case(270):
                    Qt.vector3d(x, yMax,z + length/2)
                    break;
                default:

                }
            }


            rotation: {
                switch(orientationAngle){
                case 0:
                case 180:
                    fromAxisAndAngle(Qt.vector3d(0, 0, 1), 90)
                    break;
                case 90:
                case 270:
                    fromAxisAndAngle(Qt.vector3d(0, 1, 1), 90)
                }

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

        function updateBal(){

            bal2.yVal = yMin;
        }


    }




