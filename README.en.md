# Jeomseon Unity Shaders

URP world shaders for hexagon shapes / grids, plus a uGUI-only compatibility UI shader.

## Requirements / render pipeline

- Unity `6000.6.0f1` or newer.
- The grid shaders (`Hex Grid Surface`, `Hexagon Outline`) are **URP `17.6` only** (since the 6000.6
  migration, via the `com.unity.render-pipelines.universal` dependency). They do not compile under the
  Built-in Render Pipeline.
- `UI/RoundedEdgeWithFade_Masked` (`GradientMaskShader.shader`) is a **uGUI (Canvas) compatibility
  asset**. It is pipeline-independent (works under Built-in and URP) but **frozen**: bug fixes only,
  no new features. Unity 6000.6 UI Toolkit does not support per-element custom shaders, so new UI
  visuals (rounded panels, fades, masking) are built the UI Toolkit way (USS + `Painter2D`) in the
  `Jeomseon.Unity.UI` package. See harness `architecture/ui-toolkit-shader-migration.md`.

## Hex shader layers

- `HexagonShapeCore.hlsl` owns only the centered single-hex outline distance and antialiasing.
- `HexagonShape.shader` renders one standalone hexagon.
- `HexGridCore.hlsl` maps coordinates to hex centers, axial coordinates, and contiguous indices,
  then composes the shape core.
- `HexGridSurface.shader` is the high-level surface shader that repeats the shape across UV space.

Grid membership is based on a tile center instead of the current pixel. When an outer tile center is
inside the grid, its complete `HexagonShapeCore` outline, including the antialiasing width, remains
visible.
