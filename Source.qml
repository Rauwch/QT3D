import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import QtQuick 2.2 as QQ2


Entity{
    id:source
    property var sourceNr
    property real s: 1 //Grote van bron, bepaald door spanning
    //Positie variablen
    property real x: 0
    property real y: 0
    property real z: 0
    property bool clickable: false
    property var clickableBal


    QQ2.QtObject{

        id:o

        //Variables for spawning objects
        property var balFactory
    }

    QQ2.Component.onCompleted: {
        if(clickable)
            createBal();
        else
            console.log("Er wordt geen bal aangemaakt")
    }
//    Entity{
//        components: [objectPicker,clickableBal]

//        property ObjectPicker objectPicker: ObjectPicker {
//            onClicked: {
//                console.log("clicked on a THESOURCE");
//                myGameScreen.showBox = !myGameScreen.showBox;
//                myGameScreen.clickedSource = sourceNr;
//            }
//        }
//    }

    function updateBal(){
        clickableBal.yVal = source.y + source.s/2;
    }

    function createBal() {

        o.balFactory = Qt.createComponent("Bal.qml");
        source.clickableBal = o.balFactory.createObject(source,{"xVal": source.x,"yVal":  source.y + (source.s/2), "zVal": source.z, "sourceNr": source.sourceNr});

        if (o.balFactory === null) {
            // Error Handling
            console.log("Error creating object");
        }
    }


    Entity{
        components: [somesh,sotrans]

        Entity{
            //            //Basismodel bron
            id:somesh
            components: [mesh,trans,mat]

            CuboidMesh {
                id:mesh
                yzMeshResolution: Qt.size(2, 2)
                xzMeshResolution: Qt.size(2, 2)
                xyMeshResolution: Qt.size(2, 2)
            }

            Transform{
                id:trans
                translation: Qt.vector3d(0, 0.5, 0)
            }

            PhongMaterial {
                id:mat
                diffuse: "red"
                ambient: "red"
                specular: "blue"
                shininess: 0.2
            }
        }

        Transform{
            id:sotrans
            translation: Qt.vector3d(x, y, z)
            scale3D : Qt.vector3d(2, 1*s, 2)

        }
    }
}




