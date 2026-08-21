#ifndef JEOMSEON_HEXAGON_SHAPE_CORE_INCLUDED
#define JEOMSEON_HEXAGON_SHAPE_CORE_INCLUDED

float JeomseonDistanceToHexagonSegment(float2 samplePoint, float2 start, float2 end)
{
    float2 segment = end - start;
    float denominator = max(dot(segment, segment), 0.000001);
    return length(samplePoint - (start + saturate(dot(samplePoint - start, segment) / denominator) * segment));
}

float JeomseonHexagonOutlineAlpha(float2 position, float radius, float lineWidth)
{
    float minimumDistance = 1e10;

    [unroll]
    for (int corner = 0; corner < 6; corner++)
    {
        float angleA = radians(60.0 * corner);
        float angleB = radians(60.0 * (corner + 1));
        float2 start = radius * float2(cos(angleA), sin(angleA));
        float2 end = radius * float2(cos(angleB), sin(angleB));
        minimumDistance = min(minimumDistance, JeomseonDistanceToHexagonSegment(position, start, end));
    }

    float halfWidth = max(lineWidth * 0.5, 0.00001);
    float antialiasing = max(fwidth(minimumDistance), 0.00001);
    return 1.0 - smoothstep(halfWidth - antialiasing, halfWidth + antialiasing, minimumDistance);
}

#endif
