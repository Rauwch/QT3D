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

        for(var i= 0; i< 4; i++ )
        {
            var electron = electronFactory.createObject(null,{"beginAnimation": Qt.vector3d(0,0,5),"endAnimation": Qt.vector3d(40,0,5),"startPosition": Qt.vector3d(i*10,0,5),"currentPosition": Qt.vector3d(i*10,0,5),"speed": 0,"direction": 0});
            electron.parent = controller.parent;
        }
    }
}
