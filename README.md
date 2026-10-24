# Jeomseon Unity Shaders

한국어 | [English](README.en.md)

단일 Hex 도형과 Hex Grid를 나누는 URP Shader/HLSL, 그리고 기존 uGUI용 호환 Shader를 제공합니다.

## 빠르게 시작하기

HexagonShape로 단일 도형 또는 HexGridSurface로 UV Grid Material 생성 → renderer에 연결 → 속성과 외곽선 조정. uGUI 호환 Shader는 Canvas Graphic에서 사용합니다.

## 계약과 주의사항

Grid는 URP 17.6 기준이며 Built-in용 fallback을 제공하지 않습니다. uGUI Shader는 UI Toolkit 요소용 Shader가 아닙니다. 타일 경계는 픽셀이 아닌 중심 기준으로 판정합니다.

## 요구 사항

- Unity `6000.6.0f1`
- 패키지: `com.jeomseon.unity.shaders` `0.2.0`
- `com.unity.ugui`: `2.6.0`
- `com.unity.render-pipelines.universal`: `17.6.0`

## 설치

프로젝트 `Packages/manifest.json`의 기존 dependencies와 registry를 유지하면서 다음 항목을 병합합니다.

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

또는 Package Manager의 **Install package from git URL**을 사용합니다:

```text
https://github.com/jeomseon0516/Unity.Shaders.git#v0.2.0
```

## API 사용과 상세 설명

### 육각형 Shader 계층

- `HexagonShapeCore.hlsl`: 중심 기준 단일 육각형 외곽선 거리와 안티앨리어싱만 담당합니다.
- `HexagonShape.shader`: 단일 육각형 도형을 바로 확인하는 표면 Shader입니다.
- `HexGridCore.hlsl`: 좌표에서 육각형 중심·축 좌표·연속 인덱스를 계산하고 도형 코어를 조합합니다.
- `HexGridSurface.shader`: UV 좌표 위에 여러 육각형을 그리는 고수준 Shader입니다.

Grid 경계는 픽셀이 아니라 타일 중심으로 판정합니다. 가장 바깥 타일은 중심이 Grid 안에 있으면
`HexagonShapeCore`가 계산한 외곽선 전체와 안티앨리어싱 폭까지 표시합니다.

## 샘플 실행

**Package Manager > Samples**에서 예제를 Import합니다. 포함된 Scene 또는 Editor 도구를 열고 필요한 Setup 메뉴를 먼저 실행합니다.

- [Basic Usage](Samples~/BasicUsage/README.md)
  - [ShadersBasicUsageSample](Samples~/BasicUsage/ShadersBasicUsageSample.unity)

## 테스트

[테스트 코드](Tests)

manifest의 `testables`에 패키지 ID를 추가하고 Unity Test Runner의 관련 EditMode/PlayMode 어셈블리를 실행합니다.

## 추가 문서

[전체 코드 지도와 패키지 구성](Documentation~/Overview.md)
- [Changelog](CHANGELOG.md)

## 라이선스

[License](LICENSE.md)
