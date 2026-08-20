#ifndef JEOMSEON_HEX_GRID_CORE_INCLUDED
#define JEOMSEON_HEX_GRID_CORE_INCLUDED

#include "HexagonShapeCore.hlsl"

static const float JEOMSEON_SQRT_3 = 1.7320508075688772;

struct JeomseonHexCell
{
    int q;
    int r;
    int s;
    float2 center;
};

float3 JeomseonCubeRound(float3 cube)
{
    float3 rounded = round(cube);
    float3 difference = abs(rounded - cube);

    if (difference.x > difference.y && difference.x > difference.z)
        rounded.x = -rounded.y - rounded.z;
    else if (difference.y > difference.z)
        rounded.y = -rounded.x - rounded.z;
    else
        rounded.z = -rounded.x - rounded.y;

    return rounded;
}

JeomseonHexCell JeomseonGetHexCell(float2 position, float tileRadius)
{
    float safeRadius = max(tileRadius, 0.00001);
    float q = (2.0 / 3.0 * position.x) / safeRadius;
    float r = (-1.0 / 3.0 * position.x + JEOMSEON_SQRT_3 / 3.0 * position.y) / safeRadius;
    float3 cube = JeomseonCubeRound(float3(q, r, -q - r));

    JeomseonHexCell cell;
    cell.q = (int)cube.x;
    cell.r = (int)cube.y;
    cell.s = (int)cube.z;
    cell.center = safeRadius * float2(
        1.5 * cell.q,
        JEOMSEON_SQRT_3 * (0.5 * cell.q + cell.r));
    return cell;
}

bool JeomseonIsCellInsideGrid(JeomseonHexCell cell, int gridRadius)
{
    return max(abs(cell.q), max(abs(cell.r), abs(cell.s))) <= gridRadius;
}

int JeomseonHexCellIndex(JeomseonHexCell cell, int gridRadius)
{
    int negativePrefix = gridRadius * (gridRadius + 1) / 2;
    int absolutePrefix = cell.q <= 0
        ? negativePrefix - (-cell.q) * (-cell.q + 1) / 2
        : negativePrefix + cell.q * (cell.q - 1) / 2;
    int rMin = max(-gridRadius, -cell.q - gridRadius);
    return (2 * gridRadius + 1) * (cell.q + gridRadius) - absolutePrefix + cell.r - rMin;
}

JeomseonHexCell JeomseonGetHexCellFromCoordinates(int q, int r, float tileRadius)
{
    JeomseonHexCell cell;
    cell.q = q;
    cell.r = r;
    cell.s = -q - r;
    cell.center = max(tileRadius, 0.00001) * float2(
        1.5 * cell.q,
        JEOMSEON_SQRT_3 * (0.5 * cell.q + cell.r));
    return cell;
}

bool JeomseonTryGetVisibleHexCell(
    float2 position,
    float tileRadius,
    int gridRadius,
    float lineWidth,
    out JeomseonHexCell cell,
    out float outlineAlpha)
{
    cell = JeomseonGetHexCell(position, tileRadius);
    if (JeomseonIsCellInsideGrid(cell, gridRadius))
    {
        outlineAlpha = JeomseonHexagonOutlineAlpha(position - cell.center, tileRadius, lineWidth);
        return true;
    }

    static const int2 neighborOffsets[6] =
    {
        int2(1, 0), int2(1, -1), int2(0, -1),
        int2(-1, 0), int2(-1, 1), int2(0, 1)
    };

    [unroll]
    for (int neighborIndex = 0; neighborIndex < 6; neighborIndex++)
    {
        JeomseonHexCell neighbor = JeomseonGetHexCellFromCoordinates(
            cell.q + neighborOffsets[neighborIndex].x,
            cell.r + neighborOffsets[neighborIndex].y,
            tileRadius);
        if (!JeomseonIsCellInsideGrid(neighbor, gridRadius)) continue;

        float neighborAlpha = JeomseonHexagonOutlineAlpha(
            position - neighbor.center,
            tileRadius,
            lineWidth);
        if (neighborAlpha <= 0.0) continue;

        cell = neighbor;
        outlineAlpha = neighborAlpha;
        return true;
    }

    outlineAlpha = 0.0;
    return false;
}

#endif
