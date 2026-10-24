# Jeomseon Unity Shaders

[한국어](README.md) | English

Provides URP Shader/HLSL layers for a single Hex and Hex Grids, plus a legacy uGUI compatibility shader.

## Quick start

Create a Material using HexagonShape or HexGridSurface, assign it to a renderer, and tune properties/outlines. Use the uGUI shader on Canvas Graphics.

## Contracts and limitations

Grid shaders target URP 17.6 without a Built-in fallback. The uGUI shader is not a UI Toolkit element shader. Tile boundary inclusion is center-based rather than pixel-based.

## Requirements

- Unity `6000.6.0f1`
- Package: `com.jeomseon.unity.shaders` `0.2.0`
- `com.unity.ugui`: `2.6.0`
- `com.unity.render-pipelines.universal`: `17.6.0`

## Installation

Merge this into your project's `Packages/manifest.json`; preserve existing dependencies and registries.

```json
{
  "scopedRegistries": [
    {
      "name": "OpenUPM",
      "url": "https://package.openupm.com",
      "scopes": [
        "com.jeomseon"
      ]
    }
  ],
  "dependencies": {
    "com.jeomseon.unity.shaders": "0.2.0"
  }
}
```

Or use **Install package from git URL** in Package Manager:

```text
https://github.com/jeomseon0516/Unity.Shaders.git#v0.2.0
```

## API usage and details

### Hex shader layers

- `HexagonShapeCore.hlsl` owns only the centered single-hex outline distance and antialiasing.
- `HexagonShape.shader` renders one standalone hexagon.
- `HexGridCore.hlsl` maps coordinates to hex centers, axial coordinates, and contiguous indices,
  then composes the shape core.
- `HexGridSurface.shader` is the high-level surface shader that repeats the shape across UV space.

Grid membership is based on a tile center instead of the current pixel. When an outer tile center is
inside the grid, its complete `HexagonShapeCore` outline, including the antialiasing width, remains
visible.

## Samples

Import the desired entry from **Package Manager > Samples**. Use the included Scene/Editor tool and complete its Setup step first, if required.

- [Basic Usage](Samples~/BasicUsage/README.md)
  - [ShadersBasicUsageSample](Samples~/BasicUsage/ShadersBasicUsageSample.unity)

## Tests

[Test sources](Tests)

Add the package ID to manifest `testables`, then execute its relevant EditMode/PlayMode assemblies in Unity Test Runner.

## Further reading

[Complete source map and package metadata](Documentation~/Overview.en.md)
- [Changelog](CHANGELOG.md)

## License

[License](LICENSE.md)
