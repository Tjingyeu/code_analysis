shader_type canvas_item;


uniform sampler2D iChannel0:hint_screen_texture, repeat_disable, filter_nearest; // input channel 0
uniform sampler2D iChannel1; // input channel 1
uniform samplerCube iChannel2; // input channel 2

uniform vec4 tint_color:source_color;

float bias(float x, float b) {
    return x / ((1.0 / b - 2.0) * (1.0 - x) + 1.0);
}

float gain(float x, float g) {
    float t = (1.0 / g - 2.0) * (1.0 - (2.0 * x));
    return x < 0.5 ? (x / (t + 1.0)) : (t - x) / (t - 1.0);
}

vec3 degamma(vec3 c) {
    return pow(c, vec3(2.2));
}

vec3 gamma(vec3 c) {
    return pow(c, vec3(1.0 / 1.5));
}

#define DIVS 4

void fragment() {

	vec2 uv = SCREEN_UV;
	//vec2 uv = UV;
    uv.y =  1.-uv.y;
    uv.x *= (1. / SCREEN_PIXEL_SIZE).x / (1. / SCREEN_PIXEL_SIZE).y;
	//vec2 uv_lowres = floor(uv * vec2(1.0 / 2.0)) * 2.0;
    float h = 0.0;

    float time = TIME;


    for (int iy = 0; iy < DIVS; iy++) {
        for (int ix = 0; ix < DIVS * 2; ix++) {
            vec4 t = texture(iChannel1, vec2(float(ix), float(iy)) * (4.0 / 256.0),100);

            vec2 p = vec2(float(ix), float(iy)) * (1.0 / float(DIVS - 1));
            p += (0.75 / float(DIVS - 1)) * (t.xy * 2.0 - 1.0);

            vec2 v = uv - p;
            float d = dot(v, v);
            d = pow(d, 0.7);
            float life = 10.0;

            float n = time * 2.0 * (t.w + 0.05) - t.z * 10.0;
            n *= 0.01 + t.w;
            n = mod(n, life*0.5 + t.z * 3.0 + 2.0);

            float x = d * 99.0;
            float T = x < (2.0 * PI * n) ? 1.0 : 0.0;
            float e = max(1.0 - (n / life), 0.0);
            float F = e * x / (2.0 * PI * n);

            float s = sin(x - (2.0 * PI * n) - PI * 0.5);
            s = s * 0.5 + 0.5;
            s = bias(s, 0.5);

            s = (F * s) / (x + 1.1) * T;

            h += s * 100.0 * (0.5 + t.w);
        }
    }

    vec3 n = vec3(dFdx(h), 15.0, dFdy(h));
    n = normalize(n);

    //vec3 e = normalize(vec3(-uv.y * 2.0 - 1.0, 1.0, uv.x * 2.0 - 1.0));
	vec3 e = normalize(vec3(-uv.y*1.0+1.0,1.0,uv.x*1.0-1.0));
	//vec3 e = normalize(vec3(1000.0, 1000.0, 1000.0));
    vec3 rv = reflect(-e, n);
    vec3 reflect_color = degamma(texture(iChannel2, rv).xyz);

    vec3 fn = refract(vec3(0, 1, 0), n, 2.5);
    //uv += fn.xz * 0.1;

    float lod = length(fn.xz) * 10.0;

    vec3 c = vec3(0.0);

    //c += degamma(textureLod(iChannel0, uv + vec2(0.66, 0.0), lod).xyz);
	c += degamma(textureLod(iChannel0, (SCREEN_UV + fn.xz * 0.05), lod).xyz);

    c *= 1.0 - h * 0.0125;
    c += reflect_color * .2;

    vec3 L = normalize(vec3(1.0, 1.0, 1.0));
    float dl = max(dot(n, L), 0.0) * 0.7 + 0.3;
    c *= dl;

    c = gamma(c);
	//vec4 f_c = vec4(c,1.0);
	//f_c = mix(f_c,tint_color,0.2);
	//f_c *= tint_color;
	//COLOR = f_c;
    COLOR = vec4(c, 1.0);
}