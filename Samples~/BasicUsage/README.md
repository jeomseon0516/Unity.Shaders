# Shaders 기본 예제

Import 직후 별도 Setup 작업 없이 `ShadersBasicUsageSample.unity`를 바로 열어 패키지 Shader가
실제로 어떻게 보이는지 확인합니다. Play Mode가 필요 없는 순수 UI 렌더링 예제라 Scene 뷰만으로
확인할 수 있습니다. `Materials/*.mat` 4개는 Scene과 함께 이미 커밋되어 있습니다.

## Scene 구성

어두운 배경 위에 `UI/RoundedEdgeWithFade_Masked` Shader의 프로퍼티 조합 4가지를 나란히 보여주는
`Image` 4개가 있습니다. 각 Panel은 자신을 사용하는 Material과 같은 이름이고, 아래에 Label이
붙어 있습니다.

- **Rounded Panel** — 기본 라운드 사각형(`_CornerRadius`/`_CornerSoftness`만 사용, Outline/Edge/
  Fade 없음).
- **Rounded Outline** — 라운드 사각형 + 윤곽선(`_OutlineColor`/`_OutlineThickness`) + 엣지
  그라데이션(`_EdgeColor`/`_EdgeThickness`/`_EdgeGradient`).
- **Radial Fade** — `_FadeMode = Radial`. 중심(`_FadeCenter`)에서 `_FadeRadius`/`_FadePower`에
  따라 원형으로 투명해집니다.
- **Linear Fade** — `_FadeMode = Linear`. 위쪽에서 아래쪽으로 `_FadePower`에 따라 투명해집니다.
- **Shader Lookup Debug** — `ShaderLookupSample` 부착. 컨텍스트 메뉴로 `Shader.Find`가 패키지
  Shader를 찾는지 별도로 확인할 수 있습니다.

`_MainTex`는 모든 Material에서 기본값(흰 텍스처)을 그대로 쓰므로 `Image.sprite`는 비워둡니다.
`[KeywordEnum]` 기반 `_FadeMode`는 Material Inspector 드롭다운에서 값을 바꾸면 자동으로
`_FADEMODE_RADIAL`/`_FADEMODE_LINEAR` 키워드가 토글됩니다(`RadialFade.mat`/`LinearFade.mat`은
각각 해당 키워드를 켠 상태로 커밋되어 있습니다. `_FadeMode = None`은 아무 키워드도 켜지 않아도
셰이더의 `#else` 분기로 자연스럽게 떨어집니다).

## 확인 절차

1. `ShadersBasicUsageSample.unity`를 엽니다.
2. Scene 뷰(또는 Game 뷰)에서 4개 Panel이 각각 다른 모양으로 렌더링되는지 확인합니다 — 특히
   `Radial Fade`/`Linear Fade`가 서로 다른 방향으로 투명해지는지, `Rounded Outline`에 윤곽선과
   엣지 그라데이션이 보이는지 확인합니다.
3. 아무 Panel의 Material을 선택해 Inspector에서 `Corner Radius`/`Outline Thickness` 등의 슬라이더를
   조절하면서 값이 Scene 뷰에 실시간으로 반영되는지 확인합니다(Shader 자체의 Properties 계약
   확인).
4. `Shader Lookup Debug`를 선택해 `ShaderLookupSample` 컴포넌트의 컨텍스트 메뉴("샘플 Shader
   확인")를 실행하고 `Shader.Find`가 패키지 Shader를 정상적으로 찾는지 Console에서 확인합니다.
