/*
  do we still use this?
  */
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Logic 2.0
import QtQuick 2.2 as QQ2

Entity{
    id:electron

    //PositieVariablen
    property real x: 0
    property real y: 0
    property real z: 0

    //size of electron
    property real s: 1


    //Original start
    property real xstart:0

    //Startpoint for animation
    property real xbegin: 0

    //Endpoint for animation
    property real xend: 4

    //Duration of variable
    property real dur: 1000


    components: [electronMesh,trans,theMaterial]

    QQ2.Behavior on s{
        QQ2.NumberAnimation{
            duration: 1000
            easing.type: "InOutQuad"
        }
    }

    function printS(){
        //console.log("DE GROTE VAN S:  "+ s);
    }

    Mesh{
        id: electronMesh
        source: "Jelly/OBJ/Jellyfish.obj"
    }

        property Material material: DiffuseMapMaterial {
        id: theMaterial
        diffuse: "Jelly/Textures/Jellyfish.png"
        ambient: Qt.rgba( 1, 1, 1, 1.0 )
        specular: Qt.rgba( 1, 1, 1, 1.0 )
        shininess: 0
    }

    Transform
    {
        id:trans
        translation: (Qt.vector3d(x, y, z))
        scale: s*2
        //scale: 0.5
    }
    PhongMaterial {
        id:mat
        diffuse: "darkblue"
        ambient: "darkblue"
        specular: "darkblue"
        shininess: 0.2
    }

    QQ2.SequentialAnimation{


        running: true
        loops: QQ2.Animation.Infinite
        QQ2.NumberAnimation {

            target: electron
            property: "x"
            duration: electron.dur*Math.abs(xbegin-xend)
            from: electron.xbegin
            to: electron.xend
        }
        QQ2.NumberAnimation {

            target: electron
            property: "x"
            duration: electron.dur*Math.abs(xstart-xbegin)
            from: electron.xstart
            to: electron.xbegin
        }

    }
}
