/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

DoStep(keyboard_check(ord("D")) - keyboard_check(ord("A")));

if (keyboard_check(vk_space) || keyboard_check(ord("W")) || keyboard_check(ord("j"))) 
	DoJump();
	