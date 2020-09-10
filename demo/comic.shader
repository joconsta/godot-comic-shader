shader_type spatial;

uniform vec4 color : hint_color;
uniform float size : hint_range(0, 1, 0.05);
uniform bool glossy;

void fragment() {
    ALBEDO = color.rgb;    
}

void light() {
    float dvn = dot(VIEW, NORMAL);
    
    // ink
    if (dvn < size) {
        DIFFUSE_LIGHT = vec3(0.0) - ALBEDO;
    // specular
    } else if ((glossy) && (dot(NORMAL, LIGHT) > 0.0) && (length(ATTENUATION) * pow(max(0.0, dot(reflect(-LIGHT, NORMAL), VIEW)), 20.0) > 0.5)) {
        DIFFUSE_LIGHT = LIGHT_COLOR * .75 * ALBEDO;
    // outline
    } else if (dvn < (size * 2.0)) {
        DIFFUSE_LIGHT = ALBEDO * vec3(.0);
    // lit
    } else if (length(ATTENUATION) * max(0.0, dot(NORMAL, LIGHT)) >= .2) {
        DIFFUSE_LIGHT = LIGHT_COLOR * ALBEDO * vec3(.5);
    // unlit
    } else {
        //DIFFUSE_LIGHT = ALBEDO * vec3(.1);
        DIFFUSE_LIGHT = LIGHT_COLOR * ALBEDO * vec3(.25);
    }
}