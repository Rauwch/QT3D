import QtQuick 2.0 as QQ2
import Qt3D.Core 2.0
import Qt3D.Render 2.0

Entity{

    id: root

    property var entityMesh: null
    property int entityIndex: 0
    property int entityCount: 0
    property real magnitude: 0

    property Transform xTransform: Transform {
            translation: Qt.vector3d(xAnimation,0,0)
            property int xAnimation: 0

            onXAnimationChanged: {
                while(xAnimation !=0){

                }
            }
    }
    components: [entityMesh, xTransform]

    QQ2.NumberAnimation {
        id: nodeMover
        target: xTransform
        property: "xAnimation"
        duration: 1000
        loops: QQ2.Animation.Infinite
        running: true
        from: 0
        to: 10

    }

}
