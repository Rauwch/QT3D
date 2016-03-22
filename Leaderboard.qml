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
            Row{
                anchors.left: parent.left
                anchors.leftMargin: 50
                spacing: 50
                Text{
                    text: myLevelboard.giveName(index)
                    renderType: Text.NativeRendering
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Helvetica"
                    font.pointSize: 20
                    color: "black"
                }

                Text{

                    text: myLevelboard.giveStars(index)
                    //anchors.horizontalCenter: container.horizontalCenter
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Helvetica"
                    font.pointSize: 20
                    color: "black"

                }
                Text{
                    text: myLevelboard.giveClicks(index)

                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Helvetica"
                    font.pointSize: 20
                    color: "black"
                }
            }
        }

    }


}


