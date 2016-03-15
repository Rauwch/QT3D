import QtQuick 2.0
import QtQuick.Window 2.0

import LB 1.0
Column{
    property Levelboard myLevelboard: Levelboard
    {
        Component.onCompleted: {

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
            width: Screen.width/2
            height: Screen.height/14

            Component.onCompleted: {
                console.log("created levelboard entry");
                console.log("name: " +myLevelboard.giveName(index));
                console.log("name: " +myLevelboard.giveStars(index));
            }
            color:"grey"

            Row{
                spacing: 50
                Text{
                    text: myLevelboard.giveName(index)
                }

                Text{
                    text: myLevelboard.giveStars(index)
                }
                Text{
                    text: myLevelboard.giveClicks(index)
                }
            }
        }

    }


}


