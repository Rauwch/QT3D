import QtQuick 2.0 as QQ2
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Logic 2.0
import QtQuick 2.0 as QQ2

Entity {
    id: world3D
    property real cameraAngle: 180
    //QQ2.Component.onCompleted: { console.log("Completed world3D")}
    //CiruitMiddle
    property real x: 5
    property real y: 0
    property real z: -5

    //Zoomlevel
    property real zoomlevel: 60


    //Camera
    Camera {
        id: mainCamera
        projectionType: CameraLens.PerspectiveProjection
        fieldOfView: 45
        aspectRatio: 16 / 9
        nearPlane : 0.1
        farPlane : 1000.0
        position: Qt.vector3d(zoomlevel*Math.sin(cameraAngle*180/Math.PI)+x*generator.sf,
                              zoomlevel*0.6, -zoomlevel*Math.cos(cameraAngle*180/Math.PI)+z*generator.sf )

        //upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
        viewCenter: Qt.vector3d((x*generator.sf + generator.sf)/2+3 , 0.0, (z*generator.sf - generator.sf)/2+3)

    }


    Light{
        id: light

    }
    QQ2.Component.onCompleted: {
        console.log(" X position: " + mainCamera.position.x + " Z Position: " + mainCamera.position.z );
    }

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
