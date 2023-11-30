var _lista = ds_list_create();

var _qtd = instance_place_list(x, y, obj_entidade_pai, _lista, false);

//Pegar os inimigos da minha lista e passar eles para a lista de inimigos
for (var i = 0; i < ds_list_size(_lista); i++)
{
	//pegando o inimigo atual da lista
	var _atual = _lista[| i];
	
	//Checando se o inimigo atual NÃO existe na minha lista de inimigos
	var _existe = array_contains(lista_inimigos, _atual);
	
	//Se o inimigo não existe na lista, eu adiciono ele à lista
	if (!_existe)
	{
		array_push(lista_inimigos, _atual);
		//Eu vou dar dano
		with(_atual)
		{
			if (!dead)
			{
				//Chamando o método que lida com o dano
				lida_dano(, other.dano_poise);
			}
		}
	}
	
}

//Depois que eu usei a lista, eu zero ela
ds_list_destroy(_lista);