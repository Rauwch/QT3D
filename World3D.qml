import QtQuick 2.0 as QQ2
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Logic 2.0

Entity {
    id: world3D
    //property real cameraAngle: 100
    property real cameraAngle: Math.PI/4
    //CiruitMiddle
    property real x: 3
    property real y: 0
    property real z: -3

    //Zoomlevel
    property real zoomlevel: 50

    QQ2.Component.onCompleted: {
        startUpAnimation.running= true;
    }
    Camera {
        id: mainCamera
        projectionType: CameraLens.PerspectiveProjection
        fieldOfView: 45
        aspectRatio: 16 / 9
        viewCenter: Qt.vector3d(15 , 12.0, -15)
        upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
        nearPlane : 0.1
        farPlane : 1000.0
        position: Qt.vector3d(zoomlevel*Math.sin(cameraAngle)+x*generator.sf,4/5*zoomlevel,zoomlevel*Math.cos(cameraAngle)+z*generator.sf)
    }

    QQ2.ParallelAnimation{
        id: entireAnimation
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
    QQ2.ParallelAnimation{
        id: startUpAnimation
        running: false

        QQ2.PropertyAnimation{
            id: startUpCam
            alwaysRunToEnd: false
            target: mainCamera
            easing.type: "InOutSine"
            property: "position"
            from: Qt.vector3d(50*Math.sin(cameraAngle)+3*5,70,50*Math.cos(cameraAngle)-3*5)
            to: Qt.vector3d(50*Math.sin(cameraAngle)+3*5,40,50*Math.cos(cameraAngle)-3*5)
            duration: 10000/5
        }
        QQ2.PropertyAnimation{
            id: startUpGroundplane
            alwaysRunToEnd: false
            target: myGroundPlane
            easing.type: "InOutSine"
            property: "planeHeight"
            from: Qt.vector3d(50,30,0)
            to: Qt.vector3d(50,0,0)
            duration: 10000/5
        }
    }

    components: FrameGraph {
        ForwardRenderer {
            camera: mainCamera
            clearColor: "black"
        }
    }

    //World generation
    property Entity generator: Generator{
        id:generator
    }
    OceanBox{
        id:background
        cameraPosition: mainCamera.position
    }
//    GroundPlane{
//        id: myGroundPlane
//    }

    function destroyCamera(){
//        background.destroy();
//        mainCamera.destroy();
//        console.log("destroy camera")
    }

    function dontChangeCamera(){
        entireAnimation.running = false;
    }

    function changeCamera(){
        entireAnimation.running = true;
    }

}
