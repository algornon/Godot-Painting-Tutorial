extends Node2D

@onready var painting_sprite: Sprite2D = $Painting

# Convert saved resource to texture and apply to a sprite
func apply_texture_from_resource():
	var painting = GameManager.painting
	var grid_size = int(sqrt(painting.colors.size()))

	if painting and grid_size > 0:
		var image = Image.create(grid_size, grid_size, false, Image.FORMAT_RGBA8)

		for y in range(grid_size):
			for x in range(grid_size):
				var color_index = x + (y * grid_size)
				var color = painting.colors[color_index]
				image.set_pixel(x, y, color)

		var texture = ImageTexture.create_from_image(image)
		painting_sprite.texture = texture
