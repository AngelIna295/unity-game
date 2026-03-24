// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

#warning Upgrade NOTE: unity_Scale shader variable was removed; replaced 'unity_Scale.w' with '1.0'
// Upgrade NOTE: commented out 'float4 unity_LightmapST', a built-in variable
// Upgrade NOTE: commented out 'sampler2D unity_Lightmap', a built-in variable
// Upgrade NOTE: commented out 'sampler2D unity_LightmapInd', a built-in variable
// Upgrade NOTE: replaced tex2D unity_Lightmap with UNITY_SAMPLE_TEX2D
// Upgrade NOTE: replaced tex2D unity_LightmapInd with UNITY_SAMPLE_TEX2D_SAMPLER

// Shader created with Shader Forge Beta 0.36 
// Shader Forge (c) Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:0.36;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,limd:1,uamb:True,mssp:True,lmpd:True,lprd:True,enco:False,frtr:True,vitr:True,dbil:False,rmgx:True,rpth:0,hqsc:True,hqlp:False,tesm:0,blpr:0,bsrc:0,bdst:1,culm:0,dpts:2,wrdp:True,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:0,x:32811,y:32512|diff-1162-RGB,spec-1246-OUT,gloss-1224-OUT,normal-4-RGB,emission-1629-OUT,amspl-5-OUT;n:type:ShaderForge.SFN_Cubemap,id:1,x:34078,y:32788,ptlb:Cubemap,ptin:_Cubemap;n:type:ShaderForge.SFN_Tex2d,id:2,x:33414,y:32538,ptlb:Specular,ptin:_Specular,ntxv:2,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:4,x:33330,y:32822,ptlb:Normal,ptin:_Normal,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Multiply,id:5,x:33221,y:33005|A-224-OUT,B-10-OUT;n:type:ShaderForge.SFN_NormalVector,id:6,x:34124,y:33047,pt:False;n:type:ShaderForge.SFN_ComponentMask,id:8,x:33799,y:33100,cc1:1,cc2:-1,cc3:-1,cc4:-1|IN-6-OUT;n:type:ShaderForge.SFN_Add,id:10,x:33431,y:33169|A-12-OUT,B-13-OUT;n:type:ShaderForge.SFN_Vector1,id:11,x:33799,y:33237,v1:0.7;n:type:ShaderForge.SFN_Multiply,id:12,x:33612,y:33110|A-8-OUT,B-11-OUT;n:type:ShaderForge.SFN_OneMinus,id:13,x:33612,y:33237|IN-11-OUT;n:type:ShaderForge.SFN_Vector1,id:214,x:34078,y:32955,v1:8;n:type:ShaderForge.SFN_Multiply,id:215,x:33890,y:32850|A-1-RGB,B-1-A,C-214-OUT;n:type:ShaderForge.SFN_Lerp,id:224,x:33511,y:32850|A-225-OUT,B-215-OUT,T-1293-OUT;n:type:ShaderForge.SFN_Multiply,id:225,x:33709,y:32692|A-226-OUT,B-215-OUT;n:type:ShaderForge.SFN_Vector1,id:226,x:33904,y:32712,v1:1;n:type:ShaderForge.SFN_Tex2d,id:1162,x:33219,y:32400,ptlb:Difuse,ptin:_Difuse,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Slider,id:1224,x:33623,y:32454,ptlb:Glossines,ptin:_Glossines,min:0,cur:0.5759066,max:1;n:type:ShaderForge.SFN_Multiply,id:1246,x:33179,y:32570|A-2-RGB,B-1250-OUT;n:type:ShaderForge.SFN_Slider,id:1250,x:33362,y:32720,ptlb:Specular Power,ptin:_SpecularPower,min:0,cur:0.3089664,max:1;n:type:ShaderForge.SFN_Fresnel,id:1293,x:33725,y:32933;n:type:ShaderForge.SFN_Tex2d,id:1603,x:33088,y:33053,ptlb:Emmisive,ptin:_Emmisive,ntxv:2,isnm:False|MIP-1620-OUT;n:type:ShaderForge.SFN_Slider,id:1620,x:33010,y:33270,ptlb:Power,ptin:_Power,min:0,cur:0,max:0.5;n:type:ShaderForge.SFN_Blend,id:1629,x:32837,y:33004,blmd:10,clmp:True|SRC-1603-RGB,DST-1620-OUT;proporder:1162-2-1250-1224-4-1-1603-1620;pass:END;sub:END;*/

Shader "BR/Emmisive_Relfexion" {
    Properties {
        _Difuse ("Difuse", 2D) = "white" {}
        _Specular ("Specular", 2D) = "black" {}
        _SpecularPower ("Specular Power", Range(0, 1)) = 0.3089664
        _Glossines ("Glossines", Range(0, 1)) = 0.5759066
        _Normal ("Normal", 2D) = "bump" {}
        _Cubemap ("Cubemap", Cube) = "_Skybox" {}
        _Emmisive ("Emmisive", 2D) = "black" {}
        _Power ("Power", Range(0, 0.5)) = 0
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "ForwardBase"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma exclude_renderers gles xbox360 ps3 flash 
            #pragma target 3.0
            #pragma glsl
            #ifndef LIGHTMAP_OFF
                // float4 unity_LightmapST;
                // sampler2D unity_Lightmap;
                #ifndef DIRLIGHTMAP_OFF
                    // sampler2D unity_LightmapInd;
                #endif
            #endif
            uniform samplerCUBE _Cubemap;
            uniform sampler2D _Specular; uniform float4 _Specular_ST;
            uniform sampler2D _Normal; uniform float4 _Normal_ST;
            uniform sampler2D _Difuse; uniform float4 _Difuse_ST;
            uniform float _Glossines;
            uniform float _SpecularPower;
            uniform sampler2D _Emmisive; uniform float4 _Emmisive_ST;
            uniform float _Power;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 binormalDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
                #ifndef LIGHTMAP_OFF
                    float2 uvLM : TEXCOORD7;
                #else
                    float3 shLight : TEXCOORD7;
                #endif
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.texcoord0;
                #ifdef LIGHTMAP_OFF
                    o.shLight = ShadeSH9(float4(mul(unity_ObjectToWorld, float4(v.normal,0)).xyz * 1.0,1)) * 0.5;
                #endif
                o.normalDir = mul(float4(v.normal,0), unity_WorldToObject).xyz;
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.binormalDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex);
                #ifndef LIGHTMAP_OFF
                    o.uvLM = v.texcoord1 * unity_LightmapST.xy + unity_LightmapST.zw;
                #endif
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.binormalDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
/////// Normals:
                float2 node_1654 = i.uv0;
                float3 normalLocal = UnpackNormal(tex2D(_Normal,TRANSFORM_TEX(node_1654.rg, _Normal))).rgb;
                float3 normalDirection =  normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                #ifndef LIGHTMAP_OFF
                    float4 lmtex = UNITY_SAMPLE_TEX2D(unity_Lightmap,i.uvLM);
                    #ifndef DIRLIGHTMAP_OFF
                        float3 lightmap = DecodeLightmap(lmtex);
                        float3 scalePerBasisVector = DecodeLightmap(UNITY_SAMPLE_TEX2D_SAMPLER(unity_LightmapInd,unity_Lightmap,i.uvLM));
                        UNITY_DIRBASIS
                        half3 normalInRnmBasis = saturate (mul (unity_DirBasis, normalLocal));
                        lightmap *= dot (normalInRnmBasis, scalePerBasisVector);
                    #else
                        float3 lightmap = DecodeLightmap(lmtex);
                    #endif
                #endif
                #ifndef LIGHTMAP_OFF
                    #ifdef DIRLIGHTMAP_OFF
                        float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                    #else
                        float3 lightDirection = normalize (scalePerBasisVector.x * unity_DirBasis[0] + scalePerBasisVector.y * unity_DirBasis[1] + scalePerBasisVector.z * unity_DirBasis[2]);
                        lightDirection = mul(lightDirection,tangentTransform); // Tangent to world
                    #endif
                #else
                    float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                #endif
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = dot( normalDirection, lightDirection );
                #ifndef LIGHTMAP_OFF
                    float3 diffuse = lightmap.rgb;
                #else
                    float3 diffuse = max( 0.0, NdotL) * attenColor;
                #endif
////// Emissive:
                float3 emissive = saturate(( _Power > 0.5 ? (1.0-(1.0-2.0*(_Power-0.5))*(1.0-tex2Dlod(_Emmisive,float4(TRANSFORM_TEX(node_1654.rg, _Emmisive),0.0,_Power)).rgb)) : (2.0*_Power*tex2Dlod(_Emmisive,float4(TRANSFORM_TEX(node_1654.rg, _Emmisive),0.0,_Power)).rgb) ));
///////// Gloss:
                float gloss = _Glossines;
                float specPow = exp2( gloss * 10.0+1.0);
////// Specular:
                NdotL = max(0.0, NdotL);
                float4 node_1 = texCUBE(_Cubemap,viewReflectDirection);
                float3 node_215 = (node_1.rgb*node_1.a*8.0);
                float node_11 = 0.7;
                float3 specularColor = (tex2D(_Specular,TRANSFORM_TEX(node_1654.rg, _Specular)).rgb*_SpecularPower);
                float3 specularAmb = (lerp((1.0*node_215),node_215,(1.0-max(0,dot(normalDirection, viewDirection))))*((i.normalDir.g*node_11)+(1.0 - node_11))) * specularColor;
                float3 specular = 1 * pow(max(0,dot(halfDirection,normalDirection)),specPow) * specularColor + specularAmb;
                #ifndef LIGHTMAP_OFF
                    #ifndef DIRLIGHTMAP_OFF
                        specular *= lightmap;
                    #else
                        specular *= (floor(attenuation) * _LightColor0.xyz);
                    #endif
                #else
                    specular *= (floor(attenuation) * _LightColor0.xyz);
                #endif
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                #ifdef LIGHTMAP_OFF
                    diffuseLight += i.shLight; // Per-Vertex Light Probes / Spherical harmonics
                #endif
                finalColor += diffuseLight * tex2D(_Difuse,TRANSFORM_TEX(node_1654.rg, _Difuse)).rgb;
                finalColor += specular;
                finalColor += emissive;
/// Final Color:
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "ForwardAdd"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            Fog { Color (0,0,0,0) }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma exclude_renderers gles xbox360 ps3 flash 
            #pragma target 3.0
            #pragma glsl
            #ifndef LIGHTMAP_OFF
                // float4 unity_LightmapST;
                // sampler2D unity_Lightmap;
                #ifndef DIRLIGHTMAP_OFF
                    // sampler2D unity_LightmapInd;
                #endif
            #endif
            uniform sampler2D _Specular; uniform float4 _Specular_ST;
            uniform sampler2D _Normal; uniform float4 _Normal_ST;
            uniform sampler2D _Difuse; uniform float4 _Difuse_ST;
            uniform float _Glossines;
            uniform float _SpecularPower;
            uniform sampler2D _Emmisive; uniform float4 _Emmisive_ST;
            uniform float _Power;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 binormalDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.texcoord0;
                o.normalDir = mul(float4(v.normal,0), unity_WorldToObject).xyz;
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.binormalDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.binormalDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
/////// Normals:
                float2 node_1655 = i.uv0;
                float3 normalLocal = UnpackNormal(tex2D(_Normal,TRANSFORM_TEX(node_1655.rg, _Normal))).rgb;
                float3 normalDirection =  normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = dot( normalDirection, lightDirection );
                float3 diffuse = max( 0.0, NdotL) * attenColor;
///////// Gloss:
                float gloss = _Glossines;
                float specPow = exp2( gloss * 10.0+1.0);
////// Specular:
                NdotL = max(0.0, NdotL);
                float3 specularColor = (tex2D(_Specular,TRANSFORM_TEX(node_1655.rg, _Specular)).rgb*_SpecularPower);
                float3 specular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow) * specularColor;
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                finalColor += diffuseLight * tex2D(_Difuse,TRANSFORM_TEX(node_1655.rg, _Difuse)).rgb;
                finalColor += specular;
/// Final Color:
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
