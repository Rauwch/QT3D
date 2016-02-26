/*
  instances of squids
  */

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import QtQuick 2.0 as QQ2
import QtQml 2.2


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
    property real electronSpeed: myLinker.speed
    // richting in welke de elektronen zich begeven
    property int direction
    //property Linker theLinker
    property Material material
    //    property Material material2


    Connections{
        target: myGameScreen

        onSpeedupdate:{
            animationX.complete();
            animationX.restart();
            electronSpeed = newSpeed;
        }
    }

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

    property Transform transform: Transform {
        id: electronTransform
        translation: Qt.vector3d(currentPosX, (25/2-8)+(myLinker.height-25), currentPosZ)
        rotation: fromAxisAndAngle(Qt.vector3d(0, 1, 0),direction )
        scale: 2
    }

    QQ2.SequentialAnimation on currentPosX{
        id: animationX
        loops: QQ2.Animation.Infinite
        running: true
        QQ2.PropertyAnimation { from: startPosition.x; to: endAnimation.x; duration: (startPosition.x-endAnimation.x)/electronSpeed*100000;  }
        QQ2.PropertyAnimation { from: endAnimation.x; to: beginAnimation.x; duration: 0 }
        QQ2.PropertyAnimation { from: beginAnimation.x; to: startPosition.x; duration: (beginAnimation.x-startPosition.x)/electronSpeed*100000 }
    }

    components: [electronMesh,electronTransform,theMaterial]

}
