if (instance_place(x,y, obj_player))
{
	if(global.vida_player < global.max_vida_player)
	{
		global.vida_player++;
	}
	instance_destroy();
}

roda_estado();