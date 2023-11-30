/// @description Insert description here
// You can write your code in this editor



// Inherit the parent event
event_inherited();

meu_dano = 2;

sprite = 
{
	attack :	spr_goblin_attack,
	death :		spr_goblin_death,
	hurt :		spr_goblin_hurt,
	idle :		spr_goblin_idle,
	walk :		spr_goblin_walk
};

inicia_estado(estado_idle);

estado_attack.roda = function()
{

	//Causa dano no meio da animação de ataque
	if (image_index >= image_number / 2 and image_index <= image_number - .5)
	{
		var _player = instance_place(x, y, obj_player);
	
		//Se eu toquei no player, então eu aplico dano no bobão
		if (_player)
		{
			_player.toma_dano(meu_dano);
		}
	}
	
	//Saindo do estado de attack
	if (image_index >= image_number - .5)
	{
		troca_estado(estado_idle);
	}
	

}

estado_attack.finaliza = function()
{
	alvo = noone;
	
	if(global.vida_player <= 0)
	{
		troca_estado(estado_idle);	
	}
		
}

estado_hurt.finaliza = function()
{
	image_xscale = image_xscale + 0.2;
	image_yscale = image_yscale + 0.2;
}