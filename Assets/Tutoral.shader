Shader "Tutorials/Tutoral_01"
{
    Properties
    {
        _MainTexture("Texture", 2D) = "white" {}
        _Color("Color", Color) = (1, 1, 1, 1)
        _ColorThreshold("Color Threshold", Range(0.0, 1.001)) = 1
    }

    SubShader
    {
        pass
        {
            CGPROGRAM

            #pragma vertex vertexFunc
            #pragma fragment fragmentFunc

            #include "UnityCG.cginc"

            struct appdata {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f {
                float4 position : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            fixed4 _Color;
            sampler2D _MainTexture;
            float _ColorThreshold;

            v2f vertexFunc(appdata IN) {
                v2f OUT;
                OUT.position = UnityObjectToClipPos(IN.vertex);
                OUT.uv = IN.uv;
                return OUT;
            }

            fixed4 fragmentFunc(v2f IN) : SV_TARGET {
                fixed4 pixelColor = tex2D(_MainTexture, IN.uv);
                if(any(pixelColor.rgb >= fixed3(_ColorThreshold, _ColorThreshold, _ColorThreshold))) {
                    pixelColor *= _Color * sin(_Time.y * 4) + .1;
                }
                return pixelColor;
                
            }

            ENDCG
        }
    }

}