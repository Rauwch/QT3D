/*
  ball for Switches that makes them clickable
  */
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import QtQuick 2.2 as QQ2

Entity{
    id:switchBol
    property real xVal: 0
    property real yVal: 0
    property real zVal: 0
    property real switchNr
    property real breath
    components: [mesh,bolTrans,objectPicker,material]
    SphereMesh{
        id:mesh
        radius: 1.5
    }

    //do we use this still?
    signal hasbeenclicked()
    QQ2.Component.onCompleted: {
        objectPicker.clicked.connect(hasbeenclicked);
    }

    Transform{
        id:bolTrans
        translation: Qt.vector3d(xVal,yVal,zVal)

    }
    property Material material: DiffuseMapMaterial {
        id: theMaterial
        diffuse: "Switch.jpg"
        ambient: Qt.rgba( breath, breath, breath, 1.0 )
        specular: Qt.rgba( 1, 1, 1, 1.0 )
        shininess: 0
    }

    property ObjectPicker objectPicker: ObjectPicker {

        onClicked: {
            myGameScreen.toggleSwitch(switchNr);
        }
    }

    QQ2.SequentialAnimation{


        running: true
        loops: QQ2.Animation.Infinite
        QQ2.NumberAnimation {

            target: switchBol
            property: "breath"
            duration: 1000
            from: 1
            to: 0.5
        }
        QQ2.NumberAnimation {

            target: switchBol
            property: "breath"
            duration: 1000
            from: 0.5
            to: 1
        }

    }


}
