if script.level.level_name ~= "roguef" then
	return
end

local cos = math.cos
local rad = math.rad
local sin = math.sin
local random = math.random
local len = string.len
local sub = string.sub

local function unlock()
	local l = global.stats.level
	local main_frame = game.get_player(1).gui.left.main
	main_frame.mt[l .. "-1"].visible = true
	main_frame.mt[l .. "-2"].visible = true
	main_frame.mt[l .. "-3"].visible = true
end

local function sound(pos, s)
	game.surfaces[1].create_entity{name = s .. "-sound", position = pos}
end

-- flying-text
local function pt(text, color) -- TOOD: Fix this
	local player = game.get_player(1)
	player.surface.create_entity{name = "playertext", position = player.position, text = text, color = color or {g = 1}}
end
-- local function nt(ent, text, color)
-- 	if color == nil then
-- 		color = {r = 1, g = 1, b = 1}
-- 	end
-- 	local surface = ent.surface
-- 	local position = ent.position
-- 	surface.create_entity{name = "playertext", position = {position.x, position.y + 1}, text = text, color = color}
-- 	surface.create_entity{name = "msg-sound", position = position}
-- end
local function et(pos, text, color)
	if color == nil then
		color = {r = 1, g = 1, b = 1}
	end
	game.surfaces[1].create_entity{name = "damage-text", position = pos, text = text, color = color}
end
local function bt(pos, text, color)
	if color == nil then
		color = {r = 1, g = 0, b = 1}
	end
	game.surfaces[1].create_entity{name = "critical-text", position = pos, text = text, color = color}
end

-- levelup
local function levelup()
	-- local player = game.get_player(1) -- TODO: fix this
	if global.stats.level < 1 + #global.xp and global.stats.xp >= global.xp[global.stats.level] then
		global.stats.xp = global.stats.xp - global.xp[global.stats.level]
		global.stats.level = global.stats.level + 1
		unlock()
		pt({"rf.levelup"})
		-- sound(player.position,"levelup")
	end
end

-- TODO: change this
-- function of distance
local function get_distance(ent, ents)
	local a, b, c, d
	if ent.position then
		a = ent.position.x
	elseif ent.x then
		a = ent.x
	else
		a = ent[1]
	end
	if ent.position then
		b = ent.position.y
	elseif ent.y then
		b = ent.y
	else
		b = ent[2]
	end
	if ents.position then
		c = ents.position.x
	elseif ents.x then
		c = ents.x
	else
		c = ents[1]
	end
	if ents.position then
		d = ents.position.y
	elseif ents.y then
		d = ents.y
	else
		d = ents[2]
	end
	return math.sqrt((a - c) ^ 2 + (b - d) ^ 2)
end

-- function of target rotate
local function targetrotate(po, pos, t)
	local a = pos.x - po.x
	local b = pos.y - po.y
	local rad_t = rad(t)
	local x1 = cos(rad_t)
	local x2 = sin(rad_t)
	local i = (a * x1) - (b * x2) + po.x
	local j = (b * x1) + (a * x2) + po.y
	return {x = i, y = j}
end

-- function of target line
local function targetline(po, pos, n)
	if n == nil or n == 0 then
		return {x = po.x, y = po.y}
	else
		local i = 0
		local j = 0
		local a = po.x
		local b = po.y
		local c = pos.x
		local d = pos.y
		if a == c then
			c = c + 0.1
		end
		local k = (d - b) / (c - a)
		local aa = 1 + k ^ 2
		local bb = (-2) * (a + (k ^ 2) * c + (-1) * k * d + k * b)
		local cc = a ^ 2 + b ^ 2 + d ^ 2 + (k * c) ^ 2 + (-1) * (n ^ 2) + (-2) * (k * c * d + (-1) * k * b * c + b * d)
		local g = (bb ^ 2 + (-4) * aa * cc) ^ 0.5
		if a < c then
			i = ((-1) * bb + g) / (2 * aa)
		elseif a > c then
			i = ((-1) * bb - g) / (2 * aa)
		else
			i = a
		end
		j = k * (i - c) + d
		if n > 0 then
			return {x = i, y = j}
		elseif n < 0 then
			return targetrotate(po, {x = i, y = j}, 180)
		end
	end
end

-- function of bullet
local function bullet_circle(n, pos, speed, d)
	if d == nil then
		d = 3
	end
	local player = game.get_player(1) -- TODO: FIX THIS
	local player_position = player.position
	local surface = player.surface
	for i = -6, 6 do
		local tar = targetrotate(pos, player_position, i * 10)
		local po = targetline(pos, tar, d)
		surface.create_entity{name = "ep-" .. n, position = po, target = tar, speed = speed}
		surface.create_entity{name = "explosion-gunshot", position = po, target = tar}
	end
end
local function c_()
	local character = game.get_player(1).character
	character.destructible = true
	character.die()
	game.print({"rf.c"})
end
local function bullet_line(ent, bullet, distance, t, speed)
	local pos = targetrotate(ent.position, {x = ent.position.x, y = ent.position.y - distance}, ent.orientation * 360 + t)
	local player = game.get_player(1) -- TODO: FIX THIS
	local surface = player.surface
	if game.entity_prototypes[bullet].type == "projectile" then
		return surface.create_entity{name = bullet, position = ent.position, target = pos, speed = speed}
	else
		return surface.create_entity{name = bullet, position = pos}
	end
end

-- function of blood explosion
local function blood(pos, n)
	local size = "huge"
	if n == 1 then
		size = "small"
	elseif n == 2 then
		size = "big"
	end
	game.surfaces[1].create_entity{name = "blood-explosion-" .. size, position = pos}
end

-- is this crap?
-- function of position inout
-- local function inout(stage)
-- 	local player = game.get_player(1) -- TODO: fix this
-- 	local pos
-- 	if get_distance(global.stage.starts[global.stage.num],player)<10 then pos=targetline(global.stage.starts[global.stage.num],player.position,15)
-- 	else pos=targetline(global.stage.starts[global.stage.num],player.position,5) end
-- 	return pos
-- end

-- function of position side
local function side(stage, t)
	local player = game.get_player(1) -- TODO: fix this
	local start = global.stage.starts[global.stage.num] -- TODO: check
	return targetrotate(start, targetline(start, player.position, 15), t)
end

-- function of stage 4
local function tile4(po)
	local player = game.get_player(1) -- TODO: fix this
	local pos = {x = po.x, y = po.y}
	local x = player.position.x
	local y = player.position.y
	if (x - po.x) ^ 2 >= (y - po.y) ^ 2 then
		if x < po.x then
			pos.x = po.x - 1
		else
			pos.x = po.x + 1
		end
	else
		if y < po.y then
			pos.y = po.y - 1
		else
			pos.y = po.y + 1
		end
	end
	player.surface.create_entity{name = "explosion-32", position = pos}
	player.surface.set_tiles({{name = "water-red", position = pos}}, false)
	return pos
end

-- function of stage 6
local function tile6(po)
	local surface = game.surfaces[1]
	if po.x >= 0 and po.x < 130 then
		local b = game.get_player(1) -- TODO: fix this
		surface.create_entity{name = "explosion-32", position = {po.x + 0.5, po.y + 0.5}}
		surface.set_tiles({{name = "water-red", position = po}}, false)
		if po.x % 2 == 0 and po.y == 219 then
			return {x = po.x + 1, y = 219}
		elseif po.x % 2 == 1 and po.y == 200 then
			return {x = po.x + 1, y = 200}
		elseif po.x % 2 == 0 then
			return {x = po.x, y = po.y + 1}
		else
			return {x = po.x, y = po.y - 1}
		end
	else
		return false
	end
end

-- gui
local function gui()
	local gui = game.get_player(1).gui -- TODO: fix this

	-- mastery
	local g = gui.left
	g.add{type = "frame", name = "main", direction = "vertical", style = "outer_frame_style"}
	g.main.add{
		type = "sprite-button",
		name = "mastery",
		sprite = "item/stage",
		tooltip = {"gui.mastery"},
		style = "side_menu_button_style"
	}
	g.main.add{type = "table", name = "mt", column_count = 3, colspan = 3}
	for i = 1, 7 do
		for j = 1, 3 do
			g.main.mt.add{
				type = "sprite-button",
				name = i .. "-" .. j,
				sprite = "item/mastery-" .. i .. "-" .. j,
				tooltip = {"mastery-info." .. i .. "-" .. j},
				style = "side_menu_button_style"
			}
			g.main.mt[i .. "-" .. j].visible = false
		end
	end
	g.main.mt.visible = false
	unlock()

	-- enemy health
	local top = gui.top
	top.add{type = "frame", name = "main", direction = "vertical", style = "outer_frame_style"}
	top.main.add{type = "frame", name = "enemy", direction = "horizontal", style = "outer_frame_style"}
	local enemy_gui = top.main.enemy
	enemy_gui.add{type = "progressbar", name = "bar", size = 1, value = 0, style = "health_progressbar_style"}
	enemy_gui.bar.add{type = "label", name = "label"}
	enemy_gui.bar.label.style.top_padding = 12
	enemy_gui.bar.label.style.bottom_padding = 0
	enemy_gui.style.minimal_height = 0
	enemy_gui.bar.style.minimal_height = 50
	enemy_gui.bar.style.minimal_width = 800
	enemy_gui.bar.style.maximal_width = 800
	top.main.style.left_padding = 100
	top.main.style.top_padding = 10
	enemy_gui.bar.visible = false
	-- enemy_gui.bar.label.caption={"gui.mastery"}
end

-- passive item search
local function passive(n)
	-- local name="passive-"..n
	-- local quickbar = player.get_quickbar() -- TODO: FIX THIS
	-- if quickbar[1].valid_for_read and quickbar[1].name==name then
	-- 	return true
	-- elseif quickbar[2].valid_for_read and quickbar[2].name==name then
	-- 	return true
	-- elseif quickbar[3].valid_for_read and quickbar[3].name==name then
	-- 	return true
	-- elseif quickbar[4].valid_for_read and quickbar[4].name==name then
	-- 	return true
	-- else
	return false
	-- end
end

-- function of find entity by tag
local function tag(n)
	return game.get_entity_by_tag(n).position
end

-- function of  market
local function market(price, item)
	game.get_entity_by_tag("market").add_market_item{price = {{"money", price}}, offer = {type = "give-item", item = item}}
end

-- function of enemy target
local function etarget(n)
	local player = game.get_player(1) -- TODO: fix this
	local d = player.walking_state.direction * 45
	local pos = {x = player.position.x, y = player.position.y - n}
	return targetrotate(player.position, pos, d)
end

-- function of target direction
local function rotation(a, player)
	local ax = a.position.x
	local ay = a.position.y
	local px = player.position.x
	local py = player.position.y
	local r = 180 + 180 * math.atan2(ax - px, py - ay) / math.pi
	local c = 22.5
	local d = 0
	if r > c * 1 and r <= c * 3 then
		d = 1
	elseif r > c * 3 and r <= c * 5 then
		d = 2
	elseif r > c * 5 and r <= c * 7 then
		d = 3
	elseif r > c * 7 and r <= c * 9 then
		d = 4
	elseif r > c * 9 and r <= c * 11 then
		d = 5
	elseif r > c * 11 and r <= c * 13 then
		d = 6
	elseif r > c * 13 and r <= c * 15 then
		d = 7
	else
		d = 0
	end
	return d
end

-- function of orientation
local function orientation(a, player)
	local ax = a.position.x
	local ay = a.position.y
	local px = player.position.x
	local py = player.position.y
	local r = 180 + 180 * math.atan2(ax - px, py - ay) / math.pi
	return r / 360
end

-- crap?

-- damages
-- local function damagetarget(ent,effect,damage)
-- 	local b = game.get_player(1) -- TODO: fix this
-- 	if ent.valid and ent.destructible==true and ent.health~=nil then
-- 		local c=game.entity_prototypes[effect].type
-- 		local po=ent.position
-- 		local pos={x=ent.position.x+1,y=ent.position.y}
-- 		if c=="explosion" then
-- 			b.surface.create_entity{name=effect,position=targetrotate(po,targetline(po,pos,random()/2),random()*360)}
-- 		else
-- 			b.surface.create_entity{name=effect,position=ent.position,target=ent,speed=1}
-- 		end
-- 	end
-- 	ent.damage(damage,b.force.name,"damage-player")
-- end
-- local function damagearea(pos,area,areaeffect,effect,damage)
-- 	local b = game.get_player(1) -- TODO: fix this
-- 	local c=game.entity_prototypes[effect].type
-- 	for i,j in pairs(b.surface.find_entities_filtered{area={{pos.x-area,pos.y-area},{pos.x+area,pos.y+area}}}) do
-- 		if j.valid and j.destructible==true and j.health~=nil and math.sqrt((pos.x-j.position.x)^2+(pos.y-j.position.y)^2) <= area then
-- 			local po=j.position
-- 			local pos={x=j.position.x+1,y=j.position.y}
-- 			if j.name~="player" then
-- 				local poss=j.position
-- 				j.damage(damage,b.force.name,"damage-player")
-- 				if c=="explosion" then
-- 					b.surface.create_entity{name=effect,position=targetrotate(po,targetline(po,pos,random()/2),random()*360)}
-- 				else
-- 					b.surface.create_entity{name=effect,position=poss,target=poss,speed=1}
-- 				end
-- 			end
-- 		end
-- 	end
-- 	c=game.entity_prototypes[areaeffect].type
-- 	if c=="explosion" then
-- 		b.surface.create_entity{name=areaeffect,position=pos}
-- 	else
-- 		b.surface.create_entity{name=areaeffect,position=pos,target=pos,speed=1}
-- 	end
-- end
-- local function edamagetarget(ent,effect,damage,speed)
-- 	if speed==nil then speed=1 end
-- 	local b = game.get_player(1) -- TODO: fix this
-- 	if get_distance(b.character,ent)<=50 then
-- 		local c=game.entity_prototypes[effect].type
-- 		local po=b.character.position
-- 		local pos={x=b.character.position.x+1,y=b.character.position.y}
-- 		if c=="explosion" then
-- 			b.surface.create_entity{name=effect,position=targetrotate(po,targetline(po,pos,random()/2),random()*360)}
-- 		else
-- 			b.surface.create_entity{name=effect,position=ent.position,target=b.character,speed=speed}
-- 		end
-- 	end
-- 	b.damage(damage,"enemy","damage-enemy")
-- end
-- local function edamagearea(pos,area,areaeffect,effect,damage,speed)
-- 	if speed==nil then speed=1 end
-- 	local b = game.get_player(1) -- TODO: fix this
-- 	local c=game.entity_prototypes[effect].type
-- 	for i,j in pairs(b.surface.find_entities_filtered{area={{pos.x-area,pos.y-area},{pos.x+area,pos.y+area}}}) do
-- 		if j.valid and j.destructible==true and j.health~=nil and j.force.name~="enemy" and math.sqrt((pos.x-j.position.x)^2+(pos.y-j.position.y)^2) <= area then
-- 			local po=j.position
-- 			local pos={x=j.position.x+1,y=j.position.y}
-- 			local poss=j.position
-- 			j.damage(damage,"enemy","damage-enemy")
-- 			if c=="explosion" then
-- 				b.surface.create_entity{name=effect,position=targetrotate(po,targetline(po,pos,random()/2),random()*360)}
-- 			else
-- 				b.surface.create_entity{name=effect,position=poss,target=poss,speed=speed}
-- 			end
-- 		end
-- 	end
-- 	c=game.entity_prototypes[areaeffect].type
-- 	if c=="explosion" then
-- 		b.surface.create_entity{name=areaeffect,position=pos}
-- 	else
-- 		b.surface.create_entity{name=areaeffect,position=pos,target=pos,speed=1}
-- 	end
-- end

-- respawn
local function player_respawn()
	local player = game.get_player(1) -- TODO: fix this
	local surface = player.surface
	sound(player.position, "recall")
	surface.wind_speed = 0
	player.teleport(global.respawn)
	surface.create_entity{name = "recall", position = global.respawn}
	local test_1 = global.test[1]
	for _, entity in pairs(surface.find_entities_filtered{force = "enemy"}) do
		if test_1 ~= entity then
			entity.destroy()
		end
	end
	local targets = {"projectile", "land-mine", "corpse", "blaze-8", "mark"}
	for _, name in pairs(targets) do
		for _, entity in pairs(surface.find_entities_filtered{type = name}) do
			entity.destroy()
		end
	end
	--  "green-circle" -- TODO: recheck
	local targets = {"item-on-ground", "rf_stone", "rf_consol-clear", "blaze-8", "mark"}
	for _, name in pairs(targets) do
		for _, entity in pairs(surface.find_entities_filtered{name = name}) do
			entity.destroy()
		end
	end
	-- TODO: check this \/, probably it doesn't work
	for _, decorative in pairs(surface.find_entities_filtered{type = "decorative"}) do
		if len(decorative.name) > 3 and sub(decorative.name, 1, 3) == "ex-" then
			decorative.destroy()
		end
	end
	ent = {}
	for i = 150, 179 do
		for j = 150, 179 do
			ent[#ent + 1] = {name = "concrete", position = {i, j}}
		end
	end
	for i = 0, 130 do
		for j = 200, 219 do
			ent[#ent + 1] = {name = "concrete", position = {i, j}}
		end
	end
	surface.set_tiles(ent, false)
	local enemy_force = game.forces["enemy"]
	enemy_force.set_gun_speed_modifier("ammo-enemy", 0)
	enemy_force.set_ammo_damage_modifier("ammo-enemy", 0)
	player.gui.top.main.enemy.bar.visible = false
	for i = 1, 6 do
		game.get_entity_by_tag("6-gate-" .. i).request_to_close("player")
	end
	global.weapons = {}
end

local function market_reset()
	-- TOOD: FIX THIS
	-- local market = game.get_entity_by_tag("market")
	-- for i=1,#market.get_market_items() do
	-- 	market.remove_market_item(1)
	-- end
	local armors = global.market.armor
	market(10 + global.stats.stage - 2, "heal")
	market(armors[1], "armor-1")
	market(armors[2], "armor-2")
	market(armors[3], "armor-3")
	market(armors[4], "armor-4")
	market(armors[5], "armor-5")
	local ran = random(1, #global.market.weapon)
	market(global.market.weapon[ran], "weapon-" .. ran)
	if global.stats.mastery[6] == 2 then
		ran = random(1, #global.market.weapon)
		market(global.market.weapon[ran], "weapon-" .. ran)
	end
	ran = random(1, #global.market.active)
	market(global.market.active[ran], "active-" .. ran)
	ran = random(1, #global.market.passive)
	market(global.market.passive[ran], "passive-" .. ran)
end

-- stage clear
local function stageclear(n)
	local stage_timer = global.stage.timer[global.stats.stage]
	stage_timer[1] = stage_timer[1] + 1
	local tick = math.ceil((game.tick - global.timer) / 60 * 100) / 100
	if stage_timer[2] == 0 or stage_timer[2] > tick then
		stage_timer[2] = tick
	end
	local player = game.get_player(1) -- TODO: fix this
	local surface = player.surface
	local character = player.character
	local ent = surface.create_entity{name = "rf_consol-clear", position = global.stage.clear[n]}
	ent.destructible = false
	-- surface.create_entity{name="green-circle",position=global.stage.item[n]} -- TODO: recheck it
	local ran = random()
	local d = "weapon-" .. random(1, #global.market.weapon)
	local stats = global.stats
	local mastery4 = stats.mastery[4]
	if mastery4 == 1 then
		if ran < 0.05 then
			d = "active-" .. random(1, #global.market.active)
		elseif ran < 0.2 then
			d = "passive-" .. random(1, #global.market.passive)
		end
	elseif mastery4 == 2 then
		if ran < 0.2 then
			d = "active-" .. random(1, #global.market.active)
		elseif ran < 0.5 then
			d = "passive-" .. random(1, #global.market.passive)
		end
	elseif mastery4 == 3 then
		if ran < 0.1 then
			d = "active-" .. random(1, #global.market.active)
		elseif ran < 0.6 then
			d = "passive-" .. random(1, #global.market.passive)
		end
	else
		if ran < 0.1 then
			d = "active-" .. random(1, #global.market.active)
		elseif ran < 0.4 then
			d = "passive-" .. random(1, #global.market.passive)
		end
	end
	if stats.mastery[6] == 1 then
		surface.create_entity{name = "item-on-ground", position = global.stage.item[n], stack = {name = "money", count = 20}}
	end
	-- surface.create_entity{name="item-on-ground",position=global.stage.item[n],stack={name=d}}
	player.insert{name = d}
	game.print("stage clear!!")
	sound(player.position, "stageclear")
	-- TODO: OPTIMIZE!
	for _, j in pairs(surface.find_entities_filtered{force = "enemy"}) do
		if global.test[1] ~= j then
			j.destroy()
		end
	end
	for _, j in pairs(surface.find_entities_filtered{name = "blaze-8"}) do
		j.destroy()
	end
	stats.stage = stats.stage + 1
	global.stage.num = 0
	global.stage.start = false
	global.bgm.num = 0
	global.bgm.tick = 0
	global.boss = {}
	player.gui.top.main.enemy.bar.visible = false

	-- xp
	local earned = 50 + (stats.stage - 2) * 50
	if stats.mastery[1] == 3 then
		stats.xp = stats.xp + earned * 0.5
	end
	stats.xp = stats.xp + earned

	-- money
	local count = 100 + (stats.stage - 2) * 10
	if stats.mastery[2] == 2 then
		player.insert({name = "money", count = count * 0.2}) -- check
	else
		player.insert({name = "money", count = count})
	end

	-- market set
	market_reset()

	-- health
	if stats.mastery[1] == 2 then
		character.health = character.health + character.prototype.max_health * 0.2
		sound(player.position, "firstaid")
		surface.create_entity{name = "firstaid", position = player.position}
		if character.health > character.prototype.max_health then
			character.health = character.prototype.max_health
		end
	end
end

-- movement
local function movement()
	local player = game.get_player(1) -- TODO: fix this
	local speed = 0
	if game.tick >= global.dodge then
		if passive(2) then
			speed = speed + 0.15
		end
		if passive(9) then
			speed = speed - 0.15
		end
		if global.stats.mastery[2] == 3 then
			speed = speed + 0.15
		end
		if global.stim then
			if global.stim + 60 * 10 > game.tick then
				speed = speed + 0.3
			else
				global.stim = false
			end
		end
		local stage = global.stats.stage
		local boss = global.boss
		if stage == 6 and boss and boss.e and boss.e ~= true and boss.e.valid and boss.e.name == "spitter-normal-6" then
			speed = (speed + 1) * 0.5 - 1
		elseif stage == 6 and boss and boss.c and boss.c ~= true and boss.c.valid and boss.c.name == "spitter-normal-6" then
			speed = (speed + 1) * 0.5 - 1
		elseif stage == 5 and boss and boss.a and boss.a <= 240 - (24 * 9) then
			speed = (speed + 1) * 0.5 - 1
		end
		player.character_running_speed_modifier = speed
	end
end

-- gun
local function gun(n)
	local player = game.get_player(1) -- TODO: fix this
	local character = player.character
	local speed = 0
	local damage = 0
	if passive(1) then
		speed = speed + 0.1
	end
	if passive(9) then
		speed = speed + 0.2
	end
	local mastery = global.stats.mastery
	if mastery[2] == 1 then
		speed = speed + 0.1
	end
	if mastery[5] == 1 and character.health / character.prototype.max_health <= 0.4 then
		speed = speed + 0.1
	elseif mastery[5] == 2 and character.health / character.prototype.max_health >= 0.7 then
		speed = speed + 0.1
	end
	if global.stim then
		if global.stim + 60 * 10 > game.tick then
			speed = speed + 0.3
		else
			global.stim = false
		end
	end
	local force = player.force
	for i = 1, n do
		force.set_gun_speed_modifier("ammo-" .. i, speed)
		force.set_ammo_damage_modifier("ammo-" .. i, damage)
	end
	if mastery[3] == 3 then
		force.set_ammo_damage_modifier("ammo-1", force.get_ammo_damage_modifier("ammo-1") + 0.1)
	end
	if passive(16) then
		force.set_ammo_damage_modifier("ammo-1", force.get_ammo_damage_modifier("ammo-1") + 0.2)
	end
	if mastery[6] == 3 then
		force.set_gun_speed_modifier("ammo-1", force.get_gun_speed_modifier("ammo-1") + 0.1)
	end
	if passive(14) then
		force.set_gun_speed_modifier("ammo-10", force.get_gun_speed_modifier("ammo-10") + 0.2)
		force.set_gun_speed_modifier("ammo-16", force.get_gun_speed_modifier("ammo-16") + 0.2)
		force.set_gun_speed_modifier("ammo-29", force.get_gun_speed_modifier("ammo-29") + 0.2)
	end
	if passive(6) then
		game.forces["player"].set_ammo_damage_modifier("rf_robot", 0.5)
	else
		game.forces["player"].set_ammo_damage_modifier("rf_robot", 0)
	end
	if passive(8) then
		game.forces["player"].set_gun_speed_modifier("rf_robot", 0.5)
	else
		game.forces["player"].set_gun_speed_modifier("rf_robot", 0)
	end
end

-- TODO: make it on other events
-- on player created
script.on_event(defines.events.on_player_created, function(event)
	local player = game.get_player(event.player_index)
	if not (player and player.valid) then
		return
	end
	local new_force = game.create_force(tostring(event.player_index))
	local enemy_force = game.forces.enemy
	player.force = new_force
	for _, force in pairs(game.forces) do
		force.set_cease_fire(new_force, true)
		new_force.set_cease_fire(force, true)
	end
	game.forces[player.force.name].disable_research()
	new_force.set_cease_fire(enemy_force, false)
	enemy_force.set_cease_fire(new_force, false)
	enemy_force.set_cease_fire("player", true)
	player.character.clear_items_inside()
	-- for _, entity in pairs(game.surfaces[1].find_entities_filtered({force="player"})) do
	-- 	entity.destructible=false
	-- 	entity.minable=false
	-- end

	player.minimap_enabled = false
	-- player.zoom=(21*60)^2

	-- stats
	global.timer = 0
	global.stats = {}
	global.stats.money = 0
	global.stats.level = 1
	global.stats.xp = 0
	global.stats.mastery = {0, 0, 0, 0, 0, 0, 0}
	global.stats.stage = 1
	global.stun = {}
	global.gunnum = 0
	global.weapons = {}
	global.active = {false, 0, 0}
	global.stim = false
	global.stop = false
	global.robot = {}
	global.robot[1] = false
	global.robot[2] = false
	global.robot[3] = false
	global.robot[4] = {}
	global.robot[5] = {}
	player.force.maximum_following_robot_count = 1000
	game.forces["player"].maximum_following_robot_count = 1000
	player.insert({name = "weapon-1"})
	-- player.insert({name="money",count=1000})
	for _, j in pairs(game.item_prototypes) do
		local length = len(j.name)
		if length > 5 then
			if sub(j.name, 1, 5) == "ammo-" then
				if global.gunnum < tonumber(sub(j.name, 6, length)) then
					global.gunnum = tonumber(sub(j.name, 6, length))
				end
			elseif length > 6 then
				if sub(j.name, 1, 6) == "armor-" then
					-- player.insert({name=j.name})
				elseif length > 7 then
					if sub(j.name, 1, 7) == "weapon-" or sub(j.name, 1, 7) == "active-" then
						-- player.insert({name=j.name})
					elseif length > 8 then
						-- if sub(j.name,1,8)=="passive-" then
						-- -- player.insert({name=j.name})
						-- end
					end
				end
			end
		end
	end

	global.dodge = 0
	global.bgm = {}
	global.bgm.num = 0
	global.bgm.tick = 0
	global.boss = {}
	global.bgmtable = {}
	global.bgmtable[0] = {6, 60 * 9.5}
	global.bgmtable[1] = {6, 60 * 12}
	global.bgmtable[2] = {5, 60 * 10}
	global.bgmtable[3] = {6, 60 * 11}
	global.bgmtable[4] = {6, 60 * 10.3}
	global.bgmtable[5] = {6, 60 * 10}
	global.bgmtable[6] = {4, 60 * 8}
	global.bgmtable[7] = {8, 60 * 8}
	global.bgmtable[8] = {9, 60 * 10}
	global.bgmtable[9] = {5, 60 * 11}

	-- gamedata
	global.respawn = {x = 25, y = 25}
	global.xp = {}
	for i = 1, 6 do
		if i == 1 then
			global.xp[i] = 100 * 2
		else
			global.xp[i] = global.xp[i - 1] * 1.5
		end
	end

	-- game.surfaces[1].daytime=0
	-- game.surfaces[1].freeze_daytime = true
	-- game.surfaces[1].wind_orientation_change=0
	-- game.surfaces[1].wind_speed=0
	-- game.surfaces[1].wind_orientation=0
	-- if game.map_settings.pollution.enabled then game.map_settings.pollution.enabled=false end
	-- if game.map_settings.enemy_evolution.enabled then game.map_settings.enemy_evolution.enabled=false end
	-- if game.map_settings.enemy_expansion.enabled then game.map_settings.enemy_expansion.enabled=false end
	-- for _, tree in pairs(game.surfaces[1].find_entities_filtered({type="tree"})) do
	-- 	tree.destructible=false
	-- 	tree.minable=false
	-- end
	global.test = {}
	global.test[1] = game.surfaces[1].create_entity{name = "player-dummy", position = {28.5, 26.5}}
	global.test[1].active = false
	global.test[2] = global.test[1].prototype.max_health
	global.test[3] = 0
	global.test[4] = 0
	global.market = {}
	global.market.weapon = {}
	global.market.weapon[1] = 62
	global.market.weapon[2] = 81
	global.market.weapon[3] = 86
	global.market.weapon[4] = 86
	global.market.weapon[5] = 80
	global.market.weapon[6] = 78
	global.market.weapon[7] = 78
	global.market.weapon[8] = 78
	global.market.weapon[9] = 78
	global.market.weapon[10] = 83
	global.market.weapon[11] = 86
	global.market.weapon[12] = 94
	global.market.weapon[13] = 81
	global.market.weapon[14] = 79
	global.market.weapon[15] = 78
	global.market.weapon[16] = 78
	global.market.weapon[17] = 86
	global.market.weapon[18] = 76
	global.market.weapon[19] = 83
	global.market.weapon[20] = 104
	global.market.weapon[21] = 78
	global.market.weapon[22] = 85
	global.market.weapon[23] = 94
	global.market.weapon[24] = 78
	global.market.weapon[25] = 90
	global.market.weapon[26] = 92
	global.market.weapon[27] = 83
	global.market.weapon[28] = 94
	global.market.weapon[29] = 86

	global.market.armor = {}
	global.market.armor[1] = 40
	global.market.armor[2] = 80
	global.market.armor[3] = 120
	global.market.armor[4] = 160
	global.market.armor[5] = 200

	global.market.active = {}
	global.market.active[1] = 60
	global.market.active[2] = 90
	global.market.active[3] = 90
	global.market.active[4] = 40
	global.market.active[5] = 120
	global.market.active[6] = 60
	global.market.active[7] = 40
	global.market.active[8] = 40
	global.market.active[9] = 90

	global.market.passive = {}
	global.market.passive[1] = 100
	global.market.passive[2] = 80
	global.market.passive[3] = 80
	global.market.passive[4] = 80
	global.market.passive[5] = 80
	global.market.passive[6] = 80
	global.market.passive[7] = 80
	global.market.passive[8] = 80
	global.market.passive[9] = 120
	global.market.passive[10] = 80
	global.market.passive[11] = 80
	global.market.passive[12] = 40
	global.market.passive[13] = 60
	global.market.passive[14] = 80
	global.market.passive[15] = 100
	global.market.passive[16] = 80
	global.market.passive[17] = 80
	global.market.passive[18] = 80
	global.market.passive[19] = 80
	global.market.passive[20] = 100

	-- stage
	global.stage = {}
	global.stage.start = false
	global.stage.num = 0
	global.stage.item = {}
	global.stage.clear = {}
	global.stage.starts = {}
	global.stage.timer = {}
	-- TODO: FIX THIS!!!!
	local stage = 9
	for i = 1, stage do
		global.stage.timer[i] = {0, 0}
		global.stage.item[i] = tag(i .. "-i")
		game.get_entity_by_tag(i .. "-i").destroy()
		global.stage.clear[i] = tag(i .. "-c")
		game.get_entity_by_tag(i .. "-c").destroy()
		global.stage.starts[i] = tag(i .. "-start")
		game.get_entity_by_tag(i .. "-start").destroy()
	end
	global.stage.boss = {}
	global.stage.boss[3] = tag("3-12")
	game.get_entity_by_tag("3-12").destroy()

	gui()
end)

-- reload
script.on_event("reload", function(event)
	local player = game.get_player(event.player_index)
	if not (player and player.valid) then
		return
	end
	local character_guns = player.get_inventory(defines.inventory.character_guns)
	local character_ammo = player.get_inventory(defines.inventory.character_ammo)
	for i = 1, 3 do
		if character_guns[i].valid_for_read then
			local n = character_guns[i].name
			character_ammo[i].set_stack({name = "ammo-" .. sub(n, string.find(n, "-") + 1, len(n)), 1000})
		end
	end
end)

-- dodge
script.on_event("dodge", function(event)
	local player = game.get_player(event.player_index)
	if not (player and player.valid) then
		return
	end

	local surface = player.surface
	local mastery = global.stats.mastery
	local t = 60
	if mastery[3] == 1 then
		t = t - 6
	end
	if mastery[3] == 2 then
		t = t + 12
	end
	if passive(10) then
		t = t - 6
	end
	if global.dodge == false or global.dodge + t < event.tick then
		global.dodge = event.tick + 5
		if mastery[1] == 1 then
			global.dodge = global.dodge + 1
		end
		if mastery[3] == 2 then
			global.dodge = global.dodge + 1
		end
		if passive(17) then
			surface.create_entity{name = "blaze-5", position = player.position}
		end
		if passive(18) and random() < 0.15 then
			surface.create_entity{name = "mine-6", force = player.force.name, position = player.position}
		end
	end
end)

-- active item
script.on_event("useitem", function(event)
	local player = game.get_player(event.player_index)
	if not (player and player.valid) then
		return
	end

	local surface = player.surface
	local character = player.character
	local player_position = player.position
	if character.active == false then
		character.active = true
		character.destructible = true
	end
	if global.active[1] and global.active[2] == global.active[3] then
		local n = global.active[1]
		if n == 1 then
			character.health = character.health + character.prototype.max_health * 0.4
			if character.health > character.prototype.max_health then
				character.health = character.prototype.max_health
			end
			sound(player_position, "firstaid")
			surface.create_entity{name = "firstaid", position = player_position}
			-- player.get_quickbar()[5].clear() -- TODO: FIX THIS
		elseif n == 2 then
			surface.create_entity{name = "emp", position = player_position}
			sound(player_position, "target-elec")
			local filters = {
				area = {{player_position.x - 20, player_position.y - 20}, {player_position.x + 20, player_position.y + 20}},
				type = "projectile"
			}
			for _, projectile in pairs(surface.find_entities_filtered(filters)) do
				projectile.destroy()
			end
		elseif n == 3 then
			sound(player_position, "active-3")
			-- character.active=false -- TODO: fix this
			-- character.destructible=false -- TODO: fix this
			global.stats.stun = event.tick
		elseif n == 4 then
			player.gui.top.main.enemy.bar.visible = false
			global.stage.start = false
			global.boss = {}
			global.bgm.num = 0
			global.bgm.tick = 0
			player_respawn()
			game.print("escape!!")
			character.health = character.health + character.prototype.max_health * 0.3
			if character.health > character.prototype.max_health then
				character.health = character.prototype.max_health
			end
			-- player.get_quickbar()[5].clear() -- TODO: FIX THIS
		elseif n == 5 then
			sound(player_position, "stim")
			global.stim = event.tick
			movement()
			gun(global.gunnum)
		elseif n == 6 then
			sound(player_position, "active-6")
			surface.create_entity{name = "mine-6", force = player.force.name, position = player_position}
		elseif n == 7 then
			market_reset()
			sound(player_position, "get")
			-- player.get_quickbar()[5].clear()  -- TODO: FIX THIS
		elseif n == 8 then
			if character.health / character.prototype.max_health > 0.25 then
				sound(player_position, "get")
				player.insert({name = "money", count = 10})
				character.damage(character.prototype.max_health * 0.1, "enemy", "damage-enemy")
			end
		elseif n == 9 then
			global.stop = event.tick

		end
		global.active[2] = 0
		-- player.get_quickbar()[6].clear()  -- TODO: FIX THIS
	end
end)

-- TODO: FIX THIS!
-- do
-- 	--active item cooldown
-- 	local function active_cool(d)
-- 		if d==1 then global.active[3]=1
-- 		elseif d==2 then global.active[3]=30
-- 		elseif d==3 then global.active[3]=30
-- 		elseif d==4 then global.active[3]=1
-- 		elseif d==5 then global.active[3]=60
-- 		elseif d==6 then global.active[3]=10
-- 		elseif d==7 then global.active[3]=1
-- 		elseif d==8 then global.active[3]=1
-- 		elseif d==9 then global.active[3]=30
-- 		end
-- 	end

-- 	--active item search
-- 	script.on_event(defines.events.on_player_quickbar_inventory_changed, function(event)
-- 		local player = game.get_player(event.player_index)
-- 		if not (player and player.valid) then return end
-- 		local b = game.get_player(1) -- TODO: fix this
-- --		local quickbar = player.get_quickbar()  -- TODO: FIX THIS
-- 		if b.get_quickbar()[5].valid_for_read then
-- 			local n=quickbar[5].name
-- 			local d
-- 			if string.find(n,"active-") and global.active[1]==false then
-- 				d=tonumber(sub(n,8,len(n)))
-- 				global.active[1]=d
-- 				active_cool(d)
-- 			elseif string.find(n,"active-") and global.active[1] then
-- 				d=tonumber(sub(n,8,len(n)))
-- 				if global.active[1]~=d then
-- 					global.active[1]=d
-- 					active_cool(d)
-- 					global.active[2]=0
-- 					quickbar[6].clear()
-- 				end
-- 			else
-- 				global.active={false,0,0}
-- 				quickbar[6].clear()
-- 			end
-- 		else
-- 			global.active={false,0,0}
-- 			quickbar[6].clear()
-- 		end
-- 	--passive item equipe
-- 		if passive(3) then
-- 			if global.robot[1]==false or (global.robot[1] and global.robot[1].valid==false) then
-- 				global.robot[1]=b.surface.create_entity{name="robot-1",force="player",position=b.position,target=b.character}
-- 				global.robot[1].destructible=false
-- 			end
-- 		elseif passive(3)==false and global.robot[1] then
-- 			if global.robot[1].valid then global.robot[1].destroy() end
-- 			global.robot[1]=false
-- 		end
-- 		if passive(4) then
-- 			if global.robot[2]==false or (global.robot[2] and global.robot[2].valid==false) then
-- 				global.robot[2]=b.surface.create_entity{name="robot-2",force="player",position=b.position,target=b.character}
-- 				global.robot[2].destructible=false
-- 			end
-- 		elseif passive(4)==false and global.robot[2] then
-- 			if global.robot[2].valid then global.robot[2].destroy() end
-- 			global.robot[2]=false
-- 		end
-- 		if passive(5) then
-- 			if global.robot[3]==false or (global.robot[3] and global.robot[3].valid==false) then
-- 				global.robot[3]=b.surface.create_entity{name="robot-3",force="player",position=b.position,target=b.character}
-- 				global.robot[3].destructible=false
-- 			end
-- 		elseif passive(5)==false and global.robot[3] then
-- 			if global.robot[3].valid then global.robot[3].destroy() end
-- 			global.robot[3]=false
-- 		end
-- 	end)
-- end

-- on gui click
script.on_event(defines.events.on_gui_click, function(event)
	local player = game.get_player(event.player_index)
	if not (player and player.valid) then
		return
	end
	local n = event.element.name

	-- mastery button
	local main_mt_gui = player.gui.left.main.mt
	if n == "mastery" and main_mt_gui.visible == true then
		main_mt_gui.visible = false
	elseif n == "mastery" and main_mt_gui.visible == false then
		main_mt_gui.visible = true
	elseif main_mt_gui and main_mt_gui[n] then
		local player_position = player.position
		local x = player_position.x
		local y = player_position.y
		if x > -1 and x < 40 and y > -7 and y < 20 then
			main_mt_gui[n].style = "green_circuit_network_content_slot_style"
			local i = tonumber(sub(n, 1, 1))
			local j = tonumber(sub(n, 3, 3))
			global.stats.mastery[i] = j
			if j == 3 then
				main_mt_gui[i .. "-1"].style = "red_circuit_network_content_slot_style"
				main_mt_gui[i .. "-2"].style = "red_circuit_network_content_slot_style"
			elseif j == 2 then
				main_mt_gui[i .. "-1"].style = "red_circuit_network_content_slot_style"
				main_mt_gui[i .. "-3"].style = "red_circuit_network_content_slot_style"
			else
				main_mt_gui[i .. "-2"].style = "red_circuit_network_content_slot_style"
				main_mt_gui[i .. "-3"].style = "red_circuit_network_content_slot_style"
			end
		else
			player.print{"gui.mastery-fail"}
		end
	end
end)

-- on player before death
script.on_event(defines.events.on_pre_player_died, function(event)
	local player = game.get_player(event.player_index)
	if not (player and player.valid) then
		return
	end
	local character = player.character

	if global.stage.num == 9 then
		character.health = 1000
		game.set_game_state{game_finished = true, player_won = false, can_continue = false}
	else
		local timer = global.stage.timer[global.stats.stage]
		timer[1] = timer[1] + 1
		global.stats.xp = global.stats.xp + (50 + (global.stats.stage - 2) * 50) / 2
		sound(player.position, "die")
		character.clear_items_inside()
		player.insert({name = "weapon-1"})
		if global.stats.mastery[7] == 1 then
			player.insert({name = "active-4"})
		elseif global.stats.mastery[7] == 2 then
			player.insert({name = "active-7"})
		elseif global.stats.mastery[7] == 3 then
			player.insert({name = "active-8"})
		end
		character.health = character.prototype.max_health
		player_respawn()
		global.stage.start = false
		global.boss = {}
		global.bgm.num = 0
		global.bgm.tick = 0
		player.gui.top.main.enemy.bar.visible = false
		global.stats.stage = 1
		-- TOOD: FIX THIS
		-- local market = game.get_entity_by_tag("market")
		-- for i=1,#market.get_market_items() do
		-- 	market.remove_market_item(1)
		-- end
	end
end)

-- interaction
script.on_event("interaction", function(event)
	local player = game.get_player(event.player_index)
	if not (player and player.valid) then
		return
	end
	local character = player.character
	if not (character and character.valid) then
		return
	end

	local player_position = player.position
	local ent = player.selected
	if ent and ent.valid and get_distance(character, ent) < 2 then
		local surface = player.surface
		local stage = global.stats.stage
		if ent.name == "rf_consol-stage" and global.stage.start == false then -- TODO: CHANGE THIS
			player.zoom = 1000
			if global.active[1] then
				global.active[2] = global.active[3]
			end
			-- stage select
			if stage == 1 then
				global.stage.num = 3
			elseif stage == 2 then
				global.stage.num = 2
			elseif stage == 3 then
				global.stage.num = 1
			elseif stage == 4 then
				global.stage.num = 4
			elseif stage == 5 then
				global.stage.num = 5
			elseif stage == 6 then
				global.stage.num = 6
			elseif stage == 7 then
				global.stage.num = 7
			elseif stage == 8 then
				global.stage.num = 8
			elseif stage == 9 then
				global.stage.num = 9
			end
			-- global.stage.num=9 ---------------------------------------------------for test
			game.print({"boss." .. global.stage.num .. "-0", stage})
			player.teleport(global.stage.starts[global.stage.num])
			if passive(3) then
				global.robot[1].teleport(global.stage.starts[global.stage.num])
			end
			if passive(4) then
				global.robot[2].teleport(global.stage.starts[global.stage.num])
			end
			if passive(5) then
				global.robot[3].teleport(global.stage.starts[global.stage.num])
			end
			global.stage.start = event.tick
			global.timer = event.tick
		elseif ent.name == "rf_consol-clear" and global.stage.start == false then
			player_respawn()
			if stage == 9 then
				game.print({"rf.save"})
			end
		elseif ent.name == "rf_consol-tuto" then
			-- tutorial
			sound(player_position, "tuto")
		elseif ent.name == "storage-tank" then
			if global.water == nil then
				global.water = true
				surface.create_entity{name = "playertext", position = player_position, text = {"rf.water-1"}, color = {g = 1}}
			elseif global.water == false then
				surface.create_entity{name = "playertext", position = player_position, text = {"rf.water-3"}, color = {g = 1}}
				surface.create_entity{name = "firstaid", position = player_position}
				sound(player_position, "firstaid")
				character.health = character.prototype.max_health
				global.water = 0
			end
		elseif ent.name == "player-dummy" and global.water and global.water ~= 0 and global.test and global.test[1] and
						global.test[1].valid then
			surface.create_entity{
				name = "playertext",
				position = global.test[1].position,
				text = {"rf.water-2"},
				color = {g = 1}
			}
			global.water = false
		else
			for i = 1, 2 do
				if get_distance(game.get_entity_by_tag("gate-" .. i), player_position) <= 3 then
					game.get_entity_by_tag("gate-" .. i).request_to_open("player", 180)
				end
			end
		end
	end
	-- TODO: FIX THIS!!!
	-- local gun = player.get_inventory(defines.inventory.character_guns)[character.selected_gun_index]
	-- if gun.valid_for_read then
	-- 	local n=gun.name
	-- 	local cursor_stack = player.cursor_stack
	-- 	if n=="weapon-13" and global.weapons[13] then
	-- 		if global.weapons[13]>0 then
	-- 			cursor_stack.clear()
	-- 			cursor_stack.set_stack({name="rf_no"})
	-- 			character.character_build_distance_bonus=100
	-- 			player.build_from_cursor() -- TODO: FIX THIS
	-- 			character.character_build_distance_bonus=0
	-- 			cursor_stack.clear()
	-- 		end
	-- 	elseif n=="weapon-23" then
	-- 		cursor_stack.clear()
	-- 		cursor_stack.set_stack({name="rf_no"})
	-- 		character.character_build_distance_bonus=100
	-- 		player.build_from_cursor() -- TODO: FIX THIS
	-- 		character.character_build_distance_bonus=0
	-- 		sound(player_position,"p-23")
	-- 		cursor_stack.clear()
	-- 	end
	-- end
end)

-- on build
do
	local character_guns_index = defines.inventory.character_guns
	script.on_event(defines.events.on_built_entity, function(event)
		local ent = event.created_entity
		if ent.name ~= "rf_no" then
			return
		end

		local player = game.get_player(event.player_index)
		if not (player and player.valid) then
			return
		end

		ent.destroy()

		local gun = player.get_inventory(character_guns_index)[player.character.selected_gun_index]
		if gun.valid_for_read == false then
			return
		end

		local pos = ent.position
		local n = player.name
		local surface = player.surface
		local player_position = player.position
		if n == "weapon-13" and global.weapons[13] then
			local d = global.weapons[13]
			local new_position = targetline(player_position, pos, 1)
			if d > 0 and d < 1 then
				surface.create_entity{name = "13-1", position = new_position, target = pos, speed = 0.4}
			elseif d >= 1 and d < 2 then
				surface.create_entity{name = "13-2", position = new_position, target = pos, speed = 0.5}
			elseif d >= 2 and d < 3 then
				surface.create_entity{name = "13-3", position = new_position, target = pos, speed = 0.6}
			else
				surface.create_entity{name = "13-4", position = new_position, target = pos, speed = 0.7}
			end
			global.weapons[13] = 0
			sound(player_position, "laser")
		elseif n == "weapon-23" then
			local weapon = global.weapons[23]
			if weapon and weapon.valid then
				weapon.destroy()
			end
			global.weapons[23] = surface.create_decoratives{
				check_collision = false,
				decoratives = {name = "ex-32", position = pos, amount = 1}
			} -- TODO: CHECK THIS
		end
	end)
end

--[[on kill
script.on_event(defines.events.on_entity_died, function(event)
	local player = game.get_player(event.player_index)
	if not (player and player.valid) then return end

	if event.force.name~="player" and event.force.name~="enemy" and event.entity.force.name == "enemy" then
		local b = game.get_player(1) -- TODO: fix this
		local ent=event.entity
		if ent.name == "boss" then
			player.surface.create_entity{name="item-on-ground",position=tag("1-boss"),stack={name="armor-1"}}
			game.print("stage clear!!")
			sound(player.position,"stageclear")
			global.stats.stage=global.stats.stage+1
			market(1,"weapon-1")
		end
	end
end)
]]

do
	local main_character_inventory_index = defines.inventory.character_main
	-- get item
	script.on_event(defines.events.on_player_main_inventory_changed, function(event)
		local player = game.get_player(event.player_index)
		if not (player and player.valid) then
			return
		end

		local character = player.character
		local main_inv = player.get_inventory(main_character_inventory_index)
		if main_inv.get_item_count("money") > 0 then
			-- player.get_quickbar()[7].set_stack({name="money",count=player.get_item_count("money")})  -- TODO: FIX THIS
			-- main_inv.remove({name="money",count=main_inv.get_item_count("money")})
		else
			for _, name in pairs({"active", "level", "xp", "stage"}) do
				local count = main_inv.get_item_count(name)
				if count > 0 then
					main_inv.remove({name = name, count = count})
				end
			end
		end
		if main_inv.get_item_count("heal") > 0 then
			character.health = character.health + character.prototype.max_health * 0.1
			if passive(13) then
				character.health = character.health + character.prototype.max_health * 0.05
			end
			sound(player.position, "firstaid")
			player.surface.create_entity{name = "firstaid", position = player.position}
			if character.health > character.prototype.max_health then
				character.health = character.prototype.max_health
			end
			main_inv.remove({name = "heal"})
		end
		for i = 1, global.gunnum do
			main_inv.remove({name = "ammo-" .. i})
		end
	end)
end

-- TODO: change it on data stage to remove it
-- script.on_event(defines.events.on_player_cursor_stack_changed, function(event)
-- 	local player = game.get_player(event.player_index)
-- 	if not (player and player.valid) then return end
-- 	local cursor_stack = player.cursor_stack
-- 	if cursor_stack.valid_for_read == false then return end

-- 	local item_name = player.cursor_stack.name
-- 	if cursor_stack.type == "ammo" then
-- 		player.clear_cursor()
-- 	elseif item_name == "active" then
-- 		player.clear_cursor()
-- 	elseif item_name == "money" then
-- 		player.clear_cursor()
-- 	elseif item_name == "level" then
-- 		player.clear_cursor()
-- 	elseif item_name == "xp" then
-- 		player.clear_cursor()
-- 	elseif item_name == "stage" then
-- 		player.clear_cursor()
-- 	end
-- end)

-- on tick
script.on_event(defines.events.on_tick, function(event)
	local player = game.get_player(1) -- TODO: FIX THIS
	if not (player and player.valid) then
		return
	end
	local character = player.character
	if not character then
		return
	end

	local surface = player.surface
	-- opening
	if event.tick == 2 then
		game.show_message_dialog{text = {"rf.0"}}
		player.game_view_settings.update_entity_selection = false
		player.clear_selected_entity()
	elseif event.tick <= 21 * 60 then
		-- This seems not necessary
		-- if game.get_entity_by_tag("train").train.passengers[1]~=character then
		-- 	game.get_entity_by_tag("train").train.passengers[1]=character
		-- end
		-- for i=1, 20 do
		-- 	if get_distance(game.get_entity_by_tag("g-"..i),game.get_entity_by_tag("train"))<20 then
		-- 		game.get_entity_by_tag("g-"..i).request_to_open("player",60)
		-- 	end
		-- end
		local t = event.tick + 1 -- TODO: fix this (handled the event in a wrong way)
		-- character.active=false
		-- player.zoom=(21*60/t)^2
		if t == 60 then
			sound(player.position, "open")
		elseif t == 60 * 3 then
			game.print({"rf.1"})
		elseif t == 60 * 6 then
			game.print({"rf.2"})
		elseif t == 60 * 9 then
			game.print({"rf.3"})
		elseif t == 60 * 12 then
			game.print({"rf.4"})
		elseif t == 60 * 15 then
			game.print({"rf.5"})
		elseif t == 60 * 17 then
			game.print({"rf.6"})
		elseif t == 60 * 20 then
			game.print({"rf.7"})
		elseif t == 21 * 60 then
			-- character.active=true
			player.game_view_settings.update_entity_selection = true
			-- game.get_entity_by_tag("train").passengers=nil
		end
	end
	-- every tick call
	-- dps
	local t = global.test
	if t[1] and t[1].valid and t[2] ~= t[1].health then
		local d = t[2] - t[1].health
		t[1].health = t[2]
		et(t[1].position, math.ceil(d * 100) / 100)
		if t[3] == 0 or t[3] + 300 < event.tick then
			t[5] = event.tick
		end
		t[3] = event.tick
		t[4] = t[4] + d
		if random() < 0.1 then
			surface.create_entity{name = "weapon-text", position = t[1].position, text = {"gui.dps-0"}, color = {g = 1}}
		end
	elseif t[1] and t[1].valid and t[3] ~= 0 and t[3] + 300 == event.tick then
		local total_damage = math.ceil(t[4])
		local combat_time = math.ceil((event.tick - t[5] - 300) / 60)
		local dps = math.ceil(total_damage / combat_time)
		game.print({"gui.dps", combat_time, total_damage, dps})
		t[4] = 0
		if dps < 50 then
			surface.create_entity{name = "playertext", position = t[1].position, text = {"gui.dps-1"}, color = {g = 1}}
		end
	end
	-- dodge
	if event.tick < global.dodge then
		character_running_speed_modifier = 3
		player.walking_state = {walking = true, direction = player.walking_state.direction}
		character.destructible = false
		if passive(11) then
			local pos = player.position
			local filters = {area = {{pos.x - 1, pos.y - 1}, {pos.x + 1, pos.y + 1}}, type = "projectile"}
			for _, projectile in pairs(surface.find_entities_filtered(filters)) do
				projectile.destroy()
			end
		end
	elseif event.tick == global.dodge then
		movement()
		character.destructible = true
	end

	local weapons = global.weapons
	-- weapon 10
	local weapon = weapons[10]
	if weapons[10] then
		if weapon[1] and weapon[1].valid and weapon[2] < event.tick and (event.tick - weapon[2]) % 15 == 0 then
			local n = weapon[1].name
			local d = tonumber(sub(n, 4, len(n))) - 32
			if d > 0 then
				local ent = surface.create_decoratives{
					check_collision = false,
					decoratives = {name = "ex-" .. d, position = weapon[1].position, amount = 1}
				} -- TODO: CHECK THIS
				weapon[1].destroy()
				weapon[1] = ent
			else
				weapon[1].destroy()
				weapons[10] = false
			end
		elseif weapon[1] and weapon[1].valid == false then
			weapons[10] = false
		end
	end
	-- weapon 14
	if weapons[14] then
		if weapons[14][2] < event.tick and (event.tick - weapons[14][2]) % 2 == 0 then
			local n = (event.tick - weapons[14][2]) / 2
			local po = targetline(player.position, weapons[14][1], n * 2)
			local pos = {x = po.x, y = po.y + 1}
			local p = targetline(po, pos, random() * 1.5)
			surface.create_entity{name = "explosion-14", position = p}
			if n == 10 then
				weapons[14] = false
			end
		end
	end
	-- weapon 15
	-- TODO: FIX THIS!
	-- if weapons[15] then
	-- 	surface.create_entity{name="p-155",position=weapons[15][1],target=player.position,speed=0}
	-- 	weapons[15]=false
	-- end
	-- weapon 18
	if weapons[18] then
		surface.create_entity{name = "ep-30", position = weapons[18][1], target = player.position, speed = 0.3}
		weapons[18] = false
	end
	-- weapon 19
	-- TODO: FIX THIS!
	-- if weapons[19] then
	-- 	local ent=surface.find_entities_filtered{force="enemy",position=weapons[19][1]}
	-- 	if ent[1] and ent[1].valid and ent[1].health then
	-- 		surface.create_entity{name="p-199",position=weapons[19][1],target=ent[1],speed=1}
	-- 	end
	-- 	weapons[19]=false
	-- end
	-- weapon 20
	if weapons[20] then
		-- TODO: FIX THIS
		-- if player.get_quickbar()[7].valid_for_read and player.get_quickbar()[7].count > 0 then
		-- 	player.get_quickbar()[7].count=player.get_quickbar()[7].count-1
		-- 	surface.create_entity{name="p-200",position=targetline(player.position,weapons[20][1],1),target=weapons[20][1],speed=0.5}
		-- end
		weapons[20] = false
	end
	-- weapon 25
	if weapons[25] and weapons[25].valid then
		local pos = weapons[25].position
		local d = surface.find_entities_filtered{
			area = {{pos.x - 0.5, pos.y - 0.5}, {pos.x + 0.5, pos.y + 0.5}},
			type = "projectile"
		}
		for i, j in pairs(d) do
			if j == weapons[25] then
				table.remove(d, i)
			end
		end
		for _, j in pairs(d) do
			j.destroy()
		end
	end
	-- weapon 29
	if weapons[29] and weapons[29][1].valid and weapons[29][2] < event.tick and event.tick < weapons[29][2] + 31 then
		-- TODO: FIX THIS!
		-- if event.tick%2==0 then
		-- 	surface.create_entity{name="p-29-2",position=weapons[29][1].position,target=weapons[29][1].position,speed=1}
		-- end
		if weapons[29][2] + 30 == event.tick then
			weapons[29][1].destroy()
			weapons[29] = false
		end
	end
	-- active 3
	if global.stats.stun and global.stats.stun + 180 == event.tick then
		character.active = true
		character.destructible = true
	end
	-- active 9
	if global.stop then
		if global.stop + 60 > event.tick then
			game.speed = 0.2
			character.character_running_speed_modifier = 4
		else
			game.speed = 1
			global.stop = false
			character.character_running_speed_modifier = 0
		end
	end
	-- passive 12
	if (character.health / character.prototype.max_health) < 0.1 and passive(12) then
		character.health = character.health + character.prototype.max_health * 0.3
		-- player.get_quickbar().remove({name="passive-12"})  -- TODO: FIX THIS
		sound(player.position, "firstaid")
		surface.create_entity{name = "firstaid", position = player.position}
	end

	-- stage
	if global.stage.start then
		if global.stage.start + 10 == event.tick then
			global.bgm.num = 0
			sound(global.stage.starts[global.stage.num], "stagestart")
		elseif global.stage.start + 10 < event.tick then
			local a = global.boss
			-- local d=global.stats.stage
			local pos
			if event.tick - global.stage.start - 10 <= 300 then
				player.zoom = 300 / (event.tick - global.stage.start - 10)
			end
			-- stage 1
			if global.stage.num == 1 then
				if global.stage.start + 410 == event.tick then
					pos = {side(1, 45)}
					for i = 1, #pos do
						blood(pos[i], 3)
					end
					a.a = surface.create_entity{name = "spawner-biter-normal-1", position = pos[1]}
				elseif a.a and a.a.valid == false then
					a.a = false
					pos = {side(1, -45)}
					for i = 1, #pos do
						blood(pos[i], 3)
					end
					a.b = surface.create_entity{name = "spawner-spitter-normal-1", position = pos[1]}
				elseif a.b and a.b.valid == false then
					a.b = false
					pos = {side(1, 45), side(1, -45)}
					for i = 1, #pos do
						blood(pos[i], 3)
					end
					a.c = surface.create_entity{name = "spawner-spitter-normal-1", position = pos[1]}
					a.d = surface.create_entity{name = "spawner-biter-normal-1", position = pos[2]}
				elseif a.c and a.d and a.c.valid == false and a.d.valid == false then
					a.c = false
					a.d = false
					pos = {side(1, 45), side(1, -45), side(1, 90), side(1, -90)}
					for i = 1, #pos do
						blood(pos[i], 3)
					end
					a.e = surface.create_entity{name = "spawner-spitter-normal-1", position = pos[1]}
					a.f = surface.create_entity{name = "spawner-spitter-normal-1", position = pos[2]}
					a.g = surface.create_entity{name = "spawner-biter-normal-1", position = pos[3]}
					a.h = surface.create_entity{name = "spawner-biter-normal-1", position = pos[4]}
				elseif a.e and a.f and a.g and a.h and a.e.valid == false and a.f.valid == false and a.g.valid == false and
								a.h.valid == false then
					a.e = false
					a.f = false
					a.g = false
					a.h = false
					pos = {side(1, 180)}
					for i = 1, #pos do
						blood(pos[i], 3)
					end
					a.i = surface.create_entity{name = "biter-boss-1", position = pos[1]}
					a.j = event.tick
				elseif a.i and a.i.valid and a.j then
					if a.i.health > a.i.prototype.max_health * 0.3 and (a.j - event.tick) % 600 == 0 then
						a.j = event.tick
						sound(player.position, "rush")
						surface.create_entity{name = "slowdown-3-250", position = a.i.position, target = a.i}
					end
					if a.i.health <= a.i.prototype.max_health * 0.3 and (a.j - event.tick) % 300 == 0 then
						a.j = event.tick
						sound(player.position, "rush")
						surface.create_entity{name = "slowdown-3-250", position = a.i.position, target = a.i}
					end
					if a.i.health <= a.i.prototype.max_health * 0.15 and (a.j - event.tick) % 150 == 0 then
						a.j = event.tick
						sound(player.position, "rush")
						surface.create_entity{name = "slowdown-3-250", position = a.i.position, target = a.i}
					end
					if a.i.health < a.i.prototype.max_health * 0.9 and a.k == nil then
						pos = {side(1, 180)}
						for i = 1, #pos do
							blood(pos[i], 3)
						end
						a.k = surface.create_entity{name = "spawner-spitter-normal-1", position = pos[1]}
					end
					if a.i.health < a.i.prototype.max_health * 0.7 and a.l == nil then
						pos = {side(1, 225), side(1, 135)}
						for i = 1, #pos do
							blood(pos[i], 3)
						end
						a.l = surface.create_entity{name = "spawner-biter-normal-1", position = pos[1]}
						surface.create_entity{name = "spawner-biter-normal-1", position = pos[2]}
					end
					if a.i.health < a.i.prototype.max_health * 0.5 and a.m == nil then
						pos = {side(1, 195), side(1, 165), side(1, 225), side(1, 135)}
						for i = 1, #pos do
							blood(pos[i], 3)
						end
						a.m = surface.create_entity{name = "spawner-spitter-normal-1", position = pos[1]}
						surface.create_entity{name = "spawner-spitter-normal-1", position = pos[2]}
						surface.create_entity{name = "spawner-biter-normal-1", position = pos[3]}
						surface.create_entity{name = "spawner-biter-normal-1", position = pos[4]}
					end
					if a.i.health < a.i.prototype.max_health * 0.3 and event.tick % 80 == 0 then
						pos = targetrotate(player.position, a.i.position, 10)
						blood(pos, 1)
						surface.create_entity{name = "biter-mini-1", position = pos}
					end
					if a.i.health < a.i.prototype.max_health * 0.15 and event.tick % 80 == 40 then
						pos = targetrotate(player.position, a.i.position, -10)
						blood(pos, 1)
						surface.create_entity{name = "biter-mini-1", position = pos}
					end
					surface.wind_speed = (1 - a.i.health / a.i.prototype.max_health) * 0.2
					surface.wind_orientation = orientation(a.i, player)
					local enemy_bar = player.gui.top.main.enemy.bar
					enemy_bar.visible = true
					enemy_bar.value = a.i.health / a.i.prototype.max_health
					enemy_bar.label.caption = {
						"gui.boss-1", math.ceil(a.i.health), math.ceil(a.i.prototype.max_health),
							math.ceil(a.i.health / a.i.prototype.max_health * 100)
					}
					if a.i.health < a.i.prototype.max_health * 0.5 and event.tick % 30 == 0 then
						surface.create_entity{name = "blaze-3", position = a.i.position}
					elseif a.i.health < a.i.prototype.max_health * 0.3 and event.tick % 15 == 0 then
						surface.create_entity{name = "blaze-8", position = a.i.position}
					elseif a.i.health < a.i.prototype.max_health * 0.15 and event.tick % 15 == 0 then
						surface.create_entity{name = "blaze-8", position = a.i.position}
					end
				elseif a.i and a.i.valid == false then
					stageclear(global.stage.num)
				end
				-- stage 2
			elseif global.stage.num == 2 then
				if global.stage.start + 20 == event.tick then
					a.a = surface.create_entity{name = "spitter-boss-2", position = tag("2-12")}
					a.a.active = false
					a.a.destructible = false
				elseif global.stage.start + 410 == event.tick then
					a.a.active = true
					a.a.destructible = true
					bt(a.a.position, {"boss.2-1"})
					a.b = event.tick
					blood(tag("2-12"), 3)
				elseif a.a and a.a.valid and a.b then
					if a.b + 60 * 10 < event.tick and event.tick < a.b + 60 * 10 + 12 * 240 + 10 then
						if a.b + 60 * 10 + 60 == event.tick then
							bt(a.a.position, {"boss.2-2"})
						end
						if (event.tick - a.b - 60 * 10) % 240 == 0 then
							local i = (event.tick - a.b - 60 * 10) / 240
							a.a.set_command({
								type = defines.command.go_to_location,
								destination = tag("2-" .. i),
								distraction = defines.distraction.none
							})
							bullet_circle(50, a.a.position, 0.2)
							if i == 12 then
								a.c = a.b + 60 * 10 + 12 * 240 + 20
							end
						end
					elseif a.c and a.c < event.tick and event.tick < a.c + 240 * 12 + 10 then
						if (event.tick - a.c) % 240 == 230 then
							bullet_circle(50, a.a.position, 0.2)
						elseif (event.tick - a.c) % 240 == 0 then
							bullet_circle(50, a.a.position, 0.3)
							local i = random(1, 12)
							a.a.set_command({
								type = defines.command.go_to_location,
								destination = tag("2-" .. i),
								distraction = defines.distraction.none
							})
						end
					elseif a.c and a.c + 240 * 12 + 20 < event.tick and event.tick < a.c + 240 * 12 * 2 + 10 then
						if a.c + 240 * 12 + 60 == event.tick then
							bt(a.a.position, {"boss.2-3"})
						end
						if (event.tick - a.c) % 240 == 220 then
							bullet_circle(50, a.a.position, 0.1)
						elseif (event.tick - a.c) % 240 == 230 then
							bullet_circle(50, a.a.position, 0.2)
						elseif (event.tick - a.c) % 240 == 0 then
							bullet_circle(50, a.a.position, 0.3)
						end
						if (event.tick - a.c) % 240 == 0 then
							local i = random(1, 12)
							a.a.set_command({
								type = defines.command.go_to_location,
								destination = tag("2-" .. i),
								distraction = defines.distraction.none
							})
						end
					elseif a.c and a.c + 240 * 12 * 2 + 20 < event.tick then
						if a.c + 240 * 12 * 2 + 60 == event.tick then
							bt(a.a.position, {"boss.2-4"})
							a.a.set_command({
								type = defines.command.go_to_location,
								destination = tag("2-3"),
								distraction = defines.distraction.none
							})
						end
						if (event.tick - a.c) % 120 == 90 then
							bullet_circle(50, a.a.position, 0.1)
						elseif (event.tick - a.c) % 120 == 100 then
							bullet_circle(50, a.a.position, 0.2)
						elseif (event.tick - a.c) % 120 == 110 then
							bullet_circle(50, a.a.position, 0.3)
						elseif (event.tick - a.c) % 120 == 0 then
							bullet_circle(50, a.a.position, 0.4)
						end
					end
					surface.wind_speed = (1 - a.a.health / a.a.prototype.max_health) * 0.2
					surface.wind_orientation = orientation(a.a, player)
					local enemy_bar = player.gui.top.main.enemy.bar
					enemy_bar.visible = true
					enemy_bar.value = a.a.health / a.a.prototype.max_health
					enemy_bar.label.caption = {
						"gui.boss-2", math.ceil(a.a.health), math.ceil(a.a.prototype.max_health),
							math.ceil(a.a.health / a.a.prototype.max_health * 100)
					}
				elseif a.a and a.a.valid == false then
					stageclear(global.stage.num)
				end
				-- stage 3
			elseif global.stage.num == 3 then
				local main_surface = game.surfaces[1]
				if global.stage.start + 20 == event.tick then
					a.a = main_surface.create_entity{name = "rocket-silo", position = global.stage.boss[3]}
					a.a.destructible = false
				elseif global.stage.start + 410 == event.tick then
					a.a.destructible = true
					a.b = a.a.health / a.a.prototype.max_health
				elseif a.a and a.a.valid and a.b then
					a.b = a.a.health / a.a.prototype.max_health
					if a.b <= 1 and event.tick % 30 == 0 then
						main_surface.create_entity{name = "ep-50", position = tag("3-4"), target = player.position, speed = 0.3}
						main_surface.create_entity{name = "explosion-gunshot", position = tag("3-4"), target = player.position}
					end
					if a.b <= 0.8 then
						if a.c == nil then
							sound(player.position, "shot-5")
							main_surface.create_entity{name = "explosion-hit", position = tag("3-5"), target = player.position}
							a.c = main_surface.create_entity{
								name = "rf_rocket-3",
								position = tag("3-5"),
								target = character,
								speed = 0.15 * (1 - a.a.health / a.a.prototype.max_health * 0.5)
							}
						elseif a.c and a.c.valid == false then
							sound(player.position, "shot-5")
							main_surface.create_entity{name = "explosion-hit", position = tag("3-5"), target = player.position}
							a.c = main_surface.create_entity{
								name = "rf_rocket-3",
								position = tag("3-5"),
								target = character,
								speed = 0.15 * (1 - a.a.health / a.a.prototype.max_health * 0.5)
							}
						end
						if event.tick % 300 == 0 and (a.d == nil or a.d == false) then
							a.d = main_surface.create_decoratives{
								check_collision = false,
								decoratives = {name = "ex-64", position = etarget(5), amount = 1}
							} -- TODO: CHECK THIS
						elseif event.tick % 300 == 60 and a.d then
							main_surface.create_entity{name = "explosion-64", position = a.d.position}
							a.e = main_surface.create_entity{name = "rf_stone", position = a.d.position}
							a.d.destroy()
							a.d = false
						end
					end
					if a.b <= 0.6 and event.tick % 300 == 177 then
						main_surface.create_entity{name = "explosion-gunshot", position = tag("3-1"), target = player.position}
						main_surface.create_entity{name = "rf_poison-3", position = tag("3-1"), target = player.position, speed = 0.3}
					end
					if a.b <= 0.4 then
						if a.b <= 1 and event.tick % 30 == 0 then
							main_surface.create_entity{name = "explosion-gunshot", position = tag("3-2"), target = player.position}
							main_surface.create_entity{name = "ep-50", position = tag("3-2"), target = player.position, speed = 0.3}
						end
					end
					if a.b <= 0.2 and event.tick % 30 == 17 then
						main_surface.create_entity{
							name = "rf_flame-3",
							position = tag("3-3"),
							source = game.get_entity_by_tag("3-3"),
							target = player.position,
							speed = 0.3
						}
					end
					surface.wind_speed = (1 - a.a.health / a.a.prototype.max_health) * 0.2
					if a.c and a.c.valid then
						surface.wind_orientation = orientation(player, a.c)
					end
					local enemy_bar = player.gui.top.main.enemy.bar
					enemy_bar.visible = true
					enemy_bar.value = a.a.health / a.a.prototype.max_health
					enemy_bar.label.caption = {
						"gui.boss-3", math.ceil(a.a.health), math.ceil(a.a.prototype.max_health),
							math.ceil(a.a.health / a.a.prototype.max_health * 100)
					}
				elseif a.a and a.a.valid == false then
					stageclear(global.stage.num)
				end
				-- stage 4
			elseif global.stage.num == 4 then
				local boss4 = a.a
				if global.stage.start + 580 > event.tick and event.tick % 30 == 0 then
					surface.create_entity{name = "explosion-64", position = global.stage.starts[global.stage.num]}
				elseif global.stage.start + 580 == event.tick then
					blood(global.stage.starts[global.stage.num], 3)
					a.a = surface.create_entity{name = "worm-boss-4", position = global.stage.starts[global.stage.num]}
					surface.set_tiles({
						{name = "water-red", position = {164.5, 164.5}}, {name = "water-red", position = {164.5, 165.5}},
							{name = "water-red", position = {165.5, 164.5}}, {name = "water-red", position = {165.5, 165.5}}
					}, false)
					a.b = {x = 165.5, y = 165.5}
					a.c = false
					a.e = false
				elseif boss4 and boss4.valid then
					local boss4_pos = boss4.position
					local health_ratio = player.character.health / character.prototype.max_health -- TODO: change this
					local targetline_pos = targetline(boss4_pos, a.d or player.position, 30) -- TODO: FIX a.d is nil
					if health_ratio > 0.9 then
						if event.tick % 50 == 0 then
							a.b = tile4(a.b)
						end
					elseif health_ratio > 0.8 then
						if a.c == false then
							a.c = event.tick
							a.d = player.position
						end
						if event.tick % 45 == 0 then
							a.b = tile4(a.b)
						end
						surface.create_entity{
							name = "beam-4",
							position = boss4_pos,
							source = boss4,
							target = targetrotate(boss4_pos, targetline_pos, 180 + (event.tick - a.c)),
							duration = 2
						}
					elseif health_ratio > 0.7 then
						if a.e == false then
							a.e = event.tick
							a.d = player.position
							a.c = false
						end
						if event.tick % 40 == 0 then
							a.b = tile4(a.b)
						end
						surface.create_entity{
							name = "beam-4",
							position = boss4_pos,
							source = boss4,
							target = targetrotate(boss4_pos, targetline_pos, 90 + (event.tick - a.e)),
							duration = 2
						}
						surface.create_entity{
							name = "beam-4",
							position = boss4_pos,
							source = boss4,
							target = targetrotate(boss4_pos, targetline_pos, -90 + (event.tick - a.e)),
							duration = 2
						}
					elseif health_ratio > 0.6 then
						if a.c == false then
							a.c = event.tick
							a.d = player.position
							a.e = false
						end
						if event.tick % 35 == 0 then
							a.b = tile4(a.b)
						end
						surface.create_entity{
							name = "beam-4",
							position = boss4_pos,
							source = boss4,
							target = targetrotate(boss4_pos, targetline_pos, 60 + (event.tick - a.c)),
							duration = 2
						}
						surface.create_entity{
							name = "beam-4",
							position = boss4_pos,
							source = boss4,
							target = targetrotate(boss4_pos, targetline_pos, 180 + (event.tick - a.c)),
							duration = 2
						}
						surface.create_entity{
							name = "beam-4",
							position = boss4_pos,
							source = boss4,
							target = targetrotate(boss4_pos, targetline_pos, 300 + (event.tick - a.c)),
							duration = 2
						}
					elseif health_ratio > 0.5 then
						if a.e == false then
							a.e = event.tick
							a.d = player.position
							a.c = false
						end
						if event.tick % 30 == 0 then
							a.b = tile4(a.b)
						end
						surface.create_entity{
							name = "beam-4",
							position = boss4_pos,
							source = boss4,
							target = targetrotate(boss4_pos, targetline_pos, 180 - (event.tick - a.e) * 1.5),
							duration = 2
						}
					elseif health_ratio > 0.4 then
						if a.c == false then
							a.c = event.tick
							a.d = player.position
							a.e = false
						end
						if event.tick % 25 == 0 then
							a.b = tile4(a.b)
						end
						surface.create_entity{
							name = "beam-4",
							position = boss4_pos,
							source = boss4,
							target = targetrotate(boss4_pos, targetline_pos, 90 - (event.tick - a.c) * 1.5),
							duration = 2
						}
						surface.create_entity{
							name = "beam-4",
							position = boss4_pos,
							source = boss4,
							target = targetrotate(boss4_pos, targetline_pos, -90 - (event.tick - a.c) * 1.5),
							duration = 2
						}
					elseif health_ratio > 0.3 then
						if a.e == false then
							a.e = event.tick
							a.d = player.position
							a.c = false
						end
						if event.tick % 20 == 0 then
							a.b = tile4(a.b)
						end
						surface.create_entity{
							name = "beam-4",
							position = boss4_pos,
							source = boss4,
							target = targetrotate(boss4_pos, targetline_pos, 60 - (event.tick - a.e) * 1.5),
							duration = 2
						}
						surface.create_entity{
							name = "beam-4",
							position = boss4_pos,
							source = boss4,
							target = targetrotate(boss4_pos, targetline_pos, 180 - (event.tick - a.e) * 1.5),
							duration = 2
						}
						surface.create_entity{
							name = "beam-4",
							position = boss4_pos,
							source = boss4,
							target = targetrotate(boss4_pos, targetline_pos, 300 - (event.tick - a.e) * 1.5),
							duration = 2
						}
					elseif health_ratio > 0.2 then
						if a.c == false then
							a.c = event.tick
							a.d = player.position
							a.e = false
						end
						if event.tick % 15 == 0 then
							a.b = tile4(a.b)
						end
						surface.create_entity{
							name = "beam-4",
							position = boss4_pos,
							source = boss4,
							target = targetrotate(boss4_pos, targetline_pos, 180 - (event.tick - a.c)),
							duration = 2
						}
						surface.create_entity{
							name = "beam-4",
							position = boss4_pos,
							source = boss4,
							target = targetrotate(boss4_pos, targetline_pos, 180 + (event.tick - a.c)),
							duration = 2
						}
					elseif health_ratio > 0.1 then
						if a.e == false then
							a.e = event.tick
							a.d = player.position
							a.c = false
						end
						if event.tick % 10 == 0 then
							a.b = tile4(a.b)
						end
						surface.create_entity{
							name = "beam-4",
							position = boss4_pos,
							source = boss4,
							target = targetrotate(boss4_pos, targetline_pos, 180 - (event.tick - a.e) * 1.5),
							duration = 2
						}
						surface.create_entity{
							name = "beam-4",
							position = boss4_pos,
							source = boss4,
							target = targetrotate(boss4_pos, targetline_pos, 180 + (event.tick - a.e) * 1.5),
							duration = 2
						}
					elseif health_ratio > 0 then
						if a.c == false then
							a.c = event.tick
							a.d = player.position
							a.e = false
						end
						if event.tick % 5 == 0 then
							a.b = tile4(a.b)
						end
						surface.create_entity{
							name = "beam-4",
							position = boss4_pos,
							source = boss4,
							target = targetrotate(boss4_pos, targetline_pos, 180 + (event.tick - a.c - 1) * 72),
							duration = 6
						}
					end
					if surface.get_tile(player.position).name == "water-red" then
						character.damage(2, "enemy", "damage-enemy")
					end
					surface.wind_speed = (1 - boss4.health / boss4.prototype.max_health) * 0.2
					surface.wind_orientation = orientation(boss4, player)
					game.forces["enemy"].set_gun_speed_modifier("ammo-enemy", 1 - (boss4.health / boss4.prototype.max_health))
					local enemy_bar = player.gui.top.main.enemy.bar
					enemy_bar.visible = true
					enemy_bar.value = boss4.health / boss4.prototype.max_health
					enemy_bar.label.caption = {
						"gui.boss-4", math.ceil(boss4.health), math.ceil(boss4.prototype.max_health),
							math.ceil(boss4.health / boss4.prototype.max_health * 100)
					}
				elseif boss4 and boss4.valid == false then
					stageclear(global.stage.num)
				end
				-- stage 5
			elseif global.stage.num == 5 then
				if global.stage.start + 410 == event.tick then
					a.a = 240
					a.b = event.tick
					a.t = game.get_entity_by_tag("5-train")
					local fuel_inventory = a.t.get_inventory(defines.inventory.fuel)
					fuel_inventory[1].set_stack({name = "solid-fuel", count = 50})
					fuel_inventory[2].set_stack({name = "solid-fuel", count = 50})
					fuel_inventory[3].set_stack({name = "solid-fuel", count = 50})
				elseif a.a and a.a > 0 then
					a.c = event.tick - a.b
					if a.c % 60 == 0 then
						a.a = a.a - 1
					end
					if a.a <= 240 - (24 * 0) then -- 100%
						a.a = 0
						if a.c % 20 == 0 then
							bullet_line(a.t, "ep-50", 1, 30, 0.3)
							bullet_line(a.t, "ep-50", 1, -30, 0.3)
						end
					end
					if a.a <= 240 - (24 * 1) then -- 90%
						if a.c % 300 == 0 then
							if a.d and a.d.valid then
								a.d.destroy()
							end
							a.d = bullet_line(character, "ex-192", 1, random() * 360, 0)
							surface.create_entity{name = "rf_poison-3", position = a.t.position, target = a.d.position, speed = 0.2}
						end
					end
					if a.a <= 240 - (24 * 2) then -- 80%
						if a.c % 180 == 45 then
							surface.create_entity{
								name = "biter-normal-1",
								position = targetrotate(a.t.position, {x = a.t.position.x, y = a.t.position.y - 3}, a.t.orientation * 360 + 90)
							}
						end
					end
					if a.a <= 240 - (24 * 4) then -- 60%
						if a.c % 20 == 10 then
							bullet_line(a.t, "ep-50", 1, 30, 0.3)
							bullet_line(a.t, "ep-50", 1, -30, 0.3)
						end
					end
					if a.a <= 240 - (24 * 5) then -- 50%
						if a.c % 300 == 150 then
							if a.e and a.e.valid then
								a.e.destroy()
							end
							a.e = bullet_line(character, "ex-192", 1, random() * 360, 0)
							surface.create_entity{name = "rf_poison-3", position = a.t.position, target = a.e.position, speed = 0.2}
						end
					end
					if a.a <= 240 - (24 * 6) then -- 40%
						if a.c % 180 == 135 then
							surface.create_entity{
								name = "spitter-normal-1",
								position = targetrotate(a.t.position, {x = a.t.position.x, y = a.t.position.y - 3}, a.t.orientation * 360 + 90)
							}
						end
					end
					if a.a <= 240 - (24 * 8) then -- 20%
						if a.c % 10 == 5 then
							bullet_line(a.t, "ep-50", 1, 30, 0.3)
							bullet_line(a.t, "ep-50", 1, -30, 0.3)
						end
					end
					if a.a <= 240 - (24 * 9) then -- 10%
						surface.create_entity{name = "slow-aura", position = a.t.position, target = player.position}
						movement()
					end
					if surface.get_tile(player.position).name == "water-red" then
						character.damage(1, "enemy", "damage-enemy")
					end
					if a.a and a.a > 0 then
						surface.wind_speed = (1 - a.a / 240) * 0.2
						surface.wind_orientation = orientation(a.t, player)
						local enemy_bar = player.gui.top.main.enemy.bar
						enemy_bar.visible = true
						enemy_bar.value = a.a / 240
						enemy_bar.label.caption = {"gui.boss-5", math.ceil(a.a), 240, math.ceil(a.a / 240 * 100)}
					end
					if a.a <= 240 - (24 * 3) then -- 70%
						if a.c % 6 == 0 then
							bullet_line(a.t, "blaze-3", 1, 0, 0)
						end
					end
					if a.a <= 240 - (24 * 7) then -- 30%
						if a.c % 6 == 3 then
							bullet_line(a.t, "blaze-3", 1, 0, 0)
						end
					end
				elseif a.a and a.a == 0 then
					if a.d and a.d.valid then
						a.d.destroy()
					end
					if a.e and a.e.valid then
						a.e.destroy()
					end
					stageclear(global.stage.num)
				end
				-- stage 6
			elseif global.stage.num == 6 then
				if global.stage.start + 410 == event.tick then
					a.a = {}
					a.a[1] = {x = 32, y = 210}
					a.a[2] = {x = 53, y = 210}
					a.a[3] = {x = 75, y = 210}
					a.a[4] = {x = 99, y = 210}
					a.a[5] = {x = 119, y = 210}
					a.b = tile6({x = 0, y = 200})
					a.g = {}
					for i = 1, 6 do
						a.g[i] = game.get_entity_by_tag("6-gate-" .. i)
					end
					bt(a.g[1].position, "room 0 clear")
					a.g[1].request_to_open("player", 30000)
				elseif a.g and player.position.x < 131 then
					if event.tick % 8 == 0 and a.b then
						a.b = tile6(a.b)
					end
					if a.g[1].is_opened() and a.g[2].is_opened() == false then
						if a.c == nil then
							game.print({"boss.6-1"})
							blood({a.a[1].x, a.a[1].y - 6}, 3)
							blood({a.a[1].x, a.a[1].y + 6}, 3)
							a.c = surface.create_entity{name = "worm-normal-6-1", position = {a.a[1].x, a.a[1].y - 6}}
							a.d = surface.create_entity{name = "worm-normal-6-2", position = {a.a[1].x, a.a[1].y + 6}}
						elseif a.c and a.d and a.c.valid == false and a.d.valid == false then
							bt(a.g[2].position, "room 1 clear")
							a.g[2].request_to_open("player", 30000)
							a.c = false
						end
					end
					if a.g[2].is_opened() and a.g[3].is_opened() == false then
						local boss6_2_pos = a.a[2] -- is it?
						local x = boss6_2_pos.x
						local y = boss6_2_pos.y
						if a.c == false then
							game.print({"boss.6-2"})
							blood({x + 6, y + 6}, 3)
							blood({x + 6, y - 6}, 3)
							blood({x - 6, y + 6}, 3)
							blood({x - 6, y - 6}, 3)
							a.c = surface.create_entity{name = "worm-normal-6-3", position = {x + 6, y + 6}}
							a.d = surface.create_entity{name = "worm-normal-6-3", position = {x + 6, y - 6}}
							a.e = surface.create_entity{name = "worm-normal-6-3", position = {x - 6, y + 6}}
							a.f = surface.create_entity{name = "worm-normal-6-3", position = {x - 6, y - 6}}
						elseif a.d and a.c.valid == false and event.tick % 120 == 0 then
							blood({x + 6, y + 6}, 2)
							surface.create_entity{name = "biter-normal-1", position = {x + 6, y + 6}}
						elseif a.d and a.d.valid == false and event.tick % 120 == 30 then
							blood({x + 6, y - 6}, 2)
							surface.create_entity{name = "biter-normal-1", position = {x + 6, y - 6}}
						elseif a.d and a.e.valid == false and event.tick % 120 == 60 then
							blood({x - 6, y + 6}, 2)
							surface.create_entity{name = "biter-normal-1", position = {x - 6, y + 6}}
						elseif a.d and a.f.valid == false and event.tick % 120 == 90 then
							blood({boss6_2_pos.x - 6, boss6_2_pos.y - 6}, 2)
							surface.create_entity{name = "biter-normal-1", position = {boss6_2_pos.x - 6, boss6_2_pos.y - 6}}
						elseif a.d and a.c.valid == false and a.d.valid == false and a.e.valid == false and a.f.valid == false then
							bt(a.g[3].position, "room 2 clear")
							a.g[3].request_to_open("player", 30000)
							a.d = false
						end
					end
					if a.g[3].is_opened() and a.g[4].is_opened() == false then
						if a.d == false then
							a.d = event.tick
							blood({a.a[3].x + 6, a.a[3].y + 6}, 3)
							blood({a.a[3].x + 6, a.a[3].y - 6}, 3)
							a.c = surface.create_entity{name = "biter-normal-6", position = {a.a[3].x + 6, a.a[3].y + 6}}
							a.e = surface.create_entity{name = "spitter-normal-6", position = {a.a[3].x + 6, a.a[3].y - 6}}
							game.print({"boss.6-3"})
						elseif a.c and a.e and (a.c.valid or a.e.valid) then
							if a.e and a.e.valid and event.tick % 5 == 0 then
								movement()
								local pos
								local ents = surface.find_entities_filtered{
									area = {{a.e.position.x - 5, a.e.position.y - 5}, {a.e.position.x + 5, a.e.position.y + 5}},
									type = "projectile"
								}
								if #ents > 0 then
									local ent = false
									for i, j in pairs(ents) do
										if ent == false then
											ent = j
										elseif get_distance(a.e, ent) > get_distance(a.e, j) then
											ent = j
										end
									end
									pos = targetrotate(a.a[3], targetline(a.a[3], ent.position, 9), 60)
									a.e.set_command({
										type = defines.command.go_to_location,
										destination = pos,
										distraction = defines.distraction.none
									})
								elseif get_distance(a.e, player) < 10 then
									pos = targetrotate(a.a[3], targetline(a.a[3], player.position, 9), 120)
									a.e.set_command({
										type = defines.command.go_to_location,
										destination = pos,
										distraction = defines.distraction.none
									})
								end
							end
							if a.c and a.c.valid then
								if surface.get_tile(a.c.position).name == "concrete" then
									surface.set_tiles({{name = "water-red", position = a.c.position}}, false)
								end
								surface.create_entity{
									name = "beam-4",
									position = a.c.position,
									source = a.c,
									target = targetrotate(a.c.position, targetline(a.c.position, {x = a.c.position.x, y = a.c.position.y - 1}, 30),
													-(event.tick - a.d)),
									duration = 2
								}
							end
						elseif a.c and a.e and a.c.valid == false and a.e.valid == false then
							bt(a.g[4].position, "room 3 clear")
							a.g[4].request_to_open("player", 30000)
							a.c = false
						end
					end
					if a.g[4].is_opened() and a.g[5].is_opened() == false then
						if a.c == false then
							local x = a.a[4].x
							local y = a.a[4].y
							blood({x + 7, y + 7}, 3)
							blood({x + 7, y - 7}, 3)
							blood({x - 7, y + 7}, 3)
							blood({x - 7, y - 7}, 3)
							blood({x, y}, 3)
							a.c = true
							a.d = surface.create_entity{name = "spawner-biter-normal-1", position = {x + 7, y + 7}}
							a.e = surface.create_entity{name = "spawner-biter-normal-1", position = {x + 7, y - 7}}
							a.f = surface.create_entity{name = "spawner-biter-normal-1", position = {x - 7, y + 7}}
							a.h = surface.create_entity{name = "spawner-biter-normal-1", position = {x - 7, y - 7}}
							a.i = surface.create_entity{name = "worm-normal-6-4", position = {x, y}}
							game.print({"boss.6-4"})
						elseif a.d and a.d.valid == false and a.e.valid == false and a.f.valid == false and a.h.valid == false and
										a.i.valid == false then
							bt(a.g[5].position, "room 4 clear")
							a.g[5].request_to_open("player", 30000)
							a.d = false
						end
					end
					if a.g[5].is_opened() and a.g[6].is_opened() == false then
						if a.d == false then
							local x = a.a[5].x
							local y = a.a[5].y
							blood({x, y}, 3)
							blood({x + 6, y + 6}, 3)
							blood({x + 6, y - 6}, 3)
							blood({x - 6, y + 6}, 3)
							blood({x - 6, y - 6}, 3)
							a.z = true
							a.c = surface.create_entity{name = "biter-normal-6", position = {x, y}}
							a.d = surface.create_entity{name = "worm-normal-6-4", position = {x + 6, y + 6}}
							a.e = surface.create_entity{name = "worm-normal-6-2", position = {x + 6, y - 6}}
							a.f = surface.create_entity{name = "worm-normal-6-1", position = {x - 6, y + 6}}
							a.h = surface.create_entity{name = "worm-normal-6-3", position = {x - 6, y - 6}}
							a.i = event.tick
							game.print({"boss.6-5"})
						elseif a.c and (a.c.valid or a.d.valid or a.e.valid or a.f.valid or a.h.valid) then
							local x = a.a[5].x
							local y = a.a[5].y
							if a.h.valid == false and event.tick % 120 == 0 then
								blood({x - 6, y - 6}, 2)
								surface.create_entity{name = "biter-normal-1", position = {x - 6, y - 6}}
							end
							if a.c and a.c.valid == false and a.z then
								blood({x, y}, 3)
								a.c = surface.create_entity{name = "spitter-normal-6", position = {x, y}}
								a.z = false
							end
							if a.c.valid and a.c.name == "biter-normal-6" then
								if surface.get_tile(a.c.position).name == "concrete" then
									surface.set_tiles({{name = "water-red", position = a.c.position}}, false)
								end
								surface.create_entity{
									name = "beam-4",
									position = a.c.position,
									source = a.c,
									target = targetrotate(a.c.position, targetline(a.c.position, {x = a.c.position.x, y = a.c.position.y - 1}, 30),
													-(event.tick - a.i)),
									duration = 2
								}
							elseif a.c.valid and a.c.name == "spitter-normal-6" and event.tick % 5 == 0 then
								movement()
								local pos
								local ents = surface.find_entities_filtered{
									area = {{a.c.position.x - 5, a.c.position.y - 5}, {a.c.position.x + 5, a.c.position.y + 5}},
									type = "projectile"
								}
								if #ents > 0 then
									local ent = false
									for _, j in pairs(ents) do
										if ent == false then
											ent = j
										elseif get_distance(a.c, ent) > get_distance(a.c, j) then
											ent = j
										end
									end
									pos = targetrotate(a.a[5], targetline(a.a[5], ent.position, 9), 60)
									a.c.set_command({
										type = defines.command.go_to_location,
										destination = pos,
										distraction = defines.distraction.none
									})
								elseif get_distance(a.c, player) < 10 then
									pos = targetrotate(a.a[5], targetline(a.a[5], player.position, 9), 120)
									a.c.set_command({
										type = defines.command.go_to_location,
										destination = pos,
										distraction = defines.distraction.none
									})
								end
							end
						elseif a.c and a.c.valid == false and a.d.valid == false and a.e.valid == false and a.f.valid == false and
										a.h.valid == false then
							bt(a.g[6].position, "room 5 clear")
							a.g[6].request_to_open("player", 30000)
							a.c = false
						end
					end
					if surface.get_tile(player.position).name == "water-red" then
						character.damage(1, "enemy", "damage-enemy")
					end
					if player.position.x < 131 and player.position.y > 190 then
						surface.wind_speed = (1 - player.position.x / 130) * 0.2
						surface.wind_orientation = 0.25
						local enemy_bar = player.gui.top.main.enemy.bar
						enemy_bar.visible = true
						enemy_bar.value = 1 - (player.position.x / 130)
						enemy_bar.label.caption = {
							"gui.boss-6", math.ceil(player.position.x), 130, math.ceil(player.position.x / 130 * 100)
						}
					end
				elseif player.position.x >= 131 then
					stageclear(global.stage.num)
				end
				-- stage 7
			elseif global.stage.num == 7 then
				if global.stage.start + 410 == event.tick then
					a.b = 1
					a.c = event.tick
				elseif a.b == 1 then
					-- phase 1
					a.d = event.tick - a.c
					if a.d <= 100 and a.d % 10 == 0 then
						blood(global.stage.starts[7], 2)
						if a.d == 100 then
							a.a = surface.create_entity{name = "larva-7-big", position = global.stage.starts[7]}
						end
					elseif a.a and a.a.valid and a.a.health > 1000 then
						if a.d % 300 == 0 then
							blood(targetline(a.a.position, player.position, -1.3), 1)
							surface.create_entity{name = "larva-7", position = targetline(a.a.position, player.position, -1.3)}
						end
						if a.d % 720 == 600 then
							surface.create_entity{name = "slowdown-4-0", position = a.a.position, target = a.a}
						end
						if a.d % 720 > 630 then
							if a.d % 10 then
								bullet_circle(30, a.a.position, 0.2, 1)
							end
						end
					elseif a.a and a.a.valid and a.a.health <= 1000 then
						if a.e == nil then
							a.e = targetline(global.stage.starts[7], targetrotate(global.stage.starts[7], player.position, 180), 20)
							a.a.set_command({
								type = defines.command.go_to_location,
								destination = a.e,
								distraction = defines.distraction.none
							})
						elseif a.e and get_distance(a.a, a.e) < 3 then
							a.e = a.a.position
							a.a.destroy()
							a.f = surface.create_entity{name = "egg-pre-big", position = a.e}
						end
					elseif a.f and a.f.valid == false and a.g == nil then
						a.a = surface.create_entity{name = "egg-7-big", position = a.e}
						a.a.health = 1
						a.b = 2
						a.c = event.tick
						surface.create_entity{name = "item-on-ground", position = global.stage.starts[7], stack = {name = "heal"}}
					end
				elseif a.b == 2 then
					-- phase 2
					a.d = event.tick - a.c
					a.speed = (a.a.health / a.a.prototype.max_health) * 0.1 + 0.05 -- 0.05 to 0.15
					if a.d == 60 then
						a.gas = surface.create_entity{name = "gas-7", position = a.a.position}
					end
					if a.a and a.a.valid and a.gas and a.d % (25 - math.ceil(a.speed * 100)) == 0 and a.d < 3300 then
						surface.create_entity{name = "ep-7-1", position = a.gas.position}
					end
					if a.a and a.a.valid and a.d > 300 and (a.d - 300) % (30 - math.ceil(a.speed * 100)) == 0 and a.d < 3300 then
						for i = (20 - a.speed * 100), 360, (20 - a.speed * 100) do
							surface.create_entity{
								name = "ep-30",
								position = targetrotate(a.a.position, targetline(a.a.position, player.position, -1), i),
								target = targetrotate(a.a.position, targetline(a.a.position, player.position, -2), i),
								speed = 0.2
							}
						end
					end
					if a.a and a.a.valid and a.z == nil and a.a.health == a.a.prototype.max_health then
						blood(a.a.position, 3)
						a.z = surface.create_entity{name = "boss-7", position = a.a.position}
						a.a.die()
						a.a = a.z
						sound(player.position, "anda1")
						a.b = 3
						a.c = event.tick
						a.gas.destroy()
						surface.create_entity{name = "item-on-ground", position = global.stage.starts[7], stack = {name = "heal"}}
					end
				elseif a.b == 3 then
					-- phase 3
					a.d = event.tick - a.c
					if a.d % 600 == 0 then
						sound(player.position, "anda-cast-2")
						surface.create_entity{name = "slowdown-2-0", position = a.a.position, target = a.a}
						a.gas = surface.create_entity{name = "poison-cloud-7", position = a.a.position}
					end

					if a.d % 1600 == 400 then
						if a.ee and a.ee.valid then
							a.ee.die()
						end
						blood(targetline(a.a.position, player.position, -1.2), 2)
						sound(player.position, "anda-cast-1")
						a.e = surface.create_entity{name = "larva-7", position = targetline(a.a.position, player.position, -1.2)}
						a.ep = targetline(global.stage.starts[7], player.position, -20)
						a.e.set_command({
							type = defines.command.go_to_location,
							destination = a.ep,
							distraction = defines.distraction.none
						})
					end
					if a.e and a.e.valid and a.ep and get_distance(a.e, a.ep) < 3 then
						a.et = event.tick
						a.ep = a.e.position
						a.e.destroy()
						a.eep = surface.create_entity{name = "egg-pre", position = a.ep}
					end
					if a.eep and a.eep.valid == false then
						a.eep = false
						a.ee = surface.create_entity{name = "egg-7", position = a.ep}
						a.ee.health = 100
					end
					if a.ee and a.ee.valid and a.d % 1600 == 1000 then
						blood(a.ep, 3)
						surface.create_entity{name = "worm-normal-6-3", position = a.ep}.health = a.ee.health
						a.ee.die()
					end

					if a.d % 1600 == 1200 then
						if a.fe and a.fe.valid then
							a.fe.die()
						end
						sound(player.position, "anda-cast-1")
						blood(targetline(a.a.position, player.position, -1.2), 2)
						a.f = surface.create_entity{name = "larva-7", position = targetline(a.a.position, player.position, -1.2)}
						a.fp = targetline(global.stage.starts[7], player.position, -20)
						a.f.set_command({
							type = defines.command.go_to_location,
							destination = a.fp,
							distraction = defines.distraction.none
						})
					end
					if a.f and a.f.valid and a.ep and get_distance(a.f, a.fp) < 3 then
						a.ft = event.tick
						a.fp = a.f.position
						a.f.destroy()
						a.fep = surface.create_entity{name = "egg-pre", position = a.fp}
					end
					if a.fep and a.fep.valid == false then
						a.fep = false
						a.fe = surface.create_entity{name = "egg-7", position = a.fp}
						a.fe.health = 100
					end
					if a.fe and a.fe.valid and a.d % 1600 == 200 then
						blood(a.fp, 3)
						surface.create_entity{name = "worm-normal-6-3", position = a.fp}.health = a.fe.health
						a.fe.die()
					end

					if a.a.health / a.a.prototype.max_health < 0.7 then
						sound(player.position, "anda2")
						a.b = 4
						a.c = event.tick
						surface.create_entity{name = "item-on-ground", position = global.stage.starts[7], stack = {name = "heal"}}
						if a.ee and a.ee.valid then
							a.ee.die()
						end
						if a.fe and a.fe.valid then
							a.fe.die()
						end
					end
				elseif a.b == 4 then
					-- phase 4
					a.d = event.tick - a.c
					if a.d % 400 == 0 then
						sound(player.position, "anda-cast-1")
						for i = 15, 360, 15 do
							surface.create_entity{
								name = "ep-50",
								position = targetrotate(a.a.position, targetline(a.a.position, player.position, 1.2), i),
								target = targetrotate(a.a.position, targetline(a.a.position, player.position, 30), i),
								speed = 0.01
							}
						end
					elseif a.d % 400 == 200 then
						sound(player.position, "anda-cast-1")
						surface.create_entity{name = "slowdown-4-0", position = a.a.position, target = a.a}
					elseif a.d % 400 > 230 and a.d % 400 <= 320 and a.d % 4 == 0 then
						surface.create_entity{
							name = "ep-7-1",
							position = targetline(a.a.position, player.position, (a.d % 400 - 230) * 0.3)
						}
					end
					if a.a and a.a.valid and a.a.health / a.a.prototype.max_health < 0.4 then
						sound(player.position, "anda3")
						a.b = 5
						a.c = event.tick
						surface.create_entity{name = "item-on-ground", position = global.stage.starts[7], stack = {name = "heal"}}
					end
				elseif a.b == 5 then
					-- phase 5
					a.d = event.tick - a.c
					if a.a and a.a.valid and a.e and a.e.valid and a.ep and get_distance(a.e, a.ep) < 3 then
						a.et = event.tick
						a.ep = a.e.position
						a.e.destroy()
						a.eep = surface.create_entity{name = "egg-pre", position = a.ep}
					end
					if a.a and a.a.valid and a.eep and a.eep.valid == false then
						a.eep = false
						a.ee = surface.create_entity{name = "egg-7", position = a.ep}
						a.ee.health = 100
					end
					if a.a and a.a.valid and a.ee and a.ee.valid and a.d % 800 == 600 then
						blood(a.ep, 3)
						surface.create_entity{name = "worm-normal-6-3", position = a.ep}.health = a.ee.health
						a.ee.die()
					end
					if a.a and a.a.valid and a.d % 800 == 200 then
						sound(player.position, "anda-cast-2")
						surface.create_entity{name = "slowdown-2-0", position = a.a.position, target = a.a}
						a.gas = surface.create_entity{name = "poison-cloud-7", position = a.a.position}
					elseif a.a and a.a.valid and a.d % 800 == 400 then
						sound(player.position, "anda-cast-1")
						for i = 10, 360, 10 do
							surface.create_entity{
								name = "ep-50",
								position = targetrotate(a.a.position, targetline(a.a.position, player.position, 1.2), i),
								target = targetrotate(a.a.position, targetline(a.a.position, player.position, 30), i),
								speed = 0.01
							}
						end
					elseif a.a and a.a.valid and a.d % 800 == 600 then
						sound(player.position, "anda-cast-1")
						surface.create_entity{name = "slowdown-4-0", position = a.a.position, target = a.a}
					elseif a.a and a.a.valid and a.d % 800 > 630 and a.d % 800 <= 720 and a.d % 4 == 0 then
						surface.create_entity{
							name = "ep-7-1",
							position = targetline(a.a.position, player.position, (a.d % 800 - 630) * 0.3)
						}
					elseif a.a and a.a.valid and a.d % 800 == 0 then
						for i = 10, 360, 10 do
							surface.create_entity{
								name = "ep-50",
								position = targetrotate(a.a.position, targetline(a.a.position, player.position, 1.2), i),
								target = targetrotate(a.a.position, targetline(a.a.position, player.position, 30), i),
								speed = 0.01
							}
						end
						if a.ee and a.ee.valid then
							a.ee.die()
						end
						blood(targetline(a.a.position, player.position, -1.2), 2)
						sound(player.position, "anda-cast-1")
						a.e = surface.create_entity{name = "larva-7", position = targetline(a.a.position, player.position, -1.2)}
						a.ep = targetline(global.stage.starts[7], player.position, -20)
						a.e.set_command({
							type = defines.command.go_to_location,
							destination = a.ep,
							distraction = defines.distraction.none
						})
					end
				end
				if surface.get_tile(player.position).name == "water-red" then
					character.damage(1, "enemy", "damage-enemy")
				end
				if a.a and a.a.valid then
					if a.gas and a.gas.valid then
						if a.a.name == "boss-7" then
							a.speed = 0.15 -- (1-(a.a.health/a.a.prototype.max_health)/2)
						end
						surface.wind_orientation = orientation(a.gas, player)
						surface.wind_speed = a.speed
					end
					local enemy_bar = player.gui.top.main.enemy.bar
					enemy_bar.visible = true
					enemy_bar.value = a.a.health / a.a.prototype.max_health
					enemy_bar.label.caption = {
						"gui.boss-7", math.ceil(a.a.health), math.ceil(a.a.prototype.max_health),
							math.ceil(a.a.health / a.a.prototype.max_health * 100)
					}
				end
				if global.stats.stage == 7 and a.b == 5 and a.a and a.a.valid == false then
					stageclear(global.stage.num)
				end
				-- stage 8
			elseif global.stage.num == 8 then
				if global.stage.start + 410 == event.tick then
					a.b = 1
					a.c = event.tick
					a.p = {}
					a.p[0] = global.stage.starts[8]
					local target = a.p[0]
					a.p[1] = {x = target.x, y = target.y - 20}
					local target2 = a.p[1]
					a.p[2] = targetrotate(target, target2, 72 * 1)
					a.p[3] = targetrotate(target, target2, 72 * 2)
					a.p[4] = targetrotate(target, target2, 72 * 3)
					a.p[5] = targetrotate(target, target2, 72 * 4)
					a.e = {}
					surface.create_entity{name = "explosion-128", position = a.p[0]}
				elseif a.b == 1 then
					-- phase 1
					a.d = event.tick - a.c
					if a.d > 0 and a.d <= 160 and a.d % 8 == 0 then
						if a.d == 160 then
							surface.create_entity{name = "explosion-128", position = a.p[1]}
							surface.create_entity{name = "mark", position = a.p[1]}
						end
						surface.create_entity{name = "blaze-3", position = targetline(a.p[0], a.p[1], a.d / 8)}
					elseif a.d == 220 then
						blood(a.p[1], 3)
						surface.create_entity{name = "worm-normal-8-1", position = a.p[1]}

					elseif a.d > 220 and a.d <= 220 + 60 * 20 and (a.d - 220) % 60 == 0 then
						if a.d == 220 + 60 * 20 then
							surface.create_entity{name = "explosion-128", position = a.p[4]}
							surface.create_entity{name = "mark", position = a.p[4]}
						end
						surface.create_entity{
							name = "blaze-3",
							position = targetline(a.p[1], a.p[4], (a.d - 220) / 60 * get_distance(a.p[1], a.p[4]) / 20)
						}
					elseif a.d == 220 + 60 * 20 + 60 then
						blood(a.p[4], 3)
						surface.create_entity{name = "worm-normal-8-2", position = a.p[4]}

					elseif a.d > 1480 and a.d <= 1480 + 60 * 20 and (a.d - 1480) % 60 == 0 then
						if a.d == 1480 + 60 * 20 then
							surface.create_entity{name = "explosion-128", position = a.p[2]}
							surface.create_entity{name = "mark", position = a.p[2]}
						end
						surface.create_entity{
							name = "blaze-3",
							position = targetline(a.p[4], a.p[2], (a.d - 1480) / 60 * get_distance(a.p[4], a.p[2]) / 20)
						}
					elseif a.d == 1480 + 60 * 20 + 60 then
						blood(a.p[2], 3)
						surface.create_entity{name = "worm-normal-8-3", position = a.p[2]}

					elseif a.d > 2740 and a.d <= 2740 + 60 * 20 and (a.d - 2740) % 60 == 0 then
						if a.d == 2740 + 60 * 20 then
							surface.create_entity{name = "explosion-128", position = a.p[5]}
							surface.create_entity{name = "mark", position = a.p[5]}
						end
						surface.create_entity{
							name = "blaze-3",
							position = targetline(a.p[2], a.p[5], (a.d - 2740) / 60 * get_distance(a.p[2], a.p[5]) / 20)
						}
					elseif a.d == 2740 + 60 * 20 + 60 then
						blood(a.p[5], 3)
						surface.create_entity{name = "worm-normal-8-4", position = a.p[5]}

					elseif a.d > 4000 and a.d <= 4000 + 60 * 20 and (a.d - 4000) % 60 == 0 then
						if a.d == 4000 + 60 * 20 then
							surface.create_entity{name = "explosion-128", position = a.p[3]}
							surface.create_entity{name = "mark", position = a.p[3]}
						end
						surface.create_entity{
							name = "blaze-3",
							position = targetline(a.p[5], a.p[3], (a.d - 4000) / 60 * get_distance(a.p[5], a.p[3]) / 20)
						}
					elseif a.d == 4000 + 60 * 20 + 60 then
						blood(a.p[3], 3)
						surface.create_entity{name = "worm-normal-8-5", position = a.p[3]}

					elseif a.d > 5260 and a.d <= 5260 + 60 * 20 and (a.d - 5260) % 60 == 0 then
						if a.d == 5260 + 60 * 20 then
							surface.create_entity{name = "explosion-128", position = a.p[1]}
						end
						surface.create_entity{
							name = "blaze-3",
							position = targetline(a.p[3], a.p[1], (a.d - 5260) / 60 * get_distance(a.p[3], a.p[1]) / 20)
						}
					elseif a.d == 5260 + 60 * 20 + 60 then
						surface.create_entity{name = "explosion-128", position = a.p[0]}
						blood(a.p[0], 3)
						a.a = surface.create_entity{name = "boss-8-1", position = a.p[0]}
						sound(player.position, "diablo1")
						a.b = 2
						a.c = event.tick
						surface.create_entity{name = "item-on-ground", position = a.p[0], stack = {name = "heal"}}
					end

				elseif a.b == 2 then
					-- phase 2
					a.d = event.tick - a.c
					if a.d % 1920 == 300 then
						sound(player.position, "laugh1")
						surface.create_entity{name = "slowdown-5-0", position = a.a.position, target = a.a}
					elseif a.d % 1920 == 460 then
						surface.create_entity{name = "slowdown-4-200", position = a.a.position, target = a.a}
					elseif a.d % 1920 > 460 and a.d % 1920 <= 580 and a.d % 5 == 0 then
						surface.create_entity{name = "blaze-3", position = a.a.position}
						if a.a and a.a.valid then
							surface.create_entity{name = "explosion-8", position = a.a.position}
						end
					elseif a.d % 1920 == 880 then
						sound(player.position, "laugh2")
						surface.create_entity{name = "slowdown-5-0", position = a.a.position, target = a.a}
					elseif a.d % 1920 == 1040 then
						a.p[6] = player.position
						a.p[7] = {x = player.position.x, y = player.position.y + 6}
						for i = 30, 360, 30 do
							surface.create_entity{name = "explosion-64", position = targetrotate(a.p[6], a.p[7], i)}
							surface.create_entity{name = "rf_stone", position = targetrotate(a.p[6], a.p[7], i)}
						end
					elseif a.d % 1920 == 1160 then
						for i = 1, 5 do
							for j = 30, 360, 30 do
								if a.a and a.a.valid then
									surface.create_entity{name = "ep-7-1", position = targetrotate(a.p[6], targetline(a.p[6], a.p[7], i), j)}
								end
							end
						end
					elseif a.d % 1920 == 1400 then
						sound(player.position, "laugh3")
						surface.create_entity{name = "slowdown-7-0", position = a.a.position, target = a.a}
					elseif a.d % 1920 == 1610 then
						sound(a.a.position, "castlazer")
						a.p[8] = a.a.position
						a.p[9] = a.a.health
						a.a.destroy()
						a.a = surface.create_entity{name = "boss-8-2", position = a.p[8]}
						a.a.health = a.p[9]
						surface.create_entity{name = "slowdown-10-0", position = a.a.position, target = a.a}
					elseif a.d % 1920 == 1910 then
						a.p[8] = a.a.position
						a.p[9] = a.a.health
						a.a.destroy()
						a.a = surface.create_entity{name = "boss-8-1", position = a.p[8]}
						a.a.health = a.p[9]
					elseif a.d == 7675 then
						sound(player.position, "diablo2")
						a.b = 3
						a.c = event.tick
						surface.create_entity{name = "item-on-ground", position = a.p[0], stack = {name = "heal"}}
					end
				elseif a.b == 3 then
					-- phase 3
					a.d = event.tick - a.c
					if a.d > 0 and a.d <= 160 and a.d % 8 == 0 then
						if a.d == 160 then
							surface.create_entity{name = "explosion-128", position = a.p[1]}
						end
						surface.create_entity{name = "blaze-3", position = targetline(a.p[0], a.p[1], a.d / 8)}
					elseif a.d == 220 then
						blood(a.p[1], 3)
						surface.create_entity{name = "worm-normal-8-1", position = a.p[1]}

					elseif a.d > 220 and a.d <= 220 + 60 * 20 and (a.d - 220) % 60 == 0 then
						if a.d == 220 + 60 * 20 then
							surface.create_entity{name = "explosion-128", position = a.p[4]}
						end
						surface.create_entity{
							name = "blaze-8",
							position = targetline(a.p[1], a.p[4], (a.d - 220) / 60 * get_distance(a.p[1], a.p[4]) / 20)
						}
					elseif a.d == 220 + 60 * 20 + 60 then
						blood(a.p[4], 3)
						surface.create_entity{name = "worm-normal-8-2", position = a.p[4]}

					elseif a.d > 1480 and a.d <= 1480 + 60 * 20 and (a.d - 1480) % 60 == 0 then
						if a.d == 1480 + 60 * 20 then
							surface.create_entity{name = "explosion-128", position = a.p[2]}
						end
						surface.create_entity{
							name = "blaze-8",
							position = targetline(a.p[4], a.p[2], (a.d - 1480) / 60 * get_distance(a.p[4], a.p[2]) / 20)
						}
					elseif a.d == 1480 + 60 * 20 + 60 then
						blood(a.p[2], 3)
						surface.create_entity{name = "worm-normal-8-3", position = a.p[2]}

					elseif a.d > 2740 and a.d <= 2740 + 60 * 20 and (a.d - 2740) % 60 == 0 then
						if a.d == 2740 + 60 * 20 then
							surface.create_entity{name = "explosion-128", position = a.p[5]}
						end
						surface.create_entity{
							name = "blaze-8",
							position = targetline(a.p[2], a.p[5], (a.d - 2740) / 60 * get_distance(a.p[2], a.p[5]) / 20)
						}
					elseif a.d == 2740 + 60 * 20 + 60 then
						blood(a.p[5], 3)
						surface.create_entity{name = "worm-normal-8-4", position = a.p[5]}

					elseif a.d > 4000 and a.d <= 4000 + 60 * 20 and (a.d - 4000) % 60 == 0 then
						if a.d == 4000 + 60 * 20 then
							surface.create_entity{name = "explosion-128", position = a.p[3]}
						end
						surface.create_entity{
							name = "blaze-8",
							position = targetline(a.p[5], a.p[3], (a.d - 4000) / 60 * get_distance(a.p[5], a.p[3]) / 20)
						}
					elseif a.d == 4000 + 60 * 20 + 60 then
						blood(a.p[3], 3)
						surface.create_entity{name = "worm-normal-8-5", position = a.p[3]}

					elseif a.d > 5260 and a.d <= 5260 + 60 * 20 and (a.d - 5260) % 60 == 0 then
						if a.d == 5260 + 60 * 20 then
							surface.create_entity{name = "explosion-128", position = a.p[1]}
						end
						surface.create_entity{
							name = "blaze-8",
							position = targetline(a.p[3], a.p[1], (a.d - 5260) / 60 * get_distance(a.p[3], a.p[1]) / 20)
						}
					elseif a.d == 5260 + 60 * 20 + 60 then
						a.b = 4
						a.c = event.tick
						surface.create_entity{name = "item-on-ground", position = a.p[0], stack = {name = "heal"}}
					end
					if a.a and a.a.valid then
						if a.d % 1920 == 300 then
							sound(player.position, "laugh1")
							surface.create_entity{name = "slowdown-5-0", position = a.a.position, target = a.a}
						elseif a.d % 1920 == 460 then
							surface.create_entity{name = "slowdown-4-200", position = a.a.position, target = a.a}
						elseif a.d % 1920 > 460 and a.d % 1920 <= 580 and a.d % 5 == 0 then
							surface.create_entity{name = "blaze-3", position = a.a.position}
							if a.a and a.a.valid then
								surface.create_entity{name = "explosion-8", position = a.a.position}
							end
						elseif a.d % 1920 == 880 then
							sound(player.position, "laugh2")
							surface.create_entity{name = "slowdown-5-0", position = a.a.position, target = a.a}
						elseif a.d % 1920 == 1040 then
							a.p[6] = player.position
							a.p[7] = {x = player.position.x, y = player.position.y + 6}
							for i = 30, 360, 30 do
								surface.create_entity{name = "explosion-64", position = targetrotate(a.p[6], a.p[7], i)}
								surface.create_entity{name = "rf_stone", position = targetrotate(a.p[6], a.p[7], i)}
							end
						elseif a.d % 1920 == 1160 then
							for i = 1, 5 do
								for j = 30, 360, 30 do
									surface.create_entity{name = "ep-7-1", position = targetrotate(a.p[6], targetline(a.p[6], a.p[7], i), j)}
								end
							end
						elseif a.d % 1920 == 1400 then
							sound(player.position, "laugh3")
							surface.create_entity{name = "slowdown-7-0", position = a.a.position, target = a.a}
						elseif a.d % 1920 == 1610 then
							sound(a.a.position, "castlazer")
							a.p[8] = a.a.position
							a.p[9] = a.a.health
							a.a.destroy()
							a.a = surface.create_entity{name = "boss-8-2", position = a.p[8]}
							a.a.health = a.p[9]
							surface.create_entity{name = "slowdown-10-0", position = a.a.position, target = a.a}
						elseif a.d % 1920 == 1910 then
							a.p[8] = a.a.position
							a.p[9] = a.a.health
							a.a.destroy()
							a.a = surface.create_entity{name = "boss-8-1", position = a.p[8]}
							a.a.health = a.p[9]
						end
					end
				elseif a.b == 4 then
					-- phase 4
					a.d = event.tick - a.c
					if a.d == 120 then
						blood(a.p[1], 3)
						blood(a.p[2], 3)
						blood(a.p[3], 3)
						blood(a.p[4], 3)
						blood(a.p[5], 3)
						surface.create_entity{name = "worm-normal-8-1", position = a.p[1]}
						surface.create_entity{name = "worm-normal-8-2", position = a.p[4]}
						surface.create_entity{name = "worm-normal-8-3", position = a.p[2]}
						surface.create_entity{name = "worm-normal-8-4", position = a.p[5]}
						surface.create_entity{name = "worm-normal-8-5", position = a.p[3]}
					elseif a.d % 1920 == 300 then
						sound(player.position, "laugh1")
						surface.create_entity{name = "slowdown-5-0", position = a.a.position, target = a.a}
					elseif a.d % 1920 == 460 then
						surface.create_entity{name = "slowdown-4-200", position = a.a.position, target = a.a}
					elseif a.d % 1920 > 460 and a.d % 1920 <= 580 and a.d % 5 == 0 then
						surface.create_entity{name = "blaze-8", position = a.a.position}
						if a.a and a.a.valid then
							surface.create_entity{name = "explosion-8", position = a.a.position}
						end
					elseif a.d % 1920 == 880 then
						sound(player.position, "laugh2")
						surface.create_entity{name = "slowdown-5-0", position = a.a.position, target = a.a}
					elseif a.d % 1920 == 1040 then
						a.p[6] = player.position
						a.p[7] = {x = player.position.x, y = player.position.y + 6}
						for i = 30, 360, 30 do
							surface.create_entity{name = "explosion-64", position = targetrotate(a.p[6], a.p[7], i)}
							surface.create_entity{name = "rf_stone", position = targetrotate(a.p[6], a.p[7], i)}
						end
					elseif a.d % 1920 == 1160 then
						for i = 1, 5 do
							for j = 30, 360, 30 do
								if a.a and a.a.valid then
									surface.create_entity{name = "ep-7-1", position = targetrotate(a.p[6], targetline(a.p[6], a.p[7], i), j)}
								end
							end
						end
					elseif a.d % 1920 == 1400 then
						sound(player.position, "laugh3")
						surface.create_entity{name = "slowdown-7-0", position = a.a.position, target = a.a}
					elseif a.d % 1920 == 1610 then
						sound(a.a.position, "castlazer")
						a.p[8] = a.a.position
						a.p[9] = a.a.health
						a.a.destroy()
						a.a = surface.create_entity{name = "boss-8-2", position = a.p[8]}
						a.a.health = a.p[9]
						surface.create_entity{name = "slowdown-10-0", position = a.a.position, target = a.a}
					elseif a.d % 1920 == 1910 then
						a.p[8] = a.a.position
						a.p[9] = a.a.health
						a.a.destroy()
						a.a = surface.create_entity{name = "boss-8-1", position = a.p[8]}
						a.a.health = a.p[9]
					end
				end
				if surface.get_tile(player.position).name == "water-red" then
					character.damage(1, "enemy", "damage-enemy")
				end
				if a.a and a.a.valid then
					surface.wind_speed = (1 - a.a.health / a.a.prototype.max_health) * 0.2
					surface.wind_orientation = orientation(a.a, player)
					local enemy_bar = player.gui.top.main.enemy.bar
					enemy_bar.visible = true
					enemy_bar.value = a.a.health / a.a.prototype.max_health
					enemy_bar.label.caption = {
						"gui.boss-8", math.ceil(a.a.health), math.ceil(a.a.prototype.max_health),
							math.ceil(a.a.health / a.a.prototype.max_health * 100)
					}
				elseif global.stats.stage == 8 and (a.b == 4 or a.b == 3 or a.b == 2) and a.a and a.a.valid == false then
					stageclear(global.stage.num)
				end
				-- stage 9
			elseif global.stage.num == 9 then
				if global.stage.start + 410 == event.tick then
					a.b = event.tick
					a.p = {}
					a.p[0] = {x = 19.5, y = 13.5}
					a.d = 0
				elseif a.d == 0 then
					-- phase 0
					a.c = event.tick - a.b
					if a.c == 180 then
						pt({"boss.9-1"})
						sound(player.position, "msg")
					elseif a.c == 180 * 2 then
						pt({"boss.9-2"})
						sound(player.position, "msg")
					elseif a.c == 180 * 3 then
						pt({"boss.9-3"})
						sound(player.position, "msg")
					elseif a.c == 180 * 4 then
						game.print({"boss.9-4"})
					elseif a.c == 180 * 5 then
						pt({"boss.9-5"})
						sound(player.position, "msg")
					elseif a.c == 180 * 6 then
						game.print({"boss.9-6"})
					elseif a.c == 180 * 7 then
						game.print({"boss.9-7"})
					elseif a.c == 180 * 8 + 120 then
						game.print({"boss.9-8"})
					elseif a.c == 180 * 9 + 120 then
						for i, j in pairs(surface.find_entities_filtered{area = {{-3, -7}, {40, 33}}}) do
							if j ~= character then
								if j.health then
									j.die()
								else
									j.destroy()
								end
							end
						end
						a.a = surface.create_entity{name = "tomas", position = a.p[0]}
						surface.set_tiles({
							{name = "deepwater", position = {-2, 11}}, {name = "deepwater", position = {-2, 12}},
								{name = "deepwater", position = {-2, 13}}, {name = "deepwater", position = {-2, 14}},
								{name = "deepwater", position = {-2, 15}}
						}, false)
					elseif a.c == 180 * 10 + 120 then
						game.print({"boss.9-9"})
						a.p[1] = player.position
						a.e = {}
						a.d = 1
						a.b = event.tick
						a.ep = {}
					end
				elseif a.d == 1 then
					-- phase 1
					a.c = (event.tick - a.b) % 1220
					a.i = math.ceil((event.tick - a.b) / 1220)
					if a.c >= 100 and a.c < 160 then
						if a.e[a.i] and a.e[a.i].valid then
							a.e[a.i].destroy()
						end
						a.e[a.i] = surface.create_entity{name = "mark", position = player.position}
					elseif a.c == 190 then
						surface.create_entity{name = "explosion-8", position = a.e[a.i].position}
					elseif a.c == 250 then
						blood(a.e[a.i].position, 3)
						surface.create_entity{name = "worm-normal-8-" .. a.i, position = a.e[a.i].position}
						surface.create_entity{name = "blaze-8", position = a.e[a.i].position}
					elseif a.e[a.i - 1] and a.c > 250 and a.c < 850 and a.c % 15 == 0 then
						surface.create_entity{
							name = "blaze-8",
							position = targetline(a.e[a.i - 1].position, a.e[a.i].position, math.ceil((a.c - 250) / 15) - 1)
						}
					elseif a.c == 850 then
						a.p[2] = player.position
					elseif a.c > 850 and a.c <= 1210 then
						a.ep[a.c - 850] = surface.create_entity{
							name = "ep-50",
							position = targetrotate(a.p[0], targetline(a.p[0], a.p[2], 30), a.c - 850),
							target = a.p[0],
							speed = 0.3
						}
						a.ep[a.c - 850].active = false
					elseif a.c == 1211 then
						for i = 1, 360 do
							if a.ep[i].valid then
								a.ep[i].active = true
							end
						end
						if a.i == 5 then
							a.d = 2
							a.b = event.tick
							a.ep = {}
						end
					end
					if a.d == 1 and a.a and a.a.valid then
						surface.create_entity{
							name = "beam-4",
							position = a.a.position,
							source = a.a,
							target = targetrotate(a.a.position, targetline(a.a.position, a.p[1], 20), 180 - (event.tick - a.b)),
							duration = 2
						}
					end
				elseif a.d == 2 then
					-- phase 2
					a.c = event.tick - a.b
					if a.c == 60 then
						game.print({"boss.9-10"})
					elseif a.c == 240 then
						game.print({"boss.9-11"})
					elseif a.c == 420 then
						game.print({"boss.9-12"})
						blood(a.e[5].position, 3)
						a.e[6] = surface.create_entity{
							name = "boss-7",
							position = targetrotate(a.p[0], targetline(a.p[0], player.position, 10), 180)
						}
						a.e[6].set_command({type = defines.command.attack, target = character, distraction = defines.distraction.none})
						sound(player.position, "anda1")
						a.p[1] = player.position
					elseif a.c > 420 then
						a.c = a.c - 420
						if a.c % 1200 == 360 then
							a.p[2] = player.position
						elseif a.c % 1200 > 360 and a.c % 1200 <= 720 then
							a.ep[a.c % 1200 - 360] = surface.create_entity{
								name = "ep-50",
								position = targetrotate(a.p[0], targetline(a.p[0], a.p[2], 30), a.c % 1200 - 360),
								target = player.position,
								speed = 0.3
							}
							a.ep[a.c % 1200 - 360].active = false
						elseif a.c % 1200 > 720 and a.c % 1200 <= 1080 and a.ep[a.c % 1200 - 720].valid then
							surface.create_entity{
								name = "ep-50",
								position = a.ep[a.c % 1200 - 720].position,
								target = player.position,
								speed = 0.3
							}
							a.ep[a.c % 1200 - 720].destroy()
						elseif a.c == 4790 then
							a.d = 3
							a.b = event.tick
							a.ep = {}
						end
						if a.e[6] and a.e[6].valid then
							if a.c % 600 == 0 then
								sound(player.position, "anda-cast-1")
								surface.create_entity{name = "slowdown-4-0", position = a.e[6].position, target = a.e[6]}
							elseif a.c > 600 and a.c % 600 > 30 and a.c % 600 <= 120 and a.c % 4 == 0 then
								surface.create_entity{
									name = "ep-7-1",
									position = targetline(a.e[6].position, player.position, (a.c % 600 - 30) * 0.3)
								}
							end
						end
						if a.d == 2 and a.a and a.a.valid then
							surface.create_entity{
								name = "beam-4",
								position = a.a.position,
								source = a.a,
								target = targetrotate(a.a.position, targetline(a.a.position, a.p[1], 20), 90 + a.c),
								duration = 2
							}
						end
					end
				elseif a.d == 3 then
					-- phase 3
					a.c = event.tick - a.b
					if a.c == 60 then
						game.print({"boss.9-13"})
					elseif a.c == 240 then
						game.print({"boss.9-14"})
					elseif a.c == 420 then
						game.print({"boss.9-15"})
						blood(a.e[5].position, 3)
						a.e[7] = surface.create_entity{
							name = "boss-8-1",
							position = targetrotate(a.p[0], targetline(a.p[0], player.position, 10), 180)
						}
						a.e[7].set_command({type = defines.command.attack, target = character, distraction = defines.distraction.none})
						sound(player.position, "diablo1")
						a.p[1] = player.position
					elseif a.c > 420 then
						a.c = a.c - 420
						if a.e[7] and a.e[7].valid then
							if a.c % 1200 == 600 then
								sound(player.position, "laugh3")
								surface.create_entity{name = "slowdown-7-0", position = a.e[7].position, target = a.e[7]}
							elseif a.c % 1200 == 810 then
								sound(a.a.position, "castlazer")
								a.p[3] = a.e[7].position
								a.p[4] = a.e[7].health
								a.e[7].destroy()
								a.e[7] = surface.create_entity{name = "boss-8-2", position = a.p[3]}
								a.e[7].health = a.p[4]
								surface.create_entity{name = "slowdown-10-0", position = a.e[7].position, target = a.e[7]}
							elseif a.c % 1200 == 1110 then
								a.p[3] = a.e[7].position
								a.p[4] = a.e[7].health
								a.e[7].destroy()
								a.e[7] = surface.create_entity{name = "boss-8-1", position = a.p[3]}
								a.e[7].health = a.p[4]
							end
						end
						if a.c % 1200 == 760 then
							a.p[2] = player.position
						elseif a.c % 1200 > 760 and a.c % 1200 <= 1120 then
							a.ep[a.c % 1200 - 760] = surface.create_entity{
								name = "ep-50",
								position = targetrotate(a.p[0], targetline(a.p[0], a.p[2], 30), a.c % 1200 - 760),
								target = player.position,
								speed = 0.3
							}
							a.ep[a.c % 1200 - 760].active = false
						elseif a.c % 1200 == 1121 then
							for i = 1, 360 do
								if a.ep[i].valid then
									surface.create_entity{name = "ep-50", position = a.ep[i].position, target = player.position, speed = 0.3}
									a.ep[i].destroy()
								end
							end
						elseif a.c > 4790 then
							a.d = 4
							a.b = event.tick
							a.ep = {}
						end
						if a.e[6] and a.e[6].valid then
							if a.c > 1200 and a.c % 1200 == 300 then
								sound(player.position, "anda-cast-1")
								surface.create_entity{name = "slowdown-4-0", position = a.e[6].position, target = a.e[6]}
							elseif a.c > 1200 and a.c % 1200 > 330 and a.c % 1200 <= 420 and a.c % 4 == 0 then
								surface.create_entity{
									name = "ep-7-1",
									position = targetline(a.e[6].position, player.position, (a.c % 1200 - 330) * 0.3)
								}
							end
						end
						if a.d == 3 and a.a and a.a.valid then
							local targetline_pos = targetline(a.a.position, a.p[1], 20)
							surface.create_entity{
								name = "beam-4",
								position = a.a.position,
								source = a.a,
								target = targetrotate(a.a.position, targetline_pos, 60 + a.c),
								duration = 2
							}
							surface.create_entity{
								name = "beam-4",
								position = a.a.position,
								source = a.a,
								target = targetrotate(a.a.position, targetline_pos, 180 + a.c),
								duration = 2
							}
							surface.create_entity{
								name = "beam-4",
								position = a.a.position,
								source = a.a,
								target = targetrotate(a.a.position, targetline_pos, 300 + a.c),
								duration = 2
							}
						end
					end
				elseif a.d == 4 then
					-- phase 4
					a.c = event.tick - a.b
					if a.c > 300 then
						character.active = false
						global.active[2] = 1
					end
					if a.f then
						a.g = event.tick - a.f
					end
					if a.c == 300 then
						if a.e[6].valid then
							a.e[6].die()
						end
						if a.e[7].valid then
							a.e[7].die()
						end
						game.print({"boss.9-16"})
						a.p[2] = player.position
					elseif a.c > 300 and a.c <= 660 then
						a.ep[a.c - 300] = surface.create_entity{
							name = "ep-200",
							position = targetrotate(a.p[0], targetline(a.p[0], a.p[2], 30), a.c - 300),
							target = player.position,
							speed = get_distance(targetrotate(a.p[0], targetline(a.p[0], a.p[2], 30), a.c - 300), player.position) / 200
						}
						a.ep[a.c - 300].active = false
					elseif a.c == 661 then
						for i = 1, 360 do
							if a.ep[i].valid then
								a.ep[i].active = true
							end
						end
					elseif a.c > 661 and a.f == nil then
						for i = 1, 360 do
							if a.ep[i].valid and get_distance(a.ep[i], character) < 1.3 then
								for j = 1, 360 do
									if a.ep[j].valid then
										a.ep[j].active = false
									end
								end
								a.f = event.tick
							end
						end
					elseif a.g == 1 then
						game.print({"boss.9-17"})
						sound(player.position, "alarm")
					elseif a.g == 240 then
						game.print({"boss.9-18"})
					elseif a.g == 420 then
						game.print({"boss.9-19"})
						a.a.die()
					elseif a.g == 600 then
						pt({"boss.9-20"})
						sound(player.position, "msg")
					elseif a.g == 780 then
						pt({"boss.9-21"})
						sound(player.position, "msg")
					elseif a.g == 960 then
						local g = global.stage.timer
						player.set_ending_screen_data({
							"boss.9-end", g[1][1], g[1][2], g[2][1], g[2][2], g[3][1], g[3][2], g[4][1], g[4][2], g[5][1], g[5][2], g[6][1],
								g[6][2], g[7][1], g[7][2], g[8][1], g[8][2], math.ceil((game.tick - global.timer) / 60 * 100) / 100
						})
						game.set_game_state{game_finished = true, player_won = true, can_continue = false}
					end
				end
				if a.a and a.a.valid then
					if a.a.health / a.a.prototype.max_health < 0.1 then
						game.print({"boss.9-heal"})
						a.a.health = a.a.prototype.max_health
						surface.create_entity{name = "firstaid", position = a.a.position}
					end
					surface.wind_speed = (1 - a.a.health / a.a.prototype.max_health) * 0.2
					surface.wind_orientation = orientation(a.a, player)
					local enemy_bar = player.gui.top.main.enemy.bar
					enemy_bar.visible = true
					enemy_bar.value = a.a.health / a.a.prototype.max_health
					enemy_bar.label.caption = {
						"gui.boss-9", math.ceil(a.a.health), math.ceil(a.a.prototype.max_health),
							math.ceil(a.a.health / a.a.prototype.max_health * 100)
					}
				end
			end
		end
	end
	-- every 0.1 sec call
	if event.tick % 6 == 5 then
		-- filter
		-- TODO: FIX THIS
		-- local quickbar = player.get_quickbar()
		-- quickbar.set_filter(6,"active")
		-- quickbar.set_filter(7,"money")
		-- quickbar.set_filter(8,"level")
		-- quickbar.set_filter(9,"xp")
		-- quickbar.set_filter(10,"stage")
		-- quickbar[8].set_stack({name="level",count=global.stats.level})
		-- if global.stats.xp > 0 and global.stats.level <= #global.xp then quickbar[9].set_stack({name="xp",count=math.ceil(100*global.stats.xp/global.xp[global.stats.level])})
		-- else	quickbar[9].clear()
		-- end
		-- quickbar[10].set_stack({name="stage",count=global.stats.stage})

		-- bgm
		if global.stage.start and global.stage.start + 410 < event.tick then
			if global.bgm.num == 0 then
				global.bgm.num = global.bgm.num + 1
				global.bgm.tick = event.tick
				sound(player.position, "battle-" .. global.stats.stage .. "-1")
			elseif global.bgm.tick + global.bgmtable[global.stats.stage][2] == event.tick then
				global.bgm.tick = event.tick
				global.bgm.num = global.bgm.num + 1
				if global.bgm.num == global.bgmtable[global.stats.stage][1] + 1 then
					global.bgm.num = 1
				end
				sound(player.position, "battle-" .. global.stats.stage .. "-" .. global.bgm.num)
			end
		elseif not global.stage.start and event.tick > 25 * 60 then
			if global.bgm.num == 0 then
				global.bgm.num = global.bgm.num + 1
				global.bgm.tick = event.tick
				sound(player.position, "battle-0-1")
			elseif global.bgm.tick + global.bgmtable[0][2] == event.tick then
				global.bgm.tick = event.tick
				global.bgm.num = global.bgm.num + 1
				if global.bgm.num == global.bgmtable[0][1] + 1 then
					global.bgm.num = 1
				end
				sound(player.position, "battle-0-" .. global.bgm.num)
			end
		end

	end

	-- every 1sec call
	if event.tick % 60 == 17 then
		local player_inventory = player.get_inventory(defines.inventory.character_armor)
		if player_inventory.is_empty() == false then
			player_inventory[1].durability = 1000000
		end
		-- levelup
		levelup()

		-- global.stats.xp=global.stats.xp+1000---------------------------------for test

		-- movement,gun
		movement()
		gun(global.gunnum)

		-- health
		if global.stats.mastery[5] == 3 and character.health / character.prototype.max_health <= 0.2 then
			character.health = character.health + 10
		end
		if passive(7) and character.health / character.prototype.max_health <= 0.2 then
			character.health = character.health + 10
		end

		-- active item cooldown
		if global.active[1] and global.active[2] ~= global.active[3] then
			if passive(15) and global.active[2] < global.active[3] * 0.2 then
				global.active[2] = math.ceil(global.active[3] * 0.2)
			end
			global.active[2] = global.active[2] + 1
			if global.active[2] == global.active[3] then
				surface.create_entity{
					name = "weapon-text",
					position = {player.position.x, player.position.y + 0.5},
					text = "active ready",
					color = {r = 1, g = 1, b = 1}
				}
			end
			if global.active[2] > global.active[3] then
				global.active[2] = global.active[3]
			end
			-- TODO: FIX THIS
			-- if global.active[2]>0 then
			-- 	player.get_quickbar()[6].set_stack({name="active",count=math.ceil(100*global.active[2]/global.active[3])})
			-- else player.get_quickbar()[6].clear()
			-- end
		end
	end
	if event.tick % (60 * 60) == 2773 then
		-- TODO: FIX AND CHECK: or character.prototype.resistances["damage-enemy"]
		if (event.tick > global.dodge and character.active and character.destructible == false) or
						character.prototype.max_health ~= 1000 or character.prototype.healing_per_tick > 0 then
			c_()
		end
	end
end)

-- on fire, on hit
script.on_event(defines.events.on_trigger_created_entity, function(event)
	local player = game.get_player(1) -- TODO: FIX THIS
	if not (player and player.valid) then
		return
	end

	local gun = player.get_inventory(defines.inventory.character_guns)[player.character.selected_gun_index]
	if gun.valid_for_read == false then
		return
	end

	local ent = event.entity
	local n = gun.name
	if ent.name == "player-fire" then
		local cooldown = game.item_prototypes[n].attack_parameters.cooldown
		-- TODO: CHECK THIS!
		if passive(19) then
			if random() < cooldown / 60 * 0.5 then
				local e = player.surface.find_nearest_enemy{position = player.position, max_distance = 30}
				if e and e.valid then
					player.surface.create_entity{
						name = "p-7",
						position = targetline(player.position, e.position, 1.5),
						target = e.position,
						speed = 0.5,
						max_range = 10
					}
				end
			end
		end
		if passive(20) then
			if random() < cooldown / 60 * 0.2 then
				if global.active[1] then
					global.active[2] = global.active[2] + 1
					if global.active[2] > global.active[3] then
						global.active[2] = global.active[3]
					end
				end
			end
		end
		if n == "weapon-13" then
			if global.weapons[13] == nil or global.weapons[13] == 0 then
				global.weapons[13] = 0.1
			else
				global.weapons[13] = global.weapons[13] + 0.1
				local d = global.weapons[13]
				if d >= 1 and d < 1.1 then
					player.surface.create_entity{
						name = "weapon-text",
						position = {player.position.x, player.position.y + 0.5},
						text = "33%",
						color = {r = 1, g = 1, b = 1}
					}
				elseif d >= 2 and d < 2.1 then
					player.surface.create_entity{
						name = "weapon-text",
						position = {player.position.x, player.position.y + 0.5},
						text = "66%",
						color = {r = 1, g = 1, b = 1}
					}
				elseif d >= 3 and d < 3.1 then
					player.surface.create_entity{
						name = "weapon-text",
						position = {player.position.x, player.position.y + 0.5},
						text = "100%",
						color = {r = 1, g = 1, b = 1}
					}
				elseif d > 3 then
					d = 3
				end
			end
		elseif n == "weapon-19" then
			player.character.damage(1, "enemy", "damage-enemy")
		elseif n == "weapon-23" and global.weapons[23] and global.weapons[23].valid then
			-- TODO: CHECK THIS!
			player.surface.create_entity{
				name = "p-1",
				position = targetline(player.position, global.weapons[23].position, 1.5),
				target = global.weapons[23].position,
				speed = 0.5,
				max_range = 20
			}
		end
	elseif ent.name == "ex-256" then
		local weapon = global.weapons[10]
		if weapon and weapon[1] and weapon[1].valid then
			weapon[1].destroy()
		end
		global.weapons[10] = {ent, event.tick}
		-- TODO: CHECK THIS!
		game.surfaces[1].create_entity{
			name = "p-100",
			position = {x = global.weapons[10][1].position.x, y = global.weapons[10][1].position.y - 120},
			target = global.weapons[10][1].position,
			speed = 1,
			max_range = 20
		}
	elseif ent.name == "hit-p-14" then
		global.weapons[14] = {ent.position, event.tick}
	elseif ent.name == "hit-p-15" then
		global.weapons[15] = {ent.position, event.tick}
	elseif ent.name == "hit-p-18" then
		global.weapons[18] = {ent.position, event.tick}
	elseif ent.name == "hit-p-19" then
		global.weapons[19] = {ent.position, event.tick}
	elseif ent.name == "hit-p-20" then
		global.weapons[20] = {ent.position, event.tick}
	elseif ent.name == "hit-p-24" then
		-- TODO: CHECK THIS!
		local d = random(1, 7)
		player.surface.create_entity{
			name = "p-24-" .. d,
			position = targetline(player.position, ent.position, 1.5),
			target = ent.position,
			speed = d * 0.1,
			max_range = 20
		}
	elseif ent.name == "hit-p-25" then
		-- TODO: CHECK THIS!
		local d = player.surface.create_entity{
			name = "p-25-1",
			position = targetline(player.position, ent.position, 1.5),
			target = ent.position,
			speed = 0.5,
			max_range = 20
		}
		global.weapons[25] = d
	elseif ent.name == "hit-p-29" then
		-- TODO: CHECK THIS!
		local d = player.surface.create_entity{
			name = "p-29-1",
			position = targetline(player.position, ent.position, 1.5),
			target = ent.position,
			speed = 0.6,
			max_range = 20
		}
		global.weapons[29] = {d, event.tick}
	elseif ent.name == "hit-p-16-1" then
		local ents = player.surface.find_entities_filtered{
			force = "enemy",
			area = {{ent.position.x - 8, ent.position.y - 8}, {ent.position.x + 8, ent.position.y + 8}}
		}
		if #ents > 0 then
			for i, j in pairs(ents) do
				if get_distance(j, ent) == 0 then
					table.remove(ents, i)
				end
			end
		end
		-- TODO: CHECK THIS!
		if #ents > 0 then
			local d = random(1, #ents)
			player.surface.create_entity{name = "p-16-1", position = ent.position, target = ents[d], speed = 0.5, max_range = 20}
		end
	elseif ent.name == "hit-p-16-2" then
		local ents = player.surface.find_entities_filtered{
			force = "enemy",
			area = {{ent.position.x - 6, ent.position.y - 6}, {ent.position.x + 6, ent.position.y + 6}}
		}
		if #ents > 0 then
			for i, j in pairs(ents) do
				if get_distance(j, ent) == 0 then
					table.remove(ents, i)
				end
			end
		end
		-- TODO: CHECK THIS!
		if #ents > 0 then
			local d = random(1, #ents)
			player.surface.create_entity{name = "p-16-2", position = ent.position, target = ents[d], speed = 0.4, max_range = 20}
		end
	elseif ent.name == "hit-p-16-3" then
		local ents = player.surface.find_entities_filtered{
			force = "enemy",
			area = {{ent.position.x - 4, ent.position.y - 4}, {ent.position.x + 4, ent.position.y + 4}}
		}
		if #ents > 0 then
			for i, j in pairs(ents) do
				if get_distance(j, ent) == 0 then
					table.remove(ents, i)
				end
			end
		end
		-- TODO: CHECK THIS!
		if #ents > 0 then
			local d = random(1, #ents)
			player.surface.create_entity{name = "p-16-3", position = ent.position, target = ents[d], speed = 0.3, max_range = 20}
		end
	end
end)
