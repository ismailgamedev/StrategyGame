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
	"nufus_kucukEv":{"calismaSuresi":"","Gelir":""},
	"nufus_buyukEv":{"s":"","s2":""},
	"nufus_apratmankEv":{"s":"","s2":""},
	
	"mutluluk_kucukPark":{"s":"","s2":""},
	"mutluluk_buyukPark":{"s":"","s2":""},
	
	
	"enerji_ruzgarTurbini":{"s":"","s2":""},
	"enerji_gunesPaneli":{"s":"","s2":""},
	"enerji_biyoYakit":{"s":"","s2":""},
	"enerji_petrol":{"s":"","s2":""},
	
	
}
#var dolar : int = 100 
#var yemek : int = 10
#var su : int = 10
#var enerji : float = 40
#var mutluluk : int = 100
#var nufus : int = 50
enum current_building_enum { bos,kucuk_ev,orta_ev,buyuk_ev,fabrika,petrol_donusturucusu,biyo_yakit_donusturucusu, }
var current_building = current_building_enum.bos
