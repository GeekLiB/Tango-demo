Shader "Custom/Cloud" 
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" { }
    }
     
    SubShader
    {
        Tags
        {
            Queue=Transparent 
            RenderType=Transparent
        }
         
        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
             
         CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		
		#include "UnityCG.cginc"
             
            sampler2D _MainTex;
             
            struct v2f
            {
                float4  pos : SV_POSITION;
                float2  uv : TEXCOORD0;    
            };
         
            float4 _MainTex_ST;
         
            v2f vert (appdata_base v)
            {
                v2f o;
                // 视口上的位置
                o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
                // 贴图纹理坐标
                o.uv = TRANSFORM_TEX (v.texcoord, _MainTex);
                 
                return o;
            }
         
            half4 frag (v2f i) : COLOR
            {
                // 获得地球贴图的uv x即横向在动
                float u = i.uv.x + -0.01*_Time;
                float2 x = float2 (u, i.uv.y);
                half4 texcol = tex2D (_MainTex, x);
                texcol = float4(1, 1, 1, 1) * (texcol.x);
                 
                if (texcol.x + texcol.y + texcol.z > 0.98)
                {
                    texcol = half4(texcol.xyz, 0.5);
                }
             
                return texcol;
            }
            ENDCG
        }
    }
}