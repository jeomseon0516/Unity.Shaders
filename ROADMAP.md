# Shaders 로드맵

우선순위: `P0` 결함·안전성 → `P1` 핵심 구조 → `P2` API·성능 → `P3` 장기 확장

## 작업 순서

1. **P0-01 — 렌더 파이프라인 호환성 검증**
   - Built-in, URP 및 지원 Unity 버전에서 컴파일 오류와 누락 shader를 검사합니다.
2. **P1-01 — Shader·Material 기능 경계 정리**
   - 각 shader의 사용 목적, 입력 프로퍼티, 렌더 큐와 지원 파이프라인을 문서화합니다.
3. **P2-01 — UI Gradient Mask 대체 가능성**
   - Shader Graph와 UI Toolkit 또는 uGUI 마스킹으로 대체 가능한지 비교합니다.
4. **P2-02 — 샘플과 시각 회귀 테스트**
   - 대표 material과 scene/sample을 제공하고 주요 플랫폼의 결과를 확인합니다.
5. **P3-01 — 파이프라인별 하위 패키지**
   - 파이프라인 전용 shader가 늘어날 때만 URP 등 별도 패키지 분리를 검토합니다.
