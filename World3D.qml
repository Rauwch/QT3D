import QtQuick 2.0 as QQ2
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Logic 2.0
import QtQuick 2.0 as QQ2

Entity {
    id: world3D
    property real cameraAngle: -45

    //CiruitMiddle
    property real x: 4.5
    property real y: 0
    property real z: -4.5

    //Zoomlevel
    property real zoomlevel: 15


    //Camera


//    Camera {
//        id: mainCamera
//        projectionType: CameraLens.PerspectiveProjection
//        fieldOfView: 5
//        aspectRatio: 16/9
//        nearPlane : 0.1
//        farPlane : 1000.0
//        position: Qt.vector3d( 50.0, 25.0, 50.0 )
//        upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
//        //viewCenter: Qt.vector3d(x*generator.sf, 0.0, z*generator.sf)
//        viewCenter: Qt.vector3d(0,0,0)

//      }

    function destroyCamera(){
        background.destroy();
        mainCamera.destroy();
        console.log("destroy camera")

    }

    //Render settings
//    FrameGraph {
//        id : forward_renderer
//        Viewport {
//            rect: Qt.rect(0.0, 0.0, 1.0, 1.0)
//            clearColor: "black"

//            ClearBuffer {
//                buffers : ClearBuffer.ColorDepthBuffer

//            }

//            CameraSelector {
//                camera: mainCamera

//            }
//        }
//    }
//    components: forward_renderer

    Camera {
        id: mainCamera
        projectionType: CameraLens.PerspectiveProjection
        fieldOfView: 45
        aspectRatio: 16 / 9
        nearPlane : 0.1
        farPlane : 1000.0
        position: Qt.vector3d( 50.0, 25.0, 50.0 )
        upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
        viewCenter: Qt.vector3d( 0.0, 0.0, 0.0 )
    }

    Configuration {
        controlledCamera: mainCamera
    }

    components: FrameGraph {
        ForwardRenderer {
            camera: mainCamera
            clearColor: "black"
        }
    }



    //components: [forward_renderer]

    //World generation
    property Entity generator: Generator{
        id:generator
    }

    OceanBox{
        id:background
        cameraPosition: mainCamera.position
    }

    GroundPlane{
        id: myGroundPlane
    }










    //    SphereMesh {
    //        id: sphereMesh
    //    }

    //    Entity {
    //        id: sphere1

    //        property Material material: PhongMaterial {
    //            ambient: sphere1.objectPicker1.containsMouse ? "blue" : "red"
    //        }

    //        property Transform transform: Transform {
    //            scale: 5
    //            translation: Qt.vector3d(0, 0, 0)
    //        }

    //        property ObjectPicker objectPicker1: ObjectPicker {
    //            hoverEnabled: true

    //            onPressed: sphere1.material.diffuse = "white"
    //            onReleased: sphere1.material.diffuse = "red"

    //            onClicked: {
    //                console.log("Clicked Sphere 1");

    //            }
    //        }

    //        components: [sphereMesh, material, transform, objectPicker1]
    //    }

}
