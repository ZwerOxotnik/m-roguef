local function explosion(name, count, x, y, speed, blend)
	if blend == false then
		return {
			type = "explosion",
			name = name,
			flags = {"not-on-map", "placeable-off-grid"},
			animations = {
				{
					filename = "__m-roguef__/graphics/entity/explosion/" .. name .. ".png",
					frame_count = count,
					width = x,
					height = y,
					animation_speed = speed / 60
				}
			}
		}
	else
		return {
			type = "explosion",
			name = name,
			flags = {"not-on-map", "placeable-off-grid"},
			animations = {
				{
					filename = "__m-roguef__/graphics/entity/explosion/" .. name .. ".png",
					frame_count = count,
					width = x,
					height = y,
					animation_speed = speed / 60,
					blend_mode = "additive"
				}
			}
		}
	end
end

local function projectile(name, count, x, y, speed, blend, accel, sp)
	if blend == false then
		return {
			type = "projectile",
			name = name,
			flags = {"not-on-map", "placeable-off-grid"},
			animation = {
				filename = "__m-roguef__/graphics/entity/explosion/" .. name .. ".png",
				frame_count = count,
				width = x,
				height = y,
				animation_speed = speed / 60
			},
			acceleration = accel,
			speed = sp
		}
	else
		return {
			type = "projectile",
			name = name,
			flags = {"not-on-map", "placeable-off-grid"},
			animation = {
				filename = "__m-roguef__/graphics/entity/explosion/" .. name .. ".png",
				frame_count = count,
				width = x,
				height = y,
				animation_speed = speed / 60,
				blend_mode = "additive"
			},
			acceleration = accel,
			speed = sp
		}
	end
end

for i = 1, 50 do
	data:extend({
		{
			type = "explosion",
			name = "hit-p-" .. i,
			flags = {"not-on-map", "placeable-off-grid"},
			animations = {{filename = "__m-roguef__/graphics/entity/noani/no.png", frame_count = 1, width = 1, height = 1}}
		}
	})
end

data:extend({
	-- explosion  (name,count,x,y,speed,blend)
	explosion("shot-3", 8, 16, 16, 60, false), explosion("shot-13", 8, 16, 16, 60, false),
		explosion("firstaid", 2, 32, 32, 4, true), {
			type = "explosion",
			name = "recall",
			flags = {"not-on-map", "placeable-off-grid"},
			animations = {
				{
					filename = "__m-roguef__/graphics/entity/explosion/recall.png",
					frame_count = 30,
					line_length = 5,
					width = 192,
					height = 192,
					animation_speed = 30 / 60,
					shift = {0, 1},
					blend_mode = "additive",
					scale = 1
				}
			}
		}, {
			type = "explosion",
			name = "target-elec",
			flags = {"not-on-map", "placeable-off-grid"},
			animations = {
				{
					filename = "__m-roguef__/graphics/entity/explosion/target-elec.png",
					frame_count = 8,
					line_length = 2,
					width = 32,
					height = 16,
					animation_speed = 16 / 60,
					shift = {0, 1}
				}
			},
			sound = {
				aggregation = {max_count = 1, remove = true},
				variations = {{filename = "__m-roguef__/sound/target-elec.ogg", volume = 0.3}}
			}
		}, {
			type = "explosion",
			name = "target-elec-1",
			flags = {"not-on-map", "placeable-off-grid"},
			animations = {
				{
					filename = "__m-roguef__/graphics/entity/explosion/target-elec.png",
					frame_count = 8,
					line_length = 2,
					width = 32,
					height = 16,
					animation_speed = 16 / 60,
					shift = {0, 1}
				}
			}
		}, {
			type = "explosion",
			name = "target-melee",
			flags = {"not-on-map", "placeable-off-grid"},
			animations = {
				{
					filename = "__base__/graphics/entity/explosion/explosion-3.png",
					priority = "high",
					line_length = 6,
					width = 52,
					height = 46,
					frame_count = 17,
					animation_speed = 0.5,
					shift = util.by_pixel(-1, 2),
					hr_version = {
						filename = "__base__/graphics/entity/explosion/hr-explosion-3.png",
						priority = "high",
						line_length = 6,
						width = 102,
						height = 88,
						frame_count = 17,
						animation_speed = 0.5,
						shift = util.by_pixel(-1, 1.5),
						scale = 0.5
					}
				}
			},
			sound = {
				aggregation = {max_count = 1, remove = true},
				variations = {{filename = "__m-roguef__/sound/target-melee.ogg", volume = 0.75}}
			}
		}, {
			type = "explosion",
			name = "target-melee-1",
			flags = {"not-on-map", "placeable-off-grid"},
			animations = {
				{
					filename = "__base__/graphics/entity/explosion/explosion-3.png",
					priority = "high",
					line_length = 6,
					width = 52,
					height = 46,
					frame_count = 17,
					animation_speed = 0.5,
					shift = util.by_pixel(-1, 2),
					hr_version = {
						filename = "__base__/graphics/entity/explosion/hr-explosion-3.png",
						priority = "high",
						line_length = 6,
						width = 102,
						height = 88,
						frame_count = 17,
						animation_speed = 0.5,
						shift = util.by_pixel(-1, 1.5),
						scale = 0.5
					}
				}
			},
			sound = {
				aggregation = {max_count = 1, remove = true},
				variations = {{filename = "__m-roguef__/sound/target-melee.ogg", volume = 0.5}}
			}
		}, {
			type = "explosion",
			name = "target-melee-2",
			flags = {"not-on-map", "placeable-off-grid"},
			animations = {
				{
					filename = "__base__/graphics/entity/explosion/explosion-3.png",
					priority = "high",
					line_length = 6,
					width = 52,
					height = 46,
					frame_count = 17,
					animation_speed = 0.5,
					shift = util.by_pixel(-1, 2),
					hr_version = {
						filename = "__base__/graphics/entity/explosion/hr-explosion-3.png",
						priority = "high",
						line_length = 6,
						width = 102,
						height = 88,
						frame_count = 17,
						animation_speed = 0.5,
						shift = util.by_pixel(-1, 1.5),
						scale = 0.5
					}
				}
			},
			sound = {
				aggregation = {max_count = 1, remove = true},
				variations = {{filename = "__m-roguef__/sound/target-melee.ogg", volume = 0.2}}
			}
		}, {
			type = "explosion",
			name = "target-poison",
			flags = {"not-on-map", "placeable-off-grid"},
			animations = {
				{
					filename = "__m-roguef__/graphics/entity/explosion/target-poison.png",
					frame_count = 25,
					line_length = 5,
					width = 64,
					height = 64,
					animation_speed = 50 / 60,
					shift = {0, 1}
				}
			},
			sound = {
				aggregation = {max_count = 1, remove = true},
				variations = {{filename = "__m-roguef__/sound/target-poison.ogg", volume = 0.5}}
			}
		}, {
			type = "explosion",
			name = "target-blood",
			flags = {"not-on-map", "placeable-off-grid"},
			animations = {
				{
					filename = "__m-roguef__/graphics/entity/explosion/target-blood.png",
					frame_count = 25,
					line_length = 5,
					width = 64,
					height = 64,
					animation_speed = 50 / 60,
					shift = {0, 1}
				}
			},
			sound = {
				aggregation = {max_count = 1, remove = true},
				variations = {{filename = "__m-roguef__/sound/target-poison.ogg", volume = 0.5}}
			}
		}, {
			type = "explosion",
			name = "target-water",
			flags = {"not-on-map", "placeable-off-grid"},
			animations = {
				{
					filename = "__m-roguef__/graphics/entity/explosion/target-water.png",
					frame_count = 20,
					line_length = 5,
					width = 64,
					height = 64,
					animation_speed = 50 / 60,
					shift = {0, 1},
					scale = 2
				}
			},
			sound = {
				aggregation = {max_count = 1, remove = true},
				variations = {{filename = "__m-roguef__/sound/target-water.ogg", volume = 0.2}}
			}
		}, {
			type = "explosion",
			name = "target-slash",
			flags = {"not-on-map", "placeable-off-grid"},
			animations = {
				{
					filename = "__m-roguef__/graphics/entity/explosion/target-slash.png",
					frame_count = 10,
					line_length = 5,
					width = 64,
					height = 64,
					animation_speed = 20 / 60,
					shift = {0, 1},
					scale = 2 / 3
				}
			},
			sound = {
				aggregation = {max_count = 1, remove = true},
				variations = {{filename = "__m-roguef__/sound/shot-9.ogg", volume = 0.3}}
			}
		}, {
			type = "explosion",
			name = "slash-22",
			flags = {"not-on-map", "placeable-off-grid"},
			animations = {
				{
					filename = "__m-roguef__/graphics/entity/explosion/slash-22.png",
					frame_count = 30,
					line_length = 5,
					width = 192,
					height = 192,
					animation_speed = 90 / 60,
					shift = {0, 1},
					blend_mode = "additive",
					scale = 2
				}
			}
		}, {
			type = "explosion",
			name = "target-ice",
			flags = {"not-on-map", "placeable-off-grid"},
			animations = {
				{
					filename = "__m-roguef__/graphics/entity/explosion/target-ice.png",
					frame_count = 15,
					line_length = 5,
					width = 64,
					height = 64,
					animation_speed = 90 / 60,
					shift = {0, 1},
					run_mode = "forward-then-backward"
				}
			},
			sound = {
				aggregation = {max_count = 1, remove = true},
				variations = {{filename = "__m-roguef__/sound/target-ice.ogg", volume = 0.5}}
			}
		}, {
			type = "explosion",
			name = "target-fire",
			flags = {"not-on-map", "placeable-off-grid"},
			animations = {
				{
					filename = "__m-roguef__/graphics/entity/explosion/target-fire.png",
					frame_count = 12,
					width = 48,
					height = 48,
					animation_speed = 36 / 60,
					shift = {0, 1}
				}
			},
			sound = {
				aggregation = {max_count = 1, remove = true},
				variations = {{filename = "__m-roguef__/sound/target-fire.ogg", volume = 1}}
			}
		}, {
			type = "explosion",
			name = "target-fire-1",
			flags = {"not-on-map", "placeable-off-grid"},
			animations = {
				{
					filename = "__m-roguef__/graphics/entity/explosion/target-fire.png",
					frame_count = 12,
					width = 48,
					height = 48,
					animation_speed = 36 / 60,
					shift = {0, 1 / 2},
					scale = 1 / 2
				}
			},
			sound = {
				aggregation = {max_count = 1, remove = true},
				variations = {{filename = "__m-roguef__/sound/target-fire.ogg", volume = 0.75}}
			}
		}, {
			type = "explosion",
			name = "explosion",
			flags = {"not-on-map", "placeable-off-grid"},
			animations = {
				{
					filename = "__base__/graphics/entity/explosion/explosion-1.png",
					priority = "high",
					line_length = 6,
					width = 26,
					height = 22,
					frame_count = 17,
					animation_speed = 0.5,
					shift = util.by_pixel(5, 6),
					hr_version = {
						filename = "__base__/graphics/entity/explosion/hr-explosion-1.png",
						priority = "high",
						line_length = 6,
						width = 48,
						height = 42,
						frame_count = 17,
						animation_speed = 0.5,
						shift = util.by_pixel(4.5, 6),
						scale = 0.5
					}
				}, {
					filename = "__base__/graphics/entity/explosion/explosion-2.png",
					priority = "extra-high",
					width = 64,
					height = 57,
					frame_count = 16,
					animation_speed = 0.5,
					shift = {0, 1}
				}, {
					filename = "__base__/graphics/entity/explosion/explosion-3.png",
					priority = "high",
					line_length = 6,
					width = 52,
					height = 46,
					frame_count = 17,
					animation_speed = 0.5,
					shift = util.by_pixel(-1, 2),
					hr_version = {
						filename = "__base__/graphics/entity/explosion/hr-explosion-3.png",
						priority = "high",
						line_length = 6,
						width = 102,
						height = 88,
						frame_count = 17,
						animation_speed = 0.5,
						shift = util.by_pixel(-1, 1.5),
						scale = 0.5
					}
				}, {
					filename = "__base__/graphics/entity/explosion/explosion-4.png",
					priority = "extra-high",
					width = 64,
					height = 51,
					frame_count = 16,
					animation_speed = 0.5,
					shift = {0, 1}
				}
			},
			light = {intensity = 1, size = 20},
			smoke = "smoke-fast",
			smoke_count = 2,
			smoke_slow_down_factor = 1,
			sound = {
				aggregation = {max_count = 1, remove = true},
				variations = {
					{
						filename = "__base__/sound/fight/medium-explosion-1.ogg", -- TODO: change this",
						volume = 0.75
					}, {
						filename = "__base__/sound/fight/medium-explosion-2.ogg", -- TODO: change this
						volume = 0.75
					}
				}
			}
		}, {
			type = "explosion",
			name = "explosion-1",
			flags = {"not-on-map", "placeable-off-grid"},
			animations = {
				{
					filename = "__base__/graphics/entity/explosion/explosion-1.png",
					priority = "high",
					line_length = 6,
					width = 26,
					height = 22,
					frame_count = 17,
					animation_speed = 0.5,
					shift = util.by_pixel(5, 6),
					hr_version = {
						filename = "__base__/graphics/entity/explosion/hr-explosion-1.png",
						priority = "high",
						line_length = 6,
						width = 48,
						height = 42,
						frame_count = 17,
						animation_speed = 0.5,
						shift = util.by_pixel(4.5, 6),
						scale = 0.5
					}
				}, {
					filename = "__base__/graphics/entity/explosion/explosion-2.png",
					priority = "extra-high",
					width = 64,
					height = 57,
					frame_count = 16,
					animation_speed = 0.5,
					shift = {0, 1}
				}, {
					filename = "__base__/graphics/entity/explosion/explosion-3.png",
					priority = "high",
					line_length = 6,
					width = 52,
					height = 46,
					frame_count = 17,
					animation_speed = 0.5,
					shift = util.by_pixel(-1, 2),
					hr_version = {
						filename = "__base__/graphics/entity/explosion/hr-explosion-3.png",
						priority = "high",
						line_length = 6,
						width = 102,
						height = 88,
						frame_count = 17,
						animation_speed = 0.5,
						shift = util.by_pixel(-1, 1.5),
						scale = 0.5
					}
				}, {
					filename = "__base__/graphics/entity/explosion/explosion-4.png",
					priority = "extra-high",
					width = 64,
					height = 51,
					frame_count = 16,
					animation_speed = 0.5,
					shift = {0, 1}
				}
			},
			light = {intensity = 1, size = 20},
			smoke = "smoke-fast",
			smoke_count = 2,
			smoke_slow_down_factor = 1,
			sound = {
				aggregation = {max_count = 1, remove = true},
				variations = {
					{
						filename = "__base__/sound/fight/medium-explosion-1.ogg", -- TODO: change this",
						volume = 0.25
					}, {
						filename = "__base__/sound/fight/medium-explosion-2.ogg", -- TODO: change this
						volume = 0.25
					}
				}
			}
		}, -- TODO: CHECK THIS!!!
		{
			type = "explosion",
			name = "noani",
			flags = {"not-on-map", "placeable-off-grid"},
			animations = {{filename = "__m-roguef__/graphics/entity/noani/no.png", frame_count = 1, width = 1, height = 1}}
		}, {
			type = "explosion",
			name = "emp",
			flags = {"not-on-map", "placeable-off-grid"},
			animations = {
				{
					filename = "__m-roguef__/graphics/entity/explosion/emp.png",
					frame_count = 24,
					line_length = 8,
					width = 128,
					height = 128,
					blend_mode = "additive",
					animation_speed = 96 / 60,
					scale = 5
				}
			}
		}

})

for i = 32, 256, 32 do
	data:extend({
		{
			type = "optimized-decorative",
			name = "ex-" .. i,
			flags = {"placeable-enemy", "not-on-map", "placeable-off-grid"},
			icon = "__m-roguef__/graphics/entity/explosion/ex.png",
			icon_size = 32,
			subgroup = "rf_enemy",
			order = "z",
			-- collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
			selection_box = {{-0.5 * i / 32, -0.5 * i / 32}, {0.5 * i / 32, 0.5 * i / 32}},
			collision_mask = {"object-layer"},
			selectable_in_game = false,
			pictures = {{filename = "__m-roguef__/graphics/entity/explosion/ex-" .. i .. ".png", width = i, height = i}}
		}, {
			type = "explosion",
			name = "explosion-" .. i,
			flags = {"not-on-map", "placeable-off-grid"},
			animations = {
				{
					filename = "__m-roguef__/graphics/entity/explosion/explosion.png",
					priority = "extra-high",
					width = 40,
					height = 40,
					shift = {0, 1},
					frame_count = 12,
					animation_speed = 24 / 60,
					scale = i / 32
				}
			},
			sound = {
				aggregation = {max_count = 1, remove = true},
				variations = {
					{
						filename = "__base__/sound/fight/medium-explosion-1.ogg", -- TODO: change this",
						volume = 0.5
					}, {
						filename = "__base__/sound/fight/medium-explosion-2.ogg", -- TODO: change this
						volume = 0.5
					}
				}
			}
		}
	})
end

data:extend({
	{
		type = "explosion",
		name = "player-fire",
		flags = {"not-on-map", "placeable-off-grid"},
		animations = {{filename = "__m-roguef__/graphics/entity/noani/no.png", frame_count = 1, width = 1, height = 1}}
	}, {
		type = "explosion",
		name = "hit-p",
		flags = {"not-on-map", "placeable-off-grid"},
		animations = {{filename = "__m-roguef__/graphics/entity/noani/no.png", frame_count = 1, width = 1, height = 1}}
	}, {
		type = "explosion",
		name = "hit-p-16-1",
		flags = {"not-on-map", "placeable-off-grid"},
		animations = {{filename = "__m-roguef__/graphics/entity/noani/no.png", frame_count = 1, width = 1, height = 1}}
	}, {
		type = "explosion",
		name = "hit-p-16-2",
		flags = {"not-on-map", "placeable-off-grid"},
		animations = {{filename = "__m-roguef__/graphics/entity/noani/no.png", frame_count = 1, width = 1, height = 1}}
	}, {
		type = "explosion",
		name = "hit-p-16-3",
		flags = {"not-on-map", "placeable-off-grid"},
		animations = {{filename = "__m-roguef__/graphics/entity/noani/no.png", frame_count = 1, width = 1, height = 1}}
	}, {
		type = "explosion",
		name = "big-explosion-1",
		flags = {"not-on-map"},
		animations = {
			{
				filename = "__base__/graphics/entity/big-explosion/big-explosion.png",
				priority = "extra-high",
				flags = {"compressed"},
				width = 197,
				height = 245,
				frame_count = 47,
				line_length = 6,
				axially_symmetrical = false,
				direction_count = 1,
				shift = {0.1875, -0.75},
				animation_speed = 0.5,
				scale = 2
			}
		},
		light = {intensity = 1, size = 50},
		sound = {
			aggregation = {max_count = 1, remove = true},
			variations = {
				{filename = "__base__/sound/fight/large-explosion-1.ogg", volume = 1.0},
					{filename = "__base__/sound/fight/large-explosion-2.ogg", volume = 1.0}
			}
		},
		created_effect = {
			type = "direct",
			action_delivery = {
				type = "instant",
				target_effects = {
					{
						type = "create-particle",
						repeat_count = 20,
						entity_name = "explosion-remnants-particle",
						particle_name = "spark-particle", -- TODO: check
						initial_height = 0.5,
						speed_from_center = 0.08,
						speed_from_center_deviation = 0.15,
						initial_vertical_speed = 0.08,
						initial_vertical_speed_deviation = 0.15,
						offset_deviation = {{-0.2, -0.2}, {0.2, 0.2}}
					}
				}
			}
		}
	}, {
		type = "projectile",
		name = "13-1",
		flags = {"not-on-map", "placeable-off-grid"},
		collision_box = {{-0.2, -0.2}, {0.2, 0.2}},
		acceleration = 0,
		direction_only = true,
		action = {
			type = "direct",
			action_delivery = {
				type = "instant",
				target_effects = {
					{type = "damage", damage = {amount = 5, type = "damage-player"}},
						{type = "create-entity", entity_name = "target-ice"}
				}
			}
		},
		animation = {
			filename = "__m-roguef__/graphics/entity/explosion/13-1.png",
			frame_count = 1,
			width = 15,
			height = 20,
			priority = "high",
			blend_mode = "additive",
			scale = 0.5
			-- animation_speed = 10/60
		}
	}, {
		type = "projectile",
		name = "13-2",
		flags = {"not-on-map", "placeable-off-grid"},
		collision_box = {{-0.3, -0.3}, {0.3, 0.3}},
		acceleration = 0,
		direction_only = true,
		action = {
			type = "direct",
			action_delivery = {
				type = "instant",
				target_effects = {
					{type = "damage", damage = {amount = 50, type = "damage-player"}},
						{type = "create-entity", entity_name = "target-ice"}
				}
			}
		},
		animation = {
			filename = "__m-roguef__/graphics/entity/explosion/13-1.png",
			frame_count = 1,
			width = 15,
			height = 20,
			priority = "high",
			blend_mode = "additive"
			-- animation_speed = 10/60
		}
	}, {
		type = "projectile",
		name = "13-3",
		flags = {"not-on-map", "placeable-off-grid"},
		collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
		acceleration = 0,
		direction_only = true,
		action = {
			type = "direct",
			action_delivery = {
				type = "instant",
				target_effects = {
					{type = "damage", damage = {amount = 120, type = "damage-player"}},
						{type = "create-entity", entity_name = "target-ice"}
				}
			}
		},
		animation = {
			filename = "__m-roguef__/graphics/entity/explosion/13-1.png",
			frame_count = 1,
			width = 15,
			height = 20,
			priority = "high",
			blend_mode = "additive",
			-- animation_speed = 10/60
			scale = 1.5
		}
	}, {
		type = "projectile",
		name = "13-4",
		flags = {"not-on-map", "placeable-off-grid"},
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		action = {
			type = "direct",
			action_delivery = {
				type = "instant",
				target_effects = {
					{type = "damage", damage = {amount = 200, type = "damage-player"}},
						{type = "create-entity", entity_name = "target-ice"}
				}
			}
		},
		animation = {
			filename = "__m-roguef__/graphics/entity/explosion/13-2.png",
			frame_count = 2,
			width = 30,
			height = 31,
			priority = "high",
			blend_mode = "additive",
			animation_speed = 1,
			scale = 2
		}
	}, {
		type = "explosion",
		name = "explosion-14",
		flags = {"not-on-map", "placeable-off-grid"},
		animations = {
			{
				filename = "__base__/graphics/entity/explosion/explosion-1.png",
				priority = "high",
				line_length = 6,
				width = 26,
				height = 22,
				frame_count = 17,
				animation_speed = 0.5,
				shift = util.by_pixel(5, 6),
				hr_version = {
					filename = "__base__/graphics/entity/explosion/hr-explosion-1.png",
					priority = "high",
					line_length = 6,
					width = 48,
					height = 42,
					frame_count = 17,
					animation_speed = 0.5,
					shift = util.by_pixel(4.5, 6),
					scale = 0.5
				}
			}, {
				filename = "__base__/graphics/entity/explosion/explosion-2.png",
				priority = "extra-high",
				width = 64,
				height = 57,
				frame_count = 16,
				animation_speed = 0.5
			}, {
				filename = "__base__/graphics/entity/explosion/explosion-3.png",
				priority = "high",
				line_length = 6,
				width = 52,
				height = 46,
				frame_count = 17,
				animation_speed = 0.5,
				shift = util.by_pixel(-1, 2),
				hr_version = {
					filename = "__base__/graphics/entity/explosion/hr-explosion-3.png",
					priority = "high",
					line_length = 6,
					width = 102,
					height = 88,
					frame_count = 17,
					animation_speed = 0.5,
					shift = util.by_pixel(-1, 1.5),
					scale = 0.5
				}
			}, {
				filename = "__base__/graphics/entity/explosion/explosion-4.png",
				priority = "extra-high",
				width = 64,
				height = 51,
				frame_count = 16,
				animation_speed = 0.5
			}
		},
		created_effect = {
			type = "area",
			radius = 2,
			action_delivery = {
				type = "instant",
				target_effects = {{type = "damage", damage = {amount = 15, type = "damage-player"}}}
			}
		},
		light = {intensity = 1, size = 20},
		smoke = "smoke-fast",
		smoke_count = 2,
		smoke_slow_down_factor = 1
	}
})

