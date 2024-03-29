local function sound(name, volume)
	return {
		type = "explosion",
		name = name .. "-sound",
		flags = {"not-on-map"},
		animations = {
			{
				filename = "__roguef-core__/graphics/empty.png",
				priority = "extra-high",
				width = 1,
				height = 1,
				frame_count = 1,
				animation_speed = 1
			}
		},
		created_effect = {
			type = "direct",
			action_delivery = {
				type = "instant",
				source_effects = {
					type = "play-sound",
					sound = {{filename = "__m-roguef__/sound/" .. name .. ".ogg", volume = volume or 0.5}}
				}
			}
		}
	}
end

data:extend({
	sound("msg", 1), sound("rush", 1), sound("firstaid"), sound("tuto", 0.75), sound("levelup", 0.75),
	sound("stagestart", 0.75), sound("stageclear", 0.75), sound("die", 0.75), sound("open", 1), sound("laser", 1),
	sound("p-23", 1), sound("recall", 1), sound("active-6"), sound("anda1", 1), sound("anda2", 1),
	sound("anda3", 1), sound("anda-cast-1", 1), sound("anda-cast-2", 1), sound("diablo1", 1), sound("diablo2", 1),
	sound("laugh1", 1), sound("laugh2", 1), sound("laugh3", 1), sound("castlazer", 1), sound("alarm", 1),
	sound("diesound", 1), sound("active-3"), sound("stim")
})

local bgmtable = {}

bgmtable[0] = 6
bgmtable[1] = 6
bgmtable[2] = 5
bgmtable[3] = 6
bgmtable[4] = 6
bgmtable[5] = 6
bgmtable[6] = 4
bgmtable[7] = 8
bgmtable[8] = 9
bgmtable[9] = 5

for i = 0, 9, 1 do for
	j = 1, bgmtable[i] do
		data:extend({sound("battle-" .. i .. "-" .. j)})
	end
end
