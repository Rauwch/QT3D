/*
  creates a (green) groundplane on top of which we put our objects
  */

import Qt3D.Core 2.0
import Qt3D.Render 2.0

Entity {
    id: root
    property Material material

    PlaneMesh {
        id: groundMesh
        width: 250
        height: width
        meshResolution: Qt.size(2, 2)
    }

    Transform {
        id: groundTransform
        translation: Qt.vector3d(50,-5,0)
    }

    PhongMaterial{
        id: colorMaker
        diffuse: Qt.rgba(34/255,46/255,212/255,1)
        specular: "white"
        shininess: 100.0
    }
    components: [
        groundMesh,
        groundTransform,
        colorMaker
    ]
}


