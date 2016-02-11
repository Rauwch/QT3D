import Qt3D.Core 2.0
import Qt3D.Render 2.0
import QtQuick 2.0 as QQ2
import Link 1.0

Entity {
    id: myWorld
    property int numberOfNodes: 100
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


    //cylinder
//    CylinderMesh {
//        id: cylMesh
//        length: 10
//        radius: 2
//        rings: 100
//        slices: 20
//    }

    QQ2.ListModel{
        id: entityModel
        QQ2.ListElement{emptyRole: 0}
    }

    NodeInstantiator {
        id: collection
        property int _count: 0
        property real spacing: 5
        property int cols: 8
        property int _rows: count/cols

        model: entityModel
        delegate: NodeEntity {
            id: myEntity
            position: Qt.vector3d(collection.spacing * (index % collection.cols - 0.5 * (collection.cols - 1)),
                                  0.0,collection.spacing * (Math.floor(index / collection.cols) - 0.5 * collection._rows));
//
//            entityMesh: cylMesh
//            property Material material

//            entityIndex: index
//            entityCount: myWorld.numberOfNodes
//            magnitude: 0
//            property Transform transform : Transform {
//                id: nodetransform
//                translation: Qt.vector3d(10,-2.5,0)
//            }
//            appendAll()

//            QQ2.Timer {
//                interval: 10
//                repeat: false
//                running: true
//                onTriggered: {
//                    entityModel.append({});
//                }


//            }

        }

    }

//    Visualizer {
//        id: visualizer
//        animationState: mainview.state
//        numberOfBars: 120
//    }
}

//function appendAll(){
//    i = 0
//    while(i<5){
//    entityModel.append({});
//        i++
//    }
//}



