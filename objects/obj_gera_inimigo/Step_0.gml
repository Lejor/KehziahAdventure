image_alpha += 0.015;


//Criando o slime de verdade
if (image_alpha >= 1)
{
	var _inimigo = instance_create_depth(x, y, depth, inimigo);
	_inimigo.gerado = true;
	
	instance_destroy();
	
	if (criador)
	{
		//Salvando o inimigo criado na variável do criador	
		array_push(criador.filhos, _inimigo);
	}
}