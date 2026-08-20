Shader "Jeomseon/Grid/Hex Grid Surface"
{
    Properties
    {
        _GridColor("Grid Color", Color) = (0, 1, 1, 1)
        _TileRadius("Tile Radius", Float) = 0.5
        _GridRadius("Grid Radius", Int) = 3
        _LineWidth("Line Width", Float) = 0.03
        _CoordinateScale("Coordinate Scale", Vector) = (10, 10, 0, 0)
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
            #include "HexGridCore.hlsl"

            float4 _GridColor;
            float _TileRadius;
            int _GridRadius;
            float _LineWidth;
            float4 _CoordinateScale;

            struct Attributes { float4 positionOS : POSITION; float2 uv : TEXCOORD0; };
            struct Varyings { float4 positionCS : SV_POSITION; float2 coordinate : TEXCOORD0; };

            Varyings Vertex(Attributes input)
            {
                Varyings output;
                output.positionCS = UnityObjectToClipPos(input.positionOS);
                output.coordinate = (input.uv - 0.5) * _CoordinateScale.xy;
                return output;
            }

            float4 Fragment(Varyings input) : SV_Target
            {
                JeomseonHexCell cell;
                float alpha;
                clip(JeomseonTryGetVisibleHexCell(
                    input.coordinate,
                    _TileRadius,
                    _GridRadius,
                    _LineWidth,
                    cell,
                    alpha) ? 1.0 : -1.0);
                return float4(_GridColor.rgb, _GridColor.a * alpha);
            }
            ENDHLSL
        }
    }
    Fallback Off
}
