extends AudioStreamPlayer2D

@onready var bg_music_var = $"."
var musicarray:Array = []
var song_name:Array = []
var song: String = ""
var count = 0
var flag_stop = 0

func _ready():
	_on_fd_openfolder_dir_selected("res://bg_music/")
	song = "Nothing"

func _process(delta):
	if not bg_music_var.playing and not flag_stop:
		print("Playing")
		play_next_song()

func forward():
	flag_stop = 1
	bg_music_var.stop()
	count += 1
	play_next_song()

func backward():
	flag_stop = 1
	bg_music_var.stop()
	count -= 1
	play_next_song()

func _on_fd_openfolder_dir_selected(path):
	var dirc = DirAccess.open(path)
	if dirc:
		dirc.list_dir_begin()
		var file_name = dirc.get_next()
		while file_name != "":
			if not dirc.current_is_dir():
				# Check if the file is an MP3 file
				if file_name.get_file().ends_with(".mp3"):
					print("Found MP3 file: " + file_name)
					# Add the file path to the music array
					song_name.append(file_name)
					musicarray.append(dirc.get_current_dir() + "/" + file_name)
			file_name = dirc.get_next()
		dirc.list_dir_end()  # End the directory listing
	else:
		print("An error occurred when trying to access the path.")

func play_next_song():
	if musicarray.size() > 0:
		count = count % musicarray.size()  # Ensure count is within bounds
		var path = musicarray[count]
		song = song_name[count]
		var sound: AudioStream = load(path)  # Load the audio file
		if sound:  # Ensure the sound is loaded correctly
			bg_music_var.stream = sound
			bg_music_var.play()
			flag_stop = 1
		else:
			print("Failed to load audio stream.")
			flag_stop = 1


	
