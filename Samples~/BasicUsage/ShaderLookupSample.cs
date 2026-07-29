using UnityEngine;

namespace Jeomseon.Samples.Shaders
{
    public sealed class ShaderLookupSample : MonoBehaviour
    {
        [ContextMenu("샘플 Shader 확인")]
        private void FindShader()
        {
            Shader shader = Shader.Find("UI/RoundedEdgeWithFade_Masked");
            Debug.Log(shader != null ? $"Shader 발견: {shader.name}" : "Shader를 찾지 못했습니다.");
        }
    }
}
