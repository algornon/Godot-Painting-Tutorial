extends Control

const GRID_SIZE = 32 # Length in each direction
var active_color : Color = Color(1, 0, 0)  # Default color - red
var is_painting = false  # Track if mouse is being dragged

@onready var grid: GridContainer = $CenterContainer/PanelContainer/MarginContainer/VSplitContainer/Drawing/GridContainer
@onready var color_picker: ColorPickerButton = $CenterContainer/PanelContainer/MarginContainer/VSplitContainer/Drawing/ColorPickerButton
@onready var painting: Node2D = $"../../Painting"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_grid()
	color_picker.color = active_color

# Generate a grid of cells that can be modulated
func generate_grid() -> void:
	grid.columns = GRID_SIZE
	
	# Create each cell in the grid
	for i in range(GRID_SIZE * GRID_SIZE):
		var cell = TextureButton.new()
		
		# Cursor shape
		cell.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		# Size 
		cell.custom_minimum_size = Vector2(16, 16)
		# Texture
		cell.stretch_mode = TextureButton.STRETCH_SCALE
		cell.ignore_texture_size = true
		cell.texture_normal = load("res://assets/sprites/square.png")
		# Colour
		cell.modulate = Color(1, 1, 1)
		
		grid.add_child(cell)
		
func _input(event):
	if event is InputEventMouseButton:
		# Start painting when left mouse button is pressed
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			is_painting = true
			# Paint the cell under the mouse on press
			var cell_under_mouse = get_cell_at_mouse_position(event.position)
			if cell_under_mouse:
				cell_under_mouse.modulate = active_color
				
		# Stop painting when the left mouse button is released
		if event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			is_painting = false

	if event is InputEventMouseMotion and is_painting:
		# Paint while the mouse moves (if we are painting)
		var cell_under_mouse = get_cell_at_mouse_position(event.position)
		if cell_under_mouse and !cell_under_mouse.modulate.is_equal_approx(active_color):
			cell_under_mouse.modulate = active_color  # Paint the cell
		
# Get the cell under the mouse position
func get_cell_at_mouse_position(mouse_pos: Vector2) -> TextureButton:
	# Find the cell by position (this assumes the grid layout is simple and sequential)
	var grid_buttons = grid.get_children()
	for i in range(grid_buttons.size()):
		var cell = grid_buttons[i]
		var cell_pos = cell.global_position
		var cell_size = cell.custom_minimum_size
		if cell_pos.x <= mouse_pos.x and mouse_pos.x <= cell_pos.x + cell_size.x and cell_pos.y <= mouse_pos.y and mouse_pos.y <= cell_pos.y + cell_size.y:
			return cell
	return null

func _on_color_picker_button_color_changed(color: Color) -> void:
	active_color = color
		

func _on_reset_pressed() -> void:
	if GameManager.painting.colors.size() > 0:
		GameManager.painting.load_to_grid(grid.get_children())
	

func _on_save_and_close_pressed() -> void:
	GameManager.painting.create_from_grid(grid.get_children())
	painting.apply_texture_from_resource()
	self.hide()
