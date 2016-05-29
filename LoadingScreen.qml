import QtQuick 2.0
import QtQuick.Window 2.1
Rectangle {
    id: splash
    color: "transparent"
    property int timeoutInterval: 1000
    signal timeout
    anchors.fill: parent
    Image{
        id: bikiniImg
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: "bikiniBottom.jpg"
    }

    Image {
        id: splashImage
        anchors.centerIn: parent
        source: "jelly.png"
        MouseArea {
            anchors.fill: parent
            onClicked: Qt.quit()
        }
    }
    //! [timer]
    Timer {
        interval: timeoutInterval; running: true; repeat: false
        onTriggered: {
            visible = false
            splash.timeout()
        }
    }
    //! [timer]
    Component.onCompleted: visible = true
}
