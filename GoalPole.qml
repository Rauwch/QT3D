import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import QtQuick 2.2 as QQ2


Entity{
    id:goalPole

    //property real s: 1 //Grote van bron, bepaald door spanning


    //Positie variablen
    property real x: 0
    property real y: 0
    property real z: 0



    components: [somesh,sotrans]
    QQ2.Component.onCompleted: {
        console.log("pole x y z: " + x + " " + y + " " + z);

    }
    function setGreen(){
        theMaterial.diffuse = "goalPoleGo.png";
        console.log("GREEN");
        cubeTop.setGreen();
        cubeBottom.setGreen();


    }
    function setRed(){
        theMaterial.diffuse = "goalPole.png";
        console.log("RED");
        cubeTop.setRed();
        cubeBottom.setRed();
    }
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
            diffuse: "goalPole.png"
            ambient: Qt.rgba( 1, 1, 1, 1.0 )
            specular: Qt.rgba( 1, 1, 1, 1.0 )
            shininess: 0
        }

        AlphaMaterial{
            id: ourAlphaMaterial
        }
    }


    Transform{
        id:sotrans
        translation: Qt.vector3d(x, 0, z)
        //scale3D : Qt.vector3d(2, 1*s, 2)
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




}
