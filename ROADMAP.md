# Shaders 로드맵

우선순위: `P0` 결함·안전성 → `P1` 핵심 구조 → `P2` API·성능 → `P3` 장기 확장

## 작업 순서

1. **P0-01 — 렌더 파이프라인 호환성 검증**
   - Built-in, URP 및 지원 Unity 버전에서 컴파일 오류와 누락 shader를 검사합니다.
2. **P1-01 — Shader·Material 기능 경계 정리**
   - 각 shader의 사용 목적, 입력 프로퍼티, 렌더 큐와 지원 파이프라인을 문서화합니다.
3. **P2-01 — UI Gradient Mask 대체 가능성**
   - Shader Graph와 UI Toolkit 또는 uGUI 마스킹으로 대체 가능한지 비교합니다.
4. **P2-02 — 샘플과 시각 회귀 테스트 (진행 중, 2026-08-17, Unity 검증 대기)**
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
   - **아직 실제 Unity에서 열어 렌더링 결과를 시각 확인하지 못했습니다.** 손으로 작성한 Material/
     Scene YAML이 Unity 6000.5.7f1에서 정확히 로드되는지(Missing Material/Script 없이, 4개
     Panel이 의도한 모양으로 렌더링되는지) 다음 세션(또는 사용자)이 확인해야 합니다.
5. **P3-01 — 파이프라인별 하위 패키지**
   - 파이프라인 전용 shader가 늘어날 때만 URP 등 별도 패키지 분리를 검토합니다.
