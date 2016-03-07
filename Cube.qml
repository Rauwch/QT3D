import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import QtQuick 2.2 as QQ2

Entity{
    id:theBlock
    property real xVal: 0
    property real yVal: 0
    property real zVal: 0
    components: [theCubeMesh,theCubeTrans]

    Entity{
    id:theCubeMesh
    components: [cubeMesh,cubeMat]
    CuboidMesh {
        id:cubeMesh
        yzMeshResolution: Qt.size(2, 2)
        xzMeshResolution: Qt.size(2, 2)
        xyMeshResolution: Qt.size(2, 2)
    }
    PhongMaterial {
        id:cubeMat
        diffuse: "yellow"
        ambient: "yellow"
        specular: "yellow"
        shininess: 0
    }
//    Transform{
//        id:cubeTrans
//        translation: Qt.vector3d(0, 0.5, 0)
//    }
    }
    Transform{
        id:theCubeTrans
        translation.y: yVal
        scale3D : Qt.vector3d(5, 0.01, 5)


    }
}
