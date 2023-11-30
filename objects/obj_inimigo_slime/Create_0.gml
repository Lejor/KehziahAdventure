
//Criando um timer para mudar de estado
tempo_estado = game_get_speed(gamespeed_fps) * 5;
timer_estado = tempo_estado;

range = 15;

//Criando uma estrutura com as sprites dele
sprite = 
{
	attack : spr_slime_blue_attack,
	death : spr_slime_blue_death,
	hurt : spr_slime_blue_hurt,
	idle : spr_slime_blue_idle,
	walk : spr_slime_blue_walk
};



destino_x = 0;
destino_y = 0;

image_index_prev = 0;

alvo = noone;
meu_dano = noone;
dir = 0;

// Inherit the parent event
event_inherited();

estado_hunt = new estado();

//Tudo o que vier depois desse código é sobreescrito

#region estado_idle

estado_idle.inicia = function()
{
	//Definir a sprite que ele vai usar
	sprite_index = sprite.idle;
	//Iniciar a animação do começo
	image_index = 0;
	
	timer_estado = tempo_estado;
	
	image_blend = c_white;
	
	
	
}


estado_idle.roda = function()
{
	//Diminuindo o timer do estado
	timer_estado--;
	
	var _tempo = irandom(timer_estado);
	
	if (_tempo <= tempo_estado * .01)
	{
		
		var _estado_novo = choose(estado_idle, estado_walk, estado_walk)
		troca_estado(_estado_novo);
	}
}


#endregion

#region estado_walk

estado_walk.inicia = function()
{
	sprite_index = sprite.walk;
	image_index = 0;
	
	//Resetando o timer do estado
	timer_estado = tempo_estado;
	
	//Escolhendo um local no mapa e indo até ele
	
	
	//Escolhendo aleatoriamente um local no mapa
	destino_x = irandom(room_width);
	destino_y = irandom(room_height);
	
	//Definindo o meu xscale com base no destino x
	xscale = sign(destino_x - x);
}

estado_walk.roda = function()
{
	//Diminuindo o timer do estado
	timer_estado--;
	
	var _tempo = irandom(timer_estado);
	
	if (_tempo <= 5)
	{
		var _estado_novo = choose(estado_idle, estado_walk)
		
		//troca_estado(_estado_novo);	
	}
	
	
	
	//Indo até o meu destino enquanto eu desvio dos colisores
	mp_potential_step_object(destino_x, destino_y, 1, obj_colisor);
}

	
	
	

#endregion

#region estado_attack

estado_attack.inicia = function()
{
	sprite_index = sprite.attack;
	image_index = 0;
	
	dir = point_direction (x, y, alvo.x, alvo.y);
		
	
	
	
}

estado_attack.roda = function()
{
	var _dir = point_direction(x, y, alvo.x, alvo.y);
	
	//Causa dano no meio da animação de ataque
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
#endregion 

#region estado_hurt

estado_hurt.inicia = function()
{
	sprite_index = sprite.hurt;
	image_index = 0;
	
}

estado_hurt.roda = function()
{


	//Saindo do estado de dano
	//Se eu ainda tenho vida eu vou para o estado de idle
	if (image_index >= image_number - .5)
	{
		if (vida > 0)
		{
			troca_estado(estado_hunt);	
		}
		else //Não tenh vida, eu morro!
		{
			troca_estado(estado_death);
		}
	}
}

//Depois que eu tomei o dano, eu zero meu poise
estado_hurt.finaliza = function()
{
	if (poise < 1)
	{
		poise = poise_max;	
	}
}

#endregion

#region estado_death

estado_death.inicia = function()
{

	sprite_index = sprite.death;
	image_index = 0;
	
	dead = true;
	//Criando coração
		dropa_coracao(25, 1);
		dropa_moeda(80,1);
}

estado_death.roda = function()
{
		//Morrendo
		if (image_index >= image_number - .5)
		{
			instance_destroy();	
		}
		
		
		
		
}

estado_death.finaliza = function()
{
	
}

#endregion

#region estado_hunt
estado_hunt.inicia = function()
{
	sprite_index = sprite.walk;
	image_index = 0;
	
	//image_blend = c_yellow;
	
	if(instance_exists(obj_player))
	{
		alvo = obj_player.id;	
	}
	
	cria_aviso();
	
}

estado_hunt.roda = function()
{
	//Se o meu alvo não existe, eu fico parado de boa
	if(!instance_exists(obj_player))
	{
		alvo = noone;
		troca_estado(estado_idle);
	}
	//Definindo o meu alvo como o player.	
	//Seguindo o meu alvo
	mp_potential_step_object(alvo.x, alvo.y, 1, obj_colisor)
	
	//Atacando o player!
	//Checando a distancia para o player
	var _dist = point_distance(x, y, alvo.x, alvo.y);
	
	if(_dist <= range)
	{
		troca_estado(estado_attack);	
	}
	
	
	xscale = sign(alvo.x - x);
	//Avisando aos parça que eu preciso de ajuda
	//Checando quantos de nós existem nesse level
	var _n = instance_number(object_index);
	
	//Passando por todos os objetos iguais a mim
	for(var i = 0; i < _n; i++)
	{
		//Checando se eu não estou olhando para mim mesmo
		var _slime = instance_find(object_index, i);
		
		if (_slime == id)
		{
			//Não faço nada porque esse sou eu
		}
		else
		{
			//Tenho que checar se esse cara ainda não estar perseguindo o meu alvo
			if (_slime.alvo != alvo)
			{
					//Checando a distância desse slime
				var _dist = point_distance(x, y, _slime.x, _slime.y);
				if (_dist < 300)
				{
					//Falando para ele me ajudar!
					with(_slime)
					{
						troca_estado(estado_hunt);	
					}
				}
			}
		}
	}
}


#endregion




//Iniciando o estado COM as modificações
inicia_estado(estado_idle);