import QtQuick 2.5
import QtQuick.Window 2.0

import LB 1.0
Column{
    id: leaderColumn
    spacing: 10
    property Levelboard myLevelboard: Levelboard
    {
    Component.onCompleted: {
        myGameScreen.setHighScore(myLevelboard.getHighScore());
        console.log("Levelboard on complete " + myLevelboard.getAmountOfEntries());
    }
}

Repeater{
    model:
    {
        myLevelboard.readLeaderboard(myLevels.getCurrentLevel());
        console.log("repeater value: "+ myLevelboard.getAmountOfEntries());
        myLevelboard.getAmountOfEntries();
    }
    delegate:
        Rectangle{
        id:container
        width: Screen.width/2*(4/5)
        height: Screen.height/14

        Component.onCompleted: {
            console.log("created levelboard entry");
            console.log("name: " +myLevelboard.giveName(index));
            console.log("name: " +myLevelboard.giveStars(index));
        }


        border.color: "black"
        border.width: 2
        radius: 5
        gradient: Gradient {
            GradientStop { position: 0 ; color: "#D3D3D3" }
            GradientStop { position: 1 ; color: "#FFFFFF" }
        }

        Text{
            anchors.left: container.left
            anchors.leftMargin: Screen.width/20
            anchors.verticalCenter: parent.verticalCenter

            text: myLevelboard.giveName(index)
            renderType: Text.NativeRendering
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "Helvetica"
            font.pointSize: 20
            color: "black"
        }

        Row{
            id:starRow

            anchors.horizontalCenter :container.left
            anchors.horizontalCenterOffset : Screen.width/5
            anchors.verticalCenter: parent.verticalCenter
            Repeater{
                id: starRepeater
                // this is the index from the button assigned by the top repeater
                model: myLevelboard.giveStars(index)
                delegate:
                    Image{
                    source: "starfish.png";
                    width: Screen.width/30;
                    height: width;
                }
            }
        }

        Text{
            anchors.right: container.right
            anchors.rightMargin: Screen.width/15
            anchors.verticalCenter: parent.verticalCenter

            text: myLevelboard.giveClicks(index) + " kliks"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "Helvetica"
            font.pointSize: 20
            color: "black"
        }

    }

}


}


