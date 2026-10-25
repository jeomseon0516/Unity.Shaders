# Jeomseon Unity Shaders

[한국어](Overview.md) · [Installation](../README.en.md)

## Purpose

Provides URP Shader/HLSL layers for a single Hex and Hex Grids, plus a legacy uGUI compatibility shader.

## Usage flow

Create a Material using HexagonShape or HexGridSurface, assign it to a renderer, and tune properties/outlines. Use the uGUI shader on Canvas Graphics.

## Contracts and limitations

Grid shaders target URP 17.6 without a Built-in fallback. The uGUI shader is not a UI Toolkit element shader. Tile boundary inclusion is center-based rather than pixel-based.

## Package requirements

- Package ID: `com.jeomseon.unity.shaders`
- Version: `0.2.0`
- Unity: `6000.6` / `0f1`
- `com.unity.ugui`: `2.6.0`
- `com.unity.render-pipelines.universal`: `17.6.0`

## Samples and verification

Import the following from Package Manager > Samples. Open the included Scene or Editor tool; follow any Setup step in its sample README.

- [Basic Usage](../Samples~/BasicUsage/README.md)
  - [ShadersBasicUsageSample](../Samples~/BasicUsage/ShadersBasicUsageSample.unity)

[Test sources](../Tests)

Add the package ID to manifest `testables`, then run the relevant Unity Test Runner assemblies. These links describe available tests, not a new successful test run.

## Source map

See the shader/assets and migration sections in the README.
