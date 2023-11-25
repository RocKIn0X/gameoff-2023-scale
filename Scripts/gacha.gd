class_name Gacha

var rate;

func _init(rate_config):
	rate = rate_config;
	
func random():
	var cur = 0
	var index = 0
	var total = rate.reduce(func(accum, cur): return accum + cur);
	var rand = randi_range(0, total);
	for i in rate.size():
		cur += rate[i]
		index = i;
		if (cur >= rand):
			break;
	return index;
