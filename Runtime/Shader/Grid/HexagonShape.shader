Shader "Jeomseon/Shape/Hexagon Outline"
{
    Properties
    {
        _ShapeColor("Shape Color", Color) = (0, 1, 1, 1)
        _ShapeRadius("Shape Radius", Range(0.01, 0.5)) = 0.45
        _LineWidth("Line Width", Range(0.001, 0.2)) = 0.03
    }

    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" }
        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            Cull Off

            HLSLPROGRAM
            #pragma target 3.5
            #pragma vertex Vertex
            #pragma fragment Fragment
            #include "UnityCG.cginc"
            #include "HexagonShapeCore.hlsl"

            float4 _ShapeColor;
            float _ShapeRadius;
            float _LineWidth;

            struct Attributes { float4 positionOS : POSITION; float2 uv : TEXCOORD0; };
            struct Varyings { float4 positionCS : SV_POSITION; float2 position : TEXCOORD0; };

            Varyings Vertex(Attributes input)
            {
                Varyings output;
                output.positionCS = UnityObjectToClipPos(input.positionOS);
                output.position = input.uv - 0.5;
                return output;
            }

            float4 Fragment(Varyings input) : SV_Target
            {
                float alpha = JeomseonHexagonOutlineAlpha(input.position, _ShapeRadius, _LineWidth);
                return float4(_ShapeColor.rgb, _ShapeColor.a * alpha);
            }
            ENDHLSL
        }
    }
    Fallback Off
}
