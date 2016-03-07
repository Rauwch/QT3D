import QtQuick 2.3 as QQ2
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Logic 2.0


Entity {
    id: world3D
    property real cameraAngle

    //CiruitMiddle
    property real x: 4.5
    property real y: 0
    property real z: -4.5

    //Zoomlevel
    property real zoomlevel: 40


    //Camera
    Camera {
        id: camera
        projectionType: CameraLens.PerspectiveProjection
        fieldOfView: 45
        aspectRatio: _view.width / _view.height
        nearPlane : 0.1
        farPlane : 1000.0
        position: Qt.vector3d( 0.0, 0.0, -40.0 )
        upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
        viewCenter: Qt.vector3d( 0.0, 0.0, 0.0 )
    }

    Configuration {
        controlledCamera: camera
    }

    components: FrameGraph {
        ForwardRenderer {
            camera: camera
            clearColor: "black"
        }
    }
    SphereMesh {
        id: sphereMesh
    }

    Entity {
        id: sphere3

        property Material material: PhongMaterial {
            diffuse: "yellow"
        }

        property bool toggled: false
        property real scaleFactor: toggled ? 5.0 : 0.5
        QQ2.Behavior on scaleFactor { QQ2.NumberAnimation { duration: 200; easing.type: QQ2.Easing.InQuad } }

        property Transform transform: Transform {
            scale: sphere3.scaleFactor
            translation: Qt.vector3d(0, 0, 0)
        }

        property ObjectPicker objectPicker: ObjectPicker {
            hoverEnabled: false

            onPressed: sphere3.toggled = !sphere3.toggled

            onEntered: sphere3.material.ambient = "black"
            onExited: sphere3.material.ambient = "white"

            onClicked: console.log("Clicked Sphere 3")
        }

        components: [sphereMesh, material, transform, objectPicker]
    }


}
