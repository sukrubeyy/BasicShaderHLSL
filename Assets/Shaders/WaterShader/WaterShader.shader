Shader "Unlit/WaterShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _WaveAmp("Wave Amplitude",Range(0,5))=0.1
        _WaveMoveSpeed("Wave Speed",Range(0,6))=0.1
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        Blend One One //Additive Saydam yapmak için kullanılır
        ZWrite Off  // Kamera Depth değerini yazmayı kapatır
        Cull Off // Her iki yüzü de render eder
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

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _WaveAmp;
            float _WaveMoveSpeed;

          
            v2f vert (appdata v)
            {
                v2f o;
                v.vertex.y = sin((v.uv-_Time.y*_WaveMoveSpeed)*_WaveAmp)*0.5+0.5;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            float4 frag (v2f i) : SV_Target
            {

                float4 col = tex2D(_MainTex,i.uv);
                
                return col;
            }
            ENDCG
        }
    }
}
