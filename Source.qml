import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import QtQuick 2.2 as QQ2


Entity{
    id:source
    property var sourceNr: 0
    property real s: 1 //Grote van bron, bepaald door spanning
    //Positie variablen
    property real x: 0
    property real y: 0
    property real z: 0
    Entity{
        components: [bal,objectPicker]
        Bal{
            id:bal
            xVal: x
            yVal: s/2
            zVal: z
        }
    }
    property ObjectPicker objectPicker: ObjectPicker {
        onClicked: {
            console.log("clicked on a THESOURCE");
            myGameScreen.showBox = !myGameScreen.showBox;
            myGameScreen.clickedSource = sourceNr;
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




