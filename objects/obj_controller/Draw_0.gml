if(room != rm_stash_intro) { exit; }

draw_set_color(COLOR_LIGHT);
draw_set_font(fnt_default);
draw_text_ext(16, 16, @"Welcome to the Stash test project.

This project is provided as a test and demo of the Stash script library.

Navigation:

[ Left ] Previous Room
[ Right ] Next Room
[ 'R' ] Restart current room
", -1, room_width - 32);