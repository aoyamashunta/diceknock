Shader "Unlit/Body"
{
    Properties
    {
        _MainColor ("MainColor", Color) = (1, 0, 0, 1)
        _SubColor  ("SubColor", Color) = (1, 0.5, 0, 1)
        _MaskTex ("MaskTexTure", 2D) = "white" {}

        //ñ]Ì¬x
        _RotateSpeed ("Rotate Speed", float) = 1.0
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Transparent"
        }
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            fixed4 _MainColor; //Ô
            fixed4 _SubColor;  //IW
            sampler2D _MaskTex; //¼æÌä¦

            float _RotateSpeed;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // TimeðüÍÆµÄ»ÝÌñ]pxðìé
                half timer = _Time.x;
                // ñ]sñðìé
                half angleCos = cos(timer * _RotateSpeed);
                half angleSin = sin(timer * _RotateSpeed);
                /*       |cos¦ -sin¦|
                  R(¦) = |sin¦  cos¦|  2³ñ]sñÌö®*/
                half2x2 rotateMatrix = half2x2(angleCos, -angleSin, angleSin, angleCos);
                //S
                half2 uv = i.uv - 0.5;
                // SðN_ÉUVðñ]³¹é
                i.uv = mul(uv, rotateMatrix) + 0.5;

                fixed4 mask = tex2D(_MaskTex, i.uv);
                fixed4 col = mask.r * _SubColor + (1 - mask.r) * _MainColor;

                return col;
            }
            ENDCG
        }
    }
}
