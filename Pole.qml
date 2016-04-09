import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import QtQuick 2.2 as QQ2


Entity{
    id:pole

    //property real s: 1 //Grote van bron, bepaald door spanning


    //Positie variablen
    property real x: 0
    property real y: 0
    property real z: 0

    property int nodeOfWire: 0

    QQ2.Behavior on y{
        QQ2.NumberAnimation{
            duration: 500
            easing.type: "InOutSine"
        }
    }

    components: [somesh,sotrans]


    Entity{
        id:somesh
        components: [mesh,trans,material]

        CuboidMesh {
            id:mesh
            yzMeshResolution: Qt.size(2, 2)
            xzMeshResolution: Qt.size(2, 2)
            xyMeshResolution: Qt.size(2, 2)
        }

        Transform{
            id:trans
            translation: Qt.vector3d(0, 0.5, 0)
        }

        property Material material: DiffuseMapMaterial {
            // #crash#
            //Failed to load image :  ":/postTexture.png"
            //Texture data is null, texture data failed to load
            id: theMaterial
            diffuse: "postTexture.png"
            ambient: Qt.rgba( 1, 1, 1, 1.0 )
            specular: Qt.rgba( 1, 1, 1, 1.0 )
            shininess: 0
        }
    }


    Transform{
        id:sotrans
        translation: Qt.vector3d(x, 0, z)
        //scale3D : Qt.vector3d(2, 1*s, 2)
        scale3D : Qt.vector3d(0.5, 1*y, 0.5)


    }


}

