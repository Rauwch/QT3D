import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import QtQuick 2.2 as QQ2

Entity{
    id:theBol
    property real xVal: 0
    property real yVal: 0
    property real zVal: 0
    property real resistorNr
    property real breath
    components: [mesh,bolTrans,objectPicker,material]

    SphereMesh{
        id:mesh
        radius: 1.75
    }

    Transform{
        id:bolTrans
        translation: Qt.vector3d(xVal,yVal,zVal)

    }
    property Material material: DiffuseMapMaterial {
        id: theMaterial
        diffuse: "resistorTexture.png"
        ambient: Qt.rgba( breath, breath, breath, 1.0 )
        specular: Qt.rgba( 1, 1, 1, 1.0 )
        shininess: 0
    }
    property ObjectPicker objectPicker: ObjectPicker {
        onClicked: {
           //console.log("clicked on a THERESISTOR");
            myGameScreen.updateTutorial();
            myGameScreen.showRes = !myGameScreen.showRes;
            myGameScreen.clickedRes = resistorNr;
            myGameScreen.showBox = false;
        }
    }
    QQ2.SequentialAnimation{


        running: true
        loops: QQ2.Animation.Infinite
        QQ2.NumberAnimation {

            target: theBol
            property: "breath"
            duration: 1000
            from: 1
            to: 0.5
        }
        QQ2.NumberAnimation {

            target: theBol
            property: "breath"
            duration: 1000
            from: 0.5
            to: 1
        }

    }
    function setThevisible(theint){
        if(theint === 0){
            theBol.setEnabled(false);
        }
        if(theint === 1){
            theBol.setEnabled(true);
        }
    }

}
