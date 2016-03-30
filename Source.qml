import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import QtQuick 2.2 as QQ2


Entity{
    id:source
    property var sourceNr
    property real s: 1 //Grote van bron, bepaald door spanning
    //Positie variablen
    property real x: 0
    property real y: 0
    property real z: 0
    property bool clickable: false
    //property var clickableBal
    property var eSize: 7
    property real heightIntensity: 2

    QQ2.Behavior on s{
        QQ2.NumberAnimation{
            duration: 500
            easing.type: "InOutSine"
        }
    }

    QQ2.QtObject{

        id:o

        //Variables for spawning objects
        property var balFactory
    }



    QQ2.Component.onCompleted: {
        if(!clickable)
            clickableBal.destroy();
    }

    Bal{
        id: clickableBal
        xVal: x
        yVal: y + s;
        zVal: z
        sourceNr: source.sourceNr

    }

    Entity{
        components: [somesh,sotrans]

        Entity{
            id:somesh
            components: [cmesh,trans,material]

            CuboidMesh {
                id:mesh
                yzMeshResolution: Qt.size(2, 2)
                xzMeshResolution: Qt.size(2, 2)
                xyMeshResolution: Qt.size(2, 2)
            }

            CylinderMesh{
                id: cmesh
                radius: 1
                length: 1
            }

            Transform{
                id:trans
                translation: Qt.vector3d(0, 0.5, 0)
            }

            property Material material: DiffuseMapMaterial {
                id: theMaterial
                diffuse: "poleTexture.png"
                ambient: Qt.rgba( 1, 1, 1, 1.0 )
                specular: Qt.rgba( 1, 1, 1, 1.0 )
                shininess: 0
            }
        }

        Transform{
            id:sotrans
            translation: Qt.vector3d(x, y, z)
            scale3D : Qt.vector3d(1, (1*s) , 1)

        }
    }


}




