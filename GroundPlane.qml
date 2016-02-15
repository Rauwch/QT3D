import Qt3D.Core 2.0
import Qt3D.Render 2.0

Entity {
    id: root
    property Material material

    PlaneMesh {
        id: groundMesh
        width: 400
        height: width
        meshResolution: Qt.size(2, 2)
    }

    Transform {
        id: groundTransform
        translation: Qt.vector3d(0,-5,0)
    }

    PhongMaterial{
        id: colorMaker
        diffuse: Qt.rgba(34/255,212/255,46/255,1)
        specular: "white"
        shininess: 100.0
    }
    components: [
        groundMesh,
        groundTransform,
        colorMaker
    ]
}


