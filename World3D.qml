import QtQuick 2.0 as QQ2
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Logic 2.0


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
    Camera {
        id: mainCamera
        projectionType: CameraLens.PerspectiveProjection
        fieldOfView: 60
        aspectRatio: 16/9
        //position: Qt.vector3d( 50.0, 25.0, 50.0 )
        upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
        //viewCenter: Qt.vector3d( 50.0, 0.0, 0.0 )
        position: Qt.vector3d(zoomlevel*Math.sin(cameraAngle*180/Math.PI)+x*generator.sf*0, 2*zoomlevel, -zoomlevel*Math.cos(cameraAngle*180/Math.PI)+z*generator.sf*0 )
        //viewCenter: Qt.vector3d(0,0,0)
        viewCenter: Qt.vector3d(x*generator.sf, 0.0, z*generator.sf)
    }

    Camera {
        id: myCamera
        projectionType: CameraLens.PerspectiveProjection
        fieldOfView: 75
        aspectRatio: 16/9
        nearPlane : 0.1
        farPlane : 1000.0
        position: Qt.vector3d( 0, 30.0, 0.0 )
        upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
        //viewCenter: Qt.vector3d(x*generator.sf, 0.0, z*generator.sf)
        viewCenter: Qt.vector3d(0,0,0)

    }

    function destroyCamera(){
        background.destroy();
        mainCamera.destroy();
        console.log("destroy camera")

    }

    //Render settings
    FrameGraph {
        id : forward_renderer
        Viewport {
            rect: Qt.rect(0.0, 0.0, 1.0, 1.0)
            clearColor: "black"

            ClearBuffer {
                buffers : ClearBuffer.ColorDepthBuffer

            }

            CameraSelector {
                camera: mainCamera

            }
        }
    }


    components: [forward_renderer]

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
