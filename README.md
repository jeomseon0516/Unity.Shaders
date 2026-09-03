# Jeomseon Unity Shaders

육각형 도형/Grid용 URP world 셰이더와, uGUI 전용 호환 UI 셰이더를 담는 Shader 패키지입니다.

## 요구 사항 / 렌더 파이프라인

- Unity `6000.6.0f1` 이상
- grid 셰이더(`Hex Grid Surface`, `Hexagon Outline`)는 **URP `17.6` 전용**입니다
  (6000.6 전환부터, `com.unity.render-pipelines.universal` 의존성). Built-in Render Pipeline에서는
  컴파일되지 않습니다.
- `UI/RoundedEdgeWithFade_Masked`(`GradientMaskShader.shader`)는 **uGUI(Canvas) 전용 호환 자산**
  입니다. 파이프라인 비종속이라 Built-in·URP 모두에서 동작하지만 **동결 상태**로, 결함 수정만
  받고 신규 기능은 추가하지 않습니다. Unity 6000.6 UI Toolkit는 요소별 커스텀 셰이더를 지원하지
  않으므로, 앞으로 둥근 패널·페이드·마스킹 같은 UI 시각 요소는 UI Toolkit(USS + `Painter2D`)
  기준으로 `Jeomseon.Unity.UI` 패키지에 구현합니다. 근거는 하네스
  `architecture/ui-toolkit-shader-migration.md` 참고.

## 육각형 Shader 계층

- `HexagonShapeCore.hlsl`: 중심 기준 단일 육각형 외곽선 거리와 안티앨리어싱만 담당합니다.
- `HexagonShape.shader`: 단일 육각형 도형을 바로 확인하는 표면 Shader입니다.
- `HexGridCore.hlsl`: 좌표에서 육각형 중심·축 좌표·연속 인덱스를 계산하고 도형 코어를 조합합니다.
- `HexGridSurface.shader`: UV 좌표 위에 여러 육각형을 그리는 고수준 Shader입니다.

Grid 경계는 픽셀이 아니라 타일 중심으로 판정합니다. 가장 바깥 타일은 중심이 Grid 안에 있으면
`HexagonShapeCore`가 계산한 외곽선 전체와 안티앨리어싱 폭까지 표시합니다.

## OpenUPM으로 설치

프로젝트의 `Packages/manifest.json`에 OpenUPM scoped registry를 한 번 등록합니다.

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

## Git URL로 설치

Unity Package Manager의 `Install package from git URL`에 다음 주소를 사용합니다.

```text
https://github.com/jeomseon0516/Unity.Shaders.git#v0.2.0
```

## 리팩토링 방침

Unity가 제공하는 동등 기능과 비교해 대체 가능한 코드는 소스의 한글 TODO 주석과 CHANGELOG의 Unreleased 항목에서 추적합니다.
