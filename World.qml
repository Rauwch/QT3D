import Qt3D.Core 2.0
import Qt3D.Render 2.0
import QtQuick 2.0 as QQ2
import Link 1.0

Entity {
    id: myWorld
    property int numberOfNodes: 4
    Camera {
        id: camera
        projectionType: CameraLens.PerspectiveProjection
        fieldOfView: 45
        aspectRatio: 16/9
        nearPlane : 0.1
        farPlane : 1000.0
        position: Qt.vector3d( 0.0, 0.0, 50.0 )
        upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
        viewCenter: Qt.vector3d( 0.0, 0.0, 0.0 )
    }

    GroundPlane {
        id:ground
        material: AdsMaterial {
            diffuseColor: Qt.rgba(0.2, 0.5, 0.3, 1.0)
            specularColor: Qt.rgba(0, 0, 0, 1.0)
        }

    }

    CylinderMesh {
        id: cylinderMesh
        radius: 1
        length: myLinker.height
        rings: 100
        slices: 20
    }
    PhongMaterial{
        id: colorCylinder
        diffuse: Qt.rgba(1,1,0,1)
        specular: "white"
        shininess: 100.0
    }




    Entity {

        id: cylinder1
        property Material material

        property Transform transform : Transform {
            id: cylindertransform
            translation: Qt.vector3d(0,-2.5,0)
        }
        property ObjectPicker objectPicker: ObjectPicker {

            onClicked: {mainWindow.showBox = !mainWindow.showBox }
        }



        components: [
            cylinderMesh,
            colorCylinder,
            transform,
            objectPicker

        ]
    }

    Configuration  {
        controlledCamera: camera
    }

    FrameGraph {
        id : external_forward_renderer
        Viewport{
            id:mainViewport
            rect: Qt.rect(0,0,1,1)
            clearColor: "black"
            CameraSelector{
                id: cameraSelectors
                camera: camera
                ClearBuffer {
                               buffers: ClearBuffer.ColorDepthBuffer
                          }
            }
        }
    }

    NodeInstantiator {
          id: collection
          property int maxCount: parent.numberOfNodes
          model: maxCount

          delegate: NodeEntity {
              id: cubicEntity
              entityMesh: cylMesh
              entityIndex: index
              entityCount: myWorld.numberOfNodes
              magnitude: 0
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

    QQ2.ListModel{
        id: entityModel
        QQ2.ListElement{emptyRole: 0}
    }




}

//function appendAll(){
//    i = 0
//    while(i<5){
//    entityModel.append({});
//        i++
//    }
//}



