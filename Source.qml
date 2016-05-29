import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import QtQuick 2.2 as QQ2


Entity{
    id:source
    property var sourceNr
    /* size of the source */
    property real s: 1

    /*postion variables */
    property real x: 0
    property real y: 0
    property real z: 0

    property bool clickable: false
    property var eSize: 7
    property real positionInArray: 0
    property var buttonValues: [0,0,0,0,0]

    QQ2.Behavior on s
    {
        QQ2.NumberAnimation{
            duration: 500
            easing.type: "InOutSine"
        }
    }
    QQ2.Behavior on y
    {
        QQ2.NumberAnimation{
            duration: 500
            easing.type: "InOutSine"
        }
    }

    /*sets which button will be highlighted */
    function setButtonValues(initial, step, difference)
    {
        var rng;
        var isPositive = ( difference > 0 );
        if(isPositive)
            rng = Math.floor((Math.random() * (5 - difference)) + 1) - 1;
        else
            rng = Math.floor((Math.random() * (5+(difference))) + 1)+((-1)*(difference)-1);
        buttonValues[rng] = initial;
        positionInArray = rng;
        for( var i = rng +1; i < 5; i++)
        {
            buttonValues[i]= initial + (i - rng) * step;
        }
        if( rng !== 0)
        {
            for(  i = rng - 1 ; i >= 0; i--)
            {
                buttonValues[i]= initial - (rng - i) * step;
            }
        }
    }
    QQ2.Component.onCompleted: {
        if(!clickable)
            clickableBal.destroy();
    }

    Bal{
        id: clickableBal
        xVal: x
        yVal: y + s;
        zVal: z
        sourceNr: source.sourceNr

    }

    Entity{
        components: [somesh,sotrans]

        Entity{
            id:somesh
            components: [cmesh,trans,material]

            CylinderMesh{
                id: cmesh
                radius: 1
                length: 1
            }

            Transform{
                id:trans
                translation: Qt.vector3d(0, 0.5, 0)
            }

            property Material material: DiffuseMapMaterial {
                diffuse: "poleTexture.png"
                ambient: Qt.rgba( 1, 1, 1, 1.0 )
                specular: Qt.rgba( 1, 1, 1, 1.0 )
                shininess: 0
            }
        }

        Transform{
            id:sotrans
            translation: Qt.vector3d(x, y, z)
            scale3D : Qt.vector3d(1, (1*s) , 1)

        }
    }


}




