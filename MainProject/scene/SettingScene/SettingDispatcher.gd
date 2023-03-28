extends Node
class_name SettingDispatcher

var scene_ref

func setRef(scene):
	scene_ref = scene

func scene():
	return scene_ref

func render():
	return scene().render()

func service():
	return scene().service()

func launch():
	render().renderSettingFrame()
	render().renderBgmText()
	render().renderBgmVolume()
	render().renderBgmVolumeMark()
	render().renderSoundText()
	render().renderSoundVolume()
	render().renderSoundVolumeMark()
	render().renderReturnButton()
	render().renderReturnText()

	emitAdjustBgmVolumeSignal()
	emitAdjustSoundVolumeSignal()
	emitReturnSignal()

func emitAdjustBgmVolumeSignal():
	var bgm_volume = render().getBgmVolume().getComponent()
	if not bgm_volume.is_connected("pressed", render(), "updateBgmVolume"):
		bgm_volume.connect("pressed", render(), "updateBgmVolumeMark")

func emitAdjustSoundVolumeSignal():
	var sound_volume = render().getSoundVolume().getComponent()
	if not sound_volume.is_connected("pressed", render(), "updateSoundVolume"):
		sound_volume.connect("pressed", render(), "updateSoundVolumeMark")
	
func emitReturnSignal():
	var return_button = render().getReturnButton().getComponent()
	if not return_button.is_connected("pressed", service(), "return"):
		return_button.connect("pressed", service(), "return")
