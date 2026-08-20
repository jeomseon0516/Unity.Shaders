# Jeomseon Unity Shaders

Reusable UI, hexagon shape, and hex-grid shaders.

## Hex shader layers

- `HexagonShapeCore.hlsl` owns only the centered single-hex outline distance and antialiasing.
- `HexagonShape.shader` renders one standalone hexagon.
- `HexGridCore.hlsl` maps coordinates to hex centers, axial coordinates, and contiguous indices,
  then composes the shape core.
- `HexGridSurface.shader` is the high-level surface shader that repeats the shape across UV space.

Grid membership is based on a tile center instead of the current pixel. When an outer tile center is
inside the grid, its complete `HexagonShapeCore` outline, including the antialiasing width, remains
visible.
