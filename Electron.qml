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

    property real speed: 0
    // richting in welke de elektronen zich begeven
    property int direction


    Mesh{
        id: electronMesh
        source: "OctopusFree_OBJ/OctopusFree.obj"
    }
    QQ2.Component.onCompleted: {
        console.log("electron gemaakt");
        currentPosition = startPosition;
        electronTransform.beginAnimation2 = beginAnimation;
        electronTransform.endAnimation2 = endAnimation;
        electronTransform.startPosition2 = startPosition;
        electronTransform.currentPosition2 = currentPosition;

    }

    property Transform transform: Transform {

        id: electronTransform
        //begin en einde positie van animatie
        property vector3d beginAnimation2
        property vector3d endAnimation2

        //start plaats
        property vector3d startPosition2
        property vector3d currentPosition2


        translation: currentPosition2
        rotation: fromAxisAndAngle(Qt.vector3d(0, 1, 0),0 )
    }

    QQ2.SequentialAnimation{
        id: electronMovement
        loops:QQ2.Animation.Infinite
        running: true
        QQ2.Vector3dAnimation {target:electronTransform; property: "currentPosition2"; to: "endAnimation2"; duration:1000; easing.type: QQ2.Easing.Linear}
        QQ2.Vector3dAnimation {target:electronTransform; property: "currentPosition2"; to: "beginAnimation2"; duration:0; easing.type: QQ2.Easing.Linear}
        QQ2.Vector3dAnimation {target:electronTransform; property: "currentPosition2"; to: "startPosition2"; duration:1000; easing.type: QQ2.Easing.Linear}



    }


    components: [electronMesh,electronTransform]

}
