class_name PaintingResource
extends Resource

# Store the pixel colors as a pool of Color values
@export var colors: Array[Color]

# Function to create a drawing resource from the grid
func create_from_grid(grid_buttons: Array):
	colors.resize(grid_buttons.size())  # Resize the array to match the grid size
	for i in range(grid_buttons.size()):
		colors[i] = grid_buttons[i].modulate  # Capture the modulate color of each cell

# Function to load drawing data into a grid
func load_to_grid(grid_buttons: Array):
	for i in range(grid_buttons.size()):
		grid_buttons[i].modulate = colors[i]  # Set the modulate color of each cell
