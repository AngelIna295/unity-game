// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Shader created with Shader Forge v1.19 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.19;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:3,spmd:1,trmd:0,grmd:0,uamb:False,mssp:True,bkdf:True,hqlp:True,rprd:False,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.1280277,fgcg:0.1953466,fgcb:0.2352941,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:True;n:type:ShaderForge.SFN_Final,id:142,x:34642,y:32396,varname:node_142,prsc:2|emission-428-OUT,alpha-422-A;n:type:ShaderForge.SFN_Color,id:215,x:33819,y:32528,ptovrint:False,ptlb:Holo_color,ptin:_Holo_color,varname:node_4914,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:0;n:type:ShaderForge.SFN_Multiply,id:217,x:34199,y:32521,varname:node_217,prsc:2|A-219-OUT,B-251-OUT,C-215-RGB;n:type:ShaderForge.SFN_Slider,id:219,x:33843,y:32379,ptovrint:False,ptlb:Inter_streng,ptin:_Inter_streng,varname:node_7511,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1.358974,max:3;n:type:ShaderForge.SFN_Tex2d,id:230,x:33964,y:32751,ptovrint:False,ptlb:Interference,ptin:_Interference,varname:node_2527,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:e9d07e8d4cc68f241932f670175dff9d,ntxv:0,isnm:False|UVIN-246-OUT;n:type:ShaderForge.SFN_FragmentPosition,id:244,x:33016,y:32583,varname:node_244,prsc:2;n:type:ShaderForge.SFN_Multiply,id:246,x:33752,y:32741,varname:node_246,prsc:2|A-318-OUT,B-255-UVOUT;n:type:ShaderForge.SFN_ConstantLerp,id:251,x:34199,y:32758,varname:node_251,prsc:2,a:0.1,b:1|IN-230-RGB;n:type:ShaderForge.SFN_Panner,id:255,x:33571,y:32799,varname:node_255,prsc:2,spu:1,spv:1|UVIN-2714-OUT,DIST-339-TDB;n:type:ShaderForge.SFN_ValueProperty,id:318,x:33530,y:32665,ptovrint:False,ptlb:Interference_escale,ptin:_Interference_escale,varname:node_2864,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.2;n:type:ShaderForge.SFN_Time,id:339,x:33229,y:32914,varname:node_339,prsc:2;n:type:ShaderForge.SFN_Time,id:342,x:33290,y:32419,varname:node_342,prsc:2;n:type:ShaderForge.SFN_Tex2d,id:422,x:34207,y:32244,ptovrint:False,ptlb:Emmisive,ptin:_Emmisive,varname:node_5529,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:69456000a89649b49afc10a03704ea19,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Blend,id:428,x:34394,y:32486,varname:node_428,prsc:2,blmd:1,clmp:False|SRC-422-RGB,DST-217-OUT;n:type:ShaderForge.SFN_Append,id:2714,x:33268,y:32671,varname:node_2714,prsc:2|A-244-Y,B-244-W;proporder:422-215-230-219-318;pass:END;sub:END;*/

Shader "BR/Holo_Emmisive" {
    Properties {
        _Emmisive ("Emmisive", 2D) = "white" {}
        _Holo_color ("Holo_color", Color) = (1,1,1,0)
        _Interference ("Interference", 2D) = "white" {}
        _Inter_streng ("Inter_streng", Range(0, 3)) = 1.358974
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
            Blend One One
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdbase
            #pragma exclude_renderers metal xbox360 xboxone ps3 ps4 psp2 
            #pragma target 2.0
            uniform float4 _TimeEditor;
            uniform float4 _Holo_color;
            uniform float _Inter_streng;
            uniform sampler2D _Interference; uniform float4 _Interference_ST;
            uniform float _Interference_escale;
            uniform sampler2D _Emmisive; uniform float4 _Emmisive_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
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
                o.pos = UnityObjectToClipPos(v.vertex );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
/////// Vectors:
////// Lighting:
////// Emissive:
                float4 _Emmisive_var = tex2D(_Emmisive,TRANSFORM_TEX(i.uv0, _Emmisive));
                float4 node_339 = _Time + _TimeEditor;
                float2 node_246 = (_Interference_escale*(float2(i.posWorld.g,i.posWorld.a)+node_339.b*float2(1,1)));
                float4 _Interference_var = tex2D(_Interference,TRANSFORM_TEX(node_246, _Interference));
                float3 emissive = (_Emmisive_var.rgb*(_Inter_streng*lerp(0.1,1,_Interference_var.rgb)*_Holo_color.rgb));
                float3 finalColor = emissive;
                return fixed4(finalColor,_Emmisive_var.a);
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
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "UnityMetaPass.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma exclude_renderers metal xbox360 xboxone ps3 ps4 psp2 
            #pragma target 2.0
            uniform float4 _TimeEditor;
            uniform float4 _Holo_color;
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
                o.Emission = (_Emmisive_var.rgb*(_Inter_streng*lerp(0.1,1,_Interference_var.rgb)*_Holo_color.rgb));
                
                float3 diffColor = float3(0,0,0);
                float specularMonochrome;
                float3 specColor;
                diffColor = DiffuseAndSpecularFromMetallic( diffColor, 0, specColor, specularMonochrome );
                o.Albedo = diffColor;
                
                return UnityMetaFragment( o );
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
