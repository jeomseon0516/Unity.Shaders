# 변경 기록

## [0.1.2] - 2026-07-29

- Samples 어셈블리의 `rootNamespace`를 샘플 namespace에 맞게 정리했습니다.

## [0.1.1] - 2026-07-29

- 패키지 Shader 검색을 확인하는 `Basic Usage` 샘플을 추가했습니다.

## [Unreleased]

- **(P2-02, Unity 검증 대기)** `Basic Usage` 샘플에 `ShadersBasicUsageSample.unity`를 추가합니다.
  `UI/RoundedEdgeWithFade_Masked`의 프로퍼티 조합 4가지(Rounded Panel/Rounded Outline/Radial
  Fade/Linear Fade)를 렌더링 결과로 직접 비교할 수 있습니다. Import 직후 별도 Setup 메뉴 실행 없이
  바로 Scene을 열어 확인할 수 있도록 `Materials/*.mat` 4개와 Scene을 직접 작성해 커밋했습니다
  (처음 시도한 Setup-메뉴 생성 방식은 매번 재실행해야 하는 번거로움과 폴더 생성 순서 버그가 있어
  폐기). 기존 `ShaderLookupSample`은 Scene의 `Shader Lookup Debug` GameObject에 포함됩니다. 아직
  Unity에서 실제로 열어 렌더링 결과를 시각 확인하지 못했습니다.
- TODO(api): UI Gradient Mask가 Shader Graph 또는 UI Toolkit 마스킹으로 대체 가능한지 렌더 파이프라인별로 검증합니다.
- 정적 이벤트와 전역 인스턴스의 Domain Reload 비활성화 호환성을 검토합니다.

## [0.1.0] - 2026-07-29

- JeomseonScriptPack의 관련 모듈을 독립 UPM 패키지로 분리했습니다.


## [0.1.3] - 2026-08-05

- Unity 6000.5.7f1을 최소 지원 버전으로 상향했습니다.
