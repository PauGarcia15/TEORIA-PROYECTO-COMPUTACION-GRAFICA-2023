#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aOffset;
layout (location = 2) in float aAngle;

out vec2 coordRect;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

mat4 BuildTranslation(vec3 delta)
{
    return mat4(
        vec4(1.0, 0.0, 0.0, 0.0),
        vec4(0.0, 1.0, 0.0, 0.0),
        vec4(0.0, 0.0, 1.0, 0.0),
        vec4(delta, 1.0));
}

mat4 rotationMatrix(vec3 axis, float angle)
{
    axis = normalize(axis);
    float s = sin(angle);
    float c = cos(angle);
    float oc = 1.0 - c;
    
    return mat4(oc * axis.x * axis.x + c,           oc * axis.x * axis.y - axis.z * s,  oc * axis.z * axis.x + axis.y * s,  0.0,
                oc * axis.x * axis.y + axis.z * s,  oc * axis.y * axis.y + c,           oc * axis.y * axis.z - axis.x * s,  0.0,
                oc * axis.z * axis.x - axis.y * s,  oc * axis.y * axis.z + axis.x * s,  oc * axis.z * axis.z + c,           0.0,
                0.0,                                0.0,                                0.0,                                1.0);
}

void main()
{   
    //gl_Position = projection * view * model * BuildTranslation(aOffset) * vec4(aPos, 1.0);
	mat4 matriz_rot = rotationMatrix(vec3(0.0, 0.0, -1.0), aAngle);
	//gl_Position = projection * view * matriz_rot * vec4(aPos + aOffset, 1.0);
	gl_Position = projection * view * BuildTranslation(aOffset) * matriz_rot * vec4(aPos, 1.0);
	coordRect = aPos.yz;
	//coordRect = (BuildTranslation(aOffset) * matriz_rot * vec4(aPos, 1.0)).yz;
}