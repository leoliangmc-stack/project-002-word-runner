extends SceneTree

func _init() -> void:
	print("WordManager autoload present: ", root.has_node("WordManager"))
	quit()
