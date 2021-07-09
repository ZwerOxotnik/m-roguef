require ("prototypes.entity.demo-worm-animations")
require ("prototypes.entity.demo-enemy-sounds")
require ("prototypes.entity.demo-gunshot-sounds")
require ("prototypes.entity.demo-enemy-autoplace-utils")
require ("prototypes.entity.demo-pipecovers")
require ("prototypes.entity.assemblerpipes")
require ("prototypes.entity.demo-spawner-animation")
require ("prototypes.entity.demo-biter-animations")
require ("prototypes.entity.spitter-animations")

data.raw["electric-turret"]["laser-turret"].energy_source =
{
	type = "electric",
	buffer_capacity = "100000kJ",
	input_flow_limit = "9600kW",
	drain = "1kW",
	usage_priority = "primary-input"
}


	--worm turret
function shift_small_worm(shiftx, shifty)
	return {shiftx - 0.1, shifty + 0.1}
end

small_worm_scale = 0.65
small_worm_tint = {r=1, g=0.63, b=0, a=1.0}

--[[
data:extend(
{
	{
		type = "turret",
		name = "small-worm-turret",
		icon = "__base__/graphics/icons/small-worm.png",
		icon_size = 32,
		flags = {"placeable-enemy", "not-repairable", "breaths-air"},
		order="b-b-d",
		max_health = 200,
		subgroup="enemies",
		healing_per_tick = 0.01,
		collision_box = {{-0.9, -0.8 }, {0.9, 0.8}},
		selection_box = {{-0.9, -0.8 }, {0.9, 0.8}},
		shooting_cursor_size = 3,
		corpse = "small-worm-corpse",
		dying_explosion = "blood-explosion-big",
		dying_sound = make_worm_dying_sounds(0.8),
		folded_speed = 0.01,
		folded_animation = worm_folded_animation(small_worm_scale, small_worm_tint),
		prepare_range = 25,
		preparing_speed = 0.025,
		preparing_animation = worm_preparing_animation(small_worm_scale, small_worm_tint, "forward"),
		prepared_speed = 0.015,
		prepared_animation = worm_prepared_animation(small_worm_scale, small_worm_tint),
		starting_attack_speed = 0.03,
		starting_attack_animation = worm_attack_animation(small_worm_scale, small_worm_tint, "forward"),
		starting_attack_sound = make_worm_roars(0.75),
		ending_attack_speed = 0.03,
		ending_attack_animation = worm_attack_animation(small_worm_scale, small_worm_tint, "backward"),
		folding_speed = 0.015,
		folding_animation =  worm_preparing_animation(small_worm_scale, small_worm_tint, "backward"),
		attack_parameters =
		{
			type = "projectile",
			ammo_category = "bullet",
			cooldown = 15,
			range = 17,
			projectile_creation_distance = 1.8,
			ammo_type =
			{
				category = "biological",
				action =
				{
					type = "direct",
					action_delivery =
					{
						type = "projectile",
						projectile = "acid-projectile-purple",
						starting_speed = 0.5
					}
				}
			}
		},
		autoplace = enemy_worm_autoplace(0),
		call_for_help_radius = 40
	},
})
]]--

function shift_medium_worm(shiftx, shifty)
	return {shiftx - 0.15, shifty + 0.15}
end

medium_worm_scale = 0.83
medium_worm_tint = {r=0.9, g=0.15, b=0.3, a=1.0}

big_worm_scale = 1.0
big_worm_tint = {r=0.34, g=0.68, b=0.90, a=1.0}

function shift_big_worm(shiftx, shifty)
	return {shiftx - 0.2, shifty + 0.2}
end

--[[
data:extend(
{
	{
		type = "turret",
		name = "medium-worm-turret",
		icon = "__base__/graphics/icons/medium-worm.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "not-repairable", "breaths-air"},
		order="b-b-e",
		subgroup="enemies",
		max_health = 350,
		resistances =
		{
			{
				type = "physical",
				decrease = 4,
			},
			{
				type = "explosion",
				decrease = 5,
				percent = 15,
			}
		},
		healing_per_tick = 0.015,
		collision_box = {{-1.1, -1.0}, {1.1, 1.0}},
		selection_box = {{-1.1, -1.0}, {1.1, 1.0}},
		shooting_cursor_size = 3.5,
		rotation_speed = 1,
		corpse = "medium-worm-corpse",
		dying_explosion = "blood-explosion-big",
		dying_sound = make_worm_dying_sounds(0.9),
		folded_speed = 0.01,
		folded_animation = worm_folded_animation(medium_worm_scale, medium_worm_tint),
		prepare_range = 25,
		preparing_speed = 0.025,
		preparing_animation = worm_preparing_animation(medium_worm_scale, medium_worm_tint, "forward"),
		prepared_speed = 0.015,
		prepared_animation = worm_prepared_animation(medium_worm_scale, medium_worm_tint),
		starting_attack_speed = 0.03,
		starting_attack_animation = worm_attack_animation(medium_worm_scale, medium_worm_tint, "forward"),
		starting_attack_sound = make_worm_roars(0.8),
		ending_attack_speed = 0.03,
		ending_attack_animation = worm_attack_animation(medium_worm_scale, medium_worm_tint, "backward"),
		folding_speed = 0.015,
		folding_animation =  worm_preparing_animation(medium_worm_scale, medium_worm_tint, "backward"),
		prepare_range = 30,
		attack_parameters =
		{
			type = "projectile",
			ammo_category = "rocket",
			cooldown = 100,
			range = 20,
			projectile_creation_distance = 1.9,
			damage_modifier = 3,
			ammo_type =
			{
				category = "biological",
				action =
				{
					type = "direct",
					action_delivery =
					{
						type = "projectile",
						projectile = "acid-projectile-purple",
						starting_speed = 0.5
					}
				}
			}
		},
		build_base_evolution_requirement = 0.3,
		autoplace = enemy_worm_autoplace(2),
		call_for_help_radius = 40
	},

	{
		type = "turret",
		name = "big-worm-turret",
		icon = "__base__/graphics/icons/big-worm.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "not-repairable", "breaths-air"},
		max_health = 500,
		order="b-b-f",
		subgroup="enemies",
		resistances =
		{
			{
				type = "physical",
				decrease = 8,
			},
			{
				type = "explosion",
				decrease = 10,
				percent = 30,
			}
		},
		healing_per_tick = 0.02,
		collision_box = {{-1.4, -1.2}, {1.4, 1.2}},
		selection_box = {{-1.4, -1.2}, {1.4, 1.2}},
		shooting_cursor_size = 4,
		rotation_speed = 1,
		corpse = "big-worm-corpse",
		dying_explosion = "blood-explosion-big",
		dying_sound = make_worm_dying_sounds(1.0),
		inventory_size = 2,
		folded_speed = 0.01,
		folded_animation = worm_folded_animation(big_worm_scale, big_worm_tint),
		prepare_range = 25,
		preparing_speed = 0.025,
		preparing_animation = worm_preparing_animation(big_worm_scale, big_worm_tint, "forward"),
		prepared_speed = 0.015,
		prepared_animation = worm_prepared_animation(big_worm_scale, big_worm_tint),
		starting_attack_speed = 0.03,
		starting_attack_animation = worm_attack_animation(big_worm_scale, big_worm_tint, "forward"),
		starting_attack_sound = make_worm_roars(0.95),
		ending_attack_speed = 0.03,
		ending_attack_animation = worm_attack_animation(big_worm_scale, big_worm_tint, "backward"),
		folding_speed = 0.015,
		folding_animation =  worm_preparing_animation(big_worm_scale, big_worm_tint, "backward"),
		prepare_range = 30,
		attack_parameters =
		{
			type = "projectile",
			ammo_category = "rocket",
			cooldown = 100,
			range = 25,
			projectile_creation_distance = 2.1,
			damage_modifier = 6,
			ammo_type =
			{
				category = "biological",
				action =
				{
					type = "direct",
					action_delivery =
					{
						type = "projectile",
						projectile = "acid-projectile-purple",
						starting_speed = 0.5
					}
				}
			}
		},
		build_base_evolution_requirement = 0.5,
		autoplace = enemy_worm_autoplace(5),
		call_for_help_radius = 40
	}
})
]]--

--enemy unit

smallbiterscale = 0.5
small_biter_tint1 =  {r=1, g=0, b=1, a=1}
small_biter_tint2 =  {r=1, g=0, b=1, a=1}

--biter_spawner_tint = {r=0.92, g=0.54, b=0, a=0.5}
biter_spawner_tint = {r=1.0, g=1.0, b=1.0, a=1.0}
spitter_spawner_tint = {r=0.99, g=0.09, b=0.09, a=1}

function spitterattackparameters(data)
	return
	{
		type = "projectile",
		ammo_category = "rocket",
		cooldown = data.cooldown,
		range = data.range,
		min_attack_distance = data.min_attack_distance,
		projectile_creation_distance = 1.9,
		damage_modifier = data.damage_modifier,
		warmup = 30,
		ammo_type =
		{
			category = "biological",
			action =
			{
				type = "direct",
				action_delivery =
				{
					type = "projectile",
					projectile = "acid-projectile-purple",
					starting_speed = 0.5
				}
			}
		},
		sound = make_spitter_roars(data.roarvolume),
		animation = spitterattackanimation(data.scale, data.tint),
	}
end

smallspitterscale = 0.5
smallspittertint =  {r=1, g=0, b=1, a=1}

mediumspitterscale = 2
mediumspittertint =  {r=0.83, g=0.39, b=0.36, a=0.75}

bigspitterscale = 1
bigspittertint = {r=0.54, g=0.58, b=0.85, a=0.6}

behemothspitterscale = 1.2
behemothspittertint = {r=0.3, g=0.9, b=0.3, a=0.75}

mediumbiterscale = 0.7
medium_biter_tint1 = {r=0.78, g=0.15, b=0.15, a=0.6}
medium_biter_tint2 = {r=0.9, g=0.3, b=0.3, a=0.75}

bigbiterscale = 1.0
big_biter_tint1 = {r=0.34, g=0.68, b=0.90, a=0.6}
big_biter_tint2 = {r=0.31, g=0.61, b=0.95, a=0.85}

behemothbiterscale = 1.2
behemoth_biter_tint1 = {r=0.3, g=0.9, b=0.3, a=0.75}
behemoth_biter_tint2 = {r=0.88, g=0.24, b=0.24, a=0.9}


data:extend(
{
	{
		type = "unit",
		name = "spitter-test",
		icon = "__base__/graphics/icons/small-spitter.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
		max_health = 1000,
	 resistances =
		{
			{
				type = "damage-player",
				percent = 100
			}
		},
		order="b",
		subgroup="rf_enemy",
		healing_per_tick = 0,
		collision_box = {{-0.3, -0.3}, {0.3, 0.3}},
		selection_box = {{-0.4, -0.4}, {0.4, 0.4}},
		sticker_box = {{-0.3, -0.5}, {0.3, 0.1}},
		distraction_cooldown = 300,
		attack_parameters =
	 {
		type = "projectile",
		range = 15,
		cooldown = 600000,
		projectile_creation_distance = 1.9,
		ammo_category = "ammo-enemy",
		ammo_type =
		{
			category = "ammo-enemy",
			target_type = "direction",
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
						}
					}
				 }
				},
				{
				 type = "direct",
				 --repeat_count = 1,

				}
			}
		},
		sound = make_spitter_roars(0),
		animation = spitterattackanimation(smallspitterscale, smallspittertint),
	},
		vision_distance = 50,
		movement_speed = 0.185,
		distance_per_frame = 0.04,
		-- in pu
		pollution_to_join_attack = 0,
		corpse = "small-spitter-corpse",
		dying_explosion = "blood-explosion-small",
		working_sound = make_biter_calls(0),
		dying_sound = make_spitter_dying_sounds(0),
		run_animation = spitterrunanimation(smallspitterscale, smallspittertint)
	},
--[[
	{
		type = "unit",
		name = "small-biter",
		icon = "__base__/graphics/icons/small-biter.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air"},
		max_health = 15,
		order = "b-b-a",
		subgroup="enemies",
		healing_per_tick = 0.01,
		collision_box = {{-0.2, -0.2}, {0.2, 0.2}},
		selection_box = {{-0.4, -0.7}, {0.7, 0.4}},
		attack_parameters =
		{
			type = "projectile",
			range = 0.5,
			cooldown = 60,
			ammo_category = "melee",
			ammo_type = make_unit_melee_ammo_type(1),
			sound = make_biter_roars(0.5),
			animation = biterattackanimation(smallbiterscale, small_biter_tint1, small_biter_tint2)
		},
		vision_distance = 10,
		movement_speed = 0.2,
		distance_per_frame = 0.1,
		pollution_to_join_attack = 0,
		distraction_cooldown = 0,
		corpse = "small-biter-corpse",
		dying_explosion = "blood-explosion-small",
		dying_sound =  make_biter_dying_sounds(1.0),
		working_sound =  make_biter_calls(0.7),
		run_animation = biterrunanimation(smallbiterscale, small_biter_tint1, small_biter_tint2),
	},

	{
		type = "unit",
		name = "medium-biter",
		icon = "__base__/graphics/icons/medium-biter.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
		max_health = 500,
		order="b-b-b",
		subgroup="enemies",
		resistances =
		{
			{
				type = "physical",
				decrease = 4,
			},
			{
				type = "explosion",
				percent = 10
			},
			{
				type = "fire",
				percent = -50
			}
		},
		healing_per_tick = 0.01,
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		selection_box = {{-0.7, -1.5}, {0.7, 0.3}},
		sticker_box = {{-0.3, -0.5}, {0.3, 0.1}},
		distraction_cooldown = 300,
		attack_parameters =
		{
			type = "projectile",
			ammo_category = "melee",
			ammo_type = make_unit_melee_ammo_type(1),
			range = 0.5,
			cooldown = 30,
			sound = make_biter_roars(0.7),
			animation = biterattackanimation(mediumbiterscale, medium_biter_tint1, medium_biter_tint2)
		},
		vision_distance = 50,
		movement_speed = 0.185,
		distance_per_frame = 0.15,
		-- in pu
		pollution_to_join_attack = 0,
		corpse = "medium-biter-corpse",
		dying_explosion = "blood-explosion-small",
		working_sound = make_biter_calls(0.8),
		dying_sound = make_biter_dying_sounds(1.0),
		run_animation = biterrunanimation(mediumbiterscale, medium_biter_tint1, medium_biter_tint2)
	},

	{
		type = "unit",
		name = "big-biter",
		order="b-b-c",
		icon = "__base__/graphics/icons/big-biter.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
		max_health = 375,
		subgroup="enemies",
		resistances =
		{
			{
				type = "physical",
				decrease = 8,
			},
			{
				type = "explosion",
				percent = 10
			}
		},
		spawning_time_modifier = 3,
		healing_per_tick = 0.02,
		collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
		selection_box = {{-0.7, -1.5}, {0.7, 0.3}},
		sticker_box = {{-0.6, -0.8}, {0.6, 0}},
		distraction_cooldown = 300,
		attack_parameters =
		{
			type = "projectile",
			range = 1.5,
			cooldown = 35,
			ammo_category = "melee",
			ammo_type = make_unit_melee_ammo_type(30),
			sound =  make_biter_roars(0.6),
			animation = biterattackanimation(bigbiterscale, big_biter_tint1, big_biter_tint2)
		},
		vision_distance = 30,
		movement_speed = 0.17,
		distance_per_frame = 0.2,
		-- in pu
		pollution_to_join_attack = 4000,
		corpse = "big-biter-corpse",
		dying_explosion = "blood-explosion-big",
		working_sound = make_biter_calls(0.9),
		dying_sound = make_biter_dying_sounds(1.0),
		run_animation = biterrunanimation(bigbiterscale, big_biter_tint1, big_biter_tint2)
	},

	{
		type = "unit",
		name = "behemoth-biter",
		order="b-b-d",
		icon = "__base__/graphics/icons/behemoth-biter.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
		max_health = 5000,
		subgroup="enemies",
		resistances =
		{
			{
				type = "physical",
				decrease = 8,
				percent = 20
			},
			{
				type = "explosion",
				decrease = 10,
				percent = 20
			}
		},
		spawning_time_modifier = 12,
		healing_per_tick = 0.1,
		collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
		selection_box = {{-0.7, -1.5}, {0.7, 0.3}},
		sticker_box = {{-0.6, -0.8}, {0.6, 0}},
		distraction_cooldown = 300,
		attack_parameters =
		{
			type = "projectile",
			range = 1.5,
			cooldown = 50,
			ammo_category = "melee",
			ammo_type = make_unit_melee_ammo_type(100),
			sound =  make_biter_roars(0.8),
			animation = biterattackanimation(behemothbiterscale, behemoth_biter_tint1, behemoth_biter_tint2)
		},
		vision_distance = 30,
		movement_speed = 0.17,
		distance_per_frame = 0.2,
		-- in pu
		pollution_to_join_attack = 20000,
		corpse = "behemoth-biter-corpse",
		dying_explosion = "blood-explosion-big",
		working_sound = make_biter_calls(1.2),
		dying_sound = make_biter_dying_sounds(1.0),
		run_animation = biterrunanimation(behemothbiterscale, behemoth_biter_tint1, behemoth_biter_tint2)
	},

	{
		type = "unit",
		name = "small-spitter",
		icon = "__base__/graphics/icons/small-spitter.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
		max_health = 10,
		order="b-b-d",
		subgroup="enemies",
		healing_per_tick = 0.01,
		collision_box = {{-0.3, -0.3}, {0.3, 0.3}},
		selection_box = {{-0.4, -0.4}, {0.4, 0.4}},
		sticker_box = {{-0.3, -0.5}, {0.3, 0.1}},
		distraction_cooldown = 300,
		attack_parameters = spitterattackparameters({range=15,
																								 min_attack_distance=10,
																								 cooldown=100,
																								 damage_modifier=1,
																								 scale=smallspitterscale,
																								 tint=smallspittertint,
																								 roarvolume=0.7}),
		vision_distance = 30,
		movement_speed = 0.185,
		distance_per_frame = 0.04,
		-- in pu
		pollution_to_join_attack = 200,
		corpse = "small-spitter-corpse",
		dying_explosion = "blood-explosion-small",
		working_sound = make_biter_calls(0.65),
		dying_sound = make_spitter_dying_sounds(1.0),
		run_animation = spitterrunanimation(smallspitterscale, smallspittertint)
	},

	{
		type = "unit",
		name = "medium-spitter",
		icon = "__base__/graphics/icons/medium-spitter.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
		max_health = 50,
		order="b-b-e",
		subgroup="enemies",
		resistances =
		{
			{
				type = "explosion",
				percent = 15
			}
		},
		healing_per_tick = 0.01,
		collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
		selection_box = {{-0.5, -0.7}, {0.5, 0.7}},
		sticker_box = {{-0.3, -0.5}, {0.3, 0.1}},
		distraction_cooldown = 300,
		attack_parameters = spitterattackparameters({range=15,
																								 min_attack_distance=10,
																								 cooldown=100,
																								 damage_modifier=2,
																								 scale=mediumspitterscale,
																								 tint=mediumspittertint,
																								 roarvolume=0.85}),
		vision_distance = 30,
		movement_speed = 0.165,
		distance_per_frame = 0.055,
		-- in pu
		pollution_to_join_attack = 600,
		corpse = "medium-spitter-corpse",
		dying_explosion = "blood-explosion-small",
		working_sound = make_biter_calls(0.75),
		dying_sound = make_spitter_dying_sounds(1.0),
		run_animation = spitterrunanimation(mediumspitterscale, mediumspittertint)
	},

	{
		type = "unit",
		name = "big-spitter",
		icon = "__base__/graphics/icons/big-spitter.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
		max_health = 200,
		order="b-b-f",
		subgroup="enemies",
		resistances =
		{
			{
				type = "explosion",
				percent = 30
			}
		},
		spawning_time_modifier = 3,
		healing_per_tick = 0.01,
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		selection_box = {{-0.7, -1.0}, {0.7, 1.0}},
		sticker_box = {{-0.3, -0.5}, {0.3, 0.1}},
		distraction_cooldown = 300,
		attack_parameters = spitterattackparameters({range=15,
																								 min_attack_distance=10,
																								 cooldown=100,
																								 damage_modifier=3,
																								 scale=bigspitterscale,
																								 tint=bigspittertint,
																								 roarvolume=0.95}),
		vision_distance = 30,
		movement_speed = 0.15,
		distance_per_frame = 0.07,
		-- in pu
		pollution_to_join_attack = 1500,
		corpse = "big-spitter-corpse",
		dying_explosion = "blood-explosion-big",
		working_sound = make_biter_calls(0.9),
		dying_sound = make_spitter_dying_sounds(1.0),
		run_animation = spitterrunanimation(bigspitterscale, bigspittertint)
	},

	{
		type = "unit",
		name = "behemoth-spitter",
		icon = "__base__/graphics/icons/behemoth-spitter.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
		max_health = 2000,
		order="b-b-f",
		subgroup="enemies",
		resistances =
		{
			{
				type = "explosion",
				percent = 35
			}
		},
		spawning_time_modifier = 12,
		healing_per_tick = 0.1,
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		selection_box = {{-0.7, -1.0}, {0.7, 1.0}},
		sticker_box = {{-0.3, -0.5}, {0.3, 0.1}},
		distraction_cooldown = 300,
		attack_parameters = spitterattackparameters({range=15,
																								 min_attack_distance=10,
																								 cooldown=100,
																								 damage_modifier=5,
																								 scale=behemothspitterscale,
																								 tint=behemothspittertint}),
		vision_distance = 30,
		movement_speed = 0.15,
		distance_per_frame = 0.084,
		pollution_to_join_attack = 10000,
		corpse = "behemoth-spitter-corpse",
		dying_explosion = "blood-explosion-big",
		dying_sound = make_spitter_dying_sounds(1.0),
		run_animation = spitterrunanimation(behemothspitterscale, behemothspittertint)
	},

	{
		type = "unit-spawner",
		name = "biter-spawner",
		icon = "__base__/graphics/icons/biter-spawner.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "not-repairable"},
		max_health = 350,
		order="b-b-g",
		subgroup="enemies",
		resistances =
		{
			{
				type = "physical",
				decrease = 2,
			},
			{
				type = "explosion",
				decrease = 5,
				percent = 15,
			}
		},
		working_sound = {
			sound =
			{
				{
					filename = "__base__/sound/creatures/spawner.ogg",
					volume = 1.0
				}
			},
			apparent_volume = 2
		},
		dying_sound =
		{
			{
				filename = "__base__/sound/creatures/spawner-death-1.ogg",
				volume = 1.0
			},
			{
				filename = "__base__/sound/creatures/spawner-death-2.ogg",
				volume = 1.0
			}
		},
		healing_per_tick = 0.02,
		collision_box = {{-3.2, -2.2}, {2.2, 2.2}},
		selection_box = {{-3.5, -2.5}, {2.5, 2.5}},
		-- in ticks per 1 pu
		pollution_absorption_absolute = 20,
		pollution_absorption_proportional = 0.01,
		pollution_to_enhance_spawning = 30000,
		corpse = "biter-spawner-corpse",
		dying_explosion = "blood-explosion-huge",
		-- loot =
		-- {
		--   {
		--     count_max = 10,
		--     count_min = 2,
		--     item = "alien-artifact",
		--     probability = 1
		--   }
		-- },
		max_count_of_owned_units = 0,
		max_friends_around_to_spawn = 0,
		animations =
		{
			spawner_idle_animation(0, biter_spawner_tint),
			spawner_idle_animation(1, biter_spawner_tint),
			spawner_idle_animation(2, biter_spawner_tint),
			spawner_idle_animation(3, biter_spawner_tint)
		},
		result_units = (function()
										 local res = {}
										 res[1] = {"small-biter", {{0.0, 0.3}, {0.6, 0.0}}}
										 if not data.is_demo then
											 -- from evolution_factor 0.3 the weight for medium-biter is linearly rising from 0 to 0.3
											 -- this means for example that when the evolution_factor is 0.45 the probability of spawning
											 -- a small biter is 66% while probability for medium biter is 33%.
											 res[2] = {"medium-biter", {{0.3, 0.0}, {0.6, 0.3}, {0.7, 0.1}}}
											 -- for evolution factor of 1 the spawning probabilities are: small-biter 0%, medium-biter 1/7, big-biter 4/7, behemoth biter 3/7
											 res[3] = {"big-biter", {{0.5, 0.0}, {1.0, 0.4}}}
											 res[4] = {"behemoth-biter", {{0.9, 0.0}, {1.0, 0.3}}}
										 end
										 return res
									 end)(),
		-- With zero evolution the spawn rate is 6 seconds, with max evolution it is 2.5 seconds
		spawning_cooldown = {30, 30},
		spawning_radius = 0,
		spawning_spacing = 0,
		max_spawn_shift = 0,
		max_richness_for_spawn_shift = 100,
		autoplace = enemy_spawner_autoplace(0),
		call_for_help_radius = 0
	},


	{
		type = "unit-spawner",
		name = "spitter-spawner",
		icon = "__base__/graphics/icons/biter-spawner.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "not-repairable"},
		max_health = 350,
		order="b-b-h",
		subgroup="enemies",
		working_sound = {
			sound =
			{
				{
					filename = "__base__/sound/creatures/spawner.ogg",
					volume = 1.0
				}
			},
			apparent_volume = 2
		},
		dying_sound =
		{
			{
				filename = "__base__/sound/creatures/spawner-death-1.ogg",
				volume = 1.0
			},
			{
				filename = "__base__/sound/creatures/spawner-death-2.ogg",
				volume = 1.0
			}
		},
		resistances =
		{
			{
				type = "physical",
				decrease = 2,
			},
			{
				type = "explosion",
				decrease = 5,
				percent = 15,
			}
		},
		healing_per_tick = 0.02,
		collision_box = {{-3.2, -2.2}, {2.2, 2.2}},
		selection_box = {{-3.5, -2.5}, {2.5, 2.5}},
		pollution_absorption_absolute = 20,
		pollution_absorption_proportional = 0.01,
		corpse = "spitter-spawner-corpse",
		dying_explosion = "blood-explosion-huge",
		loot =
		{
			{
				count_max = 15,
				count_min = 5,
				item = "alien-artifact",
				probability = 1
			}
		},
		max_count_of_owned_units = 7,
		max_friends_around_to_spawn = 5,
		animations =
		{
			spawner_idle_animation(0, spitter_spawner_tint),
			spawner_idle_animation(1, spitter_spawner_tint),
			spawner_idle_animation(2, spitter_spawner_tint),
			spawner_idle_animation(3, spitter_spawner_tint)
		},

		result_units = (function()
										 local res = {}
										 res[1] = {"small-biter", {{0.0, 0.3}, {0.35, 0}}}
										 res[2] = {"small-spitter", {{0.25, 0.0}, {0.5, 0.3}, {0.7, 0.0}}}
										 res[3] = {"medium-spitter", {{0.5, 0.0}, {0.7, 0.3}, {0.9, 0.1}}}
										 res[4] = {"big-spitter", {{0.5, 0.0}, {1.0, 0.4}}}
										 res[5] = {"behemoth-spitter", {{0.9, 0.0}, {1.0, 0.3}}}
										 return res
									 end)(),
		-- With zero evolution the spawn rate is 6 seconds, with max evolution it is 2.5 seconds
		spawning_cooldown = {360, 150},
		spawning_radius = 10,
		spawning_spacing = 3,
		max_spawn_shift = 0,
		max_richness_for_spawn_shift = 100,
		autoplace = enemy_spawner_autoplace(1),
		call_for_help_radius = 50
	},
]]--
})

--ep
for i=10,200,10 do
local scale=1-((50-i)/100)
data:extend(
{
	{
		type = "projectile",
		name = "ep-"..i,
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.2*scale, -0.2*scale}, {0.2*scale, 0.2*scale}},
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
				 damage = {amount = i, type = "damage-enemy"}
				},
				{
				 type = "create-entity",
				 entity_name = "target-fire-1"
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
		--blend_mode = "additive",
		--animation_speed = 15/60,
		scale=scale
		},
	},
})
end
--stage 1

data:extend(
{

	{
		type = "unit",
		name = "biter-normal-1",
		icon = "__base__/graphics/icons/small-biter.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air"},
		max_health = 20,
		resistances =
		{
			{
				type = "damage-enemy",
				percent = 100
			}
		},
		order = "a",
		subgroup="rf_enemy",
		healing_per_tick = 0,
		collision_box = {{-0.3, 0}, {0.3, 0.6}},
		selection_box = {{-0.4, -0.7}, {0.7, 0.4}},
		sticker_box = {{-0.2, -0.2}, {0.2, 0.2}},
		attack_parameters =
		{
			type = "projectile",
			range = 0.5,
			cooldown = 60,
			ammo_category = "ammo-enemy",
			ammo_type =
		{
		 category = "ammo-enemy",
		 target_type = "entity",
		 action =
		 {
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
				 type = "damage",
				 damage = { amount = 50 , type = "damage-enemy"}
				}
			}
		 }
		},
			sound = make_biter_roars(0.5),
			animation = biterattackanimation(smallbiterscale, {r=0,g=1,b=0,a=1}, {r=0,g=1,b=0,a=1})
		},
		vision_distance = 50,
		movement_speed = 0.2,
		distance_per_frame = 0.1,
		pollution_to_join_attack = 0,
		distraction_cooldown = 0,
		corpse = "small-biter-corpse",
		dying_explosion = "blood-explosion-small",
		dying_sound =  make_biter_dying_sounds(1.0),
		working_sound =  make_biter_calls(0.7),
		run_animation = biterrunanimation(smallbiterscale, {r=0,g=1,b=0,a=1}, {r=0,g=1,b=0,a=1}),
	},
	{
		type = "unit",
		name = "biter-mini-1",
		icon = "__base__/graphics/icons/small-biter.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air"},
		max_health = 20,
		resistances =
		{
			{
				type = "damage-enemy",
				percent = 100
			}
		},
		order = "a",
		subgroup="rf_enemy",
		healing_per_tick = 0,
		--collision_box = {{-0.3, 0}, {0.3, 0.6}},
		selection_box = {{-0.4, -0.7}, {0.7, 0.4}},
		sticker_box = {{-0.2, -0.2}, {0.2, 0.2}},
		attack_parameters =
		{
			type = "projectile",
			range = 0.5,
			cooldown = 60,
			ammo_category = "ammo-enemy",
			ammo_type =
		{
		 category = "ammo-enemy",
		 target_type = "entity",
		 action =
		 {
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
				 type = "damage",
				 damage = { amount = 30 , type = "damage-enemy"}
				}
			}
		 }
		},
			sound = make_biter_roars(0.5),
			animation = biterattackanimation(smallbiterscale*1/2, {r=0,g=1,b=0,a=1}, {r=0,g=1,b=0,a=1})
		},
		vision_distance = 50,
		movement_speed = 0.2,
		distance_per_frame = 0.1,
		pollution_to_join_attack = 0,
		distraction_cooldown = 0,
		corpse = "small-biter-corpse",
		dying_explosion = "blood-explosion-small",
		dying_sound =  make_biter_dying_sounds(1.0),
		working_sound =  make_biter_calls(0.7),
		run_animation = biterrunanimation(smallbiterscale*1/2, {r=0,g=1,b=0,a=1}, {r=0,g=1,b=0,a=1}),
	},

	{
		type = "unit",
		name = "spitter-normal-1",
		icon = "__base__/graphics/icons/small-spitter.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
		max_health = 20,
		resistances =
		{
			{
				type = "damage-enemy",
				percent = 100
			}
		},
		order="b",
		subgroup="rf_enemy",
		healing_per_tick = 0,
		collision_box = {{-0.3, 0}, {0.3, 0.6}},
		selection_box = {{-0.4, -0.4}, {0.4, 0.4}},
		sticker_box = {{-0.3, -0.5}, {0.3, 0.1}},
		distraction_cooldown = 300,
		attack_parameters =
	 {
		type = "projectile",
		range = 15,
		cooldown = 60,
		projectile_creation_distance = 1.9,
		ammo_category = "ammo-enemy",
		ammo_type =
		{
			category = "ammo-enemy",
			target_type = "direction",
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
					projectile = "ep-50",
					starting_speed = 0.3,
					--direction_deviation = 0.3,
					--range_deviation = 0.3,
					max_range = 30
				 }
				}
			}
		},
		sound = make_spitter_roars(0.7),
		animation = spitterattackanimation(smallspitterscale, {r=0,g=0,b=1,a=1}),
	},
		vision_distance = 50,
		movement_speed = 0.185,
		distance_per_frame = 0.04,
		-- in pu
		pollution_to_join_attack = 0,
		corpse = "small-spitter-corpse",
		dying_explosion = "blood-explosion-small",
		working_sound = make_biter_calls(0.65),
		dying_sound = make_spitter_dying_sounds(1.0),
		run_animation = spitterrunanimation(smallspitterscale, {r=0,g=0,b=1,a=1})
	},

	{
		type = "unit-spawner",
		name = "spawner-biter-normal-1",
		icon = "__base__/graphics/icons/biter-spawner.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "not-repairable"},
		max_health = 200,
		resistances =
		{
			{
				type = "damage-enemy",
				percent = 100
			}
		},
		order="c",
		subgroup="rf_enemy",
		working_sound = {
			sound =
			{
				{
					filename = "__base__/sound/creatures/spawner.ogg",
					volume = 1.0
				}
			},
			apparent_volume = 2
		},
		dying_sound =
		{
			{
				filename = "__base__/sound/creatures/spawner-death-1.ogg",
				volume = 1.0
			},
			{
				filename = "__base__/sound/creatures/spawner-death-2.ogg",
				volume = 1.0
			}
		},
		healing_per_tick = 0,
		collision_box = {{-3.2, -2.2}, {2.2, 2.2}},
		selection_box = {{-3.5, -2.5}, {2.5, 2.5}},
		-- in ticks per 1 pu
		pollution_absorption_absolute = 0,
		pollution_absorption_proportional = 0,
		pollution_to_enhance_spawning = 0,
		corpse = "biter-spawner-corpse",
		dying_explosion = "blood-explosion-huge",
		max_count_of_owned_units = 7,
		max_friends_around_to_spawn = 5,
		animations =
		{
			spawner_idle_animation(0, {r=0,g=1,b=0,a=1}),
			spawner_idle_animation(1, {r=0,g=1,b=0,a=1}),
			spawner_idle_animation(2, {r=0,g=1,b=0,a=1}),
			spawner_idle_animation(3, {r=0,g=1,b=0,a=1})
		},
		result_units = (function()
										 local res = {}
										 res[1] = {"biter-normal-1", {{0.0, 0.3}, {0.6, 0.0}}}
										 if not data.is_demo then
											 res[2] = {"biter-normal-1", {{0.3, 0.0}, {0.6, 0.3}, {0.7, 0.1}}}
											 res[3] = {"biter-normal-1", {{0.5, 0.0}, {1.0, 0.4}}}
											 res[4] = {"biter-normal-1", {{0.9, 0.0}, {1.0, 0.3}}}
										 end
										 return res
									 end)(),
		spawning_cooldown = {180, 180},
		spawning_radius = 10,
		spawning_spacing = 3,
		max_spawn_shift = 0,
		max_richness_for_spawn_shift = 100,
		autoplace = enemy_spawner_autoplace(0),
		call_for_help_radius = 50
	},

	{
		type = "unit-spawner",
		name = "spawner-spitter-normal-1",
		icon = "__base__/graphics/icons/biter-spawner.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "not-repairable"},
		max_health = 200,
		 resistances =
		{
			{
				type = "damage-enemy",
				percent = 100
			}
		},
		order="c",
		subgroup="rf_enemy",
		working_sound = {
			sound =
			{
				{
					filename = "__base__/sound/creatures/spawner.ogg",
					volume = 1.0
				}
			},
			apparent_volume = 2
		},
		dying_sound =
		{
			{
				filename = "__base__/sound/creatures/spawner-death-1.ogg",
				volume = 1.0
			},
			{
				filename = "__base__/sound/creatures/spawner-death-2.ogg",
				volume = 1.0
			}
		},
		healing_per_tick = 0,
		collision_box = {{-3.2, -2.2}, {2.2, 2.2}},
		selection_box = {{-3.5, -2.5}, {2.5, 2.5}},
		pollution_absorption_absolute = 0,
		pollution_absorption_proportional = 0,
		pollution_to_enhance_spawning = 0,
		corpse = "biter-spawner-corpse",
		dying_explosion = "blood-explosion-huge",
		max_count_of_owned_units = 7,
		max_friends_around_to_spawn = 5,
		animations =
		{
			spawner_idle_animation(0, {r=0,g=0,b=1,a=1}),
			spawner_idle_animation(1, {r=0,g=0,b=1,a=1}),
			spawner_idle_animation(2, {r=0,g=0,b=1,a=1}),
			spawner_idle_animation(3, {r=0,g=0,b=1,a=1})
		},
		result_units = (function()
										 local res = {}
										 res[1] = {"spitter-normal-1", {{0.0, 0.3}, {0.6, 0.0}}}
										 if not data.is_demo then
											 res[2] = {"spitter-normal-1", {{0.3, 0.0}, {0.6, 0.3}, {0.7, 0.1}}}
											 res[3] = {"spitter-normal-1", {{0.5, 0.0}, {1.0, 0.4}}}
											 res[4] = {"spitter-normal-1", {{0.9, 0.0}, {1.0, 0.3}}}
										 end
										 return res
									 end)(),
		spawning_cooldown = {180, 180},
		spawning_radius = 10,
		spawning_spacing = 3,
		max_spawn_shift = 0,
		max_richness_for_spawn_shift = 100,
		autoplace = enemy_spawner_autoplace(0),
		call_for_help_radius = 50
	},

	{
		type = "unit",
		name = "biter-boss-1",
		icon = "__base__/graphics/icons/small-biter.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air"},
		max_health = 4000,
		resistances =
		{
			{
				type = "damage-enemy",
				percent = 100
			}
		},
		order = "d",
		subgroup="rf_enemy",
		healing_per_tick = 0,
		collision_box = {{-0.3, 0}, {0.3, 0.6}},
		selection_box = {{-0.4*4, -0.7*4}, {0.7*4, 0.4*4}},
		sticker_box = {{-0.1*4, -0.2*4}, {0.1*4, 0.1*4}},
		attack_parameters =
		{
			type = "projectile",
			range = 0.5*4,
			cooldown = 60,
			ammo_category = "ammo-enemy",
			ammo_type =
		{
		 category = "ammo-enemy",
		 target_type = "entity",
		 action =
		 {
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
				 type = "damage",
				 damage = { amount = 50*2 , type = "damage-enemy"}
				}
			}
		 }
		},
			sound = make_biter_roars(0.5),
			animation = biterattackanimation(smallbiterscale*4, {r=0,g=1,b=0,a=1}, {r=0,g=1,b=0,a=1})
		},
		vision_distance = 50,
		movement_speed = 0.1,
		distance_per_frame = 0.1,
		pollution_to_join_attack = 0,
		distraction_cooldown = 0,
		corpse = "behemoth-biter-corpse",
		dying_explosion = "blood-explosion-big",
		dying_sound =  make_biter_dying_sounds(1.0),
		working_sound =  make_biter_calls(0.7),
		run_animation = biterrunanimation(smallbiterscale*4, {r=0,g=1,b=0,a=1}, {r=0,g=1,b=0,a=1}),
	},

})

--stage 2

data:extend(
{

	{
		type = "unit",
		name = "spitter-boss-2",
		icon = "__base__/graphics/icons/small-spitter.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
		max_health = 5000,
		resistances =
		{
			{
				type = "damage-enemy",
				percent = 100
			}
		},
		order="d",
		subgroup="rf_enemy",
		healing_per_tick = 0,
		collision_box = {{-0.3*4, -0.3*4}, {0.3*4, 0.6*4}},
		selection_box = {{-0.4*4, -0.4*4}, {0.4*4, 0.4*4}},
		sticker_box = {{-0.3*4, -0.5*4}, {0.3*4, 0.1*4}},
		distraction_cooldown = 300,
		attack_parameters =
	 {
		type = "projectile",
		range = 100,
		cooldown = 12,
		projectile_creation_distance = 1.9,
		ammo_category = "ammo-enemy",
		ammo_type =
		{
			category = "ammo-enemy",
			target_type = "direction",
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
						}
					}
				 }
				},
				{
				 type = "direct",
				 repeat_count = 1,
				 action_delivery =
				 {
					type = "projectile",
					projectile = "ep-50",
					starting_speed = 0.2,
					direction_deviation = 0.5,
					range_deviation = 0.5,
					max_range = 30
				 }
				}
			}
		},
		sound = make_spitter_roars(0.7),
		animation = spitterattackanimation(smallspitterscale*4, {r=1,g=0,b=0,a=1}),
	},
		vision_distance = 50,
		movement_speed = 1,
		distance_per_frame = 0.04,
		-- in pu
		pollution_to_join_attack = 0,
		corpse = "behemoth-spitter-corpse",
		dying_explosion = "blood-explosion-huge",
		working_sound = make_biter_calls(0.65),
		dying_sound = make_spitter_dying_sounds(1.0),
		run_animation = spitterrunanimation(smallspitterscale*4, {r=1,g=0,b=0,a=1})
	},

})

--stage 3

data.raw["rocket-silo"]["rocket-silo"].flags={"placeable-player", "placeable-enemy", "not-repairable", "placeable-off-grid"}
data.raw["rocket-silo"]["rocket-silo"].max_health=6000
local rock_medium_copy = util.table.deepcopy(data.raw["optimized-decorative"]["rock-medium"])
data:extend(
{

	{
		type = "simple-entity",
		name = "rf_stone",
		flags = {"placeable-player", "placeable-enemy", "not-repairable", "placeable-off-grid"},
		icon = "__base__/graphics/icons/stone.png", --TODO: check this!
		icon_size = 64,
		subgroup = "rf_enemy",
		order = "e",
		collision_box = {{-1.1, -1.1}, {1.1, 1.1}},
		selection_box = {{-1.3, -1.3}, {1.3, 1.3}},
		dying_explosion = "explosion",
		render_layer = "object",
		max_health = 500,
		pictures = rock_medium_copy.pictures
	},

	{
		type = "projectile",
		name = "rf_rocket-3",
		flags = {"not-on-map"},
	 collision_box = {{-0.2, -0.2}, {0.2, 0.2}},
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
						entity_name = "explosion"
					},
					{
						type = "damage",
						damage = {amount = 100, type = "damage-enemy"}
					},
					{
						type = "create-entity",
						entity_name = "small-scorchmark",
						check_buildability = true
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
		name = "rf_poison-3",
		flags = {"not-on-map"},
		acceleration = 0,
		action =
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					type = "create-entity",
					entity_name = "poison-cloud-3"
				}
			}
		},
		light = {intensity = 0.5, size = 4},
		animation =
		{
			filename = "__base__/graphics/entity/poison-capsule/poison-capsule.png",
			frame_count = 1,
			width = 32,
			height = 32,
			priority = "high"
		},
		shadow =
		{
			filename = "__base__/graphics/entity/poison-capsule/poison-capsule-shadow.png",
			frame_count = 1,
			width = 32,
			height = 32,
			priority = "high"
		},
		smoke = capsule_smoke,
	},

	{
		type = "smoke-with-trigger",
		name = "poison-cloud-3",
		flags = {"not-on-map"},
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
		shift={0,1}
		},
		slow_down_factor = 0,
		affected_by_wind = false,
		cyclic = true,
		duration = 60 * 10,
		fade_away_duration = 2 * 60,
		spread_duration = 10,
		color = { r = 0.2, g = 0.9, b = 0.2 },
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
						radius = 3,
						entity_flags = {"breaths-air"},
						action_delivery =
						{
							type = "instant",
							target_effects =
							{
								type = "damage",
								damage = { amount = 10, type = "damage-enemy"}
							}
						}
					}
				}
			}
		},
		action_frequency = 10
	},

	{
		type = "stream",
		name = "rf_flame-3",
		flags = {"not-on-map"},
		stream_light = {intensity = 1, size = 4},
		ground_light = {intensity = 0.8, size = 4},

		particle_buffer_size = 90,
		particle_spawn_interval = 2,
		particle_spawn_timeout = 8,
		particle_vertical_acceleration = 0.005 * 0.60,
		particle_horizontal_speed = 0.2* 0.75 * 1.5,
		particle_horizontal_speed_deviation = 0.005 * 0.70,
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
							type = "create-fire",
							entity_name = "blaze-3"
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
							damage = { amount = 100, type = "damage-enemy" }
						}
					}
				}
			}
		},

		spine_animation =
		{
			filename = "__base__/graphics/entity/flamethrower-fire-stream/flamethrower-fire-stream-spine.png",
			blend_mode = "additive",
			--tint = {r=1, g=1, b=1, a=0.5},
			line_length = 4,
			width = 32,
			height = 18,
			frame_count = 32,
			axially_symmetrical = false,
			direction_count = 1,
			animation_speed = 2,
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
			shift = {-0.09, 0.395}
		},

		particle =
		{
			filename = "__base__/graphics/entity/flamethrower-fire-stream/flamethrower-explosion.png",
			priority = "extra-high",
			width = 64,
			height = 64,
			frame_count = 32,
			line_length = 8
		},
	},

	{
		type = "fire",
		name = "blaze-3",
		flags = {"placeable-off-grid", "not-on-map"},
		duration = 600,
		fade_away_duration = 600,
		spread_duration = 600,
		start_scale = 1,
		end_scale = 0.01,
		color = {r=1, g=0.9, b=0, a=0.5},
		damage_per_tick = {amount = 2, type = "damage-enemy"},
		-- spawn_entity = "noani",
		spread_delay = 300,
		spread_delay_deviation = 180,
		maximum_spread_count = 100,
		initial_lifetime = 600,
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
			scale = fire_scale,
			tint = fire_tint,
			flags = fire_flags,
			shift = { -0.0390625/2, -0.90625/2 }
		 }},
		light = {intensity = 1, size = 20},
		working_sound =
		{
		 sound = { filename = "__base__/sound/furnace.ogg" },
		 max_sounds_per_type = 3
		},
	},

})

--stage 4

data:extend(
{

	{
		type = "turret",
		name = "worm-boss-4",
		icon = "__base__/graphics/icons/big-worm.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "not-repairable", "breaths-air", "placeable-off-grid"},
		max_health = 12000,
		order="b-b-f",
		subgroup="enemies",
		resistances =
		{
			{
				type = "damage-enemy",
				percent = 100,
			}
		},
		healing_per_tick = 0,
		collision_box = {{-1.4, -1.2}, {1.4, 1.2}},
		selection_box = {{-1.4, -1.2}, {1.4, 1.2}},
		shooting_cursor_size = 4,
		rotation_speed = 1,
		corpse = "big-worm-corpse",
		dying_explosion = "blood-explosion-big",
		dying_sound = make_worm_dying_sounds(1.0),
		inventory_size = 2,
		folded_speed = 0.01,
		folded_animation = worm_folded_animation(big_worm_scale, {r=1,g=0,b=0,a=1}),
		prepare_range = 25,
		preparing_speed = 0.025,
		preparing_animation = worm_preparing_animation(big_worm_scale, {r=1,g=0,b=0,a=1}, "forward"),
		prepared_speed = 0.015,
		prepared_animation = worm_prepared_animation(big_worm_scale, {r=1,g=0,b=0,a=1}),
		starting_attack_speed = 0.03,
		starting_attack_animation = worm_attack_animation(big_worm_scale, {r=1,g=0,b=0,a=1}, "forward"),
		starting_attack_sound = make_worm_roars(0.95),
		ending_attack_speed = 0.03,
		ending_attack_animation = worm_attack_animation(big_worm_scale, {r=1,g=0,b=0,a=1}, "backward"),
		folding_speed = 0.015,
		folding_animation =  worm_preparing_animation(big_worm_scale, {r=1,g=0,b=0,a=1}, "backward"),
		prepare_range = 30,
		attack_parameters =
	 {
		type = "stream",
		range = 50,
		cooldown = 300,
		projectile_creation_distance = 0,
		ammo_category = "ammo-enemy",
		ammo_type =
		{
			category = "ammo-enemy",
			target_type = "position",
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
						 entity_name = "explosion"
						}
					}
				 }
				},
				 {
				 type = "direct",
				 repeat_count = 1,
				 action_delivery =
				 {
					type = "stream",
					stream = "ep-4-1",
					max_range = 50
				 }
				 }
			}
		},
	 },
		build_base_evolution_requirement = 0.5,
		autoplace = enemy_worm_autoplace(5),
		call_for_help_radius = 40
	},

	{
		type = "stream",
		name = "ep-4-1",
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
		particle_vertical_acceleration = 0.003,
		particle_horizontal_speed = 0.1,
		particle_horizontal_speed_deviation = 0.001,
		particle_start_alpha = 0.5,
		particle_end_alpha = 1,
		particle_start_scale = 0.2,
		particle_loop_frame_count = 1,
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
							entity_name = "explosion",
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
							damage = { amount = 50, type = "damage-enemy" }
						}
					}
				}
			},
		{
				type = "cluster",
				cluster_count = 30,
				distance = 5,
				distance_deviation = 4,
				action_delivery =
				{
					type = "projectile",
					projectile = "ep-50",
					direction_deviation = 0.6,
					starting_speed = 0.1,
					starting_speed_deviation = 0.09,
			 max_range=20
				}
			}
		},
		spine_animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/ep-4-1.png",
			frame_count = 32,
		line_length=8,
			width = 64,
			height = 64,
			priority = "high",
		blend_mode = "additive",
		animation_speed = 64/60
		},
		shadow =
		{
			filename = "__0_16_graphics__/graphics/entity/acid-projectile-purple/acid-projectile-purple-shadow.png",
			line_length = 5,
			width = 28,
			height = 16,
			frame_count = 33,
			priority = "high",
			scale = 1.5,
			shift = {-0.09 * 1.5, 0.395 * 1.5}
		},
	},

	{
		type = "beam",
		name = "beam-4",
		flags = {"not-on-map"},
		width = 0.1,
		damage_interval = 1,
		working_sound =
		{
			{
				filename = "__base__/sound/fight/electric-beam.ogg",
				volume = 1
			}
		},
		action =
		{
			type = "line",
		range=30,
		width=0.1,
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "damage",
						damage = { amount = 25, type = "damage-enemy"}
					},
			 {
				type = "create-entity",
				entity_name = "target-elec-1"
			 },
				}
			}
		},
		head =
		{
			filename = "__m-roguef__/graphics/entity/beam/beam-head.png",
			line_length = 16,
			width = 45,
			height = 39,
			frame_count = 16,
			animation_speed = 0.5,
			blend_mode = "additive-soft",
		},
		tail =
		{
			filename = "__m-roguef__/graphics/entity/beam/beam-tail.png",
			line_length = 16,
			width = 45,
			height = 39,
			frame_count = 16,
			blend_mode = "additive-soft",
		},
		body =
		{
			{
				filename = "__m-roguef__/graphics/entity/beam/beam-body-1.png",
				line_length = 16,
				width = 45,
				height = 39,
				frame_count = 16,
				blend_mode = "additive-soft",
			},
			{
				filename = "__m-roguef__/graphics/entity/beam/beam-body-2.png",
				line_length = 16,
				width = 45,
				height = 39,
				frame_count = 16,
				blend_mode = "additive-soft",
			},
			{
				filename = "__m-roguef__/graphics/entity/beam/beam-body-3.png",
				line_length = 16,
				width = 45,
				height = 39,
				frame_count = 16,
				blend_mode = "additive-soft",
			},
			{
				filename = "__m-roguef__/graphics/entity/beam/beam-body-4.png",
				line_length = 16,
				width = 45,
				height = 39,
				frame_count = 16,
				blend_mode = "additive-soft",
			},
			{
				filename = "__m-roguef__/graphics/entity/beam/beam-body-5.png",
				line_length = 16,
				width = 45,
				height = 39,
				frame_count = 16,
				blend_mode = "additive-soft",
			},
			{
				filename = "__m-roguef__/graphics/entity/beam/beam-body-6.png",
				line_length = 16,
				width = 45,
				height = 39,
				frame_count = 16,
				blend_mode = "additive-soft",
			},
		}
	}

})

--stage 5

-- data.raw["locomotive"]["locomotive"].braking_force = 1000
-- data.raw["locomotive"]["locomotive"].friction_force = 0
-- data.raw["locomotive"]["locomotive"].air_resistance = 0
-- data.raw["locomotive"]["locomotive"].weight = 1000
-- data.raw["locomotive"]["locomotive"].max_speed = 0.75

--stage 6

data:extend({

	{
		type = "turret",
		name = "worm-normal-6-1",
		icon = "__base__/graphics/icons/medium-worm.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "not-repairable", "breaths-air"},
		order="b-b-e",
		subgroup="enemies",
		max_health = 1500,
		resistances =
		{
			{
				type = "damage-player",
				percent = 90,
			},
		{
				type = "damage-enemy",
				percent = 100,
			},
		},
		healing_per_tick = 0,
		collision_box = {{-1.1, -1.0}, {1.1, 1.0}},
		selection_box = {{-1.1, -1.0}, {1.1, 1.0}},
		shooting_cursor_size = 3.5,
		rotation_speed = 1,
		corpse = "medium-worm-corpse",
		dying_explosion = "blood-explosion-big",
		dying_sound = make_worm_dying_sounds(0.9),
		folded_speed = 0.01,
		folded_animation = worm_folded_animation(medium_worm_scale, {r=1,g=1,b=1,a=1}),
		prepare_range = 25,
		preparing_speed = 0.025,
		preparing_animation = worm_preparing_animation(medium_worm_scale, {r=1,g=1,b=1,a=1}, "forward"),
		prepared_speed = 0.015,
		prepared_animation = worm_prepared_animation(medium_worm_scale, {r=1,g=1,b=1,a=1}),
		starting_attack_speed = 0.03,
		starting_attack_animation = worm_attack_animation(medium_worm_scale, {r=1,g=1,b=1,a=1}, "forward"),
		starting_attack_sound = make_worm_roars(0.8),
		ending_attack_speed = 0.03,
		ending_attack_animation = worm_attack_animation(medium_worm_scale, {r=1,g=1,b=1,a=1}, "backward"),
		folding_speed = 0.015,
		folding_animation =  worm_preparing_animation(medium_worm_scale, {r=1,g=1,b=1,a=1}, "backward"),
		prepare_range = 50,
		attack_parameters =
	 {
		type = "projectile",
		range = 50,
		cooldown = 120,
		projectile_creation_distance = 0,
		ammo_category = "ammo-enemy",
		ammo_type =
		{
			category = "ammo-enemy",
			target_type = "direction",
			action =
			{
				 {
				 type = "direct",
				 repeat_count = 20,
				 action_delivery =
				 {
					type = "projectile",
					projectile = "ep-50",
					starting_speed = 0.3,
					starting_speed_deviation = 0.2,
					direction_deviation = 0.6,
					range_deviation = 0.6,
					max_range = 40
				 }
				 }
			}
		},
	 },
		build_base_evolution_requirement = 0.3,
		autoplace = enemy_worm_autoplace(2),
		call_for_help_radius = 40
	},

	{
		type = "turret",
		name = "worm-normal-6-2",
		icon = "__base__/graphics/icons/medium-worm.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "not-repairable", "breaths-air"},
		order="b-b-e",
		subgroup="enemies",
		max_health = 1000,
		resistances =
		{
			{
				type = "damage-enemy",
				percent = 100,
			}
		},
		healing_per_tick = 0,
		collision_box = {{-1.1, -1.0}, {1.1, 1.0}},
		selection_box = {{-1.1, -1.0}, {1.1, 1.0}},
		shooting_cursor_size = 3.5,
		rotation_speed = 1,
		corpse = "medium-worm-corpse",
		dying_explosion = "blood-explosion-big",
		dying_sound = make_worm_dying_sounds(0.9),
		folded_speed = 0.01,
		folded_animation = worm_folded_animation(medium_worm_scale, {r=0,g=0,b=1,a=1}),
		prepare_range = 25,
		preparing_speed = 0.025,
		preparing_animation = worm_preparing_animation(medium_worm_scale, {r=0,g=0,b=1,a=1}, "forward"),
		prepared_speed = 0.015,
		prepared_animation = worm_prepared_animation(medium_worm_scale, {r=0,g=0,b=1,a=1}),
		starting_attack_speed = 0.03,
		starting_attack_animation = worm_attack_animation(medium_worm_scale, {r=0,g=0,b=1,a=1}, "forward"),
		starting_attack_sound = make_worm_roars(0.8),
		ending_attack_speed = 0.03,
		ending_attack_animation = worm_attack_animation(medium_worm_scale, {r=0,g=0,b=1,a=1}, "backward"),
		folding_speed = 0.015,
		folding_animation =  worm_preparing_animation(medium_worm_scale, {r=0,g=0,b=1,a=1}, "backward"),
		prepare_range = 50,
		attack_parameters =
	 {
		type = "stream",
		range = 50,
		cooldown = 180,
		projectile_creation_distance = 0,
		ammo_category = "ammo-enemy",
		ammo_type =
		{
			category = "ammo-enemy",
			target_type = "position",
			action =
			{
				 {
				 type = "direct",
				 repeat_count = 1,
				 action_delivery =
				 {
					type = "stream",
					stream = "ep-6-1",
					max_range = 50
				 }
				 }
			}
		},
	 },
		build_base_evolution_requirement = 0.3,
		autoplace = enemy_worm_autoplace(2),
		call_for_help_radius = 40
	},

	{
		type = "stream",
		name = "ep-6-1",
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
		particle_vertical_acceleration = 0.003,
		particle_horizontal_speed = 0.2,
		particle_horizontal_speed_deviation = 0.001,
		particle_start_alpha = 0.5,
		particle_end_alpha = 1,
		particle_start_scale = 0.2,
		particle_loop_frame_count = 1,
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
							entity_name = "explosion-192",
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
							damage = { amount = 100, type = "explosion" }
						}
					}
				}
			},
		},
		spine_animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/ep-6-1.png",
			frame_count = 32,
			line_length=8,
			width = 64,
			height = 64,
			priority = "high",
			blend_mode = "additive",
			animation_speed = 64/60
		},
		shadow =
		{
			filename = "__0_16_graphics__/graphics/entity/acid-projectile-purple/acid-projectile-purple-shadow.png",
			line_length = 5,
			width = 28,
			height = 16,
			frame_count = 33,
			priority = "high",
			scale = 1.5,
			shift = {-0.09 * 1.5, 0.395 * 1.5}
		},
	},

	{
		type = "turret",
		name = "worm-normal-6-3",
		icon = "__base__/graphics/icons/medium-worm.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "not-repairable", "breaths-air"},
		order="b-b-e",
		subgroup="enemies",
		max_health = 500,
		resistances =
		{
			{
				type = "damage-enemy",
				percent = 100,
			}
		},
		healing_per_tick = 0,
		collision_box = {{-1.1, -1.0}, {1.1, 1.0}},
		selection_box = {{-1.1, -1.0}, {1.1, 1.0}},
		shooting_cursor_size = 3.5,
		rotation_speed = 1,
		corpse = "medium-worm-corpse",
		dying_explosion = "blood-explosion-big",
		dying_sound = make_worm_dying_sounds(0.9),
		folded_speed = 1,
		folded_animation = worm_folded_animation(medium_worm_scale, {r=1,g=0,b=0,a=1}),
		prepare_range = 25,
		preparing_speed = 1,
		preparing_animation = worm_preparing_animation(medium_worm_scale, {r=1,g=0,b=0,a=1}, "forward"),
		prepared_speed = 1,
		prepared_animation = worm_prepared_animation(medium_worm_scale, {r=1,g=0,b=0,a=1}),
		starting_attack_speed = 1,
		starting_attack_animation = worm_attack_animation(medium_worm_scale, {r=1,g=0,b=0,a=1}, "forward"),
		starting_attack_sound = make_worm_roars(0.1),
		ending_attack_speed = 0.1,
		ending_attack_animation = worm_attack_animation(medium_worm_scale, {r=1,g=0,b=0,a=1}, "backward"),
		folding_speed = 1,
		folding_animation =  worm_preparing_animation(medium_worm_scale, {r=1,g=0,b=0,a=1}, "backward"),
		prepare_range = 50,
		attack_parameters =
	 {
		type = "projectile",
		range = 50,
		cooldown = 6,
		projectile_creation_distance = 2,
		ammo_category = "ammo-enemy",
		ammo_type =
		{
			category = "ammo-enemy",
			target_type = "direction",
			action =
			{
				 {
				 type = "direct",
				 --repeat_count = 20,
				 action_delivery =
				 {
					type = "projectile",
					projectile = "ep-30",
					starting_speed = 0.2,
					max_range = 40
				 }
				 }
			}
		},
	 },
		build_base_evolution_requirement = 0.3,
		autoplace = enemy_worm_autoplace(2),
		call_for_help_radius = 40
	},

	{
		type = "unit",
		name = "biter-normal-6",
		icon = "__base__/graphics/icons/small-biter.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air"},
		max_health = 1000,
		resistances =
		{
			{
				type = "damage-enemy",
				percent = 100
			}
		},
		order = "a",
		subgroup="rf_enemy",
		healing_per_tick = 0,
		collision_box = {{-0.3, 0}, {0.3, 0.6}},
		selection_box = {{-0.4, -0.7}, {0.7, 0.4}},
		sticker_box = {{-0.2, -0.2}, {0.2, 0.2}},
		attack_parameters =
		{
			type = "projectile",
			range = 0.5,
			cooldown = 60,
			ammo_category = "ammo-enemy",
			ammo_type =
		{
		 category = "ammo-enemy",
		 target_type = "entity",
		 action =
		 {
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
				 type = "damage",
				 damage = { amount = 50 , type = "damage-enemy"}
				}
			}
		 }
		},
			sound = make_biter_roars(0.5),
			animation = biterattackanimation(smallbiterscale*2, {r=1,g=0,b=0,a=1}, {r=1,g=0,b=0,a=1})
		},
		vision_distance = 50,
		movement_speed = 0.1,
		distance_per_frame = 0.1,
		pollution_to_join_attack = 0,
		distraction_cooldown = 0,
		corpse = "big-biter-corpse",
		dying_explosion = "blood-explosion-big",
		dying_sound =  make_biter_dying_sounds(1.0),
		working_sound =  make_biter_calls(0.7),
		run_animation = biterrunanimation(smallbiterscale*2, {r=1,g=0,b=0,a=1}, {r=1,g=0,b=0,a=1}),
	},

	{
		type = "unit",
		name = "spitter-normal-6",
		icon = "__base__/graphics/icons/small-spitter.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
		max_health = 500,
		resistances =
		{
			{
				type = "damage-enemy",
				percent = 100
			}
		},
		order="b",
		subgroup="rf_enemy",
		healing_per_tick = 0,
		collision_box = {{-0.3, 0}, {0.3, 0.6}},
		selection_box = {{-0.4, -0.4}, {0.4, 0.4}},
		sticker_box = {{-0.3, -0.5}, {0.3, 0.1}},
		distraction_cooldown = 300,
		attack_parameters =
	 {
		type = "projectile",
		range = 30,
		cooldown = 2,
		projectile_creation_distance = 0,
		ammo_category = "ammo-enemy",
		ammo_type =
		{
		 category = "ammo-enemy",
		 target_type = "entity",
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
					 entity_name = "slow-aura"
					}
				}
			 }
			},
			{
				type = "direct",
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
					 type = "damage",
					 damage = { amount = 0 , type = "damage-enemy"}
					}
				}
			}
		 }
		},
		--sound = make_spitter_roars(0.7),
		animation = spitterattackanimation(smallspitterscale, {r=1,g=1,b=0,a=1}),
	},
		vision_distance = 50,
		movement_speed = 0.185,
		distance_per_frame = 0.04,
		-- in pu
		pollution_to_join_attack = 0,
		corpse = "small-spitter-corpse",
		dying_explosion = "blood-explosion-small",
		working_sound = make_biter_calls(0.65),
		dying_sound = make_spitter_dying_sounds(1.0),
		run_animation = spitterrunanimation(smallspitterscale, {r=1,g=1,b=0,a=1})
	},

	 {
		type = "explosion",
		name = "slow-aura",
		flags = {"not-on-map","placeable-off-grid"},
		animations =
		{
			{
				filename = "__m-roguef__/graphics/entity/explosion/slow-aura.png",
				priority = "low",
				width = 182,
				height = 160,
				frame_count = 2,
				animation_speed = 1,
				shift = {0, 1},
			blend_mode="additive"
			}
		},
		rotate = true,
	},

	{
		type = "turret",
		name = "worm-normal-6-4",
		icon = "__base__/graphics/icons/medium-worm.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "not-repairable", "breaths-air"},
		order="b-b-e",
		subgroup="enemies",
		max_health = 1000,
		resistances =
		{
			{
				type = "damage-enemy",
				percent = 100,
			}
		},
		healing_per_tick = 0,
		collision_box = {{-1.1, -1.0}, {1.1, 1.0}},
		selection_box = {{-1.1, -1.0}, {1.1, 1.0}},
		shooting_cursor_size = 3.5,
		rotation_speed = 1,
		corpse = "medium-worm-corpse",
		dying_explosion = "blood-explosion-big",
		dying_sound = make_worm_dying_sounds(0.9),
		folded_speed = 1,
		folded_animation = worm_folded_animation(medium_worm_scale, {r=0,g=1,b=0,a=1}),
		prepare_range = 25,
		preparing_speed = 1,
		preparing_animation = worm_preparing_animation(medium_worm_scale, {r=0,g=1,b=0,a=1}, "forward"),
		prepared_speed = 1,
		prepared_animation = worm_prepared_animation(medium_worm_scale, {r=0,g=1,b=0,a=1}),
		starting_attack_speed = 1,
		starting_attack_animation = worm_attack_animation(medium_worm_scale, {r=0,g=1,b=0,a=1}, "forward"),
		starting_attack_sound = make_worm_roars(0.1),
		ending_attack_speed = 0.1,
		ending_attack_animation = worm_attack_animation(medium_worm_scale, {r=0,g=1,b=0,a=1}, "backward"),
		folding_speed = 1,
		folding_animation =  worm_preparing_animation(medium_worm_scale, {r=0,g=1,b=0,a=1}, "backward"),
		prepare_range = 50,
		attack_parameters =
	 {
		type = "projectile",
		range = 50,
		cooldown = 120,
		projectile_creation_distance = 0,
		ammo_category = "ammo-enemy",
		ammo_type =
		{
			category = "ammo-enemy",
			target_type = "position",
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
						 type = "create-entity",
						 entity_name = "ep-6-2"
						}
					}
				 }
				},
			}
		},
	 },
		build_base_evolution_requirement = 0.3,
		autoplace = enemy_worm_autoplace(2),
		call_for_help_radius = 40
	},

	{
		type = "projectile",
		name = "ep-6-2",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		action =
		{
		{
				type = "cluster",
				cluster_count = 30,
				distance = 4,
				distance_deviation = 3,
				action_delivery =
				{
					type = "projectile",
					projectile = "ep-6-3",
					direction_deviation = 0.6,
					starting_speed = 0.2,
					starting_speed_deviation = 0.1,
			 max_range=50
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
		name = "ep-6-3",
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
				 damage = {amount = -20, type = "damage-enemy"}
				},
				{
				 type = "damage",
				 damage = {amount = 20, type = "damage-enemy"}
				},
				{
				 type = "create-entity",
				 entity_name = "firstaid"
				},
			}
			}
		},
		animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/ep-6-3.png",
			frame_count = 1,
			width = 17,
			height = 17,
			priority = "high",
		},
	},

})

--stage 7

data:extend({

	{
		type = "unit",
		name = "boss-7",
		icon = "__base__/graphics/icons/small-biter.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air"},
		max_health = 10000,
		resistances =
		{
			{
				type = "damage-enemy",
				percent = 100
			}
		},
		order = "a",
		subgroup="rf_enemy",
		healing_per_tick = 0,
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
		sticker_box = {{-0.5, -0.5}, {0.5, 0.5}},
		attack_parameters =
		{
			type = "projectile",
			range = 1,
			cooldown = 60,
			ammo_category = "ammo-enemy",
			ammo_type =
		{
		 category = "ammo-enemy",
		 target_type = "entity",
		 action =
		 {
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
				 type = "damage",
				 damage = { amount = 200 , type = "damage-enemy"}
				}
			}
		 }
		},
			sound =
		{
		 {
			filename = "__m-roguef__/sound/andariel/attack1.ogg",
			volume = 0.5
		 },
		 {
			filename = "__m-roguef__/sound/andariel/attack2.ogg",
			volume = 0.5
		 },
		 {
			filename = "__m-roguef__/sound/andariel/attack3.ogg",
			volume = 0.5
		 },
		 {
			filename = "__m-roguef__/sound/andariel/attack4.ogg",
			volume = 0.5
		 },
		 },
			animation =
		{
				width = 247,
				height = 248,
				frame_count = 16,
				direction_count = 8,
			stripes =
				{
				 {
					filename = "__m-roguef__/graphics/entity/anda/attack-1.png",
					width_in_frames = 8,
					height_in_frames = 8,
				 },
				 {
					filename = "__m-roguef__/graphics/entity/anda/attack-2.png",
					width_in_frames = 8,
					height_in_frames = 8,
				 }
				},
				shift = {0,-2},
				--scale = scale,
			},
		},
		vision_distance = 50,
		movement_speed = 0.15,
		distance_per_frame = 0.3,
		pollution_to_join_attack = 0,
		distraction_cooldown = 0,
		corpse = "boss-7-corpse",
		dying_explosion = "blood-explosion-big",
		dying_sound =
		{
			{
				filename = "__m-roguef__/sound/andariel/death.ogg",
				volume = 1
			},
		},
		working_sound =
		{
			{
				filename = "__m-roguef__/sound/andariel/neutral1.ogg",
				volume = 1
			},
		},
		run_animation =
		{
			width = 148,
			height = 184,
			frame_count = 12,
			direction_count = 8,
			filename = "__m-roguef__/graphics/entity/anda/run-1.png",
			shift = {0,-2},
			--scale = scale,
		},
	},

	{
		type = "corpse",
		name = "boss-7-corpse",
		icon = "__base__/graphics/icons/small-biter-corpse.png",
		icon_size = 32,
		selection_box = {{-0.8, -0.8}, {0.8, 0.8}},
		selectable_in_game = false,
		subgroup="corpses",
		order = "c[corpse]-a[biter]-a[small]",
		flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-repairable", "not-on-map"},
		dying_speed = 0.01,
		time_before_removed = 15 * 60 * 60,
		final_render_layer = "corpse",
		-- TODO: FIX THIS ANIMATION
		-- animation =
		-- {
			-- width = 203,
			-- height = 232,
			-- frame_count = 23,
			-- direction_count = 8,
			-- stripes =
			-- {
			--   {
			--     filename = "__m-roguef__/graphics/entity/anda/die-1.png",
			--     width_in_frames = 8,
			--     height_in_frames = 8,
			--   },
			--   {
			--     filename = "__m-roguef__/graphics/entity/anda/die-2.png",
			--     width_in_frames = 7,
			--     height_in_frames = 8,
			--   },
			--   {
			--     filename = "__m-roguef__/graphics/entity/anda/die-3.png",
			--     width_in_frames = 8,
			--     height_in_frames = 8,
			--   }
			-- },
			-- shift = {0,-2},
			--scale = scale,
		-- },
	},

	{
		type = "smoke-with-trigger",
		name = "poison-cloud-7",
		flags = {"not-on-map"},
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
		shift={0,1}
		},
		slow_down_factor = 0,
		affected_by_wind = true,
		cyclic = true,
		duration = 60 * 10,
		fade_away_duration = 1 * 60,
		spread_duration = 10,
		color = { r = 0.8, g = 0.2, b = 0.8 },
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
						radius = 3,
						entity_flags = {"breaths-air"},
						action_delivery =
						{
							type = "instant",
							target_effects =
							{
								type = "damage",
								damage = { amount = 10, type = "damage-enemy"}
							},
						}
					}
				}
			}
		},
		action_frequency = 10
	},

	{
		type = "unit",
		name = "larva-7",
		icon = "__base__/graphics/icons/small-biter.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air"},
		max_health = 200,
		resistances =
		{
			{
				type = "damage-enemy",
				percent = 100
			}
		},
		order = "a",
		subgroup="rf_enemy",
		healing_per_tick = 0,
		collision_box = {{-0.3, -0.3}, {0.3, 0.3}},
		selection_box = {{-0.3, -0.3}, {0.3, 0.3}},
		sticker_box = {{-0.3, -0.3}, {0.3, 0.3}},
		attack_parameters =
		{
			type = "projectile",
			range = 0.1,
			cooldown = 60,
			ammo_category = "ammo-enemy",
			ammo_type =
		{
		 category = "ammo-enemy",
		 target_type = "entity",
		 action =
		 {
				type = "direct",
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						type = "damage",
						damage = { amount = 100 , type = "damage-enemy"}
					}
				}
		 }
		 },
		 sound =
		{
			{
				filename = "__m-roguef__/sound/larva/attack-1.ogg",
				volume = 1
			},
			{
				filename = "__m-roguef__/sound/larva/attack-2.ogg",
				volume = 1
			},
			{
				filename = "__m-roguef__/sound/larva/attack-3.ogg",
				volume = 1
			},
			},
			animation =
			{
				width = 32,
				height = 28,
				frame_count = 5,
				direction_count = 16,
				filename = "__m-roguef__/graphics/entity/larva/move.png",
				shift = {0,0},
				--scale = scale,
			},
		},
	 dying_sound =
		{
		 {
			filename = "__m-roguef__/sound/larva/die.ogg",
			volume = 1
		 },
		},
		 working_sound =
		{
		 {
			filename = "__m-roguef__/sound/larva/working.ogg",
			volume = 0.5
		 },
		},
		vision_distance = 50,
		movement_speed = 0.15,
		distance_per_frame = 0.3,
		pollution_to_join_attack = 0,
		distraction_cooldown = 0,
		corpse = "larva-7-corpse",
		--dying_explosion = "blood-explosion-small",
		run_animation =
	 {
		width = 32,
		height = 28,
		frame_count = 5,
		direction_count = 16,
		filename = "__m-roguef__/graphics/entity/larva/move.png",
		shift = {0,0},
		--scale = scale,
	 },
	},

	{
		type = "unit",
		name = "larva-7-big",
		icon = "__base__/graphics/icons/small-biter.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air"},
		max_health = 3000,
		resistances =
		{
			{
				type = "damage-enemy",
				percent = 100
			}
		},
		order = "a",
		subgroup="rf_enemy",
		healing_per_tick = 0,
		collision_box = {{-0.3*2, -0.3*2}, {0.3*2, 0.3*2}},
		selection_box = {{-0.3*2, -0.3*2}, {0.3*2, 0.3*2}},
		sticker_box = {{-0.3, -0.3}, {0.3, 0.3}},
		attack_parameters =
		{
			type = "projectile",
			range = 0.1,
			cooldown = 60,
			ammo_category = "ammo-enemy",
			ammo_type =
		{
		 category = "ammo-enemy",
		 target_type = "entity",
		 action =
		 {
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
				 type = "damage",
				 damage = { amount = 200 , type = "damage-enemy"}
				}
			}
		 }
		 },
		 sound =
		{
		 {
			filename = "__m-roguef__/sound/larva/attack-1.ogg",
			volume = 1
		 },
		 {
			filename = "__m-roguef__/sound/larva/attack-2.ogg",
			volume = 1
		 },
		 {
			filename = "__m-roguef__/sound/larva/attack-3.ogg",
			volume = 1
		 },
		 },
			animation =
		{
				width = 32,
				height = 28,
				frame_count = 5,
				direction_count = 16,
				filename = "__m-roguef__/graphics/entity/larva/move.png",
				shift = {0,0},
				scale = 2,
			},
		},
	 dying_sound =
		{
		 {
			filename = "__m-roguef__/sound/larva/die.ogg",
			volume = 1
		 },
		},
		 working_sound =
		{
		 {
			filename = "__m-roguef__/sound/larva/working.ogg",
			volume = 0.5
		 },
		},
		vision_distance = 50,
		movement_speed = 0.1,
		distance_per_frame = 0.3,
		pollution_to_join_attack = 0,
		distraction_cooldown = 0,
		corpse = "larva-7-corpse",
		--dying_explosion = "blood-explosion-small",
		run_animation =
	 {
		width = 32,
		height = 28,
		frame_count = 5,
		direction_count = 16,
		filename = "__m-roguef__/graphics/entity/larva/move.png",
		shift = {0,0},
		scale = 2,
	 },
	},

	{
		type = "corpse",
		name = "larva-7-corpse",
		icon = "__base__/graphics/icons/small-biter-corpse.png",
		icon_size = 32,
		selection_box = {{-0.8, -0.8}, {0.8, 0.8}},
		selectable_in_game = false,
		subgroup="corpses",
		order = "c[corpse]-a[biter]-a[small]",
		flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-repairable", "not-on-map"},
		dying_speed = 0.03,
		time_before_removed = 15 * 60 * 60,
		final_render_layer = "corpse",
		animation =
		{
			width = 47,
			height = 24,
			frame_count = 9,
			direction_count = 1,
			filename = "__m-roguef__/graphics/entity/larva/die.png",
			shift = {0,0},
			--scale = scale,
		},
	},

	{
		type = "explosion",
		name = "egg-pre",
		flags = {"not-on-map","placeable-off-grid"},
		animations =
		{
			{
				filename = "__m-roguef__/graphics/entity/egg/pre.png",
				frame_count = 4,
				width = 36,
				height = 41,
				priority = "extra-high",
				animation_speed=4/30,
				shift={0,1}
			},
		}
	},

	{
		type = "explosion",
		name = "egg-pre-big",
		flags = {"not-on-map","placeable-off-grid"},
		animations =
		{
			{
				filename = "__m-roguef__/graphics/entity/egg/pre.png",
				frame_count = 4,
				width = 36,
				height = 41,
				priority = "extra-high",
				animation_speed=4/30,
				shift={0,1},
				scale=2
			},
		}
	},

	{
		type = "unit",
		name = "egg-7",
		icon = "__base__/graphics/icons/small-biter.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air"},
		max_health = 500,
		resistances =
		{
			{
				type = "damage-enemy",
				percent = 100
			}
		},
		order = "a",
		subgroup="rf_enemy",
		healing_per_tick = 1,
		collision_box = {{-0.3, -0.3}, {0.3, 0.3}},
		selection_box = {{-0.3, -0.3}, {0.3, 0.3}},
		sticker_box = {{-0.3, -0.3}, {0.3, 0.3}},
		attack_parameters =
		{
			type = "projectile",
			range = 100,
			cooldown = 30,
			ammo_category = "ammo-enemy",
			ammo_type =
		{
		 category = "ammo-enemy",
		 target_type = "entity",
		 action =
		 {
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
				 type = "damage",
				 damage = { amount = 0 , type = "damage-enemy"}
				}
			}
		 }
		 },
			animation =
		{
				width = 36,
				height = 41,
				frame_count = 12,
				direction_count = 1,
				filename = "__m-roguef__/graphics/entity/egg/idle.png",
				shift = {0,0},
				--scale = scale,
			},
		},
	 dying_sound =
		{
		 {
			filename = "__m-roguef__/sound/larva/die.ogg",
			volume = 1
		 },
		},
		vision_distance = 50,
		movement_speed = 0,
		distance_per_frame = 0,
		pollution_to_join_attack = 0,
		distraction_cooldown = 0,
		corpse = "egg-7-corpse",
		--dying_explosion = "blood-explosion-small",
		run_animation =
	 {
		width = 36,
		height = 41,
		frame_count = 12,
		direction_count = 1,
		filename = "__m-roguef__/graphics/entity/egg/idle.png",
		shift = {0,0},
		--scale = scale,
	},
	},

	{
		type = "unit",
		name = "egg-7-big",
		icon = "__base__/graphics/icons/small-biter.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air"},
		max_health = 60*60,
		resistances =
		{
			{
				type = "damage-enemy",
				percent = 100
			},
		{
				type = "damage-player",
				percent = 100
			}
		},
		order = "a",
		subgroup="rf_enemy",
		healing_per_tick = 1,
		collision_box = {{-0.3*2, -0.3*2}, {0.3*2, 0.3*2}},
		selection_box = {{-0.3*2, -0.3*2}, {0.3*2, 0.3*2}},
		sticker_box = {{-0.3, -0.3}, {0.3, 0.3}},
		attack_parameters =
		{
			type = "projectile",
			range = 100,
			cooldown = 30,
			ammo_category = "ammo-enemy",
			ammo_type =
		{
		category = "ammo-enemy",
		target_type = "entity",
		action =
		 {
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					type = "damage",
					damage = { amount = 0 , type = "damage-enemy"}
				}
			}
			}
			},
			animation =
			{
				width = 36,
				height = 41,
				frame_count = 12,
				direction_count = 1,
				filename = "__m-roguef__/graphics/entity/egg/idle.png",
				shift = {0,0},
				scale = 2,
			},
		},
		dying_sound =
		{
			{
				filename = "__m-roguef__/sound/larva/die.ogg",
				volume = 1
			},
		},
		vision_distance = 50,
		movement_speed = 0,
		distance_per_frame = 0,
		pollution_to_join_attack = 0,
		distraction_cooldown = 0,
		corpse = "egg-7-corpse",
		--dying_explosion = "blood-explosion-small",
		run_animation =
		{
			width = 36,
			height = 41,
			frame_count = 12,
			direction_count = 1,
			filename = "__m-roguef__/graphics/entity/egg/idle.png",
			shift = {0,0},
			scale = 2,
		},
	},

	{
		type = "corpse",
		name = "egg-7-corpse",
		icon = "__base__/graphics/icons/small-biter-corpse.png",
		icon_size = 32,
		selection_box = {{-0.8, -0.8}, {0.8, 0.8}},
		selectable_in_game = false,
		subgroup="corpses",
		order = "c[corpse]-a[biter]-a[small]",
		flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-repairable", "not-on-map"},
		dying_speed = 0.03,
		time_before_removed = 15 * 60 * 60,
		final_render_layer = "corpse",
		animation =
		{
			width = 70,
			height = 60,
			frame_count = 12,
			direction_count = 1,
			filename = "__m-roguef__/graphics/entity/egg/die.png",
			shift = {0,0},
			--scale = scale,
		},
	},

	{
		type = "explosion",
		name = "ep-7-1",
		flags = {"not-on-map","placeable-off-grid"},
		animations =
		{
			{
				filename = "__m-roguef__/graphics/entity/explosion/ep-7-1.png",
				priority = "extra-high",
				width = 29,
				height = 38,
				frame_count = 11,
				shift={0,0.3},
				animation_speed = 9/20,
				scale=2
			}
		},
	 created_effect =
	 {
			type = "area",
			radius = 0.5,
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "damage",
						damage = {amount = 200, type = "damage-enemy"}
					},
				}
			}
	 },
	 sound =
		{
			aggregation =
			{
				max_count = 1,
				remove = false
			},
			variations =
			{
				{
					filename = "__m-roguef__/sound/shot-9.ogg",
					volume = 0.5
				}
			}
		}
	},

	{
		type = "smoke-with-trigger",
		name = "gas-7",
		flags = {"not-on-map"},
		show_when_smoke_off = true,
		animation =
		{
			filename = "__m-roguef__/graphics/entity/noani/no.png",
			flags = { "compressed" },
			priority = "low",
			width = 1,
			height = 1,
			frame_count = 1,
		},
		slow_down_factor = 0,
		affected_by_wind = true,
		cyclic = true,
		duration = 60 * 60*60,
		fade_away_duration = 1 * 60,
		spread_duration = 10,
	},

})

--stage 8

data:extend({

	{
		type = "unit",
		name = "boss-8-1",
		icon = "__base__/graphics/icons/small-biter.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air"},
		max_health = 12000,
		resistances =
		{
			{
				type = "damage-enemy",
				percent = 100
			}
		},
		order = "a",
		subgroup="rf_enemy",
		healing_per_tick = 0,
		collision_box = {{-0.7, -0.5}, {0.7, 0.5}},
		selection_box = {{-0.7, -0.5}, {0.7, 0.5}},
		sticker_box = {{-0.5, -0.5}, {0.5, 0.5}},
		attack_parameters =
		{
			type = "projectile",
			range = 1,
			cooldown = 60,
			ammo_category = "ammo-enemy",
			ammo_type =
		{
		 category = "ammo-enemy",
		 target_type = "entity",
		 action =
		 {
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
				 type = "damage",
				 damage = { amount = 200 , type = "damage-enemy"}
				}
			}
		 }
		},
			sound =
		{
		 {
			filename = "__m-roguef__/sound/diablo/attack1.ogg",
			volume = 0.5
		 },
		 {
			filename = "__m-roguef__/sound/diablo/attack2.ogg",
			volume = 0.5
		 },
		 {
			filename = "__m-roguef__/sound/diablo/attack3.ogg",
			volume = 0.5
		 },
		 {
			filename = "__m-roguef__/sound/diablo/attack4.ogg",
			volume = 0.5
		 },
		 {
			filename = "__m-roguef__/sound/diablo/attack5.ogg",
			volume = 0.5
		 },
		 {
			filename = "__m-roguef__/sound/diablo/attack6.ogg",
			volume = 0.5
		 },
		 },
			animation =
		{
				width = 288,
				height = 237,
				frame_count = 16,
				direction_count = 8,
			stripes =
				{
				 {
					filename = "__m-roguef__/graphics/entity/diablo/attack-1.png",
					width_in_frames = 6,
					height_in_frames = 8,
				 },
				 {
					filename = "__m-roguef__/graphics/entity/diablo/attack-2.png",
					width_in_frames = 4,
					height_in_frames = 8,
				 },
			{
					filename = "__m-roguef__/graphics/entity/diablo/attack-3.png",
					width_in_frames = 6,
					height_in_frames = 8,
				 }
				},
				shift = {0,-2},
				--scale = scale,
			},
		},
		vision_distance = 50,
		movement_speed = 0.15,
		distance_per_frame = 0.3,
		pollution_to_join_attack = 0,
		distraction_cooldown = 0,
		corpse = "boss-8-corpse",
		dying_explosion = "blood-explosion-big",
		dying_sound =
	{
	 {
		filename = "__m-roguef__/sound/diablo/death.ogg",
		volume = 1
	 },
	},
		working_sound =
	{
	 {
		filename = "__m-roguef__/sound/diablo/yell.ogg",
		volume = 1
	 },
	},
		run_animation =
	 {
		width = 293,
		height = 188,
		frame_count = 12,
		direction_count = 8,
		stripes =
		{
		{
		 filename = "__m-roguef__/graphics/entity/diablo/walk-1.png",
		 width_in_frames = 6,
		 height_in_frames = 8,
		},
		{
		 filename = "__m-roguef__/graphics/entity/diablo/walk-2.png",
		 width_in_frames = 6,
		 height_in_frames = 8,
		},
		},
		shift = {0,-2},
		--scale = scale,
	},
	},

	{
		type = "corpse",
		name = "boss-8-corpse",
		icon = "__base__/graphics/icons/small-biter-corpse.png",
		icon_size = 32,
		selection_box = {{-0.8, -0.8}, {0.8, 0.8}},
		selectable_in_game = false,
		subgroup="corpses",
		order = "c[corpse]-a[biter]-a[small]",
		flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-repairable", "not-on-map"},
		dying_speed = 0.01,
		time_before_removed = 15 * 60 * 60,
		final_render_layer = "corpse",
		animation =
		{
			width = 169,
			height = 160,
			frame_count = 1,
			direction_count = 1,
			filename = "__m-roguef__/graphics/entity/diablo/die.png",
			shift = {0,-1},
			--scale = scale,
		},
	},

	{
		type = "unit",
		name = "boss-8-2",
		icon = "__base__/graphics/icons/small-biter.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air"},
		max_health = 12000,
		resistances =
		{
			{
				type = "damage-enemy",
				percent = 100
			}
		},
		order = "a",
		subgroup="rf_enemy",
		healing_per_tick = 0,
		collision_box = {{-0.7, -0.5}, {0.7, 0.5}},
		selection_box = {{-0.7, -0.5}, {0.7, 0.5}},
		sticker_box = {{-0.5, -0.5}, {0.5, 0.5}},
		attack_parameters =
	 {
		type = "projectile",
		range = 100,
		cooldown = 3,
		projectile_creation_distance = 2,
		ammo_category = "ammo-enemy",
		ammo_type =
		{
			category = "ammo-enemy",
			target_type = "entity",
			action =
			{
				 {
				 type = "direct",
				 --repeat_count = 20,
				 action_delivery =
				 {
					type = "projectile",
					projectile = "ep-8-2",
					starting_speed = 0.7,
					max_range = 50
				 }
				 }
			}
		},
			animation =
		{
				width = 266,
				height = 256,
				frame_count = 1,
				direction_count = 8,
			stripes =
				{
				 {
					filename = "__m-roguef__/graphics/entity/diablo/cast-3.png",
					width_in_frames = 1,
					height_in_frames = 8,
				 },
				},
				shift = {0,-2},
				--scale = scale,
			},
		},
		vision_distance = 50,
		movement_speed = 0.15,
		distance_per_frame = 0.3,
		pollution_to_join_attack = 0,
		distraction_cooldown = 0,
		corpse = "boss-8-corpse",
		dying_explosion = "blood-explosion-big",
		dying_sound =
	{
	 {
		filename = "__m-roguef__/sound/diablo/death.ogg",
		volume = 1
	 },
	},
		working_sound =
	{
	 {
		filename = "__m-roguef__/sound/diablo/yell.ogg",
		volume = 1
	 },
	},
		run_animation =
	 {
		width = 293,
		height = 188,
		frame_count = 12,
		direction_count = 8,
		stripes =
		{
		{
		 filename = "__m-roguef__/graphics/entity/diablo/walk-1.png",
		 width_in_frames = 6,
		 height_in_frames = 8,
		},
		{
		 filename = "__m-roguef__/graphics/entity/diablo/walk-2.png",
		 width_in_frames = 6,
		 height_in_frames = 8,
		},
		},
		shift = {0,-2},
		--scale = scale,
	},
	},

	{
		type = "fire",
		name = "blaze-8",
		flags = {"placeable-off-grid", "not-on-map"},
		duration = 60000,
		fade_away_duration = 60000,
		spread_duration = 60000,
		start_scale = 1,
		end_scale = 0.01,
		color = {r=1, g=0.9, b=0, a=0.5},
		damage_per_tick = {amount = 2, type = "damage-enemy"},
		-- spawn_entity = "noani",
		spread_delay = 300,
		spread_delay_deviation = 180,
		maximum_spread_count = 100,
		initial_lifetime = 60000,
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
			scale = fire_scale,
			tint = fire_tint,
			flags = fire_flags,
			shift = { -0.0390625/2, -0.90625/2 }
		 }},
		light = {intensity = 1, size = 20},
		working_sound =
		{
		 sound = { filename = "__base__/sound/furnace.ogg" },
		 max_sounds_per_type = 3
		},
	},

	{
		type = "turret",
		name = "worm-normal-8-1",
		icon = "__base__/graphics/icons/medium-worm.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "not-repairable", "breaths-air"},
		order="b-b-e",
		subgroup="enemies",
		max_health = 1500,
		resistances =
		{
		{
				type = "damage-enemy",
				percent = 100,
			},
		},
		healing_per_tick = 0,
		collision_box = {{-1.1, -1.0}, {1.1, 1.0}},
		selection_box = {{-1.1, -1.0}, {1.1, 1.0}},
		shooting_cursor_size = 3.5,
		rotation_speed = 1,
		corpse = "medium-worm-corpse",
		dying_explosion = "blood-explosion-big",
		dying_sound = make_worm_dying_sounds(0.9),
		folded_speed = 0.01,
		folded_animation = worm_folded_animation(medium_worm_scale, {r=1,g=1,b=1,a=1}),
		prepare_range = 25,
		preparing_speed = 0.025,
		preparing_animation = worm_preparing_animation(medium_worm_scale, {r=1,g=1,b=1,a=1}, "forward"),
		prepared_speed = 0.015,
		prepared_animation = worm_prepared_animation(medium_worm_scale, {r=1,g=1,b=1,a=1}),
		starting_attack_speed = 0.03,
		starting_attack_animation = worm_attack_animation(medium_worm_scale, {r=1,g=1,b=1,a=1}, "forward"),
		starting_attack_sound = make_worm_roars(0.8),
		ending_attack_speed = 0.03,
		ending_attack_animation = worm_attack_animation(medium_worm_scale, {r=1,g=1,b=1,a=1}, "backward"),
		folding_speed = 0.015,
		folding_animation =  worm_preparing_animation(medium_worm_scale, {r=1,g=1,b=1,a=1}, "backward"),
		prepare_range = 50,
		attack_parameters =
	 {
		type = "projectile",
		range = 50,
		cooldown = 60,
		projectile_creation_distance = 0,
		ammo_category = "ammo-enemy",
		ammo_type =
		{
			category = "ammo-enemy",
			target_type = "direction",
			action =
			{
				 {
				 type = "direct",
				 repeat_count = 20,
				 action_delivery =
				 {
					type = "projectile",
					projectile = "ep-50",
					starting_speed = 0.3,
					starting_speed_deviation = 0.2,
					direction_deviation = 0.6,
					range_deviation = 0.6,
					max_range = 50
				 }
				 }
			}
		},
	 },
		build_base_evolution_requirement = 0.3,
		autoplace = enemy_worm_autoplace(2),
		call_for_help_radius = 40
	},

	{
		type = "turret",
		name = "worm-normal-8-2",
		icon = "__base__/graphics/icons/medium-worm.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "not-repairable", "breaths-air"},
		order="b-b-e",
		subgroup="enemies",
		max_health = 1500,
		resistances =
		{
			{
				type = "damage-enemy",
				percent = 100,
			}
		},
		healing_per_tick = 0,
		collision_box = {{-1.1, -1.0}, {1.1, 1.0}},
		selection_box = {{-1.1, -1.0}, {1.1, 1.0}},
		shooting_cursor_size = 3.5,
		rotation_speed = 1,
		corpse = "medium-worm-corpse",
		dying_explosion = "blood-explosion-big",
		dying_sound = make_worm_dying_sounds(0.9),
		folded_speed = 0.01,
		folded_animation = worm_folded_animation(medium_worm_scale, {r=0,g=0,b=1,a=1}),
		prepare_range = 25,
		preparing_speed = 0.025,
		preparing_animation = worm_preparing_animation(medium_worm_scale, {r=0,g=0,b=1,a=1}, "forward"),
		prepared_speed = 0.015,
		prepared_animation = worm_prepared_animation(medium_worm_scale, {r=0,g=0,b=1,a=1}),
		starting_attack_speed = 0.03,
		starting_attack_animation = worm_attack_animation(medium_worm_scale, {r=0,g=0,b=1,a=1}, "forward"),
		starting_attack_sound = make_worm_roars(0.8),
		ending_attack_speed = 0.03,
		ending_attack_animation = worm_attack_animation(medium_worm_scale, {r=0,g=0,b=1,a=1}, "backward"),
		folding_speed = 0.015,
		folding_animation =  worm_preparing_animation(medium_worm_scale, {r=0,g=0,b=1,a=1}, "backward"),
		prepare_range = 50,
		attack_parameters =
	 {
		type = "stream",
		range = 50,
		cooldown = 60,
		projectile_creation_distance = 0,
		ammo_category = "ammo-enemy",
		ammo_type =
		{
			category = "ammo-enemy",
			target_type = "position",
			action =
			{
				 {
				 type = "direct",
				 repeat_count = 1,
				 action_delivery =
				 {
					type = "stream",
					stream = "ep-8-3",
					max_range = 50
				 }
				 }
			}
		},
	 },
		build_base_evolution_requirement = 0.3,
		autoplace = enemy_worm_autoplace(2),
		call_for_help_radius = 40
	},

	{
		type = "stream",
		name = "ep-8-3",
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
		particle_vertical_acceleration = 0.003,
		particle_horizontal_speed = 0.3,
		particle_horizontal_speed_deviation = 0.001,
		particle_start_alpha = 0.5,
		particle_end_alpha = 1,
		particle_start_scale = 0.2,
		particle_loop_frame_count = 1,
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
							entity_name = "explosion-128",
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
							damage = { amount = 100, type = "damage-enemy" }
						}
					}
				}
			},
		},
		spine_animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/ep-6-1.png",
			frame_count = 32,
			line_length=8,
			width = 64,
			height = 64,
			priority = "high",
		blend_mode = "additive",
		animation_speed = 64/60
		},
		shadow =
		{
			filename = "__0_16_graphics__/graphics/entity/acid-projectile-purple/acid-projectile-purple-shadow.png",
			line_length = 5,
			width = 28,
			height = 16,
			frame_count = 33,
			priority = "high",
			scale = 1.5,
			shift = {-0.09 * 1.5, 0.395 * 1.5}
		},
	},

	{
		type = "turret",
		name = "worm-normal-8-3",
		icon = "__base__/graphics/icons/medium-worm.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "not-repairable", "breaths-air"},
		order="b-b-e",
		subgroup="enemies",
		max_health = 1500,
		resistances =
		{
			{
				type = "damage-enemy",
				percent = 100,
			}
		},
		healing_per_tick = 0,
		collision_box = {{-1.1, -1.0}, {1.1, 1.0}},
		selection_box = {{-1.1, -1.0}, {1.1, 1.0}},
		shooting_cursor_size = 3.5,
		rotation_speed = 1,
		corpse = "medium-worm-corpse",
		dying_explosion = "blood-explosion-big",
		dying_sound = make_worm_dying_sounds(0.9),
		folded_speed = 1,
		folded_animation = worm_folded_animation(medium_worm_scale, {r=1,g=0,b=0,a=1}),
		prepare_range = 25,
		preparing_speed = 1,
		preparing_animation = worm_preparing_animation(medium_worm_scale, {r=1,g=0,b=0,a=1}, "forward"),
		prepared_speed = 1,
		prepared_animation = worm_prepared_animation(medium_worm_scale, {r=1,g=0,b=0,a=1}),
		starting_attack_speed = 1,
		starting_attack_animation = worm_attack_animation(medium_worm_scale, {r=1,g=0,b=0,a=1}, "forward"),
		starting_attack_sound = make_worm_roars(0.1),
		ending_attack_speed = 0.1,
		ending_attack_animation = worm_attack_animation(medium_worm_scale, {r=1,g=0,b=0,a=1}, "backward"),
		folding_speed = 1,
		folding_animation =  worm_preparing_animation(medium_worm_scale, {r=1,g=0,b=0,a=1}, "backward"),
		prepare_range = 50,
		attack_parameters =
	 {
		type = "projectile",
		range = 50,
		cooldown = 12,
		projectile_creation_distance = 2,
		ammo_category = "ammo-enemy",
		ammo_type =
		{
			category = "ammo-enemy",
			target_type = "direction",
			action =
			{
				 {
				 type = "direct",
				 --repeat_count = 20,
				 action_delivery =
				 {
					type = "projectile",
					projectile = "ep-50",
					starting_speed = 0.2,
					max_range = 50
				 }
				 }
			}
		},
	 },
		build_base_evolution_requirement = 0.3,
		autoplace = enemy_worm_autoplace(2),
		call_for_help_radius = 40
	},

	{
		type = "turret",
		name = "worm-normal-8-4",
		icon = "__base__/graphics/icons/medium-worm.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "not-repairable", "breaths-air"},
		order="b-b-e",
		subgroup="enemies",
		max_health = 1500,
		resistances =
		{
			{
				type = "damage-enemy",
				percent = 100,
			}
		},
		healing_per_tick = 0,
		collision_box = {{-1.1, -1.0}, {1.1, 1.0}},
		selection_box = {{-1.1, -1.0}, {1.1, 1.0}},
		shooting_cursor_size = 3.5,
		rotation_speed = 1,
		corpse = "medium-worm-corpse",
		dying_explosion = "blood-explosion-big",
		dying_sound = make_worm_dying_sounds(0.9),
		folded_speed = 1,
		folded_animation = worm_folded_animation(medium_worm_scale, {r=0,g=0,b=0,a=1}),
		prepare_range = 25,
		preparing_speed = 1,
		preparing_animation = worm_preparing_animation(medium_worm_scale, {r=0,g=0,b=0,a=1}, "forward"),
		prepared_speed = 1,
		prepared_animation = worm_prepared_animation(medium_worm_scale, {r=0,g=0,b=0,a=1}),
		starting_attack_speed = 1,
		starting_attack_animation = worm_attack_animation(medium_worm_scale, {r=0,g=0,b=0,a=1}, "forward"),
		starting_attack_sound = make_worm_roars(0.1),
		ending_attack_speed = 0.1,
		ending_attack_animation = worm_attack_animation(medium_worm_scale, {r=0,g=0,b=0,a=1}, "backward"),
		folding_speed = 1,
		folding_animation =  worm_preparing_animation(medium_worm_scale, {r=0,g=0,b=0,a=1}, "backward"),
		prepare_range = 50,
		attack_parameters =
	 {
		type = "projectile",
		range = 50,
		cooldown = 120,
		projectile_creation_distance = 0,
		ammo_category = "ammo-enemy",
		ammo_type =
		{
			category = "ammo-enemy",
			target_type = "position",
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
						 type = "create-entity",
						 entity_name = "ep-8-1"
						}
					}
				 }
				},
			}
		},
	 },
		build_base_evolution_requirement = 0.3,
		autoplace = enemy_worm_autoplace(2),
		call_for_help_radius = 40
	},

	{
		type = "projectile",
		name = "ep-8-1",
		flags = {"not-on-map","placeable-off-grid"},
		collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
		acceleration = 0,
		direction_only = true,
		action =
		{
		{
				type = "cluster",
				cluster_count = 40,
				distance = 4,
				distance_deviation = 3,
				action_delivery =
				{
					type = "projectile",
					projectile = "ep-50",
					direction_deviation = 0.6,
					starting_speed = 0.05,
					starting_speed_deviation = 0.04,
			 max_range=50
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
		type = "turret",
		name = "worm-normal-8-5",
		icon = "__base__/graphics/icons/medium-worm.png",
		icon_size = 32,
		flags = {"placeable-player", "placeable-enemy", "not-repairable", "breaths-air"},
		order="b-b-e",
		subgroup="enemies",
		max_health = 1500,
		resistances =
		{
			{
				type = "damage-enemy",
				percent = 100,
			}
		},
		healing_per_tick = 0,
		collision_box = {{-1.1, -1.0}, {1.1, 1.0}},
		selection_box = {{-1.1, -1.0}, {1.1, 1.0}},
		shooting_cursor_size = 3.5,
		rotation_speed = 1,
		corpse = "medium-worm-corpse",
		dying_explosion = "blood-explosion-big",
		dying_sound = make_worm_dying_sounds(0.9),
		folded_speed = 1,
		folded_animation = worm_folded_animation(medium_worm_scale, {r=0,g=1,b=0,a=1}),
		prepare_range = 25,
		preparing_speed = 1,
		preparing_animation = worm_preparing_animation(medium_worm_scale, {r=0,g=1,b=0,a=1}, "forward"),
		prepared_speed = 1,
		prepared_animation = worm_prepared_animation(medium_worm_scale, {r=0,g=1,b=0,a=1}),
		starting_attack_speed = 1,
		starting_attack_animation = worm_attack_animation(medium_worm_scale, {r=0,g=1,b=0,a=1}, "forward"),
		starting_attack_sound = make_worm_roars(0.1),
		ending_attack_speed = 0.1,
		ending_attack_animation = worm_attack_animation(medium_worm_scale, {r=0,g=1,b=0,a=1}, "backward"),
		folding_speed = 1,
		folding_animation =  worm_preparing_animation(medium_worm_scale, {r=0,g=1,b=0,a=1}, "backward"),
		prepare_range = 50,
		attack_parameters =
	 {
		type = "projectile",
		range = 50,
		cooldown = 60,
		projectile_creation_distance = 3,
		ammo_category = "ammo-enemy",
		ammo_type =
		{
			category = "ammo-enemy",
			target_type = "position",
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
						 type = "create-entity",
						 entity_name = "biter-mini-1"
						}
					}
				 }
				},
			}
		},
	 },
		build_base_evolution_requirement = 0.3,
		autoplace = enemy_worm_autoplace(2),
		call_for_help_radius = 40
	},

	{
		type = "projectile",
		name = "ep-8-2",
		flags = {"not-on-map"},
	collision_box = {{-0.3, -0.3}, {0.3, 0.3}},
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
						entity_name = "target-elec"
					},
					{
						type = "damage",
						damage = {amount = 30, type = "damage-enemy"}
					},
				}
			}
		},
	 animation =
		{
			filename = "__m-roguef__/graphics/entity/explosion/ep-8-2.png",
			frame_count = 1,
			width = 128,
			height = 117,
			priority = "high",
		blend_mode = "additive"
		},
	},

	{
		type = "explosion",
		name = "explosion-8",
		flags = {"not-on-map","placeable-off-grid"},
		animations =
		{
		{
				filename = "__m-roguef__/graphics/entity/explosion/ep-7-1.png", -- fast-fix \/
				priority = "extra-high",
				width = 29,
				height = 38,
				frame_count = 11,
				shift={0,0.3},
				animation_speed = 9/20,
				scale=2
			}
			-- {
				-- filename = "__m-roguef__/graphics/entity/explosion/explosion.png", -- TODO: FIX THIS
				-- priority = "extra-high",
				-- width = 40,
				-- height = 40,
		-- shift={0,1},
				-- frame_count = 12,
				-- animation_speed = 24/60,
		-- scale=4
			-- }
		},
		sound =
		{
			aggregation =
			{
				max_count = 1,
				remove = true
			},
			variations =
			{
				{
					filename = "__base__/sound/fight/medium-explosion-1.ogg", -- TODO: change this",
					volume = 0.5
				},
				{
					filename = "__base__/sound/fight/medium-explosion-2.ogg", -- TODO: change this
					volume = 0.5
				}
			}
		},
	 created_effect =
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
			damage = {amount = 100, type = "damage-enemy"}
			},
		 }
		}
	 },
	}

})

--stage 9

data:extend({

	{
		type = "simple-entity",
		name = "tomas",
		flags = {"placeable-neutral", "not-on-map","placeable-off-grid"},
		icon = "__m-roguef__/graphics/entity/tomas.png",
		icon_size = 32,
		subgroup = "rf_raw",
		order = "b",
	 max_health=10000,
	 resistances =
		{
			{
				type = "damage-enemy",
				percent = 100,
			}
		},
	 dying_explosion = "massive-explosion",
		render_layer = "object",
		collision_box = {{-4.5/2, -6.23/2}, {4.5/2, 6.23/2}},
		selection_box = {{-4.5/2, -6.23/2}, {4.5/2, 6.23/2}},
		selectable_in_game = true,
		pictures =
		{
			{
				filename = "__m-roguef__/graphics/entity/tomas.png",
			priority = "extra-high",
				width = 287,
				height = 399,
			scale=1/2
		 }
		},
	},

})
