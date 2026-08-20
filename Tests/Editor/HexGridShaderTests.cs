using System.IO;
using NUnit.Framework;
using UnityEngine;

namespace Jeomseon.Unity.Shaders.Tests
{
    public sealed class HexGridShaderTests
    {
        [TestCase("Jeomseon/Shape/Hexagon Outline")]
        [TestCase("Jeomseon/Grid/Hex Grid Surface")]
        public void Shader_IsDiscoverableAndSupported(string shaderName)
        {
            Shader shader = Shader.Find(shaderName);
            Assert.That(shader, Is.Not.Null);
            Assert.That(shader.isSupported, Is.True);
        }

        [Test]
        public void HexGridCore_ReusesHexagonShapeCore()
        {
            const string path = "Packages/com.jeomseon.unity.shaders/Runtime/Shader/Grid/HexGridCore.hlsl";
            string source = File.ReadAllText(path);
            StringAssert.Contains("#include \"HexagonShapeCore.hlsl\"", source);
            StringAssert.Contains("JeomseonGetHexCell", source);
            StringAssert.DoesNotContain("JeomseonHexagonOutlineAlpha(float2", source);
        }
    }
}
