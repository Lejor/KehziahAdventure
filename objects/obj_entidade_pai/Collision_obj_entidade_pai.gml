/// @description Se empurrando para fora
// You can write your code in this editor

//Achando a direção para onde eu devo ser empurrado
var _dir = point_direction(other.x, other.y, x, y);


//Checando se eu vou entrar em alguma parede
var _velh = lengthdir_x(1, _dir);
var _velv = lengthdir_y(1, _dir);

if(!place_meeting(x + _velh, y + _velv, obj_colisor))
{
	x += _velh;
	y += _velv;
}



