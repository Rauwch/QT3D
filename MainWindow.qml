import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtQuick.Layouts 1.2
QtObject {
    property SystemPalette palette: SystemPalette { }

    property var startWindow: Window {
        width: Screen.width
        height: Screen.height
        color: palette.window
        title: "Main Window"
    }


    property var splashWindow: Splash {
        onTimeout: startWindow.visible = true
    }

}

