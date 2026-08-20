# Shaders 로드맵

## 0.1.6 안정화

- [x] 단일 육각형 도형과 육각 Grid 좌표 계산을 독립 HLSL 계층으로 분리
- [x] 고수준 Grid Shader가 `HexagonShapeCore.hlsl`을 재사용하도록 구성
- [ ] Built-in/URP Scene에서 `Hexagon Outline`과 `Hex Grid Surface` 육안 검증

우선순위: `P0` 결함·안전성 → `P1` 핵심 구조 → `P2` API·성능 → `P3` 장기 확장

## 작업 순서

1. **P0-01 — 렌더 파이프라인 호환성 검증** (완료, 2026-08-18)
   - Built-in, URP 및 지원 Unity 버전에서 컴파일 오류와 누락 shader를 검사합니다.
   - 현재 shader는 `UnityCG.cginc`/`UnityUI.cginc` 기반 Canvas UI shader이며 RenderPipeline tag나
     파이프라인 전용 include가 없어 Built-in·URP 공통 경로로 유지합니다.
   - 활성 파이프라인에서 shader 존재·지원 여부와 compiler error를 검사하는 Editor 테스트를
     추가했습니다.
   - 사용자가 Built-in TestProject에서 `RoundedEdgeWithFadeShaderTests` 전체 통과를 확인했습니다.
   - **URP 검증 완료(2026-08-18)**: Unity 6000.5.7f1 3D Cross-Platform 템플릿(URP 17.5.0) 기반의
     별도 검증 프로젝트(`Unity.URPTestProject`, private, `github.com/jeomseon0516`)를 새로 만들어
     `RoundedEdgeWithFadeShaderTests` 8개 전부 PASS를 배치모드로 확인했고, `ShadersBasicUsageSample`을
     같은 프로젝트에 반입해 사용자가 Unity Editor에서 직접 열어 Built-in과 동일하게 렌더링됨을
     확인했습니다. Built-in·URP 양쪽 검증이 모두 끝나 이 항목을 완료로 표시합니다.
2. **P1-01 — Shader·Material 기능 경계 정리**
   - 각 shader의 사용 목적, 입력 프로퍼티, 렌더 큐와 지원 파이프라인을 문서화합니다.
3. **P2-01 — UI Gradient Mask 대체 가능성** (검토 완료, 유지)
   - Shader Graph와 UI Toolkit 또는 uGUI 마스킹으로 대체 가능한지 비교합니다.
   - 이 shader는 uGUI `Mask` stencil 프로퍼티와 `RectMask2D` softness/clip 계약을 동시에 제공하므로
     UI Toolkit 대체는 같은 기능 계약이 아닙니다. 단일 shader에 Shader Graph 의존성을 추가하는 것도
     패키지 크기와 variant 관리 측면의 이점이 없어 현재 hand-written shader를 유지합니다.
   - `RectMask2D`와 alpha clip이 동시에 활성화될 variant가 없던 결함을 발견해 두 local keyword를
     독립 선언했고, Fade mode는 material별 local shader feature로 축소했습니다.
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
