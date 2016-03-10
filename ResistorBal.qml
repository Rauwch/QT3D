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
    components: [mesh,bolTrans,objectPicker]

    SphereMesh{
        id:mesh
        radius: 1.75
    }

    Transform{
        id:bolTrans
        translation: Qt.vector3d(xVal,yVal,zVal)

    }

    property ObjectPicker objectPicker: ObjectPicker {
        onClicked: {
            console.log("clicked on a THERESISTOR");

            myGameScreen.showRes = !myGameScreen.showRes;
            myGameScreen.clickedRes = resistorNr;
        }
    }

}
