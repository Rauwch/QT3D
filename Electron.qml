import Qt3D.Core 2.0
import Qt3D.Render 2.0
import QtQuick 2.0 as QQ2
import Link 1.0

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
//        console.log("beginAnimation.x: " + beginAnimation.x);
//        console.log("endAnimation: " + endAnimation);
//        console.log("startPosition: " + startPosition);
//        console.log("currentPosition: " + currentPosition);
//        console.log("currentPosX: " + currentPosX);
//        console.log("currentPosY: " + currentPosY);
//        console.log("currentPosZ: " + currentPosZ);
    }


    property Transform transform: Transform {
        id: electronTransform
        translation: Qt.vector3d(currentPosX, currentPosY, currentPosZ)
        rotation: fromAxisAndAngle(Qt.vector3d(0, 1, 0),direction )
    }
    QQ2.SequentialAnimation on currentPosX{
            id: testThis
            loops: QQ2.Animation.Infinite
            running: true
                QQ2.PropertyAnimation { from: startPosition.x; to: endAnimation.x; duration: (startPosition.x-endAnimation.x)*50 }
                QQ2.PropertyAnimation { from: endAnimation.x; to: beginAnimation.x; duration: 0 }
                QQ2.PropertyAnimation { from: beginAnimation.x; to: startPosition.x; duration: (beginAnimation.x-startPosition.x)*50 }
        }
    QQ2.SequentialAnimation on currentPosY{
            id: testThisAlso
            loops: QQ2.Animation.Infinite
            running: true
                QQ2.PropertyAnimation { from: currentPosition.y; to: myLinker.height; duration: 0 }
        }
    components: [electronMesh,electronTransform]
}
