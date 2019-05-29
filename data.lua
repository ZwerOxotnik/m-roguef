require("prototypes.category")
require("prototypes.sound")
require("prototypes.enemy")
require("prototypes.explosion")
require("prototypes.entity")
require("prototypes.item")
require("prototypes.recipe")
require("prototypes.technology")
require("prototypes.tile")
for a,b in pairs(data.raw.corpse) do
	b.time_before_removed=60*30
end
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