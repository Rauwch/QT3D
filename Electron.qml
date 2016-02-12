import QtQuick 2.0 as QQ2
import Qt3D.Core 2.0
import Qt3D.Render 2.0
Entity{

    id:electron
    //begin en einde positie van animatie
    property vector3d beginAnimation
    property vector3d endAnimation

    //start plaats
    property vector3d startPosition
    property vector3d currentPosition
    currentPosition: startPosition
    property real speed: 0
    // richting in welke de elektronen zich begeven
    property int direction


    Mesh{
        id: electronMesh
        source: "OctopusFree_OBJ/OctopusFree.obj"
    }
    QQ2.Component.onCompleted: {
        console.log("electron gemaakt");
        console.log("Dit is de begin animatie plaats " + beginAnimation)
        console.log("Dit is de eind animatie plaats " + endAnimation)
        console.log("Dit is de start plaats " + startPosition)
        console.log("Dit is de current plaats " + currentPosition)

    }

    property Transform transform: Transform {

        id: electronTransform

        translation: currentPosition
        rotation: fromAxisAndAngle(Qt.vector3d(0, 1, 0),0 )
    }

    QQ2.SequentialAnimation{
        id: electronMovement
        loops:QQ2.Animation.Infinite
        running: true

        QQ2.Vector3dAnimation {target:electron; property: "currentPosition"; to: "endAnimation"; duration:1000; easing.type: QQ2.Easing.Linear}
        //QQ2.Vector3dAnimation {target:electron; property: "currentPosition"; to: "beginAnimation"; duration:0; easing.type: QQ2.Easing.Linear}
        //QQ2.Vector3dAnimation {target:electron; property: "currentPosition"; to: "startPosition"; duration:1000; easing.type: QQ2.Easing.Linear}



    }


    components: [electronMesh,electronTransform]

}
