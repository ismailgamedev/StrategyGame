extends Node


var data = {
	"dolar":500,
	"yemek":0,
	"su":0,
	"enerji":0,
	"mutluluk":100,
	"nufus":0,
	
}


var gelirListesi = {
	"nufus_kucukEv":{"calismaSuresi":25,"Gelir":2},
	"nufus_buyukEv":{"calismaSuresi":35,"Gelir":5},
	"nufus_apratmankEv":{"calismaSuresi":60,"Gelir":12},
	
	"mutluluk_kucukPark":{"calismaSuresi":60,"Gelir":5},
	"mutluluk_buyukPark":{"calismaSuresi":150,"Gelir":15},
	
	
	"enerji_ruzgarTurbini":{"calismaSuresi":90,"Gelir":15},
	"enerji_gunesPaneli":{"calismaSuresi":120,"Gelir":30},
	"enerji_biyoYakit":{"calismaSuresi":200,"Gelir":60},
	"enerji_petrol":{"calismaSuresi":310,"Gelir":70},
	
	
}
#var dolar : int = 100 
#var yemek : int = 10
#var su : int = 10
#var enerji : float = 40
#var mutluluk : int = 100
#var nufus : int = 50
enum current_building_enum { bos,kucuk_ev,orta_ev,buyuk_ev,elektirik_santrali}
var current_building = current_building_enum.bos


