

import Qt3D.Core 2.0
import Qt3D.Render 2.0

Entity {

    property alias cameraPosition: transform.translation;

    property TextureCubeMap skyboxTexture: TextureCubeMap {
        generateMipMaps: false
        magnificationFilter: Texture.Linear
        minificationFilter: Texture.Linear
        wrapMode {
            x: WrapMode.ClampToEdge
            y: WrapMode.ClampToEdge
        }
        TextureImage { cubeMapFace: Texture.CubeMapPositiveX; source: "cubemap1.png"}
        TextureImage { cubeMapFace: Texture.CubeMapPositiveY; source: "cubemap2.png"}
        TextureImage { cubeMapFace: Texture.CubeMapPositiveZ; source: "cubemap3.png"}
        TextureImage { cubeMapFace: Texture.CubeMapNegativeX; source: "cubemap6.png"}
        TextureImage { cubeMapFace: Texture.CubeMapNegativeY; source: "cubemap5.png"}
        TextureImage { cubeMapFace: Texture.CubeMapNegativeZ; source: "cubemap4.png"}
    }

    ShaderProgram {
        id: gl3SkyboxShader
        vertexShaderCode: loadSource("qrc:/shaders/gl3/skybox.vert")
        fragmentShaderCode: loadSource("qrc:/shaders/gl3/skybox.frag")
    }

    ShaderProgram {
        id: gl2es2SkyboxShader
        vertexShaderCode: loadSource("qrc:/shaders/es2/skybox.vert")
        fragmentShaderCode: loadSource("qrc:/shaders/es2/skybox.frag")
    }

    CuboidMesh {
        id: cuboidMesh
        yzMeshResolution: Qt.size(2, 2)
        xzMeshResolution: Qt.size(2, 2)
        xyMeshResolution: Qt.size(2, 2)
    }

    Transform {
        id: transform
    }

    Material {
        id: skyboxMaterial
        parameters: Parameter { name: "skyboxTexture"; value: skyboxTexture}

        effect: Effect {
            techniques: [
                // GL3 Technique
                Technique {
                    graphicsApiFilter {
                        api: GraphicsApiFilter.OpenGL
                        profile: GraphicsApiFilter.CoreProfile
                        majorVersion: 3
                        minorVersion: 1
                    }
                    renderPasses: RenderPass {
                        shaderProgram: gl3SkyboxShader
                        renderStates: [
                            // cull front faces
                            CullFace { mode: CullFace.Front },
                            DepthTest { func: DepthTest.LessOrEqual }
                        ]
                    }
                },
                Technique {
                    graphicsApiFilter {
                        api: GraphicsApiFilter.OpenGL
                        profile: GraphicsApiFilter.NoProfile
                        majorVersion: 2
                        minorVersion: 0
                    }
                    renderPasses: RenderPass {
                        shaderProgram: gl2es2SkyboxShader
                        renderStates: [
                            CullFace { mode: CullFace.Front },
                            DepthTest { func: DepthTest.LessOrEqual }
                        ]
                    }
                },
                Technique {
                    graphicsApiFilter {
                        api: GraphicsApiFilter.OpenGLES
                        profile: GraphicsApiFilter.NoProfile
                        majorVersion: 2
                        minorVersion: 0
                    }
                    renderPasses: RenderPass {
                        shaderProgram: gl2es2SkyboxShader
                        renderStates: [
                            CullFace { mode: CullFace.Front },
                            DepthTest { func: DepthTest.LessOrEqual }
                        ]
                    }
                }
            ]
        }
    }

    components: [cuboidMesh, skyboxMaterial, transform]
}

