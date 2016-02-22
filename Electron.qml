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
            console.log("this is the speed   " + electronSpeed);
        }
    }

    Mesh{
        id: electronMesh
        source: "Jelly/OBJ/Jellyfish.obj"
       }
//    Material: DiffuseMapMaterial {
    material: DiffuseMapMaterial {
            id: theMaterial
            diffuse: "Jelly/Textures/Jellyfish.png"

            specular: Qt.rgba( 1, 1, 1, 1.0 )
            shininess: 0
        }

//    material2: DiffuseMapMaterial {
//            id: theMaterial2
//            diffuse: "Eye_DF.webp"

//            specular: Qt.rgba( 1, 1, 1, 1.0 )
//            shininess: 0
//        }

    QQ2.Component.onCompleted: {

        //console.log("Dit is de hoogte  " + currentPosY)
        //console.log("Linker speed " + myLinker.speed);
        //console.log("height myLinker: " + myLinker.height);

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
        translation: Qt.vector3d(currentPosX, myLinker.height/2-7, currentPosZ)
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
//    QQ2.SequentialAnimation on currentPosY{
//            id: testThisAlso
//            loops: QQ2.Animation.Infinite
//            running: true
//                QQ2.PropertyAnimation { to: currentPosY; duration: 0 }
//            //onLoopCountChanged: theLinker.setMyHeight(theLinker.getMyHeight())
//    }

    components: [electronMesh,electronTransform,theMaterial]

}
