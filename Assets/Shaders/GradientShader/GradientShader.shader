Shader "Unlit/GradientShader"
{
    Properties
    {
        _ColorA("Color A",Color)=(1,1,1,1)
        _ColorB("Color B",Color)=(1,1,1,1)
        _StartColor("Start Color",Range(0,1))=0
        _EndColor("End Color",Range(0,1))=1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            float4 _ColorA;
            float4 _ColorB;
            float _StartColor;
            float _EndColor;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            float InverseLerp(float a, float b, float c){
                return (c-a)/(b-a);
            }
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            float4 frag (v2f i) : SV_Target
            {
                float t = saturate(InverseLerp(_StartColor,_EndColor,i.uv.x));
                float4 outColor = lerp(_ColorA,_ColorB,t);
                return outColor;
            }
            ENDCG
        }
    }
}
