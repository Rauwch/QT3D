/*
  Creates electronFactory which spawns a number (j) of Electron.qml objects
  */
import QtQuick 2.0 as QQ2
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Link 1.0

Entity{
    id:controller
    property int amountNodes: 4
    //property Linker ourLinker
    property bool running: false
    property var electronFactory
    QQ2.Component.onCompleted: {
        electronFactory = Qt.createComponent("Electron.qml");
        var j = 10;
        for(var i= 0; i< j; i++ )
        {
            //we create the object with:
            //beginAnimation: node out of which the electrons spawn
            //endAnimation: node into which the electrons disappear
            //startPosition: where each electrons starts (so they all spawn out of "nowhere" the first time)
            //speed: currently not implemented
            //direction: which way the electrons face (positive = counterclockwise looking from top)
            //myLinker.getMyHeight() is used to elevate electrons together with nodes' height
            var electron = electronFactory.createObject(null,
                            {"beginAnimation": Qt.vector3d(j*10,0+myLinker.getMyHeight(),0),
                            "endAnimation": Qt.vector3d(0,0+myLinker.getMyHeight(),0),
                            "startPosition": Qt.vector3d(i*10,0+myLinker.getMyHeight(),0),
                            "speed": 0,"direction": -45});
            electron.parent = controller.parent;
        };
    }

}
