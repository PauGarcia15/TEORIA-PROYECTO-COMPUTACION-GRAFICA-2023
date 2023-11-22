#version 330 core
out vec4 FragColor;

in vec2 coordRect;

uniform float sizeQuad;

void main()
{    
	float alpha = 1.0 / (sizeQuad * sizeQuad) * (sizeQuad * sizeQuad - coordRect.x * coordRect.x - coordRect.y * coordRect.y);
	
	if (alpha < 0.0)
		//alpha = 0.0;
		discard;
  
    FragColor = vec4(1.0, 1.0, 1.0, alpha);
}