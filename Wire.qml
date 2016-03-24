import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Logic 2.0
import QtQuick 2.0 as QQ2



Entity{
    id:root

    //Positie variablen
    property real x: 0
    property real y: 0
    property real z: 0

    property real l: 1 //Lengte van draad
    property real orientationAngle: 90 //Hoek van draad

    //Variables for spawning electrons
    property real eSize

    //global scale factor
    property real sf:1
    property bool isGoal
    property bool match;
    //list of electrons
    property var electrons: []
    components: [finmesh,fintrans]


    function toColor(){
        if(isGoal){
            if(!match)
                 return "goalPole.png";
            else
                return "goalPoleGo.png"
        }
        else{
            return "wire.png";}
    }
    function toRadius(){
        if(isGoal){
            return 0.2;
        }
        else{
            return 0.02;
        }
    }
    QQ2.Behavior on y{
        QQ2.NumberAnimation{
            duration: 500
            easing.type: Easing.InOutSine
        }
    }


    Entity{
        id:finmesh
        components: [wismesh,witrans]


        Entity{
            //basismodel draad
            id:wismesh
//            QQ2.Component.onCompleted: {
//                if(isGoal)
//                    components: [mesh, trans,matGoal]
//                else
//                    components: [mesh, trans,mat]
//            }
            components: [mesh, trans,theMaterial]

            CylinderMesh {
                id:mesh
                radius: toRadius()
                length: 1*l
            }
            Transform{
                id:trans
                translation: Qt.vector3d(0,-0.5*l,0)
            }

            property Material material: DiffuseMapMaterial {
                id: theMaterial
                diffuse: toColor()
                ambient: Qt.rgba( 1, 1, 1, 1.0 )
                specular: Qt.rgba( 1, 1, 1, 1.0 )
                shininess: 0
            }

        }

        Transform{
            id:witrans
            matrix: {
                var m = Qt.matrix4x4();
                m.rotate(90,(Qt.vector3d(0, 0, 1)));
                m.scale(1);
                return m;
            }

        }

    }
    function printeSize(){
        //console.log("this is the size of E: " + eSize)
        electrons[0].printS();
    }

    Transform{
        id:fintrans
        rotation: fromAxisAndAngle(Qt.vector3d(0,1,0),orientationAngle)
        translation: (Qt.vector3d(x, y, z))

    }




    //Stuff for spawning electrons
    QQ2.QtObject{
        id:o
        property var electronFactory

    }



    function spawnElectrons(){
        o.electronFactory=Qt.createComponent("Elektron.qml");
        for(var i=0;i<2*root.l/root.sf;i++){
            var electron;
            if(root.eSize>0)
                electron = o.electronFactory.createObject(null,{"xend":root.l, "xstart":0 , "xbegin":i/2*root.sf , "s": Math.abs(root.eSize)});
            else
                electron = o.electronFactory.createObject(null,{"xend":0, "xbegin": i/2*root.sf,"xstart":root.l, "s": Math.abs(root.eSize)});
            electron.parent=root;
            electrons[i]=electron;

        }
    }

    function destroyElectrons(){
        for(var i=0;i<electrons.length;i++){
            electrons[i].destroy();
        }
    }











}



