# Shaders 로드맵

## Unreleased — Unity 6000.6 + URP 17.6 전환

- [x] grid 셰이더 2개(`Hex Grid Surface`, `Hexagon Outline`)를 URP 전용으로 이전
      (`Core.hlsl`, `TransformObjectToHClip`, `UniversalPipeline`/`UniversalForward` 태그,
      `UnityPerMaterial` CBUFFER)
- [x] `com.unity.render-pipelines.universal` `17.6.0` 의존성 추가, `com.unity.ugui` `2.6.0`
- [x] 통합 TestProject(URP) import·컴파일 및 `RoundedEdgeWithFadeShaderTests` 11/11 통과
      (Unity 6000.6.0f1 batchmode). grid 셰이더 URP Scene 렌더 육안 검증만 잔여.
- [x] `UI/RoundedEdgeWithFade_Masked`를 **uGUI 전용 호환 자산으로 동결** (아래 참고)

## uGUI UI 셰이더 동결 — UI Toolkit로 방향 전환 (2026-09-02 사용자 지시)

`UI/RoundedEdgeWithFade_Masked`(`Runtime/Shader/UI/GradientMaskShader.shader`)는 **uGUI 전용
호환 자산으로 동결**합니다. 결함 수정은 받되 신규 기능은 추가하지 않습니다.

Unity 6000.6 UI Toolkit는 요소별 커스텀 Shader/Material 지정을 지원하지 않으므로(‘셰이더 이식’
자체가 불가), 둥근 패널·페이드·마스킹은 셰이더가 아니라 USS + `Painter2D`(벡터 API, `FillGradient`
linear/radial) + `generateVisualContent`로 재구현합니다. 상세 근거·API 표면·1:1로 옮겨지지 않는
항목은 하네스 `architecture/ui-toolkit-shader-migration.md` 참고.

앞으로 UI 시각 요소는 UI Toolkit 기준으로 **`Jeomseon.Unity.UI`** 패키지(`ADR-0008`)에 `VisualElement`
컴포넌트로 구현합니다. 이 패키지(`Jeomseon.Unity.Shaders`)에는 새 uGUI UI 셰이더를 추가하지 않으며,
활성 범위는 URP world/grid 셰이더와 향후 world-space HLSL입니다.

## 0.1.6 안정화

- [x] 단일 육각형 도형과 육각 Grid 좌표 계산을 독립 HLSL 계층으로 분리
- [x] 고수준 Grid Shader가 `HexagonShapeCore.hlsl`을 재사용하도록 구성

우선순위: `P0` 결함·안전성 → `P1` 핵심 구조 → `P2` API·성능 → `P3` 장기 확장

## 작업 순서

1. **P0-01 — 렌더 파이프라인 호환성 검증** (2026-08-18 Built-in/URP 병행 완료 → 2026-09-02 URP 전용 재확정)
   - 2026-08-18 이력: `UnityCG.cginc`/`UnityUI.cginc` 기반 shader를 Built-in·URP 공통 경로로 유지하고,
     별도 검증 프로젝트(당시 `Unity.URPTestProject`)에서 `RoundedEdgeWithFadeShaderTests` 8개 PASS와
     `ShadersBasicUsageSample` 렌더링을 확인했습니다.
   - 2026-09-02: 워크스페이스 렌더링 기준이 URP `17.6` 단일로 바뀌면서 grid 셰이더 2개는
     Built-in 공통 경로를 버리고 URP 전용(`Core.hlsl` include, `UniversalPipeline` 태그)으로
     이전했습니다. uGUI Canvas 셰이더(`UI/RoundedEdgeWithFade_Masked`)는 파이프라인 비종속이라
     그대로 유지합니다. 별도 `URPTestProject`는 통합 TestProject 자체가 URP로 전환되면서 제거했고,
     검증은 통합 TestProject Render Graph 경로에서 수행합니다.
   - 활성 파이프라인에서 shader 존재·지원 여부와 compiler error를 검사하는 Editor 테스트는 유지합니다.
2. **P1-01 — Shader·Material 기능 경계 정리**
   - 각 shader의 사용 목적, 입력 프로퍼티, 렌더 큐와 지원 파이프라인을 문서화합니다.
3. **P2-01 — UI Gradient Mask 대체 가능성** (2026-09-02 재검토 → uGUI 전용 동결로 종결)
   - Unity 6000.6 UI Toolkit는 요소별 커스텀 Shader/Material을 지원하지 않아 셰이더 이식 자체가
     불가합니다. UI Toolkit 대응은 USS + `Painter2D`(`FillGradient` linear/radial) 재구현이며
     `Jeomseon.Unity.UI`(`ADR-0008`) 소속입니다. 상세는
     하네스 `architecture/ui-toolkit-shader-migration.md`.
   - 이 셰이더는 **uGUI 전용 호환 자산으로 동결**합니다(신규 기능 없음, 결함 수정만).
   - (이력) `RectMask2D`와 alpha clip이 동시에 활성화될 variant가 없던 결함을 발견해 두 local
     keyword를 독립 선언했고, Fade mode는 material별 local shader feature로 축소했습니다.
4. **P2-02 — 샘플과 시각 회귀 테스트 (완료, 2026-08-17, 2026-08-18 사용자 Unity 검증 완료)**
   - 대표 material과 scene/sample을 제공하고 주요 플랫폼의 결과를 확인합니다.
   - 기존 `Basic Usage` 샘플은 `Shader.Find` 조회만 확인하는 스크립트뿐이라 실제 렌더링 결과를
     눈으로 볼 수 없었습니다. `UI/RoundedEdgeWithFade_Masked`의 프로퍼티 조합 4가지(Rounded Panel,
     Rounded Outline, Radial Fade, Linear Fade)를 보여주는 `ShadersBasicUsageSample.unity`를
     추가합니다.
   - **Setup 메뉴 방식을 폐기했습니다**: 처음에는 Material이 Shader를 참조하는 native 엔진
     에셋이라는 이유로 `Jeomseon/Shaders/Setup Basic Usage Sample` 메뉴를 만들어 Unity가 직접
     생성하게 했으나(`Jeomseon.Unity.SafeArea`의 `SafeAreaUIToolkitSampleSetup`과 같은 패턴),
     사용자가 "샘플 Import 후 별도 버튼을 눌러야 하는 프로세스"를 원하지 않는다고 지적했습니다.
     `AssetDatabase.CreateFolder` 직후 `AssetDatabase.CreateAsset`이 "부모 디렉토리가 존재해야
     합니다" 오류로 매번 실패하는 실제 버그도 있었습니다. Setup 스크립트/asmdef를 전부 제거하고,
     `Materials/*.mat` 4개와 `ShadersBasicUsageSample.unity`(각 `.meta` 포함)를 직접 작성해
     커밋했습니다 — Import 즉시 Scene을 열면 바로 확인할 수 있습니다. 기존 `ShaderLookupSample`도
     Scene에 `Shader Lookup Debug` GameObject로 포함했습니다(GUID를 고정한 `.meta`를 새로 커밋).
   - **사용자 Unity 검증 완료(2026-08-18)**: Unity 6000.5.7f1에서 `ShadersBasicUsageSample.unity`를
     열어 확인한 결과, 손으로 작성한 Material/Scene YAML이 정확히 로드되고 4개 Panel(Rounded Panel/
     Rounded Outline/Radial Fade/Linear Fade)이 Missing Material/Script 없이 의도한 대로
     렌더링되는 것을 확인했습니다.
5. **P3-01 — 파이프라인별 하위 패키지** (도입하지 않음)
   - 파이프라인 전용 shader가 늘어날 때만 URP 등 별도 패키지 분리를 검토합니다.
