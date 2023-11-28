extends Node

# TODO: Calculate Upgrade systems

func get_sharpness_increase_rate():
	return GameConst.F_PLAYER_BASE_SHARPEN_RATE

func get_max_sharpness():
	return GameConst.F_PLAYER_BASE_MAX_SHARPNESS

func __get_sharpness_mod():
	var current_sharpness = VarManager.get_data(Varkey.F_SHARPNESS_VAL)
	if current_sharpness <= 0.0:
		return 0.1
	return 1.0

func __get_attack_upgrade_bonus():
		return 0.0

func get_attack_power() -> int:
	if VarManager.get_data(Varkey.B_IS_FEVER):
		return 1000
	return round((GameConst.F_PLAYER_BASE_ATTACK_POWER + __get_attack_upgrade_bonus()) * __get_sharpness_mod())

func get_sharpness_loss_rate():
	return 1.0
