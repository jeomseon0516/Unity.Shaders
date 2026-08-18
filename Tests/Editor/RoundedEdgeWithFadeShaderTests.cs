using System.Linq;
using NUnit.Framework;
using UnityEditor;
using UnityEditor.Rendering;
using UnityEngine;

namespace Jeomseon.Tests
{
    public sealed class RoundedEdgeWithFadeShaderTests
    {
        private const string ShaderName = "UI/RoundedEdgeWithFade_Masked";

        [Test]
        public void Shader_IsAvailableAndSupported()
        {
            Shader shader = Shader.Find(ShaderName);

            Assert.That(shader, Is.Not.Null);
            Assert.That(shader.isSupported, Is.True);
        }

        [Test]
        public void Shader_HasNoCompilerErrors()
        {
            Shader shader = Shader.Find(ShaderName);
            Assert.That(shader, Is.Not.Null);

            string[] errors = ShaderUtil.GetShaderMessages(shader)
                .Where(message => message.severity == ShaderCompilerMessageSeverity.Error)
                .Select(message => $"{message.platform}: {message.message}")
                .ToArray();

            Assert.That(errors, Is.Empty, string.Join("\n", errors));
        }

        [TestCase("_MainTex")]
        [TestCase("_FillColor")]
        [TestCase("_CornerRadius")]
        [TestCase("_FadeMode")]
        [TestCase("_StencilComp")]
        [TestCase("_ColorMask")]
        public void Shader_ContainsRequiredUiProperty(string propertyName)
        {
            Shader shader = Shader.Find(ShaderName);

            Assert.That(shader, Is.Not.Null);
            Assert.That(shader.FindPropertyIndex(propertyName), Is.GreaterThanOrEqualTo(0));
        }
    }
}
