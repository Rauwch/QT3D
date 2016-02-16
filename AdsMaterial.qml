/*
used in World.qml to generate groundplane
  */
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import QtQuick 2.1

Material {
    id: root
    property color ambientColor: Qt.rgba(1.0, 1.0, 0.1, 1.0)
    property color diffuseColor: Qt.rgba(0.7, 0.7, 0.9, 1.0)
    property color specularColor: Qt.rgba(0.1, 0.1, 0.1, 1.0)
    property real shininess: 150.0

    parameters: [
        Parameter { name: "ambient";   value: Qt.vector3d(root.ambientColor.r, root.ambientColor.g, root.ambientColor.b) },
        Parameter { name: "diffuse";   value: Qt.vector3d(root.diffuseColor.r, root.diffuseColor.g, root.diffuseColor.b) },
        Parameter { name: "specular";  value: Qt.vector3d(root.specularColor.r, root.specularColor.g, root.specularColor.b) },
        Parameter { name: "shininess"; value: root.shininess }
    ]
}
