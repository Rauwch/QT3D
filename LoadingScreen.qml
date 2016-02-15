import QtQuick 2.0
import QtQuick.Window 2.0

Window {
    id:loading
    color: "black"
    modality: Qt.ApplicationModal
    flags: Qt.SplashScreen
    property int timeInterval: 2000
    signal timeout
    x: (Screen.width - splashImage.width ) / 2
    y: (Screen.height - splashImage.height) / 2
    width: splashImage.width
    height: splashImage.height
    Image {

        id: splashImage
        source: "Qt-logo-medium.png"

    }

    Component.onCompleted: visible = true
}
