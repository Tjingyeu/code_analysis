extends Node

var unlocking_cost = [
	10.0,
	150.0,
	750.0,
	3750.0,
	18750.0,
	93750.0,
	468750.0,
	2343750.0,
	11718750.0,
	58593750.0,
	292968750.0,
	1464843750.0,
	7324218750.0,
	36621093750.0,
	183105468750.0,
	915527343750.0,
	4577636718750.0,
	22888183593750.0
]

var snakes_income_database = {
	#01: Set IPS = 0.05
	0: { "factor": 15.0, "grow_time": 300 },
	1: { "factor": 45.0, "grow_time": 900 },
	2: { "factor": 180.0, "grow_time": 3600 },
	3: { "factor": 540.0, "grow_time": 10800 },
	4: { "factor": 2160.0, "grow_time": 43200 },
	5: { "factor": 12960.0, "grow_time": 259200 },
	
	#02: Set IPS = 0.6 (Jump: 12x)
	6: { "factor": 225.0, "grow_time": 375 },
	7: { "factor": 675.0, "grow_time": 1125 },
	8: { "factor": 2700.0, "grow_time": 4500 },
	9: { "factor": 8100.0, "grow_time": 13500 },
	10: { "factor": 32400.0, "grow_time": 54000 },
	11: { "factor": 194400.0, "grow_time": 324000 },
	
	#03: Set IPS = 2.4 (Jump: 4x)
	12: { "factor": 1125.0, "grow_time": 469 },
	13: { "factor": 3375.0, "grow_time": 1407 },
	14: { "factor": 13500.0, "grow_time": 5628 },
	15: { "factor": 40500.0, "grow_time": 16884 },
	16: { "factor": 162000.0, "grow_time": 67536 },
	17: { "factor": 972000.0, "grow_time": 405216 },
	
	#04: Set IPS = 9.6 (Jump: 4x)
	18: { "factor": 5625.0, "grow_time": 586 },
	19: { "factor": 16875.0, "grow_time": 1758 },
	20: { "factor": 67500.0, "grow_time": 7032 },
	21: { "factor": 202500.0, "grow_time": 21096 },
	22: { "factor": 810000.0, "grow_time": 84384 },
	23: { "factor": 4860000.0, "grow_time": 506304 },
	
	#05: Set IPS = 38.4 (Jump: 4x)
	24: { "factor": 28125.0, "grow_time": 733 },
	25: { "factor": 84375.0, "grow_time": 2199 },
	26: { "factor": 337500.0, "grow_time": 8796 },
	27: { "factor": 1012500.0, "grow_time": 26388 },
	28: { "factor": 4050000.0, "grow_time": 105552 },
	29: { "factor": 24300000.0, "grow_time": 633312 },
	
	#06: Set IPS = 153.5 (Jump: 4x)
	30: { "factor": 1.40625e5, "grow_time": 916 },
	31: { "factor": 4.21875e5, "grow_time": 2748 },
	32: { "factor": 1.6875e6, "grow_time": 10992 },
	33: { "factor": 5.0625e6, "grow_time": 32976 },
	34: { "factor": 2.025e7, "grow_time": 131904 },
	35: { "factor": 1.215e8, "grow_time": 791424 },
	
	#07: Set IPS = 614.0 (Jump: 4x)
	36: { "factor": 7.03125e5, "grow_time": 1145 },
	37: { "factor": 2.109375e6, "grow_time": 3435 },
	38: { "factor": 8.4375e6, "grow_time": 13740 },
	39: { "factor": 2.53125e7, "grow_time": 41220 },
	40: { "factor": 1.0125e8, "grow_time": 164880 },
	41: { "factor": 6.075e8, "grow_time": 989280 },
	
	#08: Set IPS = 2456.7 (Jump: 4x)
	42: { "factor": 3.515625e6, "grow_time": 1431 },
	43: { "factor": 1.0546875e7, "grow_time": 4293 },
	44: { "factor": 4.21875e7, "grow_time": 17172 },
	45: { "factor": 1.265625e8, "grow_time": 51516 },
	46: { "factor": 5.0625e8, "grow_time": 206064 },
	47: { "factor": 3.0375e9, "grow_time": 1236384 },
	
	#09: Set IPS = 9825.7 (Jump: 4x)
	48: { "factor": 1.7578125e7, "grow_time": 1789 },
	49: { "factor": 5.2734375e7, "grow_time": 5367 },
	50: { "factor": 2.109375e8, "grow_time": 21468 },
	51: { "factor": 6.328125e8, "grow_time": 64404 },
	52: { "factor": 2.53125e9, "grow_time": 257616 },
	53: { "factor": 1.51875e10, "grow_time": 1545696 },
	
	#10: Set IPS = 39307.0 (Jump: 4x)
	54: { "factor": 8.7890625e7, "grow_time": 2236 },
	55: { "factor": 2.63671875e8, "grow_time": 6708 },
	56: { "factor": 1.0546875e9, "grow_time": 26832 },
	57: { "factor": 3.1640625e9, "grow_time": 80496 },
	58: { "factor": 1.265625e10, "grow_time": 321984 },
	59: { "factor": 7.59375e10, "grow_time": 1931904 },
	
	#11: Set IPS = 157228.3 (Jump: 4x)
	60: { "factor": 4.39453125e8, "grow_time": 2795 },
	61: { "factor": 1.318359375e9, "grow_time": 8385 },
	62: { "factor": 5.2734375e9, "grow_time": 33540 },
	63: { "factor": 1.58203125e10, "grow_time": 100620 },
	64: { "factor": 6.328125e10, "grow_time": 402480 },
	65: { "factor": 3.796875e11, "grow_time": 2414880 },
	
	#12: Set IPS = 628868.2 (Jump: 4x)
	66: { "factor": 2.197265625e9, "grow_time": 3494 },
	67: { "factor": 6.591796875e9, "grow_time": 10482 },
	68: { "factor": 2.63671875e10, "grow_time": 41928 },
	69: { "factor": 7.91015625e10, "grow_time": 125784 },
	70: { "factor": 3.1640625e11, "grow_time": 503136 },
	71: { "factor": 1.8984375e12, "grow_time": 3018816 },
	
	#13: Set IPS = 2515180.5 (Jump: 4x)
	72: { "factor": 1.0986328125e10, "grow_time": 4368 },
	73: { "factor": 3.2958984375e10, "grow_time": 13104 },
	74: { "factor": 1.318359375e11, "grow_time": 52416 },
	75: { "factor": 3.955078125e11, "grow_time": 157248 },
	76: { "factor": 1.58203125e12, "grow_time": 628992 },
	77: { "factor": 9.4921875e12, "grow_time": 3773952 },
	
	#14: Set IPS = 10060740.0 (Jump: 4x)
	78: { "factor": 5.4931640625e10, "grow_time": 5460 },
	79: { "factor": 1.64794921875e11, "grow_time": 16380 },
	80: { "factor": 6.591796875e11, "grow_time": 65520 },
	81: { "factor": 1.9775390625e12, "grow_time": 196560 },
	82: { "factor": 7.91015625e12, "grow_time": 786240 },
	83: { "factor": 4.74609375e13, "grow_time": 4717440 },
	
	#15: Set IPS = 40242960.0 (Jump: 4x)
	84: { "factor": 2.74658203125e11, "grow_time": 6825 },
	85: { "factor": 8.23974609375e11, "grow_time": 20475 },
	86: { "factor": 3.2958984375e12, "grow_time": 81900 },
	87: { "factor": 9.8876953125e12, "grow_time": 245700 },
	88: { "factor": 3.955078125e13, "grow_time": 982800 },
	89: { "factor": 2.373046875e14, "grow_time": 5896800 },
	
	#16: Set IPS = 160976558.0 (Jump: 4x)
	90: { "factor": 1.373291015625e12, "grow_time": 8531 },
	91: { "factor": 4.119873046875e12, "grow_time": 25593 },
	92: { "factor": 1.64794921875e13, "grow_time": 102372 },
	93: { "factor": 4.94384765625e13, "grow_time": 307116 },
	94: { "factor": 1.9775390625e14, "grow_time": 1228464 },
	95: { "factor": 1.1865234375e15, "grow_time": 7370784 },
	
	#17: Set IPS = 643909720.0 (Jump: 4x)
	96: { "factor": 6.866455078125e12, "grow_time": 10664 },
	97: { "factor": 2.0599365234375e13, "grow_time": 31992 },
	98: { "factor": 8.23974609375e13, "grow_time": 127968 },
	99: { "factor": 2.471923828125e14, "grow_time": 383904 },
	100: { "factor": 9.8876953125e14, "grow_time": 1535616 },
	101: { "factor": 5.9326171875e15, "grow_time": 9213696 },
	
	#18: Set IPS = 2575564545.0 (Jump: 4x)
	102: { "factor": 3.4332275390625e13, "grow_time": 13330 },
	103: { "factor": 1.02996826171875e14, "grow_time": 39990 },
	104: { "factor": 4.119873046875e14, "grow_time": 159960 },
	105: { "factor": 1.2359619140625e15, "grow_time": 479880 },
	106: { "factor": 4.94384765625e15, "grow_time": 1919520 },
	107: { "factor": 2.96630859375e16, "grow_time": 11517120 }
}


var visitors_cost:=[
	210.0, 1e3, 5e3, 2e4, 1e5, 4.5e5, 2e6, 9e6, 4e7, 1.8e8, 8e8, 3.6e9, 1.6e10, 
	7.2e10, 3.2e11, 1.4e12, 6.4e12, 2.8e13, 1.3e14, 5.8e14, 2.6e15, 1.1e16, 
	5e16, 2.2e17, 1e18, 3e18, 5e18, 7e18, 9e18, 1e19
]
var snake_kiss_cost:=[2.5e2,1e3,1e4,1e5,1e6,1e7,1e8,1e9,1e10,1e11,1e12,1e13,1e14,1e15,1e16]
var luck_cost = [
	3.0e3,
	1.7e4,
	9.4e4,
	5.3e5,
	3.0e6,
	1.7e7,
	9.3e7,
	5.2e8,
	2.9e9,
	1.6e10,
	9.2e10,
	5.1e11,
	2.9e12,
	1.6e13,
	9.1e13,
	5.1e14,
	2.8e15,
	1.6e16,
	9.0e16,
	5.0e17,
	2.8e18
]
var tank_size_cost:=[
	5e2, 1.5e3, 4.5e3, 1.3e4, 4e4, 1.2e5, 3.6e5, 1.1e6, 3.3e6, 1e7, 3e7, 9e7, 
	2.7e8, 8.1e8, 2.4e9
]
var tank1_size_cost:=[
	1e6, 5e6, 2.5e7, 1.2e8, 6e8, 3e9, 1.5e10, 7.5e10, 3.7e11, 1.8e12, 9e12, 
	4.5e13, 2.2e14, 1.1e15, 5.5e15
]
var tank2_size_cost:=[
	1e10, 8e10, 6.4e11, 5.1e12, 4.1e13, 3.3e14, 2.6e15, 2.1e16, 1.7e17, 1.3e18, 
	1e19, 3e19, 5e19, 7e19, 9e19
]
var deco_cost_table:=[
	2e2, 1e3, 5e3, 2.5e4, 1.2e5, 6e5, 3e6, 1.5e7, 7.5e7, 3.7e8, 1.8e9, 9e9, 
	4.5e10, 2.2e11, 1.1e12, 5.5e12, 2.7e13, 1.3e14
]
var bed_cost_table:=[
	0.0, 2e2, 1e3, 5e3, 2.5e4, 1.2e5, 6e5, 3e6, 1.5e7, 7.5e7, 3.7e8, 1.8e9, 
	9e9, 4.5e10, 2.2e11, 1.1e12, 5.5e12, 2.7e13
]
var surface_cost_table:=[
	0.0, 1e2, 5e2, 2.5e3, 1.2e4, 6e4, 3e5, 1.5e6, 7.5e6, 3.7e7, 1.8e8, 9e8, 
	4.5e9, 2.2e10, 1.1e11, 5.5e11, 2.7e12, 1.3e13
]
func visitors_count(lvl:int):
	var l = float(lvl)
	var visitors = 0.01*(l)*(l)+2*(l)
	if visitors == 0:
		return 2
	return floor(visitors)
	#
#func stamina_count(lvl:int):
	#var l = float(lvl)
	#var stamina = 10+l*2
	#return stamina

func snake_kiss_multiplier(lvl:int):
	var l = float(lvl)
	var multiplier = 2+l
	return multiplier
	
#func arm_strength_count(lvl:int):
	#return lvl+1

var pond_reflection_database:=[
  "Sun-Kissed Canopy",
  "Steel Cathedral",
  "Celestial Drift",
  "Winter's Hush",
  "A Quiet Clearing",
  "Whispers of Stone",
  "Floating Colors",
  "Autumn's Farewell",
  "Forest Embrace",
  "Golden Ascent",
  "Winter's Lace",
  "Cathedral of Pines",
  "Emerald Canopy",
  "Tangled Sunlight",
  "Softwood Sky",
  "A Breath of Blue",
  "Ancient's Embrace",
  "Autumn on Glass"
]
var pond_bed_database:=[
  "Mossy Earth",
  "Overgrown Rocky Soil",
  "Dry Gravel Path",
  "Checkerboard Tiles",
  "Mossy Cobblestone",
  "Fallen Leaves",
  "Lichen-Covered Stone",
  "Parched Clay Earth",
  "Rippled Beach Sand",
  "Rocky Tundra Floor",
  "Worn Quarry Tiles",
  "Forest Floor Debris",
  "Muddy Patchy Ground",
  "Thick Leaf Litter",
  "Riverbed Pebbles",
  "Decaying Leaf Mulch",
  "Rocky Meadow Grass",
  "Overgrown Flagstone"
]

var decoration_database:=[
	"Mossy Boulder",
	"Golden Maple Leaf",
	"White Lily Blossom",
	"Mossy River Stone",
	"Drifting Pink Petal",
	"Great Lily Pad",
	"Weathered Old Coin",
	"Amber Autumn Leaf",
	"Floating Lotus Leaf",
	"Cracked Stone",
	"Golden Ginkgo Leaf",
	"Sacred Pink Lotus",
	"Lush Mossy Stone",
	"Cherry Blossom",
	"Glistening Lily Pad",
	"Layered Slate Stone",
	"Leaf Candle Light",
	"Golden Fern Frond",
	
]
