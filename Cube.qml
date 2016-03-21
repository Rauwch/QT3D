/*
  this is used for the GoalPole, to clearly indicate its top and bottom (the flat squares)
  */

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
        components: [cubeMesh,material]
        CuboidMesh {
            id:cubeMesh
            yzMeshResolution: Qt.size(2, 2)
            xzMeshResolution: Qt.size(2, 2)
            xyMeshResolution: Qt.size(2, 2)
        }
        property Material material: DiffuseMapMaterial {
            id: theMaterial
            diffuse: "t0017_0.png"
            ambient: Qt.rgba( 1, 1, 1, 1.0 )
            specular: Qt.rgba( 1, 1, 1, 1.0 )
            shininess: 0
        }

    }
    Transform{
        id:theCubeTrans
        translation.y: yVal
        scale3D : Qt.vector3d(5, 0.02, 5)


    }
    function setRed(){
        theMaterial.diffuse = "t0017_0.png";
    }
    function setGreen(){
        theMaterial.diffuse = "t0044_0.png";
    }
}
