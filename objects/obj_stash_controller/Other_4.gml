var _base_w = 256;
var _base_h = 256;

var _disp_w = display_get_width() * 0.8;
var _disp_h = display_get_height() * 0.8;

var _scale = min(_disp_w div _base_w, _disp_h div _base_h);

surface_resize(application_surface, _base_w * _scale, _base_h * _scale);
window_set_size(_base_w * _scale, _base_h * _scale);

window_center();