# Jeomseon Unity Shaders

[English](Overview.en.md) · [설치](../README.md)

## 목적

단일 Hex 도형과 Hex Grid를 나누는 URP Shader/HLSL, 그리고 기존 uGUI용 호환 Shader를 제공합니다.

## 사용 흐름

HexagonShape로 단일 도형 또는 HexGridSurface로 UV Grid Material 생성 → renderer에 연결 → 속성과 외곽선 조정. uGUI 호환 Shader는 Canvas Graphic에서 사용합니다.

## 계약과 제한

Grid는 URP 17.6 기준이며 Built-in용 fallback을 제공하지 않습니다. uGUI Shader는 UI Toolkit 요소용 Shader가 아닙니다. 타일 경계는 픽셀이 아닌 중심 기준으로 판정합니다.

## 패키지 요구 사항

- Package ID: `com.jeomseon.unity.shaders`
- Version: `0.2.0`
- Unity: `6000.6` / `0f1`
- `com.unity.ugui`: `2.6.0`
- `com.unity.render-pipelines.universal`: `17.6.0`

## 샘플과 검증

Package Manager > Samples에서 다음 예제를 Import하세요. 포함된 Scene 또는 Editor 도구를 열고 샘플 README의 Setup 절차를 먼저 수행합니다.

- [Basic Usage](../Samples~/BasicUsage/README.md)
  - [ShadersBasicUsageSample](../Samples~/BasicUsage/ShadersBasicUsageSample.unity)

[테스트 코드](../Tests)

소비 프로젝트 manifest의 `testables`에 패키지 ID를 추가하고 Unity Test Runner의 관련 어셈블리를 실행합니다. 위 링크는 테스트 위치이며 이번 문서 수정으로 새 테스트 실행을 주장하지 않습니다.

## 코드 지도

README의 Shader/자산 구성 또는 Migration 절을 참고하세요.
