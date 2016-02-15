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
    property real currentPosX
    property real currentPosY
    property real currentPosZ
    property real speed
    // richting in welke de elektronen zich begeven
    property int direction


    Mesh{
        id: electronMesh
        source: "OctopusFree_OBJ/OctopusFree.obj"
    }

    QQ2.Component.onCompleted: {
        currentPosX= startPosition.x;
        currentPosY= startPosition.y;
        currentPosZ= startPosition.z;
        currentPosition.x = currentPosX;
        currentPosition.y = currentPosY;
        currentPosition.z = currentPosZ;
        console.log("electron gemaakt");
        console.log("beginAnimation.x: " + beginAnimation.x);
        console.log("endAnimation: " + endAnimation);
        console.log("startPosition: " + startPosition);
        console.log("currentPosition: " + currentPosition);
        console.log("currentPosX: " + currentPosX);
        console.log("currentPosY: " + currentPosY);
        console.log("currentPosZ: " + currentPosZ);
//        testThis.paused= false;
    }


    property Transform transform: Transform {
        id: electronTransform
//        translation: currentPosition
       translation: Qt.vector3d(currentPosX, currentPosY, currentPosZ)
//        translation.x: currentPosX
//        translation.y: currentPosY
//        translation.z: currentPosZ
        rotation: fromAxisAndAngle(Qt.vector3d(0, 1, 0),1 )
    }
        QQ2.SequentialAnimation on currentPosX{
            id: testThis
            loops: QQ2.Animation.infinite
            QQ2.PropertyAnimation { from: startPosition.x; to: 0; duration: (startPosition.x-0)*100 }
            QQ2.PropertyAnimation { from: 0; to: 40; duration: 0 }
            QQ2.PropertyAnimation { from: 40; to: startPosition.x; duration: (40-startPosition.x)*100 }

        }


    //    QQ2.SequentialAnimation on currentPosY{
//        loops: QQ2.Animation.Infinite
//        QQ2.PropertyAnimation { to: 15; duration: 1000 }
//    }

//    QQ2.SequentialAnimation{
//        id: electronMovement
//        loops:QQ2.Animation.Infinite
//        running: true

//        QQ2.Vector3dAnimation {target:electron; property: "currentPosX"; to: 5; duration:1000; easing.type: QQ2.Easing.Linear}
//       // QQ2.Vector3dAnimation {target:electronTransform; property: "translation"; to: "endAnimation"; duration:1000; easing.type: QQ2.Easing.Linear}
//       // QQ2.Vector3dAnimation {target:electron; property: "beginAnimation"; to: "currentPosition"; duration:1000; easing.type: QQ2.Easing.Linear}
//    }
//    QQ2.SequentialAnimation{
//        id: electronMovement2
//        loops:QQ2.Animation.Infinite
//        running: true

//        QQ2.Vector3dAnimation {target:electron; property: "currentPosition"; to: "beginAnimation"; duration:1000; easing.type: QQ2.Easing.Linear}
//        //QQ2.Vector3dAnimation {target:electron; property: "endAnimation"; to: "beginAnimation"; duration:1000; easing.type: QQ2.Easing.Linear}
//       // QQ2.Vector3dAnimation {target:electron; property: "beginAnimation"; to: "currentPosition"; duration:1000; easing.type: QQ2.Easing.Linear}


//    }

    components: [electronMesh,electronTransform]

}
