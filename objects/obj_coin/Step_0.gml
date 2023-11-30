if (instance_place(x,y, obj_player))
{
	global.coin++;
	instance_destroy();
}

roda_estado();