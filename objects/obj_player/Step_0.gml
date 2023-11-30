//Ajustando a profundidade
depth = -y;

//Pegando os inputs do usuário

up = keyboard_check(vk_up) or keyboard_check(ord("W"));
down = keyboard_check(vk_down) or keyboard_check(ord("S"));
right = keyboard_check(vk_right) or keyboard_check(ord("D"));
left = keyboard_check(vk_left) or keyboard_check(ord("A"));
attack = keyboard_check(vk_space) or keyboard_check(ord("J"));


if(keyboard_check_released(vk_insert))
{
	dropa_loot();
}

if(keyboard_check_released(vk_delete))
{
	debug_morte();	
}

//perdendo vida ao apertar backspace
if (keyboard_check_released(vk_backspace))
{
	toma_dano();
}

efeito_dano();




//Ajustando a direção com base na direção que ele ta indo né


//Rodando a minha máquina de estados
roda_estado();