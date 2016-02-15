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
        var j = 10;
        for(var i= 0; i< j; i++ )
        {
            var electron = electronFactory.createObject(null,{"beginAnimation": Qt.vector3d(j*10,0+myLinker.getMyHeight(),0),"endAnimation": Qt.vector3d(0,0+myLinker.getMyHeight(),0),"startPosition": Qt.vector3d(i*10,0+myLinker.getMyHeight(),0),"speed": 0,"direction": -45});
            electron.parent = controller.parent;
        };
    }

}
