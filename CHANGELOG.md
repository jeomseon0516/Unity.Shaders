# 변경 기록

## [Unreleased]

- **(Breaking, 렌더 파이프라인)** 워크스페이스 기준을 Unity `6000.6` + URP `17.6`으로 전환하면서
  `Jeomseon/Grid/Hex Grid Surface`와 `Jeomseon/Shape/Hexagon Outline` 셰이더를 URP 전용으로
  이전했습니다.
  - `#include "UnityCG.cginc"` → `Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl`
  - `UnityObjectToClipPos` → `TransformObjectToHClip`
  - SubShader에 `"RenderPipeline"="UniversalPipeline"`, Pass에 `"LightMode"="UniversalForward"` 태그
  - 머티리얼 프로퍼티를 `CBUFFER_START(UnityPerMaterial)` 블록으로 묶어 SRP Batcher와 호환
  - 순수 수학 계층인 `HexGridCore.hlsl`/`HexagonShapeCore.hlsl`은 Unity include가 없어 변경 없음
- `com.unity.render-pipelines.universal` `17.6.0` 의존성을 추가하고 `com.unity.ugui` 최소 버전을
  `2.6.0`으로 올렸습니다.
- Built-in Render Pipeline에서는 위 두 grid 셰이더가 더 이상 컴파일되지 않습니다. uGUI Canvas
  셰이더 `UI/RoundedEdgeWithFade_Masked`는 파이프라인 비종속이라 그대로 동작합니다.
- Unity 6000.6.0f1 batchmode에서 통합 TestProject import·컴파일 통과, `RoundedEdgeWithFadeShaderTests`
  11/11 통과. grid 셰이더 URP Scene 렌더 육안 검증만 잔여.
- **(방향 전환)** `UI/RoundedEdgeWithFade_Masked`(`GradientMaskShader.shader`)를 **uGUI 전용 호환
  자산으로 동결**합니다. Unity 6000.6 UI Toolkit는 요소별 커스텀 셰이더를 지원하지 않아 셰이더
  이식이 불가하며, 앞으로 UI 시각 요소는 UI Toolkit(USS + `Painter2D`) 기준으로 `Jeomseon.Unity.UI`에
  구현합니다. 이 패키지에는 새 uGUI UI 셰이더를 추가하지 않습니다. 근거: 하네스
  `architecture/ui-toolkit-shader-migration.md`.

## [0.1.6] - 2026-08-20

- 단일 육각형 도형을 그리는 `HexagonShapeCore.hlsl`과 `Hexagon Outline` Shader를 추가했습니다.
- 육각형 중심 좌표 계산과 도형 렌더링을 분리한 `HexGridCore.hlsl` 및 `Hex Grid Surface` Shader를 추가했습니다.
- Grid 경계는 픽셀이 아니라 육각형 중심으로 판정합니다. 경계 밖 픽셀도 인접한 내부 타일의 단일
  도형 외곽선에 속하면 유지해 가장 바깥쪽 도형의 선 굵기와 안티앨리어싱이 잘리지 않게 했습니다.
- 기존 GridTileSystem의 Lit 확장 Shader Graph를 Shaders 패키지로 이동했습니다.

## [0.1.5] - 2026-08-19

- **(P0-01)** `UI/RoundedEdgeWithFade_Masked`에서 `UNITY_UI_CLIP_RECT`와 `UNITY_UI_ALPHACLIP`을
  하나의 `multi_compile`에 상호 배타적으로 선언해 두 기능을 동시에 쓰는 variant가 생성되지 않던
  결함을 수정했습니다. 두 키워드는 독립 `multi_compile_local`, Fade mode는 `shader_feature_local`로
  선언합니다.
- shader 존재·지원 여부, compiler error, uGUI 필수 프로퍼티를 검사하는 `Tests/Editor` Editor 테스트
  어셈블리(`RoundedEdgeWithFadeShaderTests`)를 추가했습니다.
- Built-in TestProject와 별도 URP 검증 프로젝트(`Unity.URPTestProject`) 양쪽에서 위 Editor 테스트
  전체 통과 및 `ShadersBasicUsageSample` 렌더링을 사용자가 확인해 P0-01(렌더 파이프라인 호환성
  검증)을 완료했습니다.

## [0.1.2] - 2026-07-29

- Samples 어셈블리의 `rootNamespace`를 샘플 namespace에 맞게 정리했습니다.

## [0.1.1] - 2026-07-29

- 패키지 Shader 검색을 확인하는 `Basic Usage` 샘플을 추가했습니다.

## [0.1.4] - 2026-08-18

- **(P2-02)** `Basic Usage` 샘플에 `ShadersBasicUsageSample.unity`를 추가했습니다.
  `UI/RoundedEdgeWithFade_Masked`의 프로퍼티 조합 4가지(Rounded Panel/Rounded Outline/Radial
  Fade/Linear Fade)를 렌더링 결과로 직접 비교할 수 있습니다. Import 직후 별도 Setup 메뉴 실행 없이
  바로 Scene을 열어 확인할 수 있도록 `Materials/*.mat` 4개와 Scene을 직접 작성해 커밋했습니다
  (처음 시도한 Setup-메뉴 생성 방식은 매번 재실행해야 하는 번거로움과 폴더 생성 순서 버그가 있어
  폐기). 기존 `ShaderLookupSample`은 Scene의 `Shader Lookup Debug` GameObject에 포함됩니다.
  **사용자가 Unity 6000.5.7f1에서 직접 열어 4개 Panel과 Shader Lookup Debug 모두 Missing
  Material/Script 없이 의도한 대로 렌더링되는 것을 확인했습니다.**
- TODO(api): UI Gradient Mask가 Shader Graph 또는 UI Toolkit 마스킹으로 대체 가능한지 렌더 파이프라인별로 검증합니다.
- 정적 이벤트와 전역 인스턴스의 Domain Reload 비활성화 호환성을 검토합니다.

## [0.1.0] - 2026-07-29

- JeomseonScriptPack의 관련 모듈을 독립 UPM 패키지로 분리했습니다.


## [0.1.3] - 2026-08-05

- Unity 6000.5.7f1을 최소 지원 버전으로 상향했습니다.
