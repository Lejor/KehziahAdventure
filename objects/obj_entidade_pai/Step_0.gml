depth = -y;


//Recuperando o poise
poise = min(poise_max, poise + poise_max * 0.001);


if (gerado)
{
	exit;	
}
//Rodando o estado
roda_estado();