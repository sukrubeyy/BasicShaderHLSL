Shader "Unlit/Shader1"
{
    Properties
    {
        _Amplitude("Amplitude", Float)=0.5
        _MainColor("Main Color", Color)=(1,0,0,1)
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

            float4 _MainColor;
            float _Amplitude;

            struct appdata
            {
                float4 vertex : POSITION;
               
            };

            struct v2f
            {
                float4 clipPos : SV_POSITION;
            };


            v2f vert (appdata v)
            {
                v2f o;
                if(v.vertex.y > 0){
                    v.vertex.y = _Amplitude * sin(_Time.y);
                }
                o.clipPos = UnityObjectToClipPos(v.vertex);
                return o;
            }

            float4 frag (v2f i) : SV_Target
            {
                 return _MainColor;   
            }
            ENDCG
        }
    }
}
