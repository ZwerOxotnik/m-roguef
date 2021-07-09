require ("prototypes.entity.demo-gunshot-sounds")
data.raw["explosion"]["explosion-gunshot"].flags = {"not-on-map","placeable-off-grid"}

--weapon
function weapon(n,cooldown,range,sound)
	if sound==nil then
		sound=make_light_gunshot_sounds()
	end

	return {
		type = "gun",
		name = "weapon-"..n,
		localised_name = {"weapon-name."..n},
		localised_description = {"weapon-info."..n},
		icon = "__m-roguef__/graphics/icons/weapon/"..n..".png",
		icon_size = 32,
		flags = {},
		subgroup = "rf_weapon",
		order = "a",
		attack_parameters =
		{
			type = "projectile",
			ammo_category = "ammo-"..n,
			cooldown = cooldown,
			movement_slow_down_cooldown =cooldown,
			movement_slow_down_factor = 0,
			projectile_creation_distance = 0.8,
			range = range,
			sound = sound
		},
		stack_size = 1
	}
end

data:extend(
{
	--point=dps*range*FACTOR
	weapon(1,15,30),--62.4
	weapon(2,60,15,{{filename = "__base__/sound/pump-shotgun.ogg",volume = 0.4}}),--80.5
	weapon(3,4,20,{{filename = "__m-roguef__/sound/target-elec.ogg",volume = 0.2}}),--86.4
	weapon(4,60,30,{{filename = "__base__/sound/fight/rocket-launcher.ogg",volume = 0.7}}),--85.8
	weapon(5,60,30,{{filename = "__m-roguef__/sound/shot-5.ogg",volume = 0.5}}),--80
	weapon(6,1,30,{{filename = "__base__/sound/fight/light-gunshot-1.ogg",volume = 0.2}}),--78
	weapon(7,12,20),--78
	weapon(8,15,30,{{filename = "__base__/sound/walking/dirt-03.ogg",volume = 0.7}}),--78
	weapon(9,25,30,{{filename = "__m-roguef__/sound/shot-9.ogg",volume = 0.5}}),--78
	weapon(10,180,30,{{filename = "__m-roguef__/sound/firecast.ogg",volume = 1}}),--83.33
	weapon(11,60,20,{{filename = "__m-roguef__/sound/shot-11.ogg",volume = 0.7}}),--86.4
	weapon(12,30,30,{{filename = "__m-roguef__/sound/shot-12.ogg",volume = 0.5}}),--93.6
	weapon(13,6,30,{{filename = "__m-roguef__/sound/shot-12.ogg",volume = 0}}),--81
	weapon(14,30,20),--79.2
	weapon(15,15,30),--78
	weapon(16,30,30,{{filename = "__m-roguef__/sound/target-elec.ogg",volume = 0.5}}),--78
	weapon(17,15,30),--85.8
	weapon(18,10,30,{{filename = "__base__/sound/fight/light-gunshot-1.ogg",volume = 0.2}}),--75.82
	weapon(19,10,30,{{filename = "__base__/sound/walking/dirt-03.ogg",volume = 0.5}}),--83.2
	weapon(20,60,30,{{filename = "__m-roguef__/sound/get.ogg",volume = 0.5}}),--104
	{--weapon 21,1,30 --78
		type = "gun",
		name = "weapon-21",
		localised_name = {"weapon-name.21"},
		localised_description = {"weapon-info.21"},
		icon = "__m-roguef__/graphics/icons/weapon/21.png",
		icon_size = 32,
		flags = {},
		subgroup = "rf_weapon",
		order = "a",
		attack_parameters =
	 {
			type = "stream",
			ammo_category = "ammo-21",
			cooldown = 1,
			movement_slow_down_factor = 0,
			projectile_creation_distance = 0.6,
			gun_barrel_length = 0.8,
			gun_center_shift = { 0, -1 },
			range = 30,
			min_range = 1,
			cyclic_sound =
			{
				begin_sound =
				{
					{
						filename = "__base__/sound/fight/flamethrower-start.ogg",
						volume = 0
					}
				},
				middle_sound =
				{
					{
						filename = "__m-roguef__/sound/shot-21.ogg",
						volume = 0.5
					}
				},
				end_sound =
				{
					{
						filename = "__base__/sound/fight/flamethrower-end.ogg",
						volume = 0
					}
				}
			}
		},
		stack_size = 1
	},

weapon(22,30,0,{{filename = "__m-roguef__/sound/shot-9.ogg",volume = 0.5}}),--84.7
weapon(23,12,30,{{filename = "__base__/sound/fight/light-gunshot-1.ogg",volume = 0.2}}),--93.6
weapon(24,20,30),--78
weapon(25,120,30),--90
weapon(26,6,15,{{filename = "__base__/sound/pump-shotgun.ogg",volume = 0.2}}),--92
weapon(27,15,30),--83.2
	{--weapon 28,60,30 --94.38
		type = "gun",
		name = "weapon-28",
		localised_name = {"weapon-name.28"},
		localised_description = {"weapon-info.28"},
		icon = "__m-roguef__/graphics/icons/weapon/28.png",
		icon_size = 32,
		flags = {},
		subgroup = "rf_weapon",
		order = "a",
		attack_parameters =
	 {
			type = "stream",
			ammo_category = "ammo-28",
			cooldown = 60,
			movement_slow_down_factor = 0,
			projectile_creation_distance = 0.6,
			gun_barrel_length = 0.8,
			gun_center_shift = { 0, -1 },
			range = 30,
			min_range = 1,
			sound={{filename = "__m-roguef__/sound/shot-5.ogg",volume = 0.5}}
		},
		stack_size = 1
	},
weapon(29,60,20,{{filename = "__m-roguef__/sound/icecast.ogg",volume = 1}}),--86.4
	})

--ammo  (n,target_type(entity,position,direction),source(shot effect),
function ammo(n,target,source,e)
return{
		type = "ammo",
		name = "ammo-"..n,
		localised_name = " ",
		icon = "__0_16_graphics__/graphics/icons/firearm-magazine.png",
		icon_size = 32,
		flags = {},
		subgroup = "rf_ammo",
		order = "a",
		ammo_type =
	 {
			category = "ammo-"..n,
			target_type = target,
			clamp_position=true,
			action =
			{
				{
					type = "direct",
					action_delivery =
					{
						type = "instant",
						source_effects =
						{
							{
								type = "create-explosion",
								entity_name = source
							},
					{
					 type = "create-entity",
					 entity_name = "player-fire",
					 trigger_created_entity="true"
					}
						}
					}
				},
			e
			}
		},
		magazine_size = 1000000,
		stack_size = 1000
	}
end

data:extend(
{

ammo(1,"direction","explosion-gunshot",
	{
	 type = "direct",
	 --repeat_count = 1,
	 action_delivery =
	 {
		type = "projectile",
		projectile = "p-1",
		starting_speed = 0.5,
		direction_deviation = 0.2,
		range_deviation = 0.2,
		max_range = 30
	 }
	}),

ammo(2,"direction","explosion-gunshot",
	{
	 type = "direct",
	 repeat_count = 10,
	 action_delivery =
	 {
		type = "projectile",
		projectile = "p-2",
		starting_speed = 1,
		direction_deviation = 0.6,
		range_deviation = 0.6,
		max_range = 15
	 }
	}),

ammo(3,"direction","shot-3",
	{
	 type = "line",
	 range=20,
	 width=0.5,
	 --repeat_count = 1,
	 source_effects =
		{
		 type = "create-explosion",
		 entity_name = "beam-3"
		},
	 action_delivery =
	 {
		type="instant",
		target_effects=
		{
			{
			 type = "damage",
			 damage = {amount=4,type="damage-player"}
			},
			{
			 type = "create-entity",
			 entity_name = "target-elec-1"
 			 },
		},
		--starting_speed = 0.1,
		--direction_deviation = 0.3,
		--range_deviation = 0.3,
	 }
	}),

	{
		type = "explosion",
		name = "beam-3",
		flags = {"not-on-map"},
		animation_speed = 3,
		rotate = true,
		beam = true,
		animations =
		{
			{
				filename = "__m-roguef__/graphics/entity/explosion/beam-3.png",
				priority = "extra-high",
				width = 62,
				height = 1,
				frame_count = 6,
			}
		},
		light = {intensity = 1, size = 10},
		smoke = "smoke-fast",
		smoke_count = 2,
		smoke_slow_down_factor = 1
	},

ammo(4,"direction","explosion-hit",
	{
	 type = "direct",
	 --repeat_count = 1,
	 action_delivery =
		{
			type = "projectile",
			projectile = "p-4",
			starting_speed = 0.1,
			max_range=30,
		},
		--starting_speed = 0.1,
		--direction_deviation = 0.3,
		--range_deviation = 0.3,
	}),

ammo(5,"direction","explosion-hit",
	{
	 type = "direct",
	 --repeat_count = 1,
	 action_delivery =
		{
		 type = "projectile",
		 projectile = "p-5",
		 starting_speed = 0.4,
		 max_range=30,
		},
		--starting_speed = 0.1,
		--direction_deviation = 0.3,
		--range_deviation = 0.3,
	}),

	ammo(6,"direction","explosion-gunshot",
	{
	 type = "direct",
	 --repeat_count = 1,
	 action_delivery =
	 {
		type = "projectile",
		projectile = "p-6",
		starting_speed = 0.7,
		direction_deviation = 0.3,
		range_deviation = 0.3,
		max_range = 30
	 }
	}),

	ammo(7,"direction","explosion-gunshot",
	{
	 type = "direct",
	 --repeat_count = 1,
	 action_delivery =
	 {
		type = "projectile",
		projectile = "p-7",
		starting_speed = 0.5,
		--direction_deviation = 0.3,
		--range_deviation = 0.3,
		max_range = 20
	 }
	}),

	ammo(8,"direction","explosion-gunshot",
	{
	 type = "direct",
	 --repeat_count = 1,
	 action_delivery =
	 {
		type = "projectile",
		projectile = "p-8",
		starting_speed = 0.5,
		--direction_deviation = 0.3,
		--range_deviation = 0.3,
		max_range = 30
	 }
	}),

	ammo(9,"direction","explosion-gunshot",
	{
	 type = "direct",
	 --repeat_count = 1,
	 action_delivery =
	 {
		type = "projectile",
		projectile = "p-9",
		starting_speed = 0.5,
		--direction_deviation = 0.3,
		--range_deviation = 0.3,
		max_range = 30
	 }
	}),

	{
		type = "ammo",
		name = "ammo-10",
		localised_name = " ",
		icon = "__0_16_graphics__/graphics/icons/firearm-magazine.png",
		icon_size = 32,
		flags = {},
		subgroup = "rf_ammo",
		order = "a",
		ammo_type =
		{
			category = "ammo-10",
			target_type = "position",
			clamp_position=false,
			action =
			{
				{
					type = "direct",
					action_delivery =
					{
						type = "instant",
						source_effects =
						{
							{
								type = "create-explosion",
								entity_name = "explosion-gunshot"
							},
							{
								type = "create-entity",
								entity_name = "player-fire",
								trigger_created_entity="true"
							}
						}
					}
				},
			{
			 type = "direct",
			 --repeat_count = 1,
			 action_delivery =
			 {
					type = "projectile",
					projectile = "p-10",
					starting_speed = 3,
					--direction_deviation = 0.3,
					--range_deviation = 0.3,
					max_range = 30
				}
			}
		}
		},
		magazine_size = 1000000,
		stack_size = 1000
	},

ammo(11,"entity","explosion-hit",
	{
		type = "direct",
		--repeat_count = 1,
		action_delivery =
		{
			type = "projectile",
			projectile = "p-11",
			starting_speed = 0.3,
			--direction_deviation = 0.3,
			--range_deviation = 0.3,
			max_range = 20
		}
	}),

	ammo(12,"direction","explosion-gunshot",
	{
		type = "direct",
		--repeat_count = 1,
		action_delivery =
		{
			type = "projectile",
			projectile = "p-12",
			starting_speed = 0.7,
			--direction_deviation = 0.3,
			--range_deviation = 0.3,
			max_range = 30
		}
	}),
	ammo(13,"direction","shot-13"),
	ammo(14,"direction","explosion-gunshot",
	{
		type = "direct",
		--repeat_count = 1,
		action_delivery =
		{
			type = "projectile",
			projectile = "p-14",
			starting_speed = 1000,
			--direction_deviation = 0.2,
			--range_deviation = 0.2,
			--max_range = 30
		}
	}),
	ammo(15,"direction","explosion-gunshot",
	{
	 type = "direct",
	 --repeat_count = 1,
	 action_delivery =
	 {
		type = "projectile",
		projectile = "p-15",
		starting_speed = 0.5,
		max_range = 30
	 }
	}),
ammo(16,"direction","explosion-gunshot",
	{
	 type = "direct",
	 --repeat_count = 1,
	 action_delivery =
	 {
		type = "projectile",
		projectile = "p-16",
		starting_speed = 0.5,
		max_range = 30
	 }
	}),
ammo(17,"direction","explosion-gunshot",
	{
	 type = "direct",
	 --repeat_count = 1,
	 action_delivery =
	 {
		type = "projectile",
		projectile = "p-17",
		starting_speed = 0.5,
		max_range = 30
	 }
	}),
ammo(18,"direction","explosion-gunshot",
	{
	 type = "direct",
	 --repeat_count = 1,
	 action_delivery =
	 {
		type = "projectile",
		projectile = "p-18",
		starting_speed = 0.5,
		direction_deviation = 0.4,
		range_deviation = 0.4,
		max_range = 30
	 }
	}),
ammo(19,"direction","explosion-gunshot",
	{
	 type = "direct",
	 --repeat_count = 1,
	 action_delivery =
	 {
		type = "projectile",
		projectile = "p-19",
		starting_speed = 0.5,
		max_range = 30
	 }
	}),
ammo(20,"direction","explosion-gunshot",
	{
	 type = "direct",
	 --repeat_count = 1,
	 action_delivery =
	 {
		type = "projectile",
		projectile = "p-20",
		starting_speed = 1000,
		max_range = 30
	 }
	}),
ammo(21,"position","explosion-gunshot",
	{
	 type = "direct",
	 --repeat_count = 1,
	 action_delivery =
	 {
		type = "stream",
		stream="p-21",
		max_range = 30,
		duration=160
	 }
	}),
ammo(22,"position","slash-22",
	{
	 type = "direct",
	 --repeat_count = 1,
	 action_delivery =
	 {
		type = "projectile",
		projectile = "p-22",
		starting_speed = 1,
		max_range = 0
	 }
	}),
ammo(23,"direction","explosion-gunshot"),
ammo(24,"direction","explosion-gunshot",
	{
	 type = "direct",
	 --repeat_count = 1,
	 action_delivery =
	 {
		type = "projectile",
		projectile = "p-24",
		starting_speed = 1000,
		max_range = 30
	 }
	}),
ammo(25,"direction","explosion-gunshot",
	{
	 type = "direct",
	 --repeat_count = 1,
	 action_delivery =
	 {
		type = "projectile",
		projectile = "p-25",
		starting_speed = 1000,
		max_range = 30
	 }
	}),
ammo(26,"direction","explosion-gunshot",
	{
	 type = "direct",
	 repeat_count = 8,
	 action_delivery =
	 {
		type = "projectile",
		projectile = "p-26",
		starting_speed = 1,
		direction_deviation = 0.5,
		range_deviation = 0.5,
		max_range = 15
	 }
	}),
ammo(27,"direction","explosion-gunshot",
	{
	 type = "direct",
	 repeat_count = 2,
	 action_delivery =
	 {
		type = "projectile",
		projectile = "p-27",
		starting_speed = 0.5,
		direction_deviation = 0.2,
		range_deviation = 0.2,
		max_range = 30
	 }
	}),
ammo(28,"position","shot-5-sound",
	{
	 type = "direct",
	 --repeat_count = 1,
	 action_delivery =
	 {
		type = "stream",
		stream = "p-28",
		max_range = 30
	 }
	}),
ammo(29,"direction","explosion-gunshot",
	{
	 type = "direct",
	 --repeat_count = 1,
	 action_delivery =
	 {
		type = "projectile",
		projectile = "p-29",
		starting_speed = 1000,
		max_range = 20
	 }
	}),
	})

--projectile
data:extend(
{
	{
		type = "projectile",
		name = "p-1",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
			{
				{
				 type = "damage",
				 damage = {amount = 12, type = "damage-player"}
				},
				{
				 type = "create-entity",
				 entity_name = "target-melee-1"
				},
				{
				 type = "create-entity",
				 entity_name = "hit-p",
				 trigger_created_entity="true"
				}
			}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-1.png",
			frame_count = 4,
			width = 16,
			height = 16,
			priority = "high",
		blend_mode = "additive",
		animation_speed = 10/60
		},
	},
	{
		type = "projectile",
		name = "p-2",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
			{
				{
				 type = "damage",
				 damage = {amount = 7, type = "damage-player"}
				},
				{
				 type = "create-entity",
				 entity_name = "target-melee-1"
				},
			}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-2.png",
			frame_count = 1,
			width = 16,
			height = 16,
			priority = "high",
		blend_mode = "additive",
		--animation_speed = 15/60
		},
	},

	{
		type = "projectile",
		name = "p-4",
		flags = {"not-on-map","placeable-off-grid"},
	 collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 1/30,
	 direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "create-entity",
						entity_name = "explosion"
					},
					{
						type = "nested-result",
						action =
						{
							type = "area",
							radius = 2,
							action_delivery =
							{
								type = "instant",
								target_effects =
								{
									{
										type = "damage",
										damage = {amount = 60, type = "damage-player"}
									},
									{
										type = "create-entity",
										entity_name = "target-melee-1"
									}
								}
							}
						},
					}
				}
			}
		},
		light = {intensity = 0.5, size = 4},
		animation =
		{
			filename = "__base__/graphics/entity/rocket/rocket.png",
			frame_count = 8,
			line_length = 8,
			width = 9,
			height = 35,
			shift = {0, 0},
			priority = "high"
		},
		shadow =
		{
			filename = "__base__/graphics/entity/rocket/rocket-shadow.png",
			frame_count = 1,
			width = 7,
			height = 24,
			priority = "high",
			shift = {0, 0}
		},
		smoke =
		{
			{
				name = "smoke-fast",
				deviation = {0.15, 0.15},
				frequency = 1,
				position = {0, -1},
				slow_down_factor = 1,
				starting_frame = 3,
				starting_frame_deviation = 5,
				starting_frame_speed = 0,
				starting_frame_speed_deviation = 5
			}
		}
	},

	{
		type = "projectile",
		name = "p-5",
		flags = {"not-on-map","placeable-off-grid"},
		acceleration = 0,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "create-entity",
						entity_name = "explosion-128"
					},
					{
						type = "create-entity",
						entity_name = "blaze-5"
					},
					{
						type = "nested-result",
						action =
						{
							type = "area",
							radius = 2,
							action_delivery =
							{
								type = "instant",
								target_effects =
								{
									{
										type = "damage",
										damage = {amount = 20, type = "damage-player"}
									},
									{
										type = "create-entity",
										entity_name = "target-fire-1"
									}
								}
							}
						},
					}
				}
			}
		},
		light = {intensity = 0.5, size = 4},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-5.png",
			frame_count = 1,
			--line_length = 8,
			width = 32,
			height = 32,
			shift = {0, 0},
			priority = "high"
		},
		smoke =
		{
			{
				name = "smoke-fast",
				deviation = {0.15, 0.15},
				frequency = 1,
				position = {0, -1},
				slow_down_factor = 1,
				starting_frame = 3,
				starting_frame_deviation = 5,
				starting_frame_speed = 0,
				starting_frame_speed_deviation = 5
			}
		}
	},

	{
		type = "fire",
		name = "blaze-5",
		flags = {"placeable-off-grid", "not-on-map"},
		duration = 120,
		fade_away_duration = 120,
		spread_duration = 120,
		start_scale = 1,
		end_scale = 0.01,
		color = {r=1, g=0.9, b=0, a=0.5},
		damage_per_tick = {amount = 1/2, type = "damage-player"},
		-- spawn_entity = "noani",
		spread_delay = 300,
		spread_delay_deviation = 180,
		maximum_spread_count = 100,
		initial_lifetime = 120,
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

		pictures =
		{ {
			filename = "__m-roguef__/graphics/entity/explosion/blaze.png",
			line_length = 8,
			width = 30,
			height = 59,
			frame_count = 25,
			axially_symmetrical = false,
			direction_count = 1,
			blend_mode = fire_blend_mode,
			animation_speed = fire_animation_speed,
			scale = 2,
			tint = fire_tint,
			flags = fire_flags,
			shift = { -0.0390625/2*2, -0.90625/2*2 }
		 }},
		light = {intensity = 1, size = 20},
		working_sound =
		{
		 sound = { filename = "__base__/sound/furnace.ogg" },
		 max_sounds_per_type = 3
		},
	},

	{
		type = "projectile",
		name = "p-6",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.3, -0.3}, {0.3, 0.3}},
		acceleration = 0,
		direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "damage",
						damage = {amount = 1, type = "damage-player"}
					},
					{
						type = "create-entity",
						entity_name = "target-melee-2"
					},
				}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-6.png",
			frame_count = 4,
			width = 16,
			height = 16,
			priority = "high",
			blend_mode = "additive",
			animation_speed = 30/60
		},
	},
	{
		type = "projectile",
		name = "p-7",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		action =
		{
		 {
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
					 type = "damage",
					 damage = {amount = 10, type = "damage-player"}
					},
					{
					 type = "create-entity",
					 entity_name = "target-melee-1"
					},
				}
			}
		 },
		 {
				type = "cluster",
				cluster_count = 20,
				distance = 4,
				distance_deviation = 3,
				action_delivery =
				{
					type = "projectile",
					projectile = "p-6",
					direction_deviation = 0.6,
					starting_speed = 0.25,
					starting_speed_deviation = 0.3,
					max_range=5
				}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-7.png",
			frame_count = 1,
			width = 19,
			height = 18,
			priority = "high",
			blend_mode = "additive",
			--animation_speed = 30/60
		},
	},

	{
		type = "projectile",
		name = "p-8",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		action =
		{
		 {
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
					 type = "damage",
					 damage = {amount = 8, type = "damage-player"}
					},
					{
					 type = "create-entity",
					 entity_name = "target-poison"
					},
					{
					 type = "create-entity",
					 entity_name = "cloud-8"
					}
				}
			}
		 },
	 },
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-8.png",
			frame_count = 32,
			line_length = 8,
			width = 64,
			height = 64,
			priority = "high",
			blend_mode = "additive",
			animation_speed = 32/60,
			scale=1/2
		},
	},

	{
		type = "smoke-with-trigger",
		name = "cloud-8",
		flags = {"not-on-map","placeable-off-grid"},
		show_when_smoke_off = true,
		animation =
		{
			filename = "__base__/graphics/entity/cloud/cloud-45-frames.png",
			flags = { "compressed" },
			priority = "low",
			width = 256,
			height = 256,
			frame_count = 45,
			animation_speed = 0.5,
			line_length = 7,
			scale = 3/3,
		},
		slow_down_factor = 0,
		affected_by_wind = false,
		cyclic = true,
		duration = 60 * 1,
		fade_away_duration = 1 * 15,
		spread_duration = 10,
		color = { r = 0.2, g = 0.9, b = 0.2 , a=1},
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					type = "nested-result",
					action =
					{
						type = "area",
						radius = 11/3,
						--entity_flags = {"breaths-air"},
						action_delivery =
						{
							type = "instant",
							target_effects =
							{
								type = "damage",
								damage = { amount = 9/6, type = "damage-player"}
							}
						}
					}
				}
			}
		},
		action_frequency = 10
	},

	{
		type = "projectile",
		name = "p-9",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		action =
		{
		 {
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
					 type = "damage",
					 damage = {amount = 20, type = "damage-player"}
					},
					{
					 type = "create-entity",
					 entity_name = "target-slash"
					},
				}
			}
		 },
		 {
		 type = "direct",
		 --repeat_count = 1,
		 action_delivery =
		 {
			type = "projectile",
			projectile = "p-99",
			starting_speed = 0.5,
			--direction_deviation = 0.3,
			--range_deviation = 0.3,
			max_range = 30
		 }
		 }
	 },
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-9.png",
			frame_count = 1,
		--line_length = 8,
			width = 16,
			height = 64,
			priority = "high",
		--blend_mode = "additive",
		--animation_speed = 32/60,
		--scale=1/2
		},
	},
	{
		type = "projectile",
		name = "p-99",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.3, -0.3}, {0.3, 0.3}},
		acceleration = 0,
		direction_only = true,
		action =
		{
		 {
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
					 type = "damage",
					 damage = {amount = 10, type = "damage-player"}
					},
					{
					 type = "create-entity",
					 entity_name = "target-slash"
					},
				}
			}
		 },
	 },
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-9.png",
			frame_count = 1,
		--line_length = 8,
			width = 16,
			height = 64,
			priority = "high",
		--blend_mode = "additive",
		--animation_speed = 32/60,
		scale=1/2
		},
	},

	{
		type = "projectile",
		name = "p-10",
		flags = {"not-on-map","placeable-off-grid"},
		--collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		--direction_only = true,
		action =
		{
		 {
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
					 type = "create-decorative",
					 entity_name = "ex-256",
					 spawn_max = 1, -- TODO: check this
					 spawn_min_radius = 0, -- TODO: check this
					 spawn_max_radius = 3, -- TODO: check this
					 trigger_created_entity="true"
					}
				}
			}
		 },
	 },
	 animation =
		{
			filename = "__m-roguef__/graphics/entity/noani/no.png",
			frame_count = 1,
			width = 1,
			height = 1,
		}
	},

	{
		type = "projectile",
		name = "p-100",
		flags = {"not-on-map","placeable-off-grid"},
		--collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		--direction_only = true,
		action =
		{
		 {
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "create-entity",
						entity_name = "big-explosion-1",
					}
				}
			}
		 },
		 {
			type = "area",
			radius = 4,
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "damage",
						damage = {amount = 250, type = "damage-player"}
					},
				}
			}
		},
		{
			type = "cluster",
			cluster_count = 7,
			distance = 4,
			distance_deviation = 3,
			action_delivery =
			{
				type = "projectile",
				projectile = "grenade-10",
				direction_deviation = 0.6,
				starting_speed = 0.25,
				starting_speed_deviation = 0.3
			}
		}
	 },
	 animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-100.png",
			frame_count = 9,
			width = 78,
			height = 119,
			animation_speed = 9/60,
		}
	},

	{
		type = "projectile",
		name = "grenade-10",
		flags = {"not-on-map"},
		acceleration = 0.005,
		action =
		{
			{
				type = "direct",
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						{
							type = "create-entity",
							entity_name = "medium-explosion"
						},
						{
							type = "create-entity",
							entity_name = "small-scorchmark",
							check_buildability = true
						}
					}
				}
			},
			{
				type = "area",
				radius = 2,
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						{
							type = "damage",
							damage = {amount = 50, type = "damage-player"}
						},
						{
							type = "create-entity",
							entity_name = "explosion"
						}
					}
				}
			}
		},
		light = {intensity = 0.5, size = 4},
		animation =
		{
			filename = "__base__/graphics/entity/grenade/grenade.png",
			frame_count = 1,
			width = 24,
			height = 24,
			priority = "high"
		},
		shadow =
		{
			filename = "__base__/graphics/entity/grenade/grenade-shadow.png",
			frame_count = 1,
			width = 24,
			height = 24,
			priority = "high"
		}
	},

	{
		type = "projectile",
		name = "p-11",
		flags = {"not-on-map","placeable-off-grid"},
		--collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		--direction_only = true,
		action =
	 {
		 {
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "create-entity",
						entity_name = "explosion"
					},
				}
			},
		 },
		 {
			type = "area",
			radius = 2,
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "damage",
						damage = {amount = 40, type = "damage-player"}
					},
					{
						type = "create-entity",
						entity_name = "target-melee-2"
					}
				}
			}
		}
	 },
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-11.png",
			frame_count = 1,
			width = 60,
			height = 111,
			priority = "high",
			blend_mode = "additive",
			--animation_speed = 10/60,
			scale = 1/2
		},
		smoke =
		{
			{
				name = "smoke",
				deviation = {0.15, 0.15},
				frequency = 1,
				position = {0, -1},
				slow_down_factor = 1,
				starting_frame = 3,
				starting_frame_deviation = 5,
				starting_frame_speed = 0,
				starting_frame_speed_deviation = 5
			}
		}
	},

	-- TODO: CHECK THIS
	-- {
	--   type = "smoke",
	--   name = "smoke-11",
	--   flags = {"not-on-map"},
	--   animation =
	--   {
	--     filename = "__m-roguef__/graphics/entity/explosion/p-6.png",
	--     priority = "high",
	--     width = 16,
	--     height = 16,
	--     frame_count = 4,
	--     animation_speed = 8 / 60,
	--     duration = 60,
	--     fade_away_duration = 60,
	--   	blend_mode = "additive",
	--   }
	-- },

	{
		type = "projectile",
		name = "p-12",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
		acceleration = 0,
		direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			 {
				type = "instant",
				target_effects =
				{
					{
						type = "create-entity",
						entity_name = "laser-bubble"
					},
					{
						type = "damage",
						damage = {amount = 40, type = "damage-player"}
					},
				}
		}
	 },
	 animation =
		{
			filename = "__base__/graphics/entity/blue-laser/blue-laser.png",
			--tint = {r=0, g=0.0, b=1.0},
			frame_count = 1,
			width = 7,
			height = 14,
			priority = "high",
			--blend_mode = "additive"
			scale=2
		},
	},
	{
		type = "projectile",
		name = "p-14",
		flags = {"not-on-map","placeable-off-grid"},
		--collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 1,
		direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
			{
				{
				 type = "create-entity",
				 entity_name = "hit-p-14",
				 trigger_created_entity="true"
				}
			}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/noani/no.png",
			frame_count = 1,
			width = 1,
			height = 1,
		},
	},
	{
		type = "projectile",
		name = "p-15",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = -0.00390625,
		direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
			{
				{
					type = "damage",
					damage = {amount = 10, type = "damage-player"}
				},
				{
					type = "create-entity",
					entity_name = "target-melee-1"
				},
				{
					type = "create-entity",
					entity_name = "hit-p-15",
					trigger_created_entity="true"
				}
			}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-15.png",
			frame_count = 6,
			width = 19,
			height = 18,
			priority = "high",
			blend_mode = "additive",
			animation_speed = 12/60
		},
	},
	{
		type = "projectile",
		name = "p-155",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0.00390625,
		direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "damage",
						damage = {amount = 5, type = "damage-player"}
					},
					{
						type = "create-entity",
						entity_name = "target-melee-1"
					},
				}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-155.png",
			frame_count = 12,
			width = 19,
			height = 18,
			priority = "high",
			blend_mode = "additive",
			animation_speed = 12/60
		},
	},
	{
		type = "projectile",
		name = "p-16",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		--direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
			{
				{
					type = "damage",
					damage = {amount = 20, type = "damage-player"}
				},
				{
					type = "create-entity",
					entity_name = "target-elec-1"
				},
				{
					type = "create-entity",
					entity_name = "hit-p-16-1",
					trigger_created_entity="true"
				}
			}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-16.png",
			frame_count = 10,
			width = 43,
			height = 117,
			priority = "high",
			blend_mode = "additive",
			animation_speed = 20/60
		},
	},
	{
		type = "projectile",
		name = "p-16-1",
		flags = {"not-on-map","placeable-off-grid"},
		--collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		--direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
			{
				{
					type = "damage",
					damage = {amount = 10, type = "damage-player"}
				},
				{
					type = "create-entity",
					entity_name = "target-elec-1"
				},
				{
					type = "create-entity",
					entity_name = "hit-p-16-2",
					trigger_created_entity="true"
				}
			}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-16.png",
			frame_count = 10,
			width = 43,
			height = 117,
			priority = "high",
			blend_mode = "additive",
			animation_speed = 20/60,
			scale=1/2
		},
	},
	{
		type = "projectile",
		name = "p-16-2",
		flags = {"not-on-map","placeable-off-grid"},
		acceleration = 0,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "damage",
						damage = {amount = 5, type = "damage-player"}
					},
					{
						type = "create-entity",
						entity_name = "target-elec-1"
					},
					{
						type = "create-entity",
						entity_name = "hit-p-16-3",
						trigger_created_entity="true"
					}
				}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-16.png",
			frame_count = 10,
			width = 43,
			height = 117,
			priority = "high",
			blend_mode = "additive",
			animation_speed = 20/60,
			scale=1/3
		},
	},
	{
		type = "projectile",
		name = "p-16-3",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "damage",
						damage = {amount = 2.5, type = "damage-player"}
					},
					{
						type = "create-entity",
						entity_name = "target-elec-1"
					},
				}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-16.png",
			frame_count = 10,
			width = 43,
			height = 117,
			priority = "high",
			blend_mode = "additive",
			animation_speed = 20/60,
			scale=1/4
		},
	},
	{
		type = "projectile",
		name = "p-17",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.7, -0.7}, {0.7, 0.7}},
		acceleration = 0,
		direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
			{
				{
				 type = "damage",
				 damage = {amount = 15, type = "damage-player"}
				},
				{
				 type = "create-entity",
				 entity_name = "target-melee-1"
				},
			}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-17.png",
			frame_count = 4,
			width = 32,
			height = 64,
			priority = "high",
			--blend_mode = "additive",
			animation_speed = 8/60
		},
	},
	{
		type = "projectile",
		name = "p-18",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "damage",
						damage = {amount = 12, type = "damage-player"}
					},
					{
						type = "create-entity",
						entity_name = "target-fire-1"
					},
					{
						type = "create-entity",
						entity_name = "hit-p-18",
						trigger_created_entity="true"
					}
				}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/ep-1.png",
			frame_count = 1,
			width = 17,
			height = 17,
			priority = "high",
		}
	},
	{
		type = "projectile",
		name = "p-19",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "damage",
						damage = {amount = 20/3, type = "damage-player"}
					},
					{
						type = "create-entity",
						entity_name = "target-blood"
					},
					{
						type = "create-entity",
						entity_name = "hit-p-19",
						trigger_created_entity="true"
					}
				}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-19.png",
			frame_count = 1,
			width = 32,
			height = 52,
			priority = "high",
			--blend_mode = "additive",
			scale=1/2
			--animation_speed = 10/60
		},
	},
	{
		type = "projectile",
		name = "p-199",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		--direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
			{
				{
					type = "damage",
					damage = {amount = 20/3, type = "damage-player"}
				},
			}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-19.png",
			frame_count = 1,
			width = 32,
			height = 52,
			priority = "high",
			--blend_mode = "additive",
			scale=1/2
			--animation_speed = 10/60
		},
	},
	{
		type = "projectile",
		name = "p-20",
		flags = {"not-on-map","placeable-off-grid"},
		--collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "create-entity",
						entity_name = "hit-p-20",
						trigger_created_entity="true"
					}
				}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/noani/no.png",
			frame_count = 1,
			width = 1,
			height = 1,
		},
	},
	{
		type = "projectile",
		name = "p-200",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
			{
				{
					type = "damage",
					damage = {amount = 100, type = "damage-player"}
				},
				{
					type = "create-entity",
					entity_name = "target-melee-1"
				},
			}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-20.png",
			frame_count = 12,
			width = 32,
			height = 32,
			priority = "high",
			--blend_mode = "additive",
			animation_speed = 12/60
		},
	},

	{
		type = "stream",
		name = "p-21",
		flags = {"not-on-map"},
		working_sound_disabled =
		{
			{
				filename = "__base__/sound/fight/electric-beam.ogg",
				volume = 0.7
			}
		},
		particle_buffer_size = 65,
		particle_spawn_interval = 2,
		particle_spawn_timeout = 2,
		particle_vertical_acceleration = 0.025 * 0.6,
		particle_horizontal_speed = 0.25,
		particle_horizontal_speed_deviation = 0.0035,
		particle_start_alpha = 0.5,
		particle_end_alpha = 1,
		particle_start_scale = 0.2,
		particle_loop_frame_count = 3,
		particle_fade_out_threshold = 0.9,
		particle_loop_exit_threshold = 0.25,
		action =
		{
			{
				type = "direct",
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						{
							type = "create-entity",
							entity_name = "target-water"
						}
					}
				}
			},
			{
				type = "area",
				radius = 3,
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						{
							type = "damage",
							damage = { amount = 2, type = "damage-player" }
						}
					}
				}
			}
		},
		spine_animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-21.png",
			--blend_mode = "additive",
			--tint = {r=0, g=0, b=1, a=0.5},
			line_length = 4,
			width = 32,
			height = 18,
			frame_count = 32,
			axially_symmetrical = false,
			direction_count = 1,
			animation_speed = 2,
			scale = 0.75,
			shift = {0, 0},
		},
		shadow =
		{
			filename = "__0_16_graphics__/graphics/entity/acid-projectile-purple/acid-projectile-purple-shadow.png",
			line_length = 5,
			width = 28,
			height = 16,
			frame_count = 33,
			priority = "high",
			scale = 0.5,
			shift = {-0.09 * 0.5, 0.395 * 0.5}
		},
	},
	{
		type = "projectile",
		name = "p-22",
		flags = {"not-on-map","placeable-off-grid"},
		--collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		--direction_only = true,
		action =
		{
		{
				type = "area",
				radius = 7,
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						{
							type = "damage",
							damage = { amount = 50, type = "damage-player" }
						},
						{
							type = "create-entity",
							entity_name = "target-slash"
						},
					}
				}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/noani/no.png",
			frame_count = 1,
			width = 1,
			height = 1,
		},
	},
	{
		type = "projectile",
		name = "p-24-1",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
			{
				{
				 type = "damage",
				 damage = {amount = 1, type = "damage-player"}
				},
				{
				 type = "create-entity",
				 entity_name = "target-melee-1"
				},
			}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-24-1.png",
			frame_count = 1,
			width = 12,
			height = 12,
			priority = "high",
			blend_mode = "additive",
			scale=1
			--animation_speed = 10/60
		},
	},
	{
		type = "projectile",
		name = "p-24-2",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
			{
				{
					type = "damage",
					damage = {amount = 5, type = "damage-player"}
				},
				{
					type = "create-entity",
					entity_name = "target-melee-1"
				},
			}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-24-2.png",
			frame_count = 1,
			width = 12,
			height = 12,
			priority = "high",
			blend_mode = "additive",
			scale=1
			--animation_speed = 10/60
		},
	},
	{
		type = "projectile",
		name = "p-24-3",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
			{
				{
					type = "damage",
					damage = {amount = 10, type = "damage-player"}
				},
				{
					type = "create-entity",
					entity_name = "target-melee-1"
				},
			}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-24-3.png",
			frame_count = 1,
			width = 12,
			height = 12,
			priority = "high",
			blend_mode = "additive",
			scale=1
			--animation_speed = 10/60
		},
	},
	{
		type = "projectile",
		name = "p-24-4",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "damage",
						damage = {amount = 20, type = "damage-player"}
					},
					{
						type = "create-entity",
						entity_name = "target-melee-1"
					},
				}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-24-4.png",
			frame_count = 1,
			width = 12,
			height = 12,
			priority = "high",
		blend_mode = "additive",
		scale=1
		--animation_speed = 10/60
		},
	},
	{
		type = "projectile",
		name = "p-24-5",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "damage",
						damage = {amount = 30, type = "damage-player"}
					},
					{
						type = "create-entity",
						entity_name = "target-melee-1"
					},
				}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-24-5.png",
			frame_count = 1,
			width = 12,
			height = 12,
			priority = "high",
			blend_mode = "additive",
			scale=1
			--animation_speed = 10/60
		},
	},
	{
		type = "projectile",
		name = "p-24-6",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "damage",
						damage = {amount = 35, type = "damage-player"}
					},
					{
						type = "create-entity",
						entity_name = "target-melee-1"
					},
				}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-24-6.png",
			frame_count = 1,
			width = 12,
			height = 12,
			priority = "high",
			blend_mode = "additive",
			scale=1
			--animation_speed = 10/60
		},
	},
	{
		type = "projectile",
		name = "p-24-7",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "damage",
						damage = {amount = 39, type = "damage-player"}
					},
					{
						type = "create-entity",
						entity_name = "target-melee-1"
					},
				}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-24-7.png",
			frame_count = 1,
			width = 12,
			height = 12,
			priority = "high",
			blend_mode = "additive",
			scale=1
			--animation_speed = 10/60
		},
	},
	{
		type = "projectile",
		name = "p-24",
		flags = {"not-on-map","placeable-off-grid"},
		--collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "create-entity",
						entity_name = "hit-p-24",
						trigger_created_entity="true"
					}
				}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/noani/no.png",
			frame_count = 1,
			width = 1,
			height = 1,
		},
	},
	{
		type = "projectile",
		name = "p-25",
		flags = {"not-on-map","placeable-off-grid"},
		--collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
			{
				{
					type = "create-entity",
					entity_name = "hit-p-25",
					trigger_created_entity="true"
				}
			}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/noani/no.png",
			frame_count = 1,
			width = 1,
			height = 1,
		},
	},
	{
		type = "projectile",
		name = "p-25-1",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "damage",
						damage = {amount = 40, type = "damage-player"}
					},
					{
						type = "create-entity",
						entity_name = "target-melee-1"
					},
				}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-25.png",
			frame_count = 1,
			width = 32,
			height = 32,
			priority = "high",
			--blend_mode = "additive",
			scale=1
			--animation_speed = 10/60
		},
	},
	{
		type = "projectile",
		name = "p-26",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "damage",
						damage = {amount = 1, type = "damage-player"}
					},
					{
						type = "create-entity",
						entity_name = "target-melee-1"
					}
				}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-26.png",
			frame_count = 1,
			width = 13,
			height = 13,
			priority = "high",
			blend_mode = "additive",
		},
	},
	{
		type = "projectile",
		name = "p-27",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "damage",
						damage = {amount = 8, type = "damage-player"}
					},
					{
						type = "create-entity",
						entity_name = "target-melee-1"
					},
				}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-27.png",
			frame_count = 4,
			width = 16,
			height = 16,
			priority = "high",
			blend_mode = "additive",
			animation_speed = 10/60
		},
	},
	{
		type = "stream",
		name = "p-28",
		flags = {"not-on-map"},
		working_sound_disabled =
		{
			{
				filename = "__base__/sound/fight/electric-beam.ogg",
				volume = 0.7
			}
		},
		particle_buffer_size = 65,
		particle_spawn_interval = 2,
		particle_spawn_timeout = 2,
		particle_vertical_acceleration = 0.1 * 0.6,
		particle_horizontal_speed = 0.5,
		particle_horizontal_speed_deviation = 0.0035,
		particle_start_alpha = 0.5,
		particle_end_alpha = 1,
		particle_start_scale = 0.2,
		particle_loop_frame_count = 3,
		particle_fade_out_threshold = 0.9,
		particle_loop_exit_threshold = 0.25,
		action =
		{
			{
				type = "direct",
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						{
							type = "create-entity",
							entity_name = "p-7",
						},
						{
							type = "create-entity",
							entity_name = "explosion",
						}
					}
				}
			},
			{
				type = "area",
				radius = 2.5,
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						{
							type = "damage",
							damage = { amount = 10, type = "damage-player" }
						}
					}
				}
			}
		},
		spine_animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-7.png",
			frame_count = 1,
			width = 19,
			height = 18,
			priority = "high",
			blend_mode = "additive",
			--animation_speed = 30/60
		},
		shadow =
		{
			filename = "__0_16_graphics__/graphics/entity/acid-projectile-purple/acid-projectile-purple-shadow.png",
			line_length = 5,
			width = 28,
			height = 16,
			frame_count = 33,
			priority = "high",
			scale = 0.5,
			shift = {-0.09 * 0.5, 0.395 * 0.5}
		},
	},
	{
		type = "projectile",
		name = "p-29",
		flags = {"not-on-map","placeable-off-grid"},
		--collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
					type = "create-entity",
					entity_name = "hit-p-29",
					trigger_created_entity="true"
					}
				}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/noani/no.png",
			frame_count = 1,
			width = 1,
			height = 1,
		},
	},
	{
		type = "projectile",
		name = "p-29-1",
		flags = {"not-on-map","placeable-off-grid"},
		--collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-29.png",
			frame_count = 24,
		line_length = 8,
			width = 64,
			height = 64,
			priority = "high",
		blend_mode = "additive",
		animation_speed = 48/60
		},
	},
	{
		type = "projectile",
		name = "p-29-2",
		flags = {"not-on-map","placeable-off-grid"},
		--collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		--direction_only = true,
		action ={
			{
				type = "cluster",
				cluster_count = 2,
				distance = 10,
				distance_deviation = 0,
				action_delivery =
				{
					type = "projectile",
					projectile = "p-29-3",
					direction_deviation = 1,
					starting_speed = 0.3,
					starting_speed_deviation = 0,
					max_range=10
				}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/noani/no.png",
			frame_count = 1,
			width = 1,
			height = 1,
		},
	},
	{
		type = "projectile",
		name = "p-29-3",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
			{
				{
				 type = "damage",
				 damage = {amount = 7, type = "damage-player"}
				},
				{
				 type = "create-entity",
				 entity_name = "target-ice"
				},
			}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/p-29-1.png",
			frame_count = 1,
			width = 15,
			height = 23,
			priority = "high",
		blend_mode = "additive",
		},
	},
	})

--armor
function armor(n,p)
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
		resistances ={
			{
				type = "damage-enemy",
				decrease = 0,
				percent = p
			},
		},
		durability = 1000000
	}
end
data:extend({
	armor(1,  5),  --20
	armor(2, 10), --40
	armor(3, 15), --60
	armor(4, 20), --80
	armor(5, 25), --100
})

--active
for i = 1, 9 do
	data:extend({
		{
		 type = "item",
		 name = "active-"..i,
		 localised_name = {"active-name."..i},
		 localised_description = {"active-info."..i},
		 icon = "__m-roguef__/graphics/icons/active/"..i..".png",
		 icon_size = 32,
		 flags = {},
		 subgroup = "rf_active",
		 order = "a",
		 stack_size = 1
		}
	})
end

--passive
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

--mastery
for t=1, 7 do
	for i=1, 3 do
		data:extend({
			{
				type = "item",
				name = "mastery-"..t.."-"..i,
				icon = "__m-roguef__/graphics/icons/mastery/"..t.."-"..i..".png",
				icon_size = 32,
				flags = {},
				subgroup = "rf_mastery",
				order = "a",
				stack_size = 1000
			}
		})
	end
end

--raw                            6              7            8                9              10
local raw={"active","money","level","xp","stage","heal"}
for _, b in pairs(raw) do
	data:extend(
	{
		{
		 type = "item",
		 name = b,
		 icon = "__m-roguef__/graphics/icons/raw/" .. b .. ".png",
		 icon_size = 32,
		 flags = {},
		 subgroup = "rf_raw",
		 order = "a",
		 stack_size = 1000
		},
	})
end

--etc
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
	},
})
