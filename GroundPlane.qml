/*
  creates a groundplane on top of which we put our objects
  */

import Qt3D.Core 2.0
import Qt3D.Render 2.0


Entity {
    id: root
    property vector3d planeHeight: Qt.vector3d(50,0,0)

    PlaneMesh {
        id: groundMesh
        width: 250
        height: width
        meshResolution: Qt.size(2, 2)
    }

    Transform {
        id: groundTransform
        translation: planeHeight
    }

    property Material material: DiffuseMapMaterial {
    id: theMaterial
    diffuse: "sandTexture.jpg"

    specular: Qt.rgba( 1, 1, 1, 1.0 )
    shininess: 0
}
    components: [
        groundMesh,
        groundTransform,
        material
    ]
}


