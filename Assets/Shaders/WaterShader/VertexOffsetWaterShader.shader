Shader "Unlit/VertexOffsetWaterShader"
{
    Properties
    {
        _Color("Color",Color)=(1,1,1,1)
        _WaveAmp("Wave Amplitude",Range(0,0.2))=0.1
        _WaveSpeed("Wave Speed",Range(0,0.3))=0.1
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        Pass
        {
            CGPROGRAM
            #define TAU 6.28318530718
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

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

            float4 _Color;
            float _WaveAmp;
            float _WaveSpeed;

            float GetWave(float2 uv){
                float2 uvCenter = uv*2-1;
                float radialCenter = length(uvCenter);
                float waves = cos((radialCenter-_Time.y*_WaveSpeed)*TAU*5)*0.5+0.5;
                waves*=1-radialCenter;
                return waves;
            }

            v2f vert (appdata v)
            {
                v2f o;
                v.vertex.y = GetWave(v.uv)*_WaveAmp;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            float4 frag (v2f i) : SV_Target
            {
                return GetWave(i.uv);
            }
            ENDCG
        }
    }
}
