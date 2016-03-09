import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import QtQuick 2.2 as QQ2

Entity{
    id:theBol
    property real xVal: 0
    property real yVal: 0
    property real zVal: 0
    property real sourceNr
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
    diffuse: "rockTexture.jpg"
    ambient: Qt.rgba( 1, 1, 1, 1.0 )
    specular: Qt.rgba( 1, 1, 1, 1.0 )
    shininess: 0
}

    property ObjectPicker objectPicker: ObjectPicker {
        onClicked: {
            console.log("clicked on a THESOURCE");
            myGameScreen.showBox = !myGameScreen.showBox;
            myGameScreen.clickedSource = sourceNr;
        }
    }

}
