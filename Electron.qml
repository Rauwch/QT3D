/*
  The actual electrons
  This class contains the properties of the electrons (current position, end/start position)
  The obj file and texture file are also loaded here
  SequentialAnimation deals with visualizing the electrons' animation
  */

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
    property real currentPosY:myLinker.height/2-7
    property real currentPosZ
    property real speed
    // richting in welke de elektronen zich begeven
    property int direction
    property Material material

    Mesh{
        id: electronMesh
        source: "Jelly/OBJ/Jellyfish.obj"
       }
    material: DiffuseMapMaterial {
            id: theMaterial
            diffuse: "Jelly/Textures/Jellyfish.png"
            specular: Qt.rgba( 1, 1, 1, 1.0 )
            shininess: 0
        }
    //initialises all the properties
    QQ2.Component.onCompleted: {
        currentPosX= startPosition.x;
        currentPosY= startPosition.y;
        currentPosZ= startPosition.z;
        currentPosition.x = currentPosX;
        currentPosition.y = currentPosY;
        currentPosition.z = currentPosZ;
        currentPosY = myLinker.height;
        currentPosition.y = myLinker.height;
        startPosition.y= myLinker.height;
        beginAnimation.y = myLinker.height;
        endAnimation.y = myLinker.height;
        console.log("electron gemaakt");
        //console.log("height myLinker: " + myLinker.height);
//        console.log("beginAnimation.x: " + beginAnimation.x);
//        console.log("endAnimation: " + endAnimation);
//        console.log("startPosition: " + startPosition);
//        console.log("currentPosition: " + currentPosition);
//        console.log("currentPosX: " + currentPosX);
//        console.log("currentPosY: " + currentPosY);
//        console.log("currentPosZ: " + currentPosZ);
    }
    //initial positioning of the electron
    //myLinker.height/2-7: division because nodes increase in size in both directions, subtraction hard-coded to get electrons in right place (subtract their own size)
    //scale to increase size of electrons
    property Transform transform: Transform {
        id: electronTransform
        translation: Qt.vector3d(currentPosX, myLinker.height/2-7, currentPosZ)
        rotation: fromAxisAndAngle(Qt.vector3d(0, 1, 0),direction )
        scale: 2
    }
    //animates the electrons' movement
    //start -> end (slow)
    //end -> begin (= reset; instantly)
    //begin -> start (slow)
    //duration is related to distance they have to travel
    QQ2.SequentialAnimation on currentPosX{
            id: testThis
            loops: QQ2.Animation.Infinite
            running: true
                QQ2.PropertyAnimation { from: startPosition.x; to: endAnimation.x; duration: (startPosition.x-endAnimation.x)*50 }
                QQ2.PropertyAnimation { from: endAnimation.x; to: beginAnimation.x; duration: 0 }
                QQ2.PropertyAnimation { from: beginAnimation.x; to: startPosition.x; duration: (beginAnimation.x-startPosition.x)*50 }
    }
//    QQ2.SequentialAnimation on currentPosY{
//            id: testThisAlso
//            loops: QQ2.Animation.Infinite
//            running: true
//                QQ2.PropertyAnimation { to: currentPosY; duration: 0 }
//            //onLoopCountChanged: theLinker.setMyHeight(theLinker.getMyHeight())
//    }
    components: [electronMesh,electronTransform,theMaterial]

}
