shader_type canvas_item;

uniform vec4 BG_Color : hint_color;

void fragment(){
	vec4 C = texture(TEXTURE, UV);
	COLOR = vec4(BG_Color.x,BG_Color.y,BG_Color.z,C.a);
}