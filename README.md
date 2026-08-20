# Jeomseon Unity Shaders

UI와 육각형 도형/Grid에 재사용할 수 있는 Shader 패키지입니다.

## 육각형 Shader 계층

- `HexagonShapeCore.hlsl`: 중심 기준 단일 육각형 외곽선 거리와 안티앨리어싱만 담당합니다.
- `HexagonShape.shader`: 단일 육각형 도형을 바로 확인하는 표면 Shader입니다.
- `HexGridCore.hlsl`: 좌표에서 육각형 중심·축 좌표·연속 인덱스를 계산하고 도형 코어를 조합합니다.
- `HexGridSurface.shader`: UV 좌표 위에 여러 육각형을 그리는 고수준 Shader입니다.

Grid 경계는 픽셀이 아니라 타일 중심으로 판정합니다. 가장 바깥 타일은 중심이 Grid 안에 있으면
`HexagonShapeCore`가 계산한 외곽선 전체와 안티앨리어싱 폭까지 표시합니다.

## 설치

OpenUPM 등록 전에는 Package Manager의 **Add package from git URL**에서 다음 주소를 사용합니다.

```text
https://github.com/jeomseon0516/Unity.Shaders.git#v0.1.6
```

## 리팩토링 방침

Unity가 제공하는 동등 기능과 비교해 대체 가능한 코드는 소스의 한글 TODO 주석과 CHANGELOG의 Unreleased 항목에서 추적합니다.
