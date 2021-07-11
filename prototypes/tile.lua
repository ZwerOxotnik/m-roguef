-- TODO: rethink
data.raw.tile["water-green"].collision_mask = {"ground-tile"}
data.raw.tile["water-green"].walking_sound = {
	{filename = "__base__/sound/walking/dirt-02.ogg", volume = 0.8},
	{filename = "__base__/sound/walking/dirt-03.ogg", volume = 0.8},
	{filename = "__base__/sound/walking/dirt-04.ogg", volume = 0.8}
}
data.raw.tile["deepwater-green"].collision_mask = {"ground-tile"}
data.raw.tile["deepwater-green"].walking_sound = {
	{filename = "__base__/sound/walking/dirt-02.ogg", volume = 0.8},
	{filename = "__base__/sound/walking/dirt-03.ogg", volume = 0.8},
	{filename = "__base__/sound/walking/dirt-04.ogg", volume = 0.8}
}

data:extend({
	{
		type = "tile",
		name = "water-red",
		collision_mask = {"ground-tile"},
		pollution_absorption_per_second = 0,
		layer = 40,
		variants = {
			main = {
				{picture = "__m-roguef__/graphics/terrain/water/water1.png", count = 8, size = 1},
				{picture = "__m-roguef__/graphics/terrain/water/water2.png", count = 8, size = 2},
				{picture = "__m-roguef__/graphics/terrain/water/water4.png", count = 6, size = 4}
			},
			inner_corner = {picture = "__m-roguef__/graphics/terrain/water/water-inner-corner.png", count = 6},
			outer_corner = {picture = "__m-roguef__/graphics/terrain/water/water-outer-corner.png", count = 6},
			side = {picture = "__m-roguef__/graphics/terrain/water/water-side.png", count = 8}
		},
		-- allowed_neighbors = { "grass" },
		map_color = {r = 1, g = 0, b = 0},
		ageing = 0.0006
	}
})
