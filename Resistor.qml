import Qt3D.Core 2.0
import Qt3D.Render 2.0
import QtQuick 2.2 as QQ2



Entity{
    id:node
    property real s: 1 //bepaald dikte vd weerstand, afhankelijk van weestandswaarde
    property real l: 1 //bepaald lengte vd weerstand, afhankelijk van spanning over weerstand

    //Variablen voor posistie
    property real x: 0
    property real y: 0
    property real z: 0


    //Variable voor hoek.
    property real a: 90 //Hoek volgens z as,bepaald door spanning over weerstand
    property real orientationAngle: 0 //Hoek volgens y as, bepaald door plaatsing weerstand


//    QQ2.Behavior on s{
//        QQ2.NumberAnimation{
//            duration: 1000
//            easing.type: "InOutQuad"
//        }
//    }

//    QQ2.Behavior on a{
//        QQ2.NumberAnimation{
//            duration: 1000
//            easing.type: "InOutQuad"
//        }
//    }
//    QQ2.Behavior on l{
//        QQ2.NumberAnimation{
//            duration: 1000
//            easing.type: "InOutQuad"
//        }
//    }

//    QQ2.Behavior on y{
//        QQ2.NumberAnimation{
//            duration: 1000
//            easing.type: "InOutQuad"
//        }
//    }

//    QQ2.Behavior on x{
//        QQ2.NumberAnimation{
//            duration: 1000
//            easing.type: "InOutQuad"
//        }
//    }
//    QQ2.Behavior on z{
//        QQ2.NumberAnimation{
//            duration: 1000
//            easing.type: "InOutQuad"
//        }
//    }

    components: [finmesh,fintrans]//,objectPicker]


    Entity{
        //Weerstand met juiste waardes, zonder plaatsing
        id:finmesh
        components: [resmesh,retrans]

        Entity{
            //Basismodel weestand
            id:resmesh
            components: [mesh, trans,material]

            CylinderMesh {
                id:mesh
                radius: 1
                length: 1
            }

            Transform{

                id:trans
                translation: Qt.vector3d(0, -0.5, 0)

            }

            property Material material: DiffuseMapMaterial {
                id: theMaterial
                diffuse: "resistorTexture.png"
                ambient: Qt.rgba( 1, 1, 1, 1.0 )
                specular: Qt.rgba( 1, 1, 1, 1.0 )
                shininess: 0
            }

        }


        Transform{
            id:retrans
            matrix: {
                var m = Qt.matrix4x4()
                m.rotate(a,(Qt.vector3d(0, 0, 1)));
                m.scale(1);
                return m;
            }
            scale3D: Qt.vector3d(0.005*s,l,0.005*s)
        }
    }
    //    Entity{
    //        id:tilted1
    //        components: [finmesh,fintrans]
    //    }
    //    Entity{
    //        id:tilted2
    //        components: [finmesh,fintrans2]
    //    }

    Transform{
        id:fintrans
        rotation: fromAxisAndAngle(Qt.vector3d(0,1,0),orientationAngle)
        translation: (Qt.vector3d(x, y, z))
    }
    //    Transform{
    //        id:fintrans
    //        rotation: fromAxisAndAngle(Qt.vector3d(0,1,0),orientationAngle-45)
    //        translation: (Qt.vector3d(x, y, z))
    //    }


    //    property ObjectPicker objectPicker: ObjectPicker {
    //        hoverEnabled: true;
    //        onEntered: console.log("hover")
    //        onExited: console.log("exit hover")
    //        onClicked: {
    //            console.log("clicked on a resistor");
    //            myGameScreen.showBox = !myGameScreen.showBox;
    //        }
    //    }

}



