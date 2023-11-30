estado_spawn = new estado();

estado_idle = new estado();



#region estado_spawn

estado_spawn.inicia = function()
{
	//definindo a sprite do coração
	
	sprite_index = spr_coin_drop;
	image_index = 0;
	
}

estado_spawn.roda = function()
{
	//saindo do estado de spawn
	
		if (image_index >= image_number - 1)
		{
			troca_estado(estado_idle);
		}
	
}




#endregion

#region estado_idle

estado_idle.inicia = function()
{
	sprite_index = spr_coin_idle;
	image_index = 0;
}


#endregion

inicia_estado(estado_spawn);