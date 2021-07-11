data.raw["explosion"]["explosion-gunshot"].flags = {"not-on-map", "placeable-off-grid"}


-- armor
local function armor(n, p)
	return {
		type = "armor",
		name = "armor-" .. n,
		localised_name = {"armor-name." .. n},
		localised_description = {"armor-info." .. n},
		icon = "__m-roguef__/graphics/icons/armor/" .. n .. ".png",
		icon_size = 32,
		flags = {},
		subgroup = "rf_armor",
		order = "a",
		stack_size = 1,
		resistances = {{type = "damage-enemy", decrease = 0, percent = p}},
		durability = 1000000
	}
end
data:extend({
	armor(1, 5), -- 20
	armor(2, 10), -- 40
	armor(3, 15), -- 60
	armor(4, 20), -- 80
	armor(5, 25) -- 100
})

-- active
for i = 1, 9 do
	data:extend({
		{
			type = "item",
			name = "active-" .. i,
			localised_name = {"active-name." .. i},
			localised_description = {"active-info." .. i},
			icon = "__m-roguef__/graphics/icons/active/" .. i .. ".png",
			icon_size = 32,
			flags = {},
			subgroup = "rf_active",
			order = "a",
			stack_size = 1
		}
	})
end

-- passive
for i = 1, 20 do
	data:extend({
		{
			type = "item",
			name = "passive-" .. i,
			localised_name = {"passive-name." .. i},
			localised_description = {"passive-info." .. i},
			icon = "__m-roguef__/graphics/icons/passive/" .. i .. ".png",
			icon_size = 32,
			flags = {},
			subgroup = "rf_passive",
			order = "a",
			stack_size = 1
		}
	})
end

-- mastery
for t = 1, 7 do
	for i = 1, 3 do
		data:extend({
			{
				type = "item",
				name = "mastery-" .. t .. "-" .. i,
				icon = "__m-roguef__/graphics/icons/mastery/" .. t .. "-" .. i .. ".png",
				icon_size = 32,
				flags = {},
				subgroup = "rf_mastery",
				order = "a",
				stack_size = 1000
			}
		})
	end
end

-- raw                            6              7            8                9              10
local raw = {"active", "money", "level", "xp", "stage", "heal"}
for _, b in pairs(raw) do
	data:extend({
		{
			type = "item",
			name = b,
			icon = "__m-roguef__/graphics/icons/raw/" .. b .. ".png",
			icon_size = 32,
			flags = {},
			subgroup = "rf_raw",
			order = "a",
			stack_size = 1000
		}
	})
end

-- etc
data:extend({
	{
		type = "item",
		name = "rf_no",
		icon = "__m-roguef__/graphics/icons/raw/heal.png",
		icon_size = 32,
		flags = {},
		subgroup = "rf_raw",
		order = "b",
		stack_size = 1000,
		place_result = "rf_no"
	}
})
