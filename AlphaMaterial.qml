import Qt3D.Core 2.0
import Qt3D.Render 2.0
import QtQuick 2.2 as QQ2

Material {
    id: alphaMaterial
    property real alpha: 0.5

    effect:  Effect {
        parameters: [
            Parameter { name: "alpha";  value: alphaMaterial.alpha },
            Parameter { name: "ka";   value: "black" },
            Parameter { name: "kd";   value: "yellow" },
            Parameter { name: "ks";  value: "white" },
            Parameter { name: "shininess"; value: 75.0 },
            Parameter { name: "lightPosition"; value: Qt.vector4d(1.0, 1.0, 0.0, 1.0) },
            Parameter { name: "lightIntensity"; value: Qt.vector3d(1.0, 1.0, 1.0) }
        ]

        ShaderProgram {
            id: alphaPhong
            vertexShaderCode: loadSource("qrc:/phongalpha.vert")
            fragmentShaderCode: loadSource("qrc:/phongalpha.frag")
        }

        techniques: [
            Technique
            {
                graphicsApiFilter {
                    api: GraphicsApiFilter.OpenGL
                    profile: GraphicsApiFilter.NoProfile
                    majorVersion: 2
                    minorVersion: 0
                }

                renderPasses: RenderPass {
                    renderStates: [
                        CullFace { mode : CullFace.Back },
                        DepthTest { func: DepthTest.Less },
                        DepthMask { mask: false },
                        BlendState {
                            srcRGB: BlendState.SrcAlpha
                            dstRGB: BlendState.OneMinusSrcAlpha
                        }
                        ,BlendEquation {mode: BlendEquation.FuncAdd}
                    ]

                    shaderProgram: alphaPhong
                }
            },
            Technique
            {
                graphicsApiFilter {
                    api: GraphicsApiFilter.OpenGLES
                    profile: GraphicsApiFilter.NoProfile
                    majorVersion: 2
                    minorVersion: 0
                }

                renderPasses: RenderPass {
                    renderStates: [
                        CullFace { mode : CullFace.Back },
                        DepthTest { func: DepthTest.Less },
                        DepthMask { mask: false },
                        BlendState {
                            srcRGB: BlendState.SrcAlpha
                            dstRGB: BlendState.OneMinusSrcAlpha
                        }
                        ,BlendEquation {mode: BlendEquation.FuncAdd}
                    ]

                    shaderProgram: alphaPhong
                }
            }
        ]
    }
}

