 -- TODO: check this
local beam_blend_mode = "additive-soft"
local fire_blend_mode = "additive"
local fire_flags = nil
local fire_tint = {r=1,g=1,b=1,a=1}
local fire_animation_speed = 0.5
local fire_scale = 1


local player = data.raw["character"]["character"]
player.max_health = 1000
player.healing_per_tick = 0
player.inventory_size = 100
player.build_distance = 0
player.drop_item_distance = 0
player.reach_distance = 1
player.loot_pickup_distance = 0
player.reach_resource_distance = 0
player.damage_hit_tint = {r = 0, g = 0, b = 0, a = 0}
player.running_speed = 0.15
player.distance_per_frame = 0.13
player.maximum_corner_sliding_distance = 0.7

local player_copy = util.table.deepcopy(player)
player_copy.name = "player-dummy"
player_copy.max_health = 10000

data:extend({
	player_copy, {
		type = "fire",
		name = "blaze",
		flags = {"placeable-off-grid", "not-on-map"},
		duration = 60,
		fade_away_duration = 60,
		spread_duration = 600,
		start_scale = 1,
		end_scale = 0.01,
		color = {r = 1, g = 0.9, b = 0, a = 0.5},
		damage_per_tick = {amount = 0, type = "fire"},
		spread_delay = 300,
		spread_delay_deviation = 180,
		maximum_spread_count = 100,
		initial_lifetime = 60,
		flame_alpha = 0.35,
		flame_alpha_deviation = 0.05,
		emissions_per_tick = 0.005,
		add_fuel_cooldown = 10,
		increase_duration_cooldown = 10,
		increase_duration_by = 20,
		fade_in_duration = 30,
		fade_out_duration = 30,
		lifetime_increase_by = 20,
		lifetime_increase_cooldown = 10,
		delay_between_initial_flames = 10,
		burnt_patch_lifetime = 0,
		on_fuel_added_action = {
			type = "direct",
			action_delivery = {
				type = "instant",
				target_effects = {
					{
						type = "create-trivial-smoke",
						smoke_name = "fire-smoke-on-adding-fuel",
						-- speed = {-0.03, 0},
						-- speed_multiplier = 0.99,
						-- speed_multiplier_deviation = 1.1,
						offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}},
						speed_from_center = 0.01
					}
				}
			}
		},
		pictures = {
			{
				filename = "__roguef-core__/graphics/explosion/blaze.png",
				line_length = 8,
				width = 30,
				height = 59,
				frame_count = 25,
				axially_symmetrical = false,
				direction_count = 1,
				blend_mode = fire_blend_mode,
				animation_speed = fire_animation_speed,
				scale = fire_scale,
				tint = fire_tint,
				flags = fire_flags,
				shift = {-0.0390625 / 2, -0.90625 / 2}
			}
		},
		light = {intensity = 1, size = 20},
		working_sound = {sound = {filename = "__base__/sound/furnace.ogg"}, max_sounds_per_type = 3}
	}, {
		type = "combat-robot",
		name = "robot-1",
		icon = "__0_16_graphics_revived__/graphics/icons/destroyer.png",
		icon_size = 32,
		flags = {"player-creation", "placeable-off-grid", "not-on-map", "not-repairable"},
		resistances = {{type = "damage-player", percent = 100}},
		subgroup = "capsule",
		order = "e-a-c",
		max_health = 1, -- why was 0???
		alert_when_damaged = false,
		-- collision_box = {{0, 0}, {0, 0}},
		selection_box = {{-0.5, -1.5}, {0.5, -0.5}},
		-- selectable_in_game = false,
		distance_per_frame = 0.13,
		time_to_live = 60 * 60 * 60 * 24 * 365,
		speed = 0.1,
		follows_player = true,
		friction = 0.05,
		range_from_player = 3.0,
		attack_parameters = {
			type = "beam",
			ammo_category = "rf_robot",
			cooldown = 6,
			range = 20,
			ammo_type = {
				category = "rf_robot",
				action = {
					type = "direct",
					action_delivery = {
						type = "beam",
						beam = "beam-robot-1",
						max_length = 20,
						duration = 6,
						source_offset = {0.15, -0.5}
					}
				}
			}
		},
		idle = {
			layers = {
				{
					filename = "__base__/graphics/entity/destroyer-robot/destroyer-robot.png",
					priority = "high",
					line_length = 32,
					width = 45,
					height = 39,
					y = 39,
					frame_count = 1,
					direction_count = 32,
					shift = {0.078125, -0.546875},
					scale = 1 / 2
				}, {
					filename = "__base__/graphics/entity/destroyer-robot/destroyer-robot-mask.png",
					priority = "high",
					line_length = 32,
					width = 27,
					height = 21,
					y = 21,
					frame_count = 1,
					direction_count = 32,
					shift = {0.078125, -0.734375},
					apply_runtime_tint = true,
					scale = 1 / 2
				}
			}
		},
		shadow_idle = {
			filename = "__base__/graphics/entity/destroyer-robot/destroyer-robot-shadow.png",
			priority = "high",
			line_length = 32,
			width = 48,
			height = 32,
			frame_count = 1,
			direction_count = 32,
			shift = {0.78125, 0},
			scale = 1 / 2
		},
		in_motion = {
			layers = {
				{
					filename = "__base__/graphics/entity/destroyer-robot/destroyer-robot.png",
					priority = "high",
					line_length = 32,
					width = 45,
					height = 39,
					frame_count = 1,
					direction_count = 32,
					shift = {0.078125, -0.546875},
					scale = 1 / 2
				}, {
					filename = "__base__/graphics/entity/destroyer-robot/destroyer-robot-mask.png",
					priority = "high",
					line_length = 32,
					width = 27,
					height = 21,
					frame_count = 1,
					direction_count = 32,
					shift = {0.078125, -0.734375},
					apply_runtime_tint = true,
					scale = 1 / 2
				}
			}
		},
		shadow_in_motion = {
			filename = "__base__/graphics/entity/destroyer-robot/destroyer-robot-shadow.png",
			priority = "high",
			line_length = 32,
			width = 48,
			height = 32,
			frame_count = 1,
			direction_count = 32,
			shift = {0.78125, 0},
			scale = 1 / 2
		}
	}, {
		type = "beam",
		name = "beam-robot-1",
		flags = {"not-on-map"},
		width = 0.5,
		damage_interval = 6,
		working_sound = {{filename = "__base__/sound/fight/electric-beam.ogg", volume = 0.3}},
		action = {
			type = "direct",
			action_delivery = {
				type = "instant",
				target_effects = {{type = "damage", damage = {amount = 1, type = "damage-player"}}}
			}
		},
		head = {
			filename = "__m-roguef__/graphics/entity/beam/beam-head.png",
			line_length = 16,
			width = 45,
			height = 39,
			frame_count = 16,
			animation_speed = 0.5,
			blend_mode = beam_blend_mode
		},
		tail = {
			filename = "__m-roguef__/graphics/entity/beam/beam-tail.png",
			line_length = 16,
			width = 45,
			height = 39,
			frame_count = 16,
			blend_mode = beam_blend_mode
		},
		body = {
			{
				filename = "__m-roguef__/graphics/entity/beam/beam-body-1.png",
				line_length = 16,
				width = 45,
				height = 39,
				frame_count = 16,
				blend_mode = beam_blend_mode
			}, {
				filename = "__m-roguef__/graphics/entity/beam/beam-body-2.png",
				line_length = 16,
				width = 45,
				height = 39,
				frame_count = 16,
				blend_mode = beam_blend_mode
			}, {
				filename = "__m-roguef__/graphics/entity/beam/beam-body-3.png",
				line_length = 16,
				width = 45,
				height = 39,
				frame_count = 16,
				blend_mode = beam_blend_mode
			}, {
				filename = "__m-roguef__/graphics/entity/beam/beam-body-4.png",
				line_length = 16,
				width = 45,
				height = 39,
				frame_count = 16,
				blend_mode = beam_blend_mode
			}, {
				filename = "__m-roguef__/graphics/entity/beam/beam-body-5.png",
				line_length = 16,
				width = 45,
				height = 39,
				frame_count = 16,
				blend_mode = beam_blend_mode
			}, {
				filename = "__m-roguef__/graphics/entity/beam/beam-body-6.png",
				line_length = 16,
				width = 45,
				height = 39,
				frame_count = 16,
				blend_mode = beam_blend_mode
			}
		}
	}, {
		type = "combat-robot",
		name = "robot-2",
		icon = "__0_16_graphics_revived__/graphics/icons/destroyer.png",
		icon_size = 32,
		flags = {"player-creation", "placeable-off-grid", "not-on-map", "not-repairable"},
		resistances = {{type = "damage-player", percent = 100}},
		subgroup = "capsule",
		order = "e-a-c",
		max_health = 1, -- why was 0???
		alert_when_damaged = false,
		-- collision_box = {{0, 0}, {0, 0}},
		selection_box = {{-0.5, -1.5}, {0.5, -0.5}},
		-- selectable_in_game = false,
		distance_per_frame = 0.13,
		time_to_live = 60 * 60 * 60 * 24 * 365,
		speed = 0.1,
		follows_player = true,
		friction = 0.05,
		range_from_player = 3.0,
		attack_parameters = {
			type = "projectile",
			ammo_category = "rf_robot",
			cooldown = 30,
			range = 30,
			ammo_type = {
				category = "rf_robot",
				target_type = "direction",
				action = {
					{
						type = "direct",
						action_delivery = {type = "projectile", projectile = "p-robot-2", starting_speed = 0.3, max_range = 30}
					}
				}
			}
		},
		idle = {
			layers = {
				{
					filename = "__base__/graphics/entity/distractor-robot/distractor-robot.png",
					priority = "high",
					line_length = 16,
					width = 38,
					height = 33,
					frame_count = 1,
					direction_count = 16,
					shift = {0, -0.078125}
				}, {
					filename = "__base__/graphics/entity/distractor-robot/distractor-robot-mask.png",
					priority = "high",
					line_length = 16,
					width = 24,
					height = 21,
					frame_count = 1,
					direction_count = 16,
					shift = {0, -0.203125},
					apply_runtime_tint = true
				}
			}
		},
		shadow_idle = {
			filename = "__base__/graphics/entity/distractor-robot/distractor-robot-shadow.png",
			priority = "high",
			line_length = 16,
			width = 40,
			height = 25,
			frame_count = 1,
			direction_count = 16,
			shift = {0.9375, 0.609375}
		},
		in_motion = {
			layers = {
				{
					filename = "__base__/graphics/entity/distractor-robot/distractor-robot.png",
					priority = "high",
					line_length = 16,
					width = 38,
					height = 33,
					frame_count = 1,
					direction_count = 16,
					shift = {0, -0.078125},
					y = 33
				}, {
					filename = "__base__/graphics/entity/distractor-robot/distractor-robot-mask.png",
					priority = "high",
					line_length = 16,
					width = 24,
					height = 21,
					frame_count = 1,
					direction_count = 16,
					shift = {0, -0.203125},
					apply_runtime_tint = true,
					y = 21
				}
			}
		},
		shadow_in_motion = {
			filename = "__base__/graphics/entity/distractor-robot/distractor-robot-shadow.png",
			priority = "high",
			line_length = 16,
			width = 40,
			height = 25,
			frame_count = 1,
			direction_count = 16,
			shift = {0.9375, 0.609375}
		}
	}, {
		type = "projectile",
		name = "p-robot-2",
		flags = {"not-on-map", "placeable-off-grid"},
		collision_box = {{-0.3, -0.3}, {0.3, 0.3}},
		acceleration = 0,
		direction_only = true,
		action = {
			type = "direct",
			action_delivery = {
				type = "instant",
				target_effects = {
					{type = "damage", damage = {amount = 5, type = "damage-player"}},
						{type = "create-entity", entity_name = "target-melee-2"}
				}
			}
		},
		animation = {
			filename = "__roguef-core__/graphics/explosion/p-1.png",
			frame_count = 4,
			width = 16,
			height = 16,
			priority = "high",
			blend_mode = "additive",
			animation_speed = 10 / 60,
			scale = 2 / 3
		}
	}, {
		type = "combat-robot",
		name = "robot-3",
		icon = "__0_16_graphics_revived__/graphics/icons/destroyer.png",
		icon_size = 32,
		flags = {"player-creation", "placeable-off-grid", "not-on-map", "not-repairable"},
		resistances = {{type = "damage-player", percent = 100}},
		subgroup = "capsule",
		order = "e-a-c",
		max_health = 1, -- why was 0???
		alert_when_damaged = false,
		-- collision_box = {{0, 0}, {0, 0}},
		selection_box = {{-0.5, -1.5}, {0.5, -0.5}},
		-- selectable_in_game = false,
		distance_per_frame = 0.13,
		time_to_live = 60 * 60 * 60 * 24 * 365,
		speed = 0.1,
		follows_player = true,
		friction = 0.05,
		range_from_player = 3.0,
		attack_parameters = {
			type = "projectile",
			ammo_category = "rf_robot",
			cooldown = 60,
			range = 25,
			ammo_type = {
				category = "rf_robot",
				target_type = "position",
				action = {
					{
						type = "direct",
						action_delivery = {type = "projectile", projectile = "p-robot-3", starting_speed = 0.3, max_range = 25}
					}, {
						type = "direct",
						action_delivery = {
							type = "instant",
							source_effects = {{type = "create-explosion", entity_name = "explosion-gunshot"}}
						}
					}
				}
			}
		},
		idle = {
			layers = {
				{
					filename = "__base__/graphics/entity/defender-robot/defender-robot.png",
					priority = "high",
					line_length = 16,
					width = 32,
					height = 33,
					frame_count = 1,
					direction_count = 16,
					shift = {0, 0.015625}
				}, {
					filename = "__base__/graphics/entity/defender-robot/defender-robot-mask.png",
					priority = "high",
					line_length = 16,
					width = 18,
					height = 16,
					frame_count = 1,
					direction_count = 16,
					shift = {0, -0.125},
					apply_runtime_tint = true
				}
			}
		},
		shadow_idle = {
			filename = "__base__/graphics/entity/defender-robot/defender-robot-shadow.png",
			priority = "high",
			line_length = 16,
			width = 43,
			height = 23,
			frame_count = 1,
			direction_count = 16,
			shift = {0.859375, 0.609375}
		},
		in_motion = {
			layers = {
				{
					filename = "__base__/graphics/entity/defender-robot/defender-robot.png",
					priority = "high",
					line_length = 16,
					width = 32,
					height = 33,
					frame_count = 1,
					direction_count = 16,
					shift = {0, 0.015625},
					y = 33
				}, {
					filename = "__base__/graphics/entity/defender-robot/defender-robot-mask.png",
					priority = "high",
					line_length = 16,
					width = 18,
					height = 16,
					frame_count = 1,
					direction_count = 16,
					shift = {0, -0.125},
					apply_runtime_tint = true,
					y = 16
				}
			}
		},
		shadow_in_motion = {
			filename = "__base__/graphics/entity/defender-robot/defender-robot-shadow.png",
			priority = "high",
			line_length = 16,
			width = 43,
			height = 23,
			frame_count = 1,
			direction_count = 16,
			shift = {0.859375, 0.609375}
		}
	}, {
		type = "projectile",
		name = "p-robot-3",
		flags = {"not-on-map"},
		acceleration = 0,
		action = {
			{
				type = "direct",
				action_delivery = {type = "instant", target_effects = {{type = "create-entity", entity_name = "explosion-1"}}}
			}, {
				type = "area",
				radius = 2,
				action_delivery = {
					type = "instant",
					target_effects = {{type = "damage", damage = {amount = 10, type = "damage-player"}}}
				}
			}
		},
		light = {intensity = 0.5, size = 4},
		animation = {
			filename = "__base__/graphics/entity/grenade/grenade.png",
			frame_count = 1,
			width = 24,
			height = 24,
			priority = "high"
		},
		shadow = {
			filename = "__base__/graphics/entity/grenade/grenade-shadow.png",
			frame_count = 1,
			width = 24,
			height = 24,
			priority = "high"
		}
	}, {
		type = "land-mine",
		name = "mine-6",
		icon = "__0_16_graphics_revived__/graphics/icons/land-mine.png",
		icon_size = 32,
		flags = {"player-creation", "placeable-off-grid"},
		max_health = 250,
		alert_when_damaged = false,
		corpse = "small-remnants",
		collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
		selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
		dying_explosion = "explosion-hit",
		picture_safe = {
			filename = "__base__/graphics/entity/land-mine/land-mine.png",
			priority = "medium",
			width = 32,
			height = 32
		},
		picture_set = {
			filename = "__base__/graphics/entity/land-mine/land-mine-set.png",
			priority = "medium",
			width = 32,
			height = 32
		},
		trigger_radius = 2.5,
		action = {
			type = "direct",
			action_delivery = {
				type = "instant",
				source_effects = {
					{
						type = "nested-result",
						affects_target = true,
						action = {
							type = "area",
							radius = 6,
							collision_mask = {"player-layer"},
							action_delivery = {
								type = "instant",
								target_effects = {type = "damage", damage = {amount = 100, type = "damage-player"}}
							}
						}
					}, {type = "create-entity", entity_name = "explosion"},
						{type = "damage", damage = {amount = 1000, type = "damage-player"}}
				}
			}
		}
	}, -- TODO: delete flying-text due of https://lua-api.factorio.com/0.17.43/LuaRendering.html#LuaRendering.draw_text
	{
		type = "flying-text",
		name = "playertext",
		flags = {"not-on-map", "placeable-off-grid"},
		time_to_live = 300,
		speed = -0.01
	}, {
		type = "flying-text",
		name = "flying-text",
		flags = {"not-on-map", "placeable-off-grid"},
		time_to_live = 200,
		speed = 0.05
	}, {
		type = "flying-text",
		name = "critical-text",
		flags = {"not-on-map", "placeable-off-grid"},
		time_to_live = 300,
		speed = -0.01
	}, {
		type = "flying-text",
		name = "damage-text",
		flags = {"not-on-map", "placeable-off-grid"},
		time_to_live = 300,
		speed = 0.1
	}, {
		type = "flying-text",
		name = "weapon-text",
		flags = {"not-on-map", "placeable-off-grid"},
		time_to_live = 60,
		speed = 0
	}, --[[npc
	{
		type = "character",
		name = "scareboy",
		icon = "__0_16_graphics_revived__/graphics/icons/player.png",
		icon_size = 32,
		flags = {"placeable-player","placeable-off-grid", "breaths-air", "not-repairable", "not-on-map"},
		max_health = 12500000,
		alert_when_damaged = false,healing_per_tick = 0.0,
		collision_box = {{-0.2, -0.2}, {0.2, 0.2}},
		selection_box = {{-0.4, -1.4}, {0.4, 0.2}},
		crafting_categories = {"crafting"},    mining_categories = {"basic-solid"},    inventory_size = 0,    build_distance = 6,    drop_item_distance = 6,    reach_distance = 6,    item_pickup_distance = 1,    loot_pickup_distance = 2,    reach_resource_distance = 2.7,
		ticks_to_keep_gun = 600,    ticks_to_keep_aiming_direction = 100,    damage_hit_tint = {r = 1, g = 0, b = 0, a = 0},
		running_speed = 0.15,    distance_per_frame = 0.13,    maximum_corner_sliding_distance = 0.7,
		subgroup = "rf_raw",    order="a",
		eat ={{filename = "__0_16_graphics_revived__/sound/eat.ogg",volume = 1}},    heartbeat ={{filename = "__0_16_graphics_revived__/sound/heartbeat.ogg"}},
		animations ={{ idle ={layers ={playeranimations.level1.idle,playeranimations.level1.idlemask,}},
		idle_with_gun ={layers ={playeranimations.level1.idlewithgun,playeranimations.level1.idlewithgunmask,}},
		mining_with_hands ={layers ={playeranimations.level1.miningwithhands,playeranimations.level1.miningwithhandsmask,}},
		mining_with_tool ={layers ={playeranimations.level1.miningwithtool,playeranimations.level1.miningwithtoolmask,}},
		running_with_gun ={layers ={playeranimations.level1.runningwithgun,playeranimations.level1.runningwithgunmask,}},
		running ={layers ={playeranimations.level1.running,playeranimations.level1.runningmask,}}}},
		mining_speed = 0,
		mining_with_hands_particles_animation_positions = {29, 63},
		mining_with_tool_particles_animation_positions = {28},
		running_sound_animation_positions = {5, 16}
	},
	]] -- weapon-attack for trigger
	{
		type = "explosion",
		name = "weapon-attack",
		flags = {"not-on-map", "placeable-off-grid"},
		animations = {
			{filename = "__roguef-core__/graphics/empty.png", frame_count = 1, width = 1, height = 1, animation_speed = 1}
		}
	}, {
		type = "explosion",
		name = "weapon-attacker",
		flags = {"not-on-map", "placeable-off-grid"},
		animations = {
			{filename = "__roguef-core__/graphics/empty.png", frame_count = 1, width = 1, height = 1, animation_speed = 1}
		}
	}
})

-- sticker ( slowdown-i-j ) i : 0.5 sec,   j : movement speed %
for i = 1, 10, 1 do
	for j = 0, 400, 10 do
		data:extend({
			{
				type = "sticker",
				name = "slowdown-" .. tostring(i) .. "-" .. tostring(j),
				flags = {"not-on-map"},
				animation = {filename = "__roguef-core__/graphics/empty.png", frame_count = 1, width = 1, height = 1},
				duration_in_ticks = i * 60 / 2,
				target_movement_modifier = j / 100
			}
		})
	end
end

-- etc

data.raw["curved-rail"]["curved-rail"].collision_mask = {"object-layer"}
data.raw["straight-rail"]["straight-rail"].collision_mask = {"object-layer"}

data:extend({
	{
		type = "optimized-decorative",
		name = "green-circle",
		flags = {"placeable-neutral", "not-on-map", "placeable-off-grid"},
		icon = "__m-roguef__/graphics/entity/green-circle.png",
		icon_size = 32,
		subgroup = "rf_raw",
		order = "b",
		collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
		selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
		collision_mask = {"object-layer"},
		selectable_in_game = false,
		pictures = {{filename = "__m-roguef__/graphics/entity/green-circle.png", width = 32, height = 32}}
	}, {
		type = "optimized-decorative",
		name = "mark",
		flags = {"placeable-neutral", "not-on-map", "placeable-off-grid"},
		icon = "__m-roguef__/graphics/entity/mark.png",
		icon_size = 32,
		subgroup = "rf_raw",
		order = "b",
		collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
		selection_box = {{-2, -2}, {2, 2}},
		collision_mask = {"object-layer"},
		selectable_in_game = false,
		pictures = {{filename = "__m-roguef__/graphics/entity/mark.png", width = 128, height = 128}}
	}, {
		type = "explosion",
		name = "rf_no",
		flags = {"not-on-map", "placeable-off-grid"},
		animations = {{filename = "__roguef-core__/graphics/empty.png", frame_count = 1, width = 1, height = 1}}
	}, {
		type = "market",
		name = "rf_market",
		icon = "__0_16_graphics_revived__/graphics/icons/market.png",
		icon_size = 32,
		flags = {"placeable-neutral", "player-creation"},
		subgroup = "rf_raw",
		order = "b",
		max_health = 150,
		corpse = "big-remnants",
		collision_box = {{-2.5, -0.7}, {2, 0.7}},
		selection_box = {{-2.5, -0.7}, {2, 0.7}},
		dying_explosion = "explosion",
		render_layer = "object",
		picture = {filename = "__m-roguef__/graphics/entity/console.png", width = 200, height = 114, shift = {0, 0.5}}
	}, {
		type = "simple-entity",
		name = "rf_consol-tuto",
		flags = {"placeable-neutral", "player-creation"},
		icon = "__0_16_graphics_revived__/graphics/icons/market.png",
		icon_size = 32,
		subgroup = "rf_raw",
		order = "b",
		collision_box = {{-2.5, -0.7}, {2, 0.7}},
		selection_box = {{-2.5, -0.7}, {2, 0.7}},
		dying_explosion = "explosion",
		render_layer = "object",
		max_health = 150,
		pictures = {{filename = "__m-roguef__/graphics/entity/console.png", width = 200, height = 114, shift = {0, 0.5}}}
	}, {
		type = "simple-entity",
		name = "rf_consol-stage",
		flags = {"placeable-neutral", "player-creation"},
		icon = "__m-roguef__/graphics/entity/console.png",
		icon_size = 32,
		subgroup = "rf_raw",
		order = "b",
		collision_box = {{-2.5, -0.7}, {2, 0.7}},
		selection_box = {{-2.5, -0.7}, {2, 0.7}},
		dying_explosion = "explosion",
		render_layer = "object",
		max_health = 150,
		pictures = {{filename = "__m-roguef__/graphics/entity/console.png", width = 200, height = 114, shift = {0, 0.5}}}
	}, {
		type = "simple-entity",
		name = "rf_consol-clear",
		flags = {"placeable-neutral", "player-creation"},
		icon = "__0_16_graphics_revived__/graphics/icons/market.png",
		icon_size = 32,
		subgroup = "rf_raw",
		order = "b",
		collision_box = {{-2.5, -0.7}, {2, 0.7}},
		selection_box = {{-2.5, -0.7}, {2, 0.7}},
		dying_explosion = "explosion",
		render_layer = "object",
		max_health = 150,
		pictures = {{filename = "__m-roguef__/graphics/entity/console.png", width = 200, height = 114, shift = {0, 0.5}}}
	}
})
