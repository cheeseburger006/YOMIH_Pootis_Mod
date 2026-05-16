extends CharacterState

class_name CharacterStateAnimatedThumbnail

export var _c_Animated_Texture_Vars = 0
export (Texture) var animated_texture
export var source_files_path = ""

func _ready():
	var image_files = []
	var dir = Directory.new()
	if dir.open(source_files_path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".png"):
				image_files.append(file_name)
			file_name = dir.get_next()
		dir.list_dir_end()

	animated_texture.set_frames(image_files.size())

	for i in range(image_files.size()):
		animated_texture.set_frame_texture(i, load(source_files_path + image_files[i]))
		animated_texture.set_frame_delay(i, 0.05)
