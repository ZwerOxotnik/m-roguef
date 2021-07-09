require("prototypes.category")
require("prototypes.sound")
require("prototypes.enemy")
require("prototypes.explosion")
require("prototypes.entity") -- TODO: refactor, fix, remake those consoles there
require("prototypes.item")
require("prototypes.tile")

-- TODO: change \/
for _, corpse in pairs(data.raw.corpse) do
	corpse.time_before_removed = 60 * 30
end

-- for _, recipe in pairs(data.raw.recipe) do
--   recipe.enabled = false
-- end

-- TODO: change \/
data:extend({
	{
		type = "custom-input",
		name = "reload",
		key_sequence = "R"
	},
	{
		type = "custom-input",
		name = "dodge",
		key_sequence = "mouse-button-2"
	},
	{
		type = "custom-input",
		name = "useitem",
		key_sequence = "CAPSLOCK"
	},
	{
		type = "custom-input",
		name = "interaction",
		key_sequence = "mouse-button-1"
	},
})
