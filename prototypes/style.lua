local default_gui = data.raw["gui-style"].default


if default_gui.button_style == nil then
	default_gui.button_style = {
		type = "button_style",
		font = "default-semibold",
		default_font_color={r=1, g=1, b=1},
		align = "center",
		top_padding = 5,
		right_padding = 5,
		bottom_padding = 5,
		left_padding = 5,
		default_graphical_set =
		{
			type = "composition",
			filename = "__core__/graphics/gui.png",
			priority = "extra-high-no-scale",
			corner_size = {3, 3},
			position = {0, 0}
		},
		hovered_font_color={r=1, g=1, b=1},
		hovered_graphical_set =
		{
			type = "composition",
			filename = "__core__/graphics/gui.png",
			priority = "extra-high-no-scale",
			corner_size = {3, 3},
			position = {0, 8}
		},
		clicked_font_color={r=1, g=1, b=1},
		clicked_graphical_set =
		{
			type = "composition",
			filename = "__core__/graphics/gui.png",
			priority = "extra-high-no-scale",
			corner_size = {3, 3},
			position = {0, 40}
		},
		disabled_font_color={r=0.5, g=0.5, b=0.5},
		disabled_graphical_set =
		{
			type = "composition",
			filename = "__core__/graphics/gui.png",
			priority = "extra-high-no-scale",
			corner_size = {3, 3},
			position = {0, 16}
		},
		pie_progress_color = {r=1, g=1, b=1}
	}
end

if default_gui.slot_button_style == nil then
	default_gui.slot_button_style = {
		type = "button_style",
		parent = "button_style",
		scalable = false,
		width = 36,
		height = 36,
		top_padding = 1,
		right_padding = 1,
		bottom_padding = 1,
		left_padding = 1,
		default_graphical_set =
		{
			type = "composition", -- "monolith"?
			filename = "__core__/graphics/gui.png",
			priority = "extra-high-no-scale",
			corner_size = {3, 3},
			position = {0, 0}
		},
		hovered_graphical_set =
		{
			type = "composition", -- "monolith"?
			filename = "__core__/graphics/gui.png",
			priority = "extra-high-no-scale",
			corner_size = {3, 3},
			position = {0, 0}
		},
		clicked_graphical_set =
		{
			type = "composition", -- "monolith"?
			filename = "__core__/graphics/gui.png",
			priority = "extra-high-no-scale",
			corner_size = {3, 3},
			position = {0, 0}
		},
		pie_progress_color = {r=0.98, g=0.66, b=0.22, a = 0.5}
	}
end

if default_gui.red_circuit_network_content_slot_style == nil then
	default_gui.red_circuit_network_content_slot_style = {
		type = "button_style",
		parent = "slot_button_style",
		default_graphical_set =
		{
			type = "composition", -- "monolith"?
			filename = "__core__/graphics/gui.png",
			priority = "extra-high-no-scale",
			corner_size = {3, 3},
			position = {0, 0}
		},
	}
end

if default_gui.green_circuit_network_content_slot_style == nil then
	default_gui.green_circuit_network_content_slot_style = {
		type = "button_style",
		parent = "slot_button_style",
		scalable = false,
		default_graphical_set =
		{
			type = "composition", -- "monolith"?
			filename = "__core__/graphics/gui.png",
			priority = "extra-high-no-scale",
			corner_size = {3, 3},
			position = {0, 0}
		},
	}
end

-- used for frames that contains exclusively other inner frames
if default_gui.outer_frame_style == nil then
	default_gui.outer_frame_style = {
		type = "frame_style",
		top_padding = 0,
		right_padding = 0,
		bottom_padding = 0,
		left_padding = 0,
		title_bottom_padding = 0,
		graphical_set = { type = "none" },
		flow_style=
		{
			horizontal_spacing = 0,
			vertical_spacing = 0,
			resize_row_to_width = true,
			resize_to_row_height = true
		}
	}
end

if default_gui.health_progressbar_style == nil then
	default_gui.health_progressbar_style = {
		type = "progressbar_style",
		smooth_size = 500,
		smooth_color = {g=1},
		smooth_bar =
		{
			filename = "__core__/graphics/gui.png",
			priority = "extra-high-no-scale",
			width = 1,
			height = 11,
			x = 223,
		},
		smooth_bar_background =
		{
			filename = "__core__/graphics/gui.png",
			priority = "extra-high-no-scale",
			width = 1,
			height = 13,
			x = 224
		}
	}
end

if default_gui.side_menu_button_style == nil then
	default_gui.side_menu_button_style = {
		type = "button_style",
		parent = "button_style",
		scalable = true,
		default_font_color={r=0, g=0, b=0},
		width = 38,
		height = 38,
		top_padding = 1,
		right_padding = 0,
		bottom_padding = 1,
		left_padding = 0,
		default_graphical_set =
		{
			type = "composition",
			filename = "__core__/graphics/gui.png",
			priority = "extra-high-no-scale",
			corner_size = {3, 3},
			position = {8, 0}
		}
	}
end
