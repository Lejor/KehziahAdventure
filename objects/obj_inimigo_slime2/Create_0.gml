/// @description Insert description here
// You can write your code in this editor



// Inherit the parent event
event_inherited();


range = 30;

dir = 0;

//Atualizando a minha estrutura de sprites

sprite = 
{
	attack : spr_slime2_attack,
	death : spr_slime2_death,
	hurt : spr_slime2_hurt,
	idle : spr_slime2_idle,
	walk : spr_slime2_walk
};

//Criando o estado de attack

estado_attack.inicia = function()
{
	sprite_index = sprite.attack;
	image_index = 0;
	
	dir = point_direction(x, y, alvo.x, alvo.y);
}

estado_attack.roda = function()
{
	if( image_index >= 7 )
	{
		var _dir = point_direction(x, y, alvo.x, alvo.y);
		//Se movendo na direção do player
		x += lengthdir_x(1, dir);
		y += lengthdir_y(1, dir);
	}
	
	if (image_index >= image_number - 0.2)
	{
		troca_estado(estado_idle);	
	}
	
		if (image_index >= image_number / 2 and image_index <= image_number - .5)
	{
		var _player = instance_place(x, y, obj_player);
	
	//Se eu toquei no player, então eu aplico dano no bobão
		if (_player)
		{
			_player.toma_dano(meu_dano);
			_player.dano_dir = point_direction(x, y, alvo.x, alvo.y);
		}
	}
	
}

inicia_estado(estado_idle);