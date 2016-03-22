import QtQuick 2.0

Item {

    Row{
        anchors.verticalCenter: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        Repeater{
            id: starRepeater
            // this is the index from the button assigned by the top repeater
            model:
            delegate:
                Image{

                source: "starfish.png";
                width: 70;
                height: 70;
            }
        }
    }
}
