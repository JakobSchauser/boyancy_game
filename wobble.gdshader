shader_type canvas_item;


// a shader that wobbles the texture 

void fragment() {
    vec2 uv = UV;
    // uv.x += sin(uv.y * 10.0 + TIME) * 0.05;
    uv.y += sin(uv.x * 4.0 + TIME + SCREEN_UV.y*20.0) * 0.5;
    COLOR = texture(TEXTURE, uv);
}