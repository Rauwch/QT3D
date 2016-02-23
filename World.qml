/*
  3d world
  makes cylinders
  makes controller which makes electrons
  */

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import QtQuick 2.0 as QQ2
import Link 1.0

Entity {
    id: myWorld
    property int numberOfNodes: 4
    property var targetHeight
    property var stepUp: 0
   QQ2.Component.onCompleted:{
       targetHeight = (myLinker.height+10);
   }

    //magic function that fixes all our problems
    function destroyCamera(){
        backgroud.destroy();
        myCamera.destroy();

    }
    function checkMatch(){
        if(myLinker.height === targetHeight){
            colorCylinder.diffuse = Qt.rgba(0,1,0,1);
        }
        else{
            colorCylinder.diffuse = Qt.rgba(1,1,0,1);

        }
    }

    AlphaMaterial{
        id: ourAlphaMaterial
    }

    Camera {
        id: myCamera
        projectionType: CameraLens.PerspectiveProjection
        fieldOfView: 75
        aspectRatio: 16/9
        nearPlane : 0.1
        farPlane : 1000.0
        position: Qt.vector3d( 50.0, 25.0, 50.0 )
        upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
        viewCenter: Qt.vector3d( 50.0, 0.0, 0.0 )

    }
    OceanBox{
        id:backgroud
        cameraPosition: myCamera.position
    }

//    GroundPlane {
//        id:ground
//        material: AdsMaterial {
//            diffuseColor: Qt.rgba(0.2, 0.5, 0.3, 1.0)
//            specularColor: Qt.rgba(0, 0, 0, 1.0)
//        }
//    }

    CylinderMesh {
        id: cylinderMesh
        radius: 3
        length: myLinker.height
        rings: 100
        slices: 20

    }
    CylinderMesh {
        id: cylinderMeshGhost
        radius: 2
        length: targetHeight
        rings: 100
        slices: 20


    }
    PhongMaterial{
        id: colorCylinder
        diffuse: Qt.rgba(1,1,0,1)
        specular: "white"
        shininess: 100.0
    }
    PhongMaterial{
        id: colorCylinderGhost
        diffuse: Qt.rgba(1,1,1,0.5)
        specular: "white"
        shininess: 100.0


    }



    Entity {

        id: cylinder1
        property Material material

        property Transform transform : Transform {
            id: cylindertransform
            translation: Qt.vector3d(0,(myLinker.height-25)/2,0)
        }
        property ObjectPicker objectPicker: ObjectPicker {

            onClicked: {
                myGameScreen.showBox = !myGameScreen.showBox;
                soundEffects.play()}
        }



        components: [
            cylinderMesh,
            colorCylinder,
            transform,
            objectPicker

        ]
    }
    Entity {

        id: cylinder1Goal
//        property Material material

        property Transform transform : Transform {
            id: cylindertransformGhost
            translation: Qt.vector3d(0,(35-25)/2,0)
        }


        components: [
            cylinderMeshGhost,
            colorCylinderGhost,
            transform,
            ourAlphaMaterial

        ]
    }
    Entity {

        id: cylinder2
        property Material material

        property Transform transform : Transform {
            id: cylindertransform2
            translation: Qt.vector3d(100,(myLinker.height-25)/2,0)
        }


        property ObjectPicker objectPicker: ObjectPicker {

            onClicked: {
                myGameScreen.showBox = !myGameScreen.showBox;
                soundEffects.play()}
        }



        components: [
            cylinderMesh,
            colorCylinder,
            cylindertransform2,
            objectPicker

        ]
    }

    Configuration  {
        id: theConfig
        controlledCamera: myCamera
    }

    FrameGraph {
        id : external_forward_renderer
        Viewport{
            id:mainViewport
            rect: Qt.rect(0,0,1,1)
            CameraSelector{
                id: cameraSelectors
                camera: myCamera
                ClearBuffer {
                               buffers: ClearBuffer.ColorDepthBuffer
                          }
            }
        }
    }


    //cylinder
    CylinderMesh {
        id: cylMesh
        length: 10
        radius: 2
        rings: 100
        slices: 20
    }

    Controller{
        id:myController
//        ourLinker: myLinker
    }


}

//function appendAll(){
//    i = 0
//    while(i<5){
//    entityModel.append({});
//        i++
//    }
//}



