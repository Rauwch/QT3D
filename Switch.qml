import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import QtQuick 2.2 as QQ2


Entity{
    id:theSwitch
    property var switchNr
    //Positie variablen
    property real x: 0
    property real y: 0
    property real z: 0
    property real orientationAngle: 0
    property var clickableBals:[]
    property int length: 5

    QQ2.QtObject
    {
        id:o
        property var balFactory
    }

    QQ2.Component.onCompleted: {
        createBal();
    }


    function createBal() {
        console.log("create clickable bal");
        o.balFactory = Qt.createComponent("Bal.qml");
        console.log("x: " + theSwitch.x + "y: " + theSwitch.y + "z: " + theSwitch.z );
        var bal = o.balFactory.createObject(theSwitch,{"xVal": theSwitch.x + theSwitch.length/2,"yVal":  theSwitch.y , "zVal": theSwitch.z, "switchNr": theSwitch.switchNr});
        bal.parent=theSwitch.parent;
        theSwitch.clickableBals[0]=bal;
        bal = o.balFactory.createObject(theSwitch,{"xVal": theSwitch.x - theSwitch.length/2,"yVal":  theSwitch.y , "zVal": theSwitch.z, "switchNr": theSwitch.switchNr});
        bal.parent=theSwitch.parent;
        theSwitch.clickableBals[1]=bal;


        if (o.balFactory === null) {
            // Error Handling
            console.log("Error creating switch bal");
        }
    }


    Entity{
        //            //Basismodel bron
        id:somesh
        components: [mesh,trans,material]

        CylinderMesh {
            id:mesh
            length: theSwitch.length
            radius: 1
        }


        Transform{
            id:trans
            //translation: Qt.vector3d(0, 0.5, 0)
            translation: Qt.vector3d(x, y,z)
            rotation: fromAxisAndAngle(Qt.vector3d(0, 0, 1), 90)
        }
        property Material material: DiffuseMapMaterial {
            id: theMaterial
            diffuse: "poleTexture.png"
            ambient: Qt.rgba( 1, 1, 1, 1.0 )
            specular: Qt.rgba( 1, 1, 1, 1.0 )
            shininess: 0
        }
    }
}




