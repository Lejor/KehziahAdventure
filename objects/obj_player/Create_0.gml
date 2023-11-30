#region iniciando variáveis
//Iniciar variáveis

dano_dir = 0;

//Controles estão sendo iniciados sem valor
up = noone;
down = noone;
left = noone;
right = noone;
attack = noone;

//Variáveis de movimento
//Iniciando parado
velh = 0;
velv = 0;

//Velocidade do jogador
vel = 1.5;

//Controlando a direção que o player está olhando
dir = 0;

//Iniciando o invicibility frame
invincibility_duration = room_speed * 2;
invincibility_timer = invincibility_duration;


#endregion

meu_dano = noone;
dano_poise = 4;

//Iniciando o meu primeiro estado
estado_idle = new estado();

//iniciando o estado walk
estado_walk = new estado();

//Iniciando o estado attack
estado_attack = new estado();

//Iniciando o estado hurt
estado_hurt = new estado();

//Iniciando o estado death
estado_death = new estado();

//Desenhando a vida do player
///@function desenha_coracoes(_x, _y)
desenha_coracoes = function(_x, _y)
{
	//desenhando 3 coracoes vazios
	//desenhando a quantidade de vida total dividido por 2 de corações
	for (var i = 0; i < global.max_vida_player; i += 2)
	{
		draw_sprite(spr_coracao, 0, _x + i * 20, _y);	
	}
	
	//Desenhando os corações preenchidos
	for(var i = 0; i < global.vida_player; i += 2)
	{
		//garantindo que o img vai ficar com o valor de 1 se
		//A ultima vida for um número ímpar
		var _img = ((global.vida_player - i) != 1) + 1;
		
		draw_sprite(spr_coracao, _img, _x + i * 20, _y);	
	}
}

desenha_moeda = function(_x, _y)
{
	draw_sprite(spr_coin_gui, 0, _x, _y);
	draw_set_font(fnt_coins);
	draw_text(_x + 80, _y + 20, global.coin);
}

#region estado_idle
//Meu estado idle precisa de um inicia
estado_idle.inicia = function()
{
	
	//Definindo a sprite atual com base na direção que eu tô olhando
	var _sprite = define_sprite(dir, spr_player_idle_side, spr_player_idle_front, spr_player_idle_back);
	
	//Ajustando a sprite
	sprite_index = _sprite;
	
	//Garantindo que a animação começa do primeiro frame
	image_index = 0;
	
	
	dead = false;
	
	invencivel = false;
}

estado_idle.roda = function()
{
	//Achando a condição para eu SAIR desse estado
	
	//SE eu estiver em movimento, então eu vou para o estado de walk
	if (up xor down or left xor right)
	{
		troca_estado(estado_walk);	
	}
	
	//Condição para ir para o estado de ataque
	if (attack) 
	{	
		troca_estado(estado_attack);
	}
}





#endregion


#region estado_walk
estado_walk.inicia = function()
{
	dir = (point_direction (0, 0, right - left, down - up) div 90);
	//Definindo a sprite
	
	//Configurando a sprite
	sprite_index = define_sprite(dir, spr_player_walk_side, spr_player_walk_front, spr_player_walk_back);
	
	//Começando a animalção do começo
	image_index = 0;
}

estado_walk.roda = function()
{
	dir = (point_direction (0, 0, velh, velv) div 90);
	
	
	//Ajustando o lado que ele olha
	if (velh != 0)
	{
		image_xscale = sign(velh);
	}
	
	//Definindo a sprite
	sprite_index = define_sprite(dir, spr_player_walk_side, spr_player_walk_front, spr_player_walk_back)
	
	//Movendo

	velv = (down - up) * vel;

	//Fazendo a velocidade horizontal

	velh = (right - left) * vel;

	//Condição para sair do estado
	//Se eu estou parado, eu vou para o estado de idle

	if(velh == 0 && velv == 0)
	{
		troca_estado(estado_idle);	
	}
	
	//Indo para o estado de ataque
	if (attack)
	{
		troca_estado(estado_attack);
	}
}

#endregion



#region estado_attack

estado_attack.inicia = function()
{
	//Definindo a sprite dele
	sprite_index = define_sprite(dir, spr_player_attack_side, spr_player_attack_front, spr_player_attack_back);
	
	image_index = 0;
	
	velh = 0;
	velv = 0;
	
	//Criando meu dano
	var _x = x + lengthdir_x(16, dir * 90);
	var _y = y + lengthdir_y(16, dir * 90);
	
	meu_dano = instance_create_depth(_x, _y, depth, obj_dano_player);
	
	//Passando o meu poise para o meu dano
	meu_dano.dano_poise = dano_poise;
}

//Configurando o estado de attack
estado_attack.roda = function()
{
	
	
	
	//Saindo do ataque quando ele acabar
	if (image_index >= image_number - 0.2)
	{
		//Indo para o estado de parado
		troca_estado(estado_idle);
	}
}

estado_attack.finaliza = function()
{
	//Encerro o meu dano
	instance_destroy(meu_dano);
}

#endregion

#region estado_hurt

estado_hurt.inicia = function()
{

//Definindo minha sprite

sprite_index = define_sprite(dir, spr_player_hurt_side, spr_player_hurt_front, spr_player_hurt_back);

image_index = 0;








}

estado_hurt.roda = function()

{
	velh = lengthdir_x(.5, dano_dir);
	velv = lengthdir_y(.5, dano_dir);


	if (image_index >= image_number - 0.2)
	{
		invincibility_timer++;
	
		if (invincibility_timer > room_speed / 2.3)
		{
			troca_estado(estado_idle);
			velv = 0;
			velh = 0;
		
		}
	}

}


estado_hurt.finaliza = function()
{
	
			
}
#endregion

#region estado_death

estado_death.inicia = function()

{

//Definindo minha sprite
sprite_index = spr_player_death;

image_index = 0;

	velh = 0;
	velv = 0;




}

estado_death.roda = function()
{
	velh = 0;
	velv = 0;
	
	if (image_index >= image_number - .5)
	{
		show_message("você morreu");
	}
	
	
}

estado_death.finaliza = function()
{
	
	
}

#endregion

toma_dano = function(_dano = 1)
{
	if(invincibility_timer >= invincibility_duration)
	{
		troca_estado(estado_hurt);
		invincibility_timer = 0;
		global.vida_player -= _dano;
	}
	
	if(global.vida_player <= 0)
	{
		troca_estado(estado_death);
	}
	
}

efeito_dano = function()
{
	//Se o timer não chegou no tempo de invencibilidade
	//Então eu aumento o valor dele
	//Faço ele piscar
	
	if (invincibility_timer < invincibility_duration and global.vida_player > 0)
	{
		invincibility_timer++;	
			image_alpha = sin(get_timer() / 100000);

	}
	else
	{
		image_alpha = 1;	
	}
}
	
debug_morte = function()
{

	troca_estado(estado_death);

}
	
//Iniciando minha máquina de estado

inicia_estado(estado_idle);

