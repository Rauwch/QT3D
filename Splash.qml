/*
  shows Qt logo on start up application
  makes it look nicer / more professional
  coverts the eventual loading time
  */

import QtQuick 2.0
import QtQuick.Window 2.0
Window {
    id:splash
    color: "transparent"
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

    Timer {
        interval: timeInterval; running: true; repeat: false
        onTriggered: {
            visible = false
            splash.timeout()
        }
    }
    Component.onCompleted: visible = true
}


