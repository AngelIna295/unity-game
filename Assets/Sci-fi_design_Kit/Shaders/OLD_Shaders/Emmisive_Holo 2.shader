// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Shader created with Shader Forge v1.19 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.19;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:False,mssp:True,bkdf:True,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.1280277,fgcg:0.1953466,fgcb:0.2352941,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:142,x:34666,y:32396,varname:node_142,prsc:2|normal-422-RGB,emission-428-OUT,alpha-422-A;n:type:ShaderForge.SFN_Slider,id:219,x:33950,y:32439,ptovrint:False,ptlb:Inter_streng,ptin:_Inter_streng,varname:node_2475,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Tex2d,id:230,x:33908,y:32908,ptovrint:False,ptlb:Interference,ptin:_Interference,varname:node_6911,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-246-OUT;n:type:ShaderForge.SFN_FragmentPosition,id:244,x:33222,y:32719,varname:node_244,prsc:2;n:type:ShaderForge.SFN_Append,id:245,x:33406,y:32719,varname:node_245,prsc:2|A-244-Y,B-244-W;n:type:ShaderForge.SFN_Multiply,id:246,x:33764,y:32728,varname:node_246,prsc:2|A-318-OUT,B-255-UVOUT;n:type:ShaderForge.SFN_ConstantLerp,id:251,x:34058,y:32691,varname:node_251,prsc:2,a:0.1,b:1|IN-230-RGB;n:type:ShaderForge.SFN_Panner,id:255,x:33592,y:32774,varname:node_255,prsc:2,spu:1,spv:1|UVIN-245-OUT,DIST-339-TDB;n:type:ShaderForge.SFN_ValueProperty,id:318,x:33592,y:32713,ptovrint:False,ptlb:Interference_escale,ptin:_Interference_escale,varname:node_5878,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.2;n:type:ShaderForge.SFN_Time,id:339,x:33292,y:32909,varname:node_339,prsc:2;n:type:ShaderForge.SFN_Time,id:342,x:33400,y:32473,varname:node_342,prsc:2;n:type:ShaderForge.SFN_Tex2d,id:422,x:34366,y:32280,ptovrint:False,ptlb:Emmisive,ptin:_Emmisive,varname:node_705,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:b918fb5752caf7f44b30509f10d6a6ee,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Blend,id:428,x:34420,y:32545,varname:node_428,prsc:2,blmd:1,clmp:False|SRC-422-RGB,DST-579-OUT;n:type:ShaderForge.SFN_Add,id:579,x:34224,y:32598,varname:node_579,prsc:2|A-219-OUT,B-251-OUT;proporder:422-230-219-318;pass:END;sub:END;*/

Shader "BR/Holo_Emmisive_1" {
    Properties {
        _Emmisive ("Emmisive", 2D) = "white" {}
        _Interference ("Interference", 2D) = "white" {}
        _Inter_streng ("Inter_streng", Range(0, 1)) = 1
        _Interference_escale ("Interference_escale", Float ) = 0.2
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma exclude_renderers xbox360 ps3 
            #pragma target 3.0
            uniform float4 _TimeEditor;
            uniform float _Inter_streng;
            uniform sampler2D _Interference; uniform float4 _Interference_ST;
            uniform float _Interference_escale;
            uniform sampler2D _Emmisive; uniform float4 _Emmisive_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
                UNITY_FOG_COORDS(5)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
/////// Vectors:
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float4 _Emmisive_var = tex2D(_Emmisive,TRANSFORM_TEX(i.uv0, _Emmisive));
                float3 normalLocal = _Emmisive_var.rgb;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
////// Lighting:
////// Emissive:
                float4 node_339 = _Time + _TimeEditor;
                float2 node_246 = (_Interference_escale*(float2(i.posWorld.g,i.posWorld.a)+node_339.b*float2(1,1)));
                float4 _Interference_var = tex2D(_Interference,TRANSFORM_TEX(node_246, _Interference));
                float3 emissive = (_Emmisive_var.rgb*(_Inter_streng+lerp(0.1,1,_Interference_var.rgb)));
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,_Emmisive_var.a);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "Meta"
            Tags {
                "LightMode"="Meta"
            }
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_META 1
            #include "UnityCG.cginc"
            #include "UnityMetaPass.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma exclude_renderers xbox360 ps3 
            #pragma target 3.0
            uniform float4 _TimeEditor;
            uniform float _Inter_streng;
            uniform sampler2D _Interference; uniform float4 _Interference_ST;
            uniform float _Interference_escale;
            uniform sampler2D _Emmisive; uniform float4 _Emmisive_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : SV_Target {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
/////// Vectors:
                UnityMetaInput o;
                UNITY_INITIALIZE_OUTPUT( UnityMetaInput, o );
                
                float4 _Emmisive_var = tex2D(_Emmisive,TRANSFORM_TEX(i.uv0, _Emmisive));
                float4 node_339 = _Time + _TimeEditor;
                float2 node_246 = (_Interference_escale*(float2(i.posWorld.g,i.posWorld.a)+node_339.b*float2(1,1)));
                float4 _Interference_var = tex2D(_Interference,TRANSFORM_TEX(node_246, _Interference));
                o.Emission = (_Emmisive_var.rgb*(_Inter_streng+lerp(0.1,1,_Interference_var.rgb)));
                
                float3 diffColor = float3(0,0,0);
                o.Albedo = diffColor;
                
                return UnityMetaFragment( o );
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
