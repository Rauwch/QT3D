import QtQuick 2.0 as QQ2
import Qt3D.Core 2.0
import Qt3D.Render 2.0

Entity{
    id:controller
    property int amountNodes: 4
    property bool running: false
    property var electronFactory
    QQ2.Component.onCompleted: {
        electronFactory = Qt.createComponent("Electron.qml");

        for(var i= 1; i< 4; i++ )
        {
            //var electron = electronFactory.createObject(null,{"beginAnimation": Qt.vector3d(5,i*10,5),"endAnimation": Qt.vector3d(45,i*10,5),"startPosition": Qt.vector3d( 15 +i*10,i*10,5),"speed": 0,"direction": 0});
            var electron = electronFactory.createObject(null,{"beginAnimation": Qt.vector3d(45,0,5),"endAnimation": Qt.vector3d(0,0,5),"startPosition": Qt.vector3d(i*10,0,5),"speed": 0,"direction": 0});

            electron.parent = controller.parent;
            console.log("currentPosX : " + electron.currentPosX);

        };

//        console.log("currentPosX : " + electron.currentPosX);
//        QQ2.ParallelAnimation on controller.electronFactory(1).currentPosX{
//            loops: QQ2.Animation.alwaysRunToEnd;
//            QQ2.PropertyAnimation { to: 15; duration: 2000 };
//        };
//        electronFactory[1]


    }
}
