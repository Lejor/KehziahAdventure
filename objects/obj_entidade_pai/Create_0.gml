

//Iniciando as variáveis "comuns" à todos os inimigos
xscale = 1;
dead = false;
meu_dano = 1;

//Chance de dropar o loot
chance = 100;
//valor do loot
valor = 1;

velh = 0;
velv = 0;

//definindo o poise dele
poise = poise_max;

gerado = false;

//Cria aviso
cria_aviso = function()
{
	var _aviso = instance_create_depth(x, y, depth, obj_aviso);
	_aviso.pai = id;
}

//Lidando com dano
lida_dano = function(_dano = 1, _poise = 1)
{
		//Tirando a vida
		vida -= _dano;
		
		//Diminuindo o poise dele
		poise = max(poise - _poise, 0);
		
		//Minha condição para mudar de estado
		//Só vou para o estado de hurt se o meu poise foi zerado
		if (poise <=0 or estado_atual != estado_attack)
		{
			//Vou para o estado de hurt
			troca_estado(estado_hurt);
		}
}

//Dropando loot
dropa_coracao = function(_chance = 25, _valor = 1)
{
	//Criando um valor entre 0 e 100
	var _numero = random(100);
	if (_chance > _numero)
	{
		instance_create_depth(x,y,depth,obj_recover_heart);
	}
	
}

dropa_moeda = function(_chance = 25, _valor = 1)
{
	//Criando um valor entre 0 e 100
	var _numero = random(100);
	if (_chance > _numero)
	{
		instance_create_depth(x,y,depth,obj_coin);
	}
	
}



//Iniciando os estados padrão de todos os inimigos

estado_idle = new estado();
estado_walk = new estado();
estado_attack = new estado();
estado_hurt = new estado();
estado_death = new estado();

//Iniciando o estado idle por padrão
inicia_estado(estado_idle);
