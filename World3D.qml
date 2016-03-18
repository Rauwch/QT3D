import QtQuick 2.0 as QQ2
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Logic 2.0

Entity {
    id: world3D
    //property real cameraAngle: 100
    property real cameraAngle: Math.PI/4
    //QQ2.Component.onCompleted: { console.log("Completed world3D")}
    //CiruitMiddle
    property real x: 3
    property real y: 0
    property real z: -3

    //Zoomlevel
    property real zoomlevel: 60



    //    Camera {
    //        id: mainCamera
    //        projectionType: CameraLens.PerspectiveProjection
    //        fieldOfView: 45
    //        aspectRatio: 16 / 9
    //        nearPlane : 0.1
    //        farPlane : 1000.0
    //        //why is this not constant
    //        position: Qt.vector3d(zoomlevel*Math.sin(cameraAngle*180/Math.PI)+x*generator.sf,
    //                              zoomlevel*0.6, -zoomlevel*Math.cos(cameraAngle*180/Math.PI)+z*generator.sf )
    //        viewCenter: Qt.vector3d((x*generator.sf + generator.sf)/2+3 , 0.0, (z*generator.sf - generator.sf)/2+3)
    //    }

    Camera {
        id: mainCamera
        projectionType: CameraLens.PerspectiveProjection
        fieldOfView: 45
        aspectRatio: 16 / 9
        viewCenter: Qt.vector3d(15 , 12.0, -15)
        upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
        nearPlane : 0.1
        farPlane : 1000.0
        position: Qt.vector3d(50*Math.sin(cameraAngle)+3*5,40,50*Math.cos(cameraAngle)-3*5)
    }

    //        Camera {
    //            id: mainCamera
    //            projectionType: CameraLens.PerspectiveProjection
    //            fieldOfView: 45
    //            aspectRatio: 16 / 9
    //            viewCenter: Qt.vector3d(15 , 0.0, -15)
    //            upVector: Qt.vector3d( 0.0, 1.0, 0.0 )

    //            position: Qt.vector3d(zoomlevel*Math.sin(cameraAngle)+x, zoomlevel, -zoomlevel*Math.cos(cameraAngle)-z)

    //        }
    function dontChangeCamera(){
        entireAnimation.running = false;
    }

    function changeCamera(){
        //mainCamera.position = Qt.vector3d(50*Math.sin(cameraAngle+Math.PI/2)+3*5,40,50*Math.cos(cameraAngle+Math.PI/2)-3*5);

        //        cameraAngle += Math.PI/20;
//        mainCamera.viewCenter= Qt.vector3d(15 , 10.0, -15);
//        mainCamera.upVector= Qt.vector3d( 0.0, 1.0, 0.0 );
        entireAnimation.running = true;

    }
    QQ2.ParallelAnimation{
        id: entireAnimation
        alwaysRunToEnd: false
//        QQ2.PropertyAnimation{
//            alwaysRunToEnd: false
//            loops: QQ2.Animation.Infinite
//            id: animation2
//            target: mainCamera
//            property: "viewCenter"
//            from: Qt.vector3d(15 , 10.0, -15)
//            to: Qt.vector3d(15 , 10.0, -15)
//            duration: 10000/2

//        }
        QQ2.PropertyAnimation{
            id: animation3
            loops: QQ2.Animation.Infinite
            alwaysRunToEnd: false
            target: mainCamera
            property: "upVector"
            from: Qt.vector3d( 0.0, 1.0, 0.0 )
            to: Qt.vector3d( 0.0, 1.0, 0.0 )
            duration: 10000/2

        }
        QQ2.PropertyAnimation{
            id: animation
            loops: QQ2.Animation.Infinite
            alwaysRunToEnd: false
            target: world
            property: "cameraAngle"
            from: cameraAngle
            to: cameraAngle+2*Math.PI
            duration: 10000/2

        }
    }

    Camera {
        id: mainCamera2
        projectionType: CameraLens.PerspectiveProjection
        fieldOfView: 45
        aspectRatio: 16 / 9
        viewCenter: Qt.vector3d(15 , 10.0, -15)
        upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
        //            nearPlane : 0.1
        //            farPlane : 1000.0
        position: Qt.vector3d(zoomlevel*Math.sin(cameraAngle+Math.PI)+x, zoomlevel, -zoomlevel*Math.cos(cameraAngle+Math.PI)-z)

    }

    Light{
        id: light

    }
//    Bal{
//        xVal: 5*5
//        yVal: 0
//        zVal : -1*5
//    }
//    //good
//    Bal{
//        xVal: 1*5
//        yVal: 0
//        zVal : -1*5
//    }
//    Bal{
//        xVal: 5*5
//        yVal: 0
//        zVal : -5*5
//    }
//    //good
//    Bal{
//        xVal: 1*5
//        yVal: 0
//        zVal : -5*5
//    }
//    Bal{
//        xVal: 3*5
//        yVal: 0
//        zVal : -3*5
//    }

    QQ2.Component.onCompleted: {
        //console.log(" X position: " + mainCamera.position.x + " Z Position: " + mainCamera.position.z );
    }

    function destroyCamera(){
        background.destroy();
        mainCamera.destroy();
        console.log("destroy camera")

    }

    //Render settings
    //        FrameGraph {
    //            id : forward_renderer
    //            Viewport {
    //                rect: Qt.rect(0.0, 0.0, 1.0, 1.0)
    //                clearColor: "black"

    //                ClearBuffer {
    //                    buffers : ClearBuffer.ColorDepthBuffer

    //                }

    //                CameraSelector {
    //                    camera: mainCamera

    //                }
    //            }
    //        }
    //        components: forward_renderer



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

}
