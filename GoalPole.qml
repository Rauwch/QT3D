import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import QtQuick 2.2 as QQ2


Entity{
    id:goalPole

    //Positie variablen
    property real x: 0
    property real y: 0
    property real z: 0


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
            id: theMaterial
            diffuse: "t0017_0.png"
            ambient: Qt.rgba( 1, 1, 1, 1.0 )
            specular: Qt.rgba( 1, 1, 1, 1.0 )
            shininess: 0
        }
    }

    Transform{
        id:sotrans
        translation: Qt.vector3d(x, 0, z)
        scale3D : Qt.vector3d(1, 1*y, 1)
    }

    Cube{
        id: cubeTop
        xVal: goalPole.x
        yVal: 1
        zVal: goalPole.z
    }
    Cube{
        id: cubeBottom
        xVal: goalPole.x
        yVal: 0
        zVal: goalPole.z
    }

    function setGreen(){
        console.log(" in goal pole set green");
        theMaterial.diffuse = "t0044_0.png";
        cubeTop.setGreen();
        cubeBottom.setGreen();
    }
    function setRed(){
        console.log(" in goal pole set red");
        theMaterial.diffuse = "t0017_0.png";
        cubeTop.setRed();
        cubeBottom.setRed();
    }

}
