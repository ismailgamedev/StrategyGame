extends Control


func _ready():

	$VBoxContainer/MusicSlider/Label.text = tr("musicsld")
	$VBoxContainer/SoundSlider/Label.text = tr("soundsld")
	
	if TranslationServer.get_locale() == "tr_TR":
		$VBoxContainer/LanguageOption.selected = 1
	if TranslationServer.get_locale() == "en":
		$VBoxContainer/LanguageOption.selected = 0
	if TranslationServer.get_locale() == "da":
		$VBoxContainer/LanguageOption.selected = 3
	if TranslationServer.get_locale() == "de":
		$VBoxContainer/LanguageOption.selected = 2

func _process(delta):
	if $VBoxContainer/LanguageOption.selected == 0:
		TranslationServer.set_locale("en")
	elif $VBoxContainer/LanguageOption.selected == 1:
		TranslationServer.set_locale("tr_TR")
	elif $VBoxContainer/LanguageOption.selected == 2:
		TranslationServer.set_locale("de")
	elif $VBoxContainer/LanguageOption.selected == 3:
		TranslationServer.set_locale("da")


