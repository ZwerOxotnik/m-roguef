--on player created
script.on_event(defines.events.on_player_created, function(event)
	local a=event.player_index
	global.p=game.players[a]
	game.create_force(a)
	global.p.force=a
	for c,d in pairs(game.forces) do
		d.set_cease_fire(game.forces[a],true)
		game.forces[a].set_cease_fire(d,true)
	end
	game.forces[global.p.force.name].disable_research()
	game.forces[a].set_cease_fire(game.forces.enemy,false)
	game.forces.enemy.set_cease_fire(game.forces[a],false)		
	game.forces.enemy.set_cease_fire("player",true)
	global.p.character.clear_items_inside()
	for c,d in pairs(game.surfaces[1].find_entities_filtered({force="player"})) do 
		d.destructible=false
		d.minable=false
	end
	if global.p.minimap_enabled then global.p.minimap_enabled=false end
	global.p.zoom=(21*60)^2
	
	--stats
	global.timer=0
	global.stats={}
	global.stats.money=0
	global.stats.level=1
	global.stats.xp=0
	global.stats.mastery={0,0,0,0,0,0,0}	
	global.stats.stage=1
	global.stun={}
	global.gunnum=0
	global.weapon={}
	global.active={false,0,0}
	global.stim=false
	global.stop=false
	global.robot={}
	global.robot[1]=false
	global.robot[2]=false
	global.robot[3]=false
	global.robot[4]={}
	global.robot[5]={}
	global.p.force.maximum_following_robot_count =1000
	game.forces["player"].maximum_following_robot_count=1000
	global.p.insert({name="weapon-1",count=1})
	--global.p.insert({name="money",count=1000})
	for i,j in pairs(game.item_prototypes) do
		if string.len(j.name)>5 then
			if string.sub(j.name,1,5)=="ammo-" then
				if global.gunnum<tonumber(string.sub(j.name,6,string.len(j.name))) then
					global.gunnum=tonumber(string.sub(j.name,6,string.len(j.name)))
				end
			elseif string.len(j.name)>6 then
				if string.sub(j.name,1,6)=="armor-" then
					--global.p.insert({name=j.name,count=1})
				elseif string.len(j.name)>7 then
					if string.sub(j.name,1,7)=="weapon-" or string.sub(j.name,1,7)=="active-" then
						--global.p.insert({name=j.name,count=1})
					elseif string.len(j.name)>8 then
						if string.sub(j.name,1,8)=="passive-" then
							--global.p.insert({name=j.name,count=1})
						end
					end
				end
			end
		end
	end
	global.dodge=0
	global.bgm={}
	global.bgm.num=0
	global.bgm.tick=0
	global.boss={}
	global.bgmtable={}
	global.bgmtable[0]={6,60*9.5}
	global.bgmtable[1]={6,60*12}
	global.bgmtable[2]={5,60*10}
	global.bgmtable[3]={6,60*11}
	global.bgmtable[4]={6,60*10.3}
	global.bgmtable[5]={6,60*10}
	global.bgmtable[6]={4,60*8}
	global.bgmtable[7]={8,60*8}
	global.bgmtable[8]={9,60*10}
	global.bgmtable[9]={5,60*11}
		
	--gamedata
	global.respawn={x=25,y=25}
	global.xp={}
	for i=1,6 do
		if i==1 then global.xp[i]=100*2
		else global.xp[i]=global.xp[i-1]*1.5 end
	end
	game.surfaces[1].daytime=0
	game.surfaces[1].freeze_daytime(true)
	game.surfaces[1].wind_orientation_change=0
	game.surfaces[1].wind_speed=0
	game.surfaces[1].wind_orientation=0
	if game.map_settings.pollution.enabled then game.map_settings.pollution.enabled=false end
	if	game.map_settings.enemy_evolution.enabled then game.map_settings.enemy_evolution.enabled=false end
	if	game.map_settings.enemy_expansion.enabled then game.map_settings.enemy_expansion.enabled=false end
	for a,b in pairs(game.surfaces[1].find_entities_filtered({type="tree"})) do
		b.destructible=false
		b.minable=false
	end
	global.test={}
	global.test[1]=game.surfaces[1].create_entity{name="player-test",position={28.5,26.5}}
	global.test[1].active=false
	global.test[2]=global.test[1].prototype.max_health
	global.test[3]=0
	global.test[4]=0
	global.market={}
	global.market.weapon={}
	global.market.weapon[1]=62
	global.market.weapon[2]=81
	global.market.weapon[3]=86
	global.market.weapon[4]=86
	global.market.weapon[5]=80
	global.market.weapon[6]=78
	global.market.weapon[7]=78
	global.market.weapon[8]=78	
	global.market.weapon[9]=78
	global.market.weapon[10]=83	
	global.market.weapon[11]=86	
	global.market.weapon[12]=94	
	global.market.weapon[13]=81	
	global.market.weapon[14]=79	
	global.market.weapon[15]=78
	global.market.weapon[16]=78
	global.market.weapon[17]=86
	global.market.weapon[18]=76
	global.market.weapon[19]=83
	global.market.weapon[20]=104
	global.market.weapon[21]=78
	global.market.weapon[22]=85
	global.market.weapon[23]=94
	global.market.weapon[24]=78
	global.market.weapon[25]=90
	global.market.weapon[26]=92
	global.market.weapon[27]=83
	global.market.weapon[28]=94
	global.market.weapon[29]=86
	
	global.market.armor={}
	global.market.armor[1]=40
	global.market.armor[2]=80
	global.market.armor[3]=120
	global.market.armor[4]=160
	global.market.armor[5]=200
	
	global.market.active={}
	global.market.active[1]=60
	global.market.active[2]=90
	global.market.active[3]=90
	global.market.active[4]=40
	global.market.active[5]=120
	global.market.active[6]=60
	global.market.active[7]=40
	global.market.active[8]=40
	global.market.active[9]=90
	
	global.market.passive={}
	global.market.passive[1]=100
	global.market.passive[2]=80
	global.market.passive[3]=80
	global.market.passive[4]=80
	global.market.passive[5]=80
	global.market.passive[6]=80
	global.market.passive[7]=80
	global.market.passive[8]=80
	global.market.passive[9]=120
	global.market.passive[10]=80
	global.market.passive[11]=80
	global.market.passive[12]=40
	global.market.passive[13]=60
	global.market.passive[14]=80
	global.market.passive[15]=100
	global.market.passive[16]=80
	global.market.passive[17]=80
	global.market.passive[18]=80
	global.market.passive[19]=80
	global.market.passive[20]=100
	
	--stage
	global.stage={}
	local stage=9
	global.stage.start=false
	global.stage.num=0
	global.stage.item={}
	global.stage.clear={}
	global.stage.starts={}
	global.stage.timer={}
	for i=1,stage do
		global.stage.timer[i]={0,0}
		global.stage.item[i]=tag(i.."-i")
		game.get_entity_by_tag(i.."-i").destroy()
		global.stage.clear[i]=tag(i.."-c")
		game.get_entity_by_tag(i.."-c").destroy()
		global.stage.starts[i]=tag(i.."-start")
		game.get_entity_by_tag(i.."-start").destroy()
	end
	global.stage.boss={}
	global.stage.boss[3]=tag("3-12")
	game.get_entity_by_tag("3-12").destroy()
		
	
	
	gui()
end)

--reload
script.on_event("reload", function(event)		
	local b=global.p
	if b.get_inventory(defines.inventory.player_guns)[1].valid_for_read then
		local n=b.get_inventory(defines.inventory.player_guns)[1].name
		b.get_inventory(defines.inventory.player_ammo)[1].set_stack({name="ammo-"..string.sub(n,string.find(n,"-")+1,string.len(n)),1000})
	end
	if b.get_inventory(defines.inventory.player_guns)[2].valid_for_read then
		local n=b.get_inventory(defines.inventory.player_guns)[2].name
		b.get_inventory(defines.inventory.player_ammo)[2].set_stack({name="ammo-"..string.sub(n,string.find(n,"-")+1,string.len(n)),1000})
	end
	if b.get_inventory(defines.inventory.player_guns)[3].valid_for_read then
		local n=b.get_inventory(defines.inventory.player_guns)[3].name
		b.get_inventory(defines.inventory.player_ammo)[3].set_stack({name="ammo-"..string.sub(n,string.find(n,"-")+1,string.len(n)),1000})
	end
	
end)

--dodge
script.on_event("dodge", function(event)
	local t=60
	local b=global.p
	if global.stats.mastery[3]==1 then t=t-6 end
	if global.stats.mastery[3]==2 then t=t+12 end
	if passive(10) then t=t-6 end
	if global.dodge==false or global.dodge+t<event.tick then
		global.dodge=event.tick+5
		if global.stats.mastery[1]==1 then
			global.dodge=global.dodge+1
		end
		if global.stats.mastery[3]==2 then
			global.dodge=global.dodge+1
		end
		if passive(17) then
			b.surface.create_entity{name="blaze-5",position=b.position}
		end
		if passive(18) and math.random()<0.15 then
			b.surface.create_entity{name="mine-6",force=b.force.name,position=b.position}
		end
	end	
end)

--active item
script.on_event("useitem", function(event)		
	local b=global.p
	if b.character.active==false then
		b.character.active=true
		b.character.destructible=true
	end
	if global.active[1] and global.active[2]==global.active[3] then
		local n=global.active[1]
		if n==1 then
			b.character.health=b.character.health+b.character.prototype.max_health*0.4
			if b.character.health>b.character.prototype.max_health then
				b.character.health=b.character.prototype.max_health
			end
			sound(b.position,"firstaid")
			b.surface.create_entity{name="firstaid",position=b.position}
			b.get_quickbar()[5].clear()
		elseif n==2 then
			b.surface.create_entity{name="emp",position=b.position}
			sound(b.position,"target-elec")
			local d=b.surface.find_entities_filtered{area={{b.position.x-20,b.position.y-20},{b.position.x+20,b.position.y+20}},type="projectile"}
			for i,j in pairs(d) do
				j.destroy()
			end
		elseif n==3 then
			sound(b.position,"active-3")
			b.character.active=false
			b.character.destructible=false
			global.stats.stun=event.tick
		elseif n==4 then
			global.stage.start=false
			global.boss={}
			global.bgm.num=0
			global.bgm.tick=0
			global.p.gui.top.main.enemy.bar.style.visible=false
			player_respawn()
			game.print("escape!!")
			b.character.health=b.character.health+b.character.prototype.max_health*0.3
			if b.character.health>b.character.prototype.max_health then
				b.character.health=b.character.prototype.max_health
			end
			b.get_quickbar()[5].clear()
		elseif n==5 then
			sound(b.position,"stim")
			global.stim=event.tick
			movement()
			gun(global.gunnum)
		elseif n==6 then
			sound(b.position,"active-6")
			b.surface.create_entity{name="mine-6",force=b.force.name,position=b.position}
		elseif n==7 then
			market_reset()
			sound(b.position,"get")
			b.get_quickbar()[5].clear()
		elseif n==8 then
			if b.character.health/b.character.prototype.max_health>0.25 then
				sound(b.position,"get")
				b.insert({name="money",count=10})
				b.character.damage(b.character.prototype.max_health*0.1,"enemy","damage-enemy")
			end
		elseif n==9 then
			global.stop=event.tick
		
		end
		global.active[2]=0
		b.get_quickbar()[6].clear()
	end	
end)

--passive item search
function passive(n)
	local b=global.p
	local name="passive-"..n
	if b.get_quickbar()[1].valid_for_read and b.get_quickbar()[1].name==name then
		return true
	elseif b.get_quickbar()[2].valid_for_read and b.get_quickbar()[2].name==name then
		return true
	elseif b.get_quickbar()[3].valid_for_read and b.get_quickbar()[3].name==name then
		return true
	elseif b.get_quickbar()[4].valid_for_read and b.get_quickbar()[4].name==name then
		return true
	else
		return false
	end
end

--active item search
script.on_event(defines.events.on_player_quickbar_inventory_changed, function(event)
	local b=global.p
	if b.get_quickbar()[5].valid_for_read then
		local n=b.get_quickbar()[5].name
		local d
		if string.find(n,"active-") and global.active[1]==false then
			d=tonumber(string.sub(n,8,string.len(n)))
			global.active[1]=d
			active_cool(d)
		elseif string.find(n,"active-") and global.active[1] then
			d=tonumber(string.sub(n,8,string.len(n)))
			if global.active[1]~=d then 
				global.active[1]=d
				active_cool(d)
				global.active[2]=0
				b.get_quickbar()[6].clear()
			end
		else
			global.active={false,0,0}
			b.get_quickbar()[6].clear()
		end
	else
		global.active={false,0,0}
		b.get_quickbar()[6].clear()
	end
--passive item equipe
	if passive(3) then
		if global.robot[1]==false or (global.robot[1] and global.robot[1].valid==false) then
			global.robot[1]=b.surface.create_entity{name="robot-1",force="player",position=b.position,target=b.character}
			global.robot[1].destructible=false
		end
	elseif passive(3)==false and global.robot[1] then
		if global.robot[1].valid then global.robot[1].destroy() end
		global.robot[1]=false
	end
	if passive(4) then
		if global.robot[2]==false or (global.robot[2] and global.robot[2].valid==false) then
			global.robot[2]=b.surface.create_entity{name="robot-2",force="player",position=b.position,target=b.character}
			global.robot[2].destructible=false
		end
	elseif passive(4)==false and global.robot[2] then
		if global.robot[2].valid then global.robot[2].destroy() end
		global.robot[2]=false
	end
	if passive(5) then
		if global.robot[3]==false or (global.robot[3] and global.robot[3].valid==false) then
			global.robot[3]=b.surface.create_entity{name="robot-3",force="player",position=b.position,target=b.character}
			global.robot[3].destructible=false
		end
	elseif passive(5)==false and global.robot[3] then
		if global.robot[3].valid then global.robot[3].destroy() end
		global.robot[3]=false
	end
end)

--active item cooldown
function active_cool(d)
	if d==1 then global.active[3]=1 
	elseif d==2 then global.active[3]=30 
	elseif d==3 then global.active[3]=30
	elseif d==4 then global.active[3]=1
	elseif d==5 then global.active[3]=60
	elseif d==6 then global.active[3]=10
	elseif d==7 then global.active[3]=1
	elseif d==8 then global.active[3]=1
	elseif d==9 then global.active[3]=30
	end
end

--gui
function gui()
	local b=global.p
	
	--mastery
	local g=b.gui.left
	g.add{type="frame",name="main",style="outer_frame_style",direction="vertical"}
	g.main.add{type="sprite-button",name="mastery",style="side_menu_button_style",sprite="item/stage",tooltip={"gui.mastery"}}
	g.main.add{type="table",name="mt",colspan=3}
	for i=1,7 do
		for j=1,3 do
			g.main.mt.add{type="sprite-button",name=i.."-"..j,style="side_menu_button_style",sprite="item/mastery-"..i.."-"..j,tooltip={"mastery-info."..i.."-"..j}}
			g.main.mt[i.."-"..j].style.visible=false
		end
	end
	g.main.mt.style.visible=false
	unlock()
		
	--enemy health
	g=b.gui.top
	g.add{type="frame",name="main",style="outer_frame_style",direction="vertical"}
	g.main.add{type="frame",name="enemy",style="outer_frame_style",direction="horizontal"}
	g.main.enemy.add{type="progressbar",name="bar",size=1,value=0,style="health_progressbar_style"}
	g.main.enemy.bar.add{type="label",name="label"}
	g.main.enemy.bar.label.style.top_padding=12
	g.main.enemy.bar.label.style.bottom_padding=0
	g.main.enemy.style.minimal_height=0
	g.main.enemy.bar.style.minimal_height=50
	g.main.enemy.bar.style.minimal_width=800
	g.main.enemy.bar.style.maximal_width=800
	g.main.style.left_padding=100
	g.main.style.top_padding=10
	g.main.enemy.bar.style.visible=false
	--g.main.enemy.bar.label.caption={"gui.mastery"}
	
end

--on gui click
script.on_event(defines.events.on_gui_click, function(event)
	local b=global.p
	local n=event.element.name
	
	--mastery button
	if n=="mastery" and b.gui.left.main.mt.style.visible==true then
		b.gui.left.main.mt.style.visible=false
	elseif n=="mastery" and b.gui.left.main.mt.style.visible==false then
		b.gui.left.main.mt.style.visible=true
	elseif b.gui.left.main.mt and b.gui.left.main.mt[n] then 
		if b.position.x > -1 and b.position.x < 40 and b.position.y > -7 and b.position.y < 20 then
			b.gui.left.main.mt[n].style="green_circuit_network_content_slot_style"
			local i=tonumber(string.sub(n,1,1))
			local j=tonumber(string.sub(n,3,3))
			global.stats.mastery[i]=j	
			if j==3 then 
				b.gui.left.main.mt[i.."-1"].style="red_circuit_network_content_slot_style"
				b.gui.left.main.mt[i.."-2"].style="red_circuit_network_content_slot_style"
			elseif j==2 then
				b.gui.left.main.mt[i.."-1"].style="red_circuit_network_content_slot_style"
				b.gui.left.main.mt[i.."-3"].style="red_circuit_network_content_slot_style"
			else b.gui.left.main.mt[i.."-2"].style="red_circuit_network_content_slot_style"
				b.gui.left.main.mt[i.."-3"].style="red_circuit_network_content_slot_style"
			end			
		else b.print{"gui.mastery-fail"}
		end
	end

end)

--unlock
function unlock()
	local l=global.stats.level
	global.p.gui.left.main.mt[l.."-1"].style.visible=true
	global.p.gui.left.main.mt[l.."-2"].style.visible=true
	global.p.gui.left.main.mt[l.."-3"].style.visible=true
end

--sound
function sound(pos,s)
	game.surfaces[1].create_entity{name=s.."-sound",position=pos}
end

--levelup
function levelup()
	local b=global.p
	if global.stats.level < 1+#global.xp and global.stats.xp >= global.xp[global.stats.level] then
		global.stats.xp=global.stats.xp-global.xp[global.stats.level]
		global.stats.level=global.stats.level+1
		unlock()
		pt({"rf.levelup"})
		--sound(b.position,"levelup")
	end
end

--flying-text
function pt(text,color)
	if color==nil then color={g=1}end
	global.p.surface.create_entity{name = "playertext", position = global.p.position, text = text, color=color}
end
function nt(ent,text,color)
	if color==nil then color={r=1,g=1,b=1}end
	ent.surface.create_entity{name = "playertext", position = {ent.position.x,ent.position.y+1}, text = text, color=color}
	ent.surface.create_entity{name = "msg-sound", position=ent.position}
end
function et(pos,text,color)
	if color==nil then color={r=1,g=1,b=1}end
	game.surfaces[1].create_entity{name = "damage-text", position = pos, text = text, color=color}
end
function bt(pos,text,color)
	if color==nil then color={r=1,g=0,b=1}end
	game.surfaces[1].create_entity{name = "critical-text", position = pos, text = text, color=color}
end

--damages
function damagetarget(ent,effect,damage)	
	local b=global.p	
	if ent.valid and ent.destructible==true and ent.health~=nil then
		local c=game.entity_prototypes[effect].type
		local po=ent.position
		local pos={x=ent.position.x+1,y=ent.position.y}
		if c=="explosion" then
			b.surface.create_entity{name=effect,position=targetrotate(po,targetline(po,pos,math.random()/2),math.random()*360)}
		else
			b.surface.create_entity{name=effect,position=ent.position,target=ent,speed=1}
		end	
	end	
	ent.damage(damage,b.force.name,"damage-player")
end
function damagearea(pos,area,areaeffect,effect,damage)
	local b=global.p
	local c=game.entity_prototypes[effect].type	
	for i,j in pairs(b.surface.find_entities_filtered{area={{pos.x-area,pos.y-area},{pos.x+area,pos.y+area}}}) do
		if j.valid and j.destructible==true and j.health~=nil and math.sqrt((pos.x-j.position.x)^2+(pos.y-j.position.y)^2) <= area then 
			local po=j.position
			local pos={x=j.position.x+1,y=j.position.y}		
			if j.name~="player" then
				local poss=j.position				
				j.damage(damage,b.force.name,"damage-player")
				if c=="explosion" then
					b.surface.create_entity{name=effect,position=targetrotate(po,targetline(po,pos,math.random()/2),math.random()*360)}
				else
					b.surface.create_entity{name=effect,position=poss,target=poss,speed=1}
				end	
			end
		end
	end
	c=game.entity_prototypes[areaeffect].type	
	if c=="explosion" then
		b.surface.create_entity{name=areaeffect,position=pos}
	else
		b.surface.create_entity{name=areaeffect,position=pos,target=pos,speed=1}
	end		
end
function edamagetarget(ent,effect,damage,speed)	
	if speed==nil then speed=1 end
	local b=global.p
	if distance(b.character,ent)<=50 then
		local c=game.entity_prototypes[effect].type
		local po=b.character.position
		local pos={x=b.character.position.x+1,y=b.character.position.y}
		if c=="explosion" then
			b.surface.create_entity{name=effect,position=targetrotate(po,targetline(po,pos,math.random()/2),math.random()*360)}
		else
			b.surface.create_entity{name=effect,position=ent.position,target=b.character,speed=speed}
		end	
	end
	b.damage(damage,"enemy","damage-enemy")
end
function edamagearea(pos,area,areaeffect,effect,damage,speed)
	if speed==nil then speed=1 end
	local b=global.p
	local c=game.entity_prototypes[effect].type	
	for i,j in pairs(b.surface.find_entities_filtered{area={{pos.x-area,pos.y-area},{pos.x+area,pos.y+area}}}) do
		if j.valid and j.destructible==true and j.health~=nil and j.force.name~="enemy" and math.sqrt((pos.x-j.position.x)^2+(pos.y-j.position.y)^2) <= area then 
			local po=j.position
			local pos={x=j.position.x+1,y=j.position.y}		
			local poss=j.position				
			j.damage(damage,"enemy","damage-enemy")
			if c=="explosion" then
				b.surface.create_entity{name=effect,position=targetrotate(po,targetline(po,pos,math.random()/2),math.random()*360)}
			else
				b.surface.create_entity{name=effect,position=poss,target=poss,speed=speed}
			end	
		end
	end
	c=game.entity_prototypes[areaeffect].type	
	if c=="explosion" then
		b.surface.create_entity{name=areaeffect,position=pos}
	else
		b.surface.create_entity{name=areaeffect,position=pos,target=pos,speed=1}
	end		
end

--function of find entity by tag
function tag(n)
	return game.get_entity_by_tag(n).position
end

--function of  market
function market(price,item)
	game.get_entity_by_tag("market").add_market_item{price={{"money", price}},offer={type="give-item", item=item,count=1}}
end

--function of enemy target
function etarget(n)
	local b=global.p
	local d=b.walking_state.direction*45
	local pos={x=b.position.x,y=b.position.y-n}
	return targetrotate(b.position,pos,d)
end

--function of target direction
function rotation(a,b) 
	local ax=a.position.x
	local ay=a.position.y
	local bx=b.position.x
	local by=b.position.y
	local r=180+180*math.atan2(ax-bx, by-ay)/math.pi
	local c=22.5
	local d=0
	if r > c*1 and r <= c*3 then d=1
	elseif r > c*3 and r <= c*5 then d=2
	elseif r > c*5 and r <= c*7 then d=3
	elseif r > c*7 and r <= c*9 then d=4
	elseif r > c*9 and r <= c*11 then d=5
	elseif r > c*11 and r <= c*13 then d=6
	elseif r > c*13 and r <= c*15 then d=7
	else d=0 end
	return d
end

--function of orientation
function orientation(a,b) 
	local ax=a.position.x
	local ay=a.position.y
	local bx=b.position.x
	local by=b.position.y
	local r=180+180*math.atan2(ax-bx, by-ay)/math.pi
	return r/360
end

--function of target line
function targetline(po,pos,n)
	if n==nil or n==0 then
		return{x=po.x,y=po.y}
	else
		local i=0
		local j=0
		local a=po.x
		local b=po.y
		local c=pos.x
		local d=pos.y
		if a==c then c=c+0.1 end
		local k=(d-b)/(c-a)
		local aa=1+k^2
		local bb=(-2)*(a+(k^2)*c+(-1)*k*d+k*b)
		local cc=a^2+b^2+d^2+(k*c)^2+(-1)*(n^2)+(-2)*(k*c*d+(-1)*k*b*c+b*d)
		if a<c then i=((-1)*bb+(bb^2+(-4)*aa*cc)^0.5)/(2*aa) elseif a>c then i=((-1)*bb-(bb^2+(-4)*aa*cc)^0.5)/(2*aa) else i=a end
		j=k*(i-c)+d	
		if n>0 then return {x=i,y=j}	
		elseif n<0 then return targetrotate(po,{x=i,y=j},180)
		end
	end
end

--function of target rotate
function targetrotate(po,pos,t)
	local a=pos.x-po.x
	local b=pos.y-po.y
	local i=0
	local j=0
	i=a*math.cos(math.rad(t))-b*math.sin(math.rad(t))+po.x
	j=b*math.cos(math.rad(t))+a*math.sin(math.rad(t))+po.y
	return {x=i,y=j}	
end

--function of distance
function distance(ent,ents)
	local a
	local b
	local c
	local d
	if ent.position then a=ent.position.x elseif ent.x then a=ent.x else a=ent[1] end
	if ent.position then b=ent.position.y elseif ent.y then b=ent.y else b=ent[2] end
	if ents.position then c=ents.position.x elseif ents.x then c=ents.x else c=ents[1] end
	if ents.position then d=ents.position.y elseif ents.y then d=ents.y else d=ents[2] end
	return math.sqrt((a-c)^2+(b-d)^2)
end

--on player before death
script.on_event(defines.events.on_pre_player_died, function(event)
	local b=global.p
	if global.stage.num==9 then
		b.character.health=1000
		game.set_game_state{game_finished=true, player_won=false, can_continue=false}
	else
		global.stage.timer[global.stats.stage][1]=global.stage.timer[global.stats.stage][1]+1
		global.stats.xp=global.stats.xp+(50+(global.stats.stage-2)*50)/2
		sound(b.position,"die")	
		global.p.character.clear_items_inside()
		global.p.insert({name="weapon-1",count=1})	
		if global.stats.mastery[7]==1 then 
			global.p.insert({name="active-4",count=1})
		elseif global.stats.mastery[7]==2 then 
			global.p.insert({name="active-7",count=1})
		elseif global.stats.mastery[7]==3 then 
			global.p.insert({name="active-8",count=1})
		end
		b.character.health=b.character.prototype.max_health
		player_respawn()
		global.stage.start=false
		global.boss={}
		global.bgm.num=0
		global.bgm.tick=0
		global.p.gui.top.main.enemy.bar.style.visible=false
		global.stats.stage=1
		for i=1,#game.get_entity_by_tag("market").get_market_items() do
			game.get_entity_by_tag("market").remove_market_item(1)
		end	
	end
end)

--respawn
function player_respawn()
	local b=global.p
	sound(b.position,"recall")
	b.surface.wind_speed=0
	b.teleport(global.respawn)
	b.surface.create_entity{name="recall",position=global.respawn}
	local ent=b.surface.find_entities_filtered{force="enemy"}
	for i,j in pairs(ent) do
		if global.test[1]~=j then
			j.destroy()
		end
	end
	ent=b.surface.find_entities_filtered{name="item-on-ground"}
	for i,j in pairs(ent) do
		j.destroy()
	end
	ent=b.surface.find_entities_filtered{type="corpse"}
	for i,j in pairs(ent) do
		j.destroy()
	end
	ent=b.surface.find_entities_filtered{type="land-mine"}
	for i,j in pairs(ent) do
		j.destroy()
	end
	ent=b.surface.find_entities_filtered{type="projectile"}
	for i,j in pairs(ent) do
		j.destroy()
	end
	ent=b.surface.find_entities_filtered{name="rf_stone"}
	for i,j in pairs(ent) do
		j.destroy()
	end
	ent=b.surface.find_entities_filtered{name="rf_consol-clear"}
	for i,j in pairs(ent) do
		j.destroy()
	end
	ent=b.surface.find_entities_filtered{name="green-circle"}
	for i,j in pairs(ent) do
		j.destroy()
	end
	ent=b.surface.find_entities_filtered{name="blaze-8"}
	for i,j in pairs(ent) do
		j.destroy()
	end
	ent=b.surface.find_entities_filtered{name="mark"}
	for i,j in pairs(ent) do
		j.destroy()
	end
	ent=b.surface.find_entities_filtered{type="decorative"}
	for i,j in pairs(ent) do
		if string.len(j.name)>3 and string.sub(j.name,1,3)=="ex-" then
			j.destroy()
		end
	end
	ent={}
	for i=150,179 do
		for j=150,179 do
			table.insert(ent,{name="concrete",position={i,j}})
		end
	end
	for i=0,130 do
		for j=200,219 do
			table.insert(ent,{name="concrete",position={i,j}})
		end
	end
	b.surface.set_tiles(ent,false)
	game.forces["enemy"].set_gun_speed_modifier("ammo-enemy",0)
	game.forces["enemy"].set_ammo_damage_modifier("ammo-enemy",0)
	global.p.gui.top.main.enemy.bar.style.visible=false
	for i=1,6 do
		game.get_entity_by_tag("6-gate-"..i).request_to_close("player")
	end
	global.weapon={}
end

--interaction
script.on_event("interaction", function(event)		
	local b=global.p	
	local ent=b.selected
	if b.selected and b.selected.valid and distance(b.character,ent)<2 then
		if ent.name=="rf_consol-stage" and global.stage.start==false then
			b.zoom=1000
			if global.active[1] then
				global.active[2]=global.active[3]
			end
		--stage select
			if global.stats.stage==1 then
				global.stage.num=3
			elseif global.stats.stage==2 then
				global.stage.num=2
			elseif global.stats.stage==3 then
				global.stage.num=1
			elseif global.stats.stage==4 then
				global.stage.num=4
			elseif global.stats.stage==5 then
				global.stage.num=5
			elseif global.stats.stage==6 then
				global.stage.num=6
			elseif global.stats.stage==7 then
				global.stage.num=7
			elseif global.stats.stage==8 then
				global.stage.num=8
			elseif global.stats.stage==9 then
				global.stage.num=9
			end
			--global.stage.num=9 ---------------------------------------------------for test
			game.print({"boss."..global.stage.num.."-0",global.stats.stage})
			b.teleport(global.stage.starts[global.stage.num])
			if passive(3) then
				global.robot[1].teleport(global.stage.starts[global.stage.num])
			end
			if passive(4) then
				global.robot[2].teleport(global.stage.starts[global.stage.num])
			end
			if passive(5) then
				global.robot[3].teleport(global.stage.starts[global.stage.num])
			end
			global.stage.start=event.tick
			global.timer=event.tick
		elseif ent.name=="rf_consol-clear" and global.stage.start==false then
			player_respawn()
			if global.stats.stage==9 then
				game.print({"rf.save"})
			end
		elseif ent.name=="rf_consol-tuto" then
			--tutorial
			sound(b.position,"tuto")
		elseif ent.name=="storage-tank" then
			if global.water==nil then 
				global.water=true
				b.surface.create_entity{name = "playertext", position = b.position, text = {"rf.water-1"}, color={g=1}}
			elseif global.water==false then
				b.surface.create_entity{name = "playertext", position = b.position, text = {"rf.water-3"}, color={g=1}}
				b.surface.create_entity{name = "firstaid", position = b.position}
				sound(b.position,"firstaid")
				b.character.health=b.character.prototype.max_health
				global.water=0
			end
		elseif ent.name=="player-test" and global.water and global.water~=0 and global.test and global.test[1] and global.test[1].valid then
			b.surface.create_entity{name = "playertext", position = global.test[1].position, text = {"rf.water-2"}, color={g=1}}
			global.water=false
		else
			for i=1,2 do
				if distance(game.get_entity_by_tag("gate-"..i),b.position)<=3 then
					game.get_entity_by_tag("gate-"..i).request_to_open("player",180)
				end
			end
		end
	end
	if b.get_inventory(defines.inventory.player_guns)[b.character.selected_gun_index].valid_for_read then
		local n=b.get_inventory(defines.inventory.player_guns)[b.character.selected_gun_index].name
		if n=="weapon-13" and global.weapon[13] then
			if global.weapon[13]>0 then
				b.cursor_stack.clear()
				b.cursor_stack.set_stack({name="rf_no", count=1})
				b.character.character_build_distance_bonus=100
				b.build_from_cursor()
				b.character.character_build_distance_bonus=0
				b.cursor_stack.clear()
			end
		elseif n=="weapon-23" then
			b.cursor_stack.clear()
			b.cursor_stack.set_stack({name="rf_no", count=1})
			b.character.character_build_distance_bonus=100
			b.build_from_cursor()
			b.character.character_build_distance_bonus=0
			sound(b.position,"p-23")
			b.cursor_stack.clear()
		end
	end
				
	
end)

--on build
script.on_event(defines.events.on_built_entity, function(event)
	local ent=event.created_entity
	local b=global.p
	if ent.name=="rf_no" then
		local pos=ent.position
		ent.destroy()
		if b.get_inventory(defines.inventory.player_guns)[b.character.selected_gun_index].valid_for_read then
		local n=b.get_inventory(defines.inventory.player_guns)[b.character.selected_gun_index].name
		if n=="weapon-13" and global.weapon[13] then
			local d=global.weapon[13]
			if d>0 and d<1 then
				b.surface.create_entity{name="13-1",position=targetline(b.position,pos,1),target=pos,speed=0.4}
			elseif d>=1 and d<2 then
				b.surface.create_entity{name="13-2",position=targetline(b.position,pos,1),target=pos,speed=0.5}
			elseif d>=2 and d<3 then
				b.surface.create_entity{name="13-3",position=targetline(b.position,pos,1),target=pos,speed=0.6}
			else b.surface.create_entity{name="13-4",position=targetline(b.position,pos,1),target=pos,speed=0.7}
			end
			global.weapon[13]=0
			sound(b.position,"laser")
		elseif n=="weapon-23" then
			local d=b.surface.create_entity{name="ex-32",position=pos}
			if global.weapon[23] and global.weapon[23].valid then global.weapon[23].destroy() end
			global.weapon[23]=d			
		end
	end
		
		
	end
end)


--[[on kill
script.on_event(defines.events.on_entity_died, function(event)	
	if event.force.name~="player" and event.force.name~="enemy" and event.entity.force.name=="enemy" then
		local b=global.p
		local ent=event.entity
		if ent.name=="boss" then
			b.surface.create_entity{name="item-on-ground",position=tag("1-boss"),stack={name="armor-1",count=1}}
			game.print("stage clear!!")
			sound(b.position,"stageclear")
			global.stats.stage=global.stats.stage+1
			market(1,"weapon-1")
		end
	end
end)
]]

--get item
script.on_event(defines.events.on_player_main_inventory_changed, function(event)
	local b=global.p
	if b.get_inventory(defines.inventory.player_main).get_item_count("money") > 0 then			
		b.get_quickbar()[7].set_stack({name="money",count=b.get_item_count("money")})
		b.get_inventory(defines.inventory.player_main).remove({name="money",count=b.get_inventory(defines.inventory.player_main).get_item_count("money")})
	else
		local list={"active","level","xp","stage"}
		for i,j in pairs(list) do
			if b.get_inventory(defines.inventory.player_main).get_item_count(j) > 0 then	
				b.get_inventory(defines.inventory.player_main).remove({name=j,count=b.get_inventory(defines.inventory.player_main).get_item_count(j)})
			end			
		end
	end
	if b.get_inventory(defines.inventory.player_main).get_item_count("heal") > 0 then
		b.character.health=b.character.health+b.character.prototype.max_health*0.1
		if passive(13) then
			b.character.health=b.character.health+b.character.prototype.max_health*0.05
		end
		sound(b.position,"firstaid")
		b.surface.create_entity{name="firstaid",position=b.position}
		if b.character.health>b.character.prototype.max_health then
			b.character.health=b.character.prototype.max_health
		end
		b.get_inventory(defines.inventory.player_main).remove({name="heal",count=1})
	end
	for i=1,global.gunnum do
		b.get_inventory(defines.inventory.player_main).remove({name="ammo-"..i})
	end
end)

script.on_event(defines.events.on_player_cursor_stack_changed, function(event)
	local b=global.p
	if b.cursor_stack.valid_for_read then
		if b.cursor_stack.name=="active" then
			b.clean_cursor()
		elseif b.cursor_stack.name=="money" then
			b.clean_cursor()
		elseif b.cursor_stack.name=="level" then
			b.clean_cursor()
		elseif b.cursor_stack.name=="xp" then
			b.clean_cursor()
		elseif b.cursor_stack.name=="stage" then
			b.clean_cursor()
		elseif b.cursor_stack.type=="ammo" then
			b.clean_cursor()
		end
	end
end)

--stage clear
function stageclear(n)
	
	global.stage.timer[global.stats.stage][1]=global.stage.timer[global.stats.stage][1]+1
	if global.stage.timer[global.stats.stage][2]==0 or global.stage.timer[global.stats.stage][2]>math.ceil((game.tick-global.timer)/60*100)/100 then
		global.stage.timer[global.stats.stage][2]=math.ceil((game.tick-global.timer)/60*100)/100
	end
	local b=global.p
	local ent=b.surface.create_entity{name="rf_consol-clear",position=global.stage.clear[n]}
	ent.destructible=false
	b.surface.create_entity{name="green-circle",position=global.stage.item[n]}
	local ran=math.random()
	local d="weapon-"..math.random(1,#global.market.weapon)
	if global.stats.mastery[4]==1 then
		if ran<0.05 then
			d="active-"..math.random(1,#global.market.active)
		elseif ran<0.2 then
			d="passive-"..math.random(1,#global.market.passive)
		end
	elseif global.stats.mastery[4]==2 then
		if ran<0.2 then
			d="active-"..math.random(1,#global.market.active)
		elseif ran<0.5 then
			d="passive-"..math.random(1,#global.market.passive)
		end
	elseif global.stats.mastery[4]==3 then
		if ran<0.1 then
			d="active-"..math.random(1,#global.market.active)
		elseif ran<0.6 then
			d="passive-"..math.random(1,#global.market.passive)
		end
	else
		if ran<0.1 then
			d="active-"..math.random(1,#global.market.active)
		elseif ran<0.4 then
			d="passive-"..math.random(1,#global.market.passive)
		end
	end
	if global.stats.mastery[6]==1 then
		b.surface.create_entity{name="item-on-ground",position=global.stage.item[n],stack={name="money",count=20}}
	end
	b.surface.create_entity{name="item-on-ground",position=global.stage.item[n],stack={name=d,count=1}}
	game.print("stage clear!!")
	sound(b.position,"stageclear")
	local ent=b.surface.find_entities_filtered{force="enemy"}
	for i,j in pairs(ent) do
		if global.test[1]~=j then
			j.destroy()
		end
	end
	ent=b.surface.find_entities_filtered{name="blaze-8"}
	for i,j in pairs(ent) do
		j.destroy()
	end
	global.stats.stage=global.stats.stage+1
	global.stage.num=0
	global.stage.start=false
	global.bgm.num=0
	global.bgm.tick=0
	global.boss={}
	global.p.gui.top.main.enemy.bar.style.visible=false
	--xp
	if global.stats.mastery[1]==3 then
		global.stats.xp=global.stats.xp+(50+(global.stats.stage-2)*50)*0.5
	end
	global.stats.xp=global.stats.xp+(50+(global.stats.stage-2)*50)
	--money
	if global.stats.mastery[2]==2 then
		b.insert({name="money",count=(100+(global.stats.stage-2)*10)*0.2})
	end
	b.insert({name="money",count=100+(global.stats.stage-2)*10})
	--market set
	market_reset()
	--health
	if global.stats.mastery[1]==2 then
		b.character.health=b.character.health+b.character.prototype.max_health*0.2
		sound(b.position,"firstaid")
		b.surface.create_entity{name="firstaid",position=b.position}
		if b.character.health>b.character.prototype.max_health then
			b.character.health=b.character.prototype.max_health
		end
	end
end

--market reset
function market_reset()
	for i=1,#game.get_entity_by_tag("market").get_market_items() do
		game.get_entity_by_tag("market").remove_market_item(1)
	end	
	market(10+global.stats.stage-2,"heal")
	market(global.market.armor[1],"armor-1")
	market(global.market.armor[2],"armor-2")
	market(global.market.armor[3],"armor-3")
	market(global.market.armor[4],"armor-4")
	market(global.market.armor[5],"armor-5")
	local ran=math.random(1,#global.market.weapon)
	market(global.market.weapon[ran],"weapon-"..ran)
	if global.stats.mastery[6]==2 then
		ran=math.random(1,#global.market.weapon)
		market(global.market.weapon[ran],"weapon-"..ran)
	end
	ran=math.random(1,#global.market.active)
	market(global.market.active[ran],"active-"..ran)
	ran=math.random(1,#global.market.passive)
	market(global.market.passive[ran],"passive-"..ran)
end
	
--movement
function movement()
	local b=global.p
	local speed=0
	if game.tick>=global.dodge then
		if passive(2) then 
			speed=speed+0.15
		end
		if passive(9) then 
			speed=speed-0.15
		end
		if global.stats.mastery[2]==3 then
			speed=speed+0.15
		end
		if global.stim then
			if global.stim+60*10>game.tick then
				speed=speed+0.3
			else global.stim=false
			end
		end
		if global.stats.stage==6 and global.boss and global.boss.e and global.boss.e~=true and global.boss.e.valid and global.boss.e.name=="spitter-normal-6" then
			speed=(speed+1)*0.5-1
		elseif global.stats.stage==6 and global.boss and global.boss.c and global.boss.c~=true and global.boss.c.valid and global.boss.c.name=="spitter-normal-6" then
			speed=(speed+1)*0.5-1
		elseif global.stats.stage==5 and global.boss and global.boss.a and global.boss.a<=240-(24*9) then
			speed=(speed+1)*0.5-1
		end
		b.character_running_speed_modifier=speed
	end
end

--gun
function gun(n)
	local b=global.p
	local speed=0
	local damage=0
	if passive(1) then 
		speed=speed+0.1
	end
	if passive(9) then 
		speed=speed+0.2
	end
	if global.stats.mastery[2]==1 then
		speed=speed+0.1
	end
	if global.stats.mastery[5]==1 and b.character.health/b.character.prototype.max_health<=0.4 then
		speed=speed+0.1
	elseif global.stats.mastery[5]==2 and b.character.health/b.character.prototype.max_health>=0.7 then
		speed=speed+0.1
	end
	if global.stim then
		if global.stim+60*10>game.tick then
			speed=speed+0.3
		else global.stim=false
		end
	end	
	for i=1,n do
		b.force.set_gun_speed_modifier("ammo-"..i,speed)
		b.force.set_ammo_damage_modifier("ammo-"..i,damage)
	end
	if global.stats.mastery[3]==3 then
		b.force.set_ammo_damage_modifier("ammo-1",b.force.get_ammo_damage_modifier("ammo-1")+0.1)
	end
	if passive(16) then
		b.force.set_ammo_damage_modifier("ammo-1",b.force.get_ammo_damage_modifier("ammo-1")+0.2)
	end
	if global.stats.mastery[6]==3 then
		b.force.set_gun_speed_modifier("ammo-1",b.force.get_gun_speed_modifier("ammo-1")+0.1)
	end
	if passive(14) then
		b.force.set_gun_speed_modifier("ammo-10",b.force.get_gun_speed_modifier("ammo-10")+0.2)
		b.force.set_gun_speed_modifier("ammo-16",b.force.get_gun_speed_modifier("ammo-16")+0.2)
		b.force.set_gun_speed_modifier("ammo-29",b.force.get_gun_speed_modifier("ammo-29")+0.2)
	end
	if passive(6) then
		game.forces["player"].set_ammo_damage_modifier("rf_robot",0.5)
	else game.forces["player"].set_ammo_damage_modifier("rf_robot",0)
	end
	if passive(8) then
		game.forces["player"].set_gun_speed_modifier("rf_robot",0.5)
	else game.forces["player"].set_gun_speed_modifier("rf_robot",0)
	end
end

--on tick
script.on_event(defines.events.on_tick, function(event)
	local b=global.p
if b.character then 

--opening
	if event.tick==2 then
		game.show_message_dialog{text = {"rf.0"}}	
		b.game_view_settings.update_entity_selection=false
		b.clear_selected_entity()
	elseif event.tick<=21*60 then
		if game.get_entity_by_tag("train").passenger~=b.character then
			game.get_entity_by_tag("train").passenger=b.character
		end
		for i=1,20 do
			if distance(game.get_entity_by_tag("g-"..i),game.get_entity_by_tag("train"))<20 then
				game.get_entity_by_tag("g-"..i).request_to_open("player",60)
			end
		end
		local t=event.tick
		b.character.active=false
		b.zoom=(21*60/event.tick)^2
		if t==60 then
			sound(b.position,"open")
		elseif t==60*3 then
			game.print({"rf.1"})
		elseif t==60*6 then
			game.print({"rf.2"})
		elseif t==60*9 then
			game.print({"rf.3"})
		elseif t==60*12 then
			game.print({"rf.4"})
		elseif t==60*15 then
			game.print({"rf.5"})
		elseif t==60*17 then
			game.print({"rf.6"})
		elseif t==60*20 then
			game.print({"rf.7"})
		elseif t==21*60 then
			b.character.active=true
			b.game_view_settings.update_entity_selection=true
			game.get_entity_by_tag("train").passenger=nil
		end
	end
--every tick call	
	--dps
	local t=global.test
	if t[1] and t[1].valid and t[2]~=t[1].health then
		local d=t[2]-t[1].health
		t[1].health=t[2]
		et(t[1].position,math.ceil(d*100)/100)
		if t[3]==0 or t[3]+300<event.tick then
			t[5]=event.tick
		end
		t[3]=event.tick
		t[4]=t[4]+d
		if math.random()<0.1 then
			b.surface.create_entity{name = "weapon-text", position = t[1].position, text = {"gui.dps-0"}, color={g=1}}
		end
	elseif t[1] and t[1].valid and t[3]~=0 and t[3]+300==event.tick then
		game.print({"gui.dps",math.ceil((event.tick-t[5]-300)/60*100)/100,math.ceil(t[4]*100)/100,math.ceil(t[4]/((event.tick-t[5]-300)/60)*100)/100})
		local d=math.ceil(t[4]/((event.tick-t[5]-300)/60)*100)/100
		t[4]=0
		if d<50 then
			b.surface.create_entity{name = "playertext", position = t[1].position, text = {"gui.dps-1"}, color={g=1}}
		end
	end
	--dodge
	if event.tick<global.dodge then
		b.character_running_speed_modifier=3
		b.walking_state = {walking = true, direction = b.walking_state.direction}
		b.character.destructible=false
		if passive(11) then
			local pos=b.position
			local d=b.surface.find_entities_filtered{area={{pos.x-1,pos.y-1},{pos.x+1,pos.y+1}},type="projectile"}
			for i,j in pairs(d) do
				j.destroy()
			end
		end
	elseif event.tick==global.dodge then
		movement()		
		b.character.destructible=true
	end
	--weapon 10
	if global.weapon[10] then
		if global.weapon[10][1] and global.weapon[10][1].valid and global.weapon[10][2]<event.tick and (event.tick-global.weapon[10][2])%15==0 then
			local n=global.weapon[10][1].name
			local d=tonumber(string.sub(n,4,string.len(n)))-32
			if d>0 then
				local ent=b.surface.create_entity{name="ex-"..d,position=global.weapon[10][1].position}
				global.weapon[10][1].destroy()
				global.weapon[10][1]=ent
			else global.weapon[10][1].destroy()
				global.weapon[10]=false
			end
		elseif global.weapon[10][1] and global.weapon[10][1].valid==false then
			global.weapon[10]=false
		end
	end
	--weapon 14
	if global.weapon[14] then
		if global.weapon[14][2]<event.tick and (event.tick-global.weapon[14][2])%2==0 then
			local n=(event.tick-global.weapon[14][2])/2
			local po=targetline(b.position,global.weapon[14][1],n*2)
			local pos={x=po.x,y=po.y+1}
			local p=targetline(po,pos,math.random()*1.5)
			b.surface.create_entity{name="explosion-14",position=p}
			if n==10 then global.weapon[14]=false end
		end
	end
	--weapon 15
	if global.weapon[15] then
		b.surface.create_entity{name="p-155",position=global.weapon[15][1],target=b.position,speed=0}
		global.weapon[15]=false
	end
	--weapon 18
	if global.weapon[18] then
		b.surface.create_entity{name="ep-30",position=global.weapon[18][1],target=b.position,speed=0.3}
		global.weapon[18]=false
	end
	--weapon 19
	if global.weapon[19] then
		local ent=b.surface.find_entities_filtered{force="enemy",position=global.weapon[19][1]}
		if ent[1] and ent[1].valid and ent[1].health then
			b.surface.create_entity{name="p-199",position=global.weapon[19][1],target=ent[1],speed=1}
		end
		global.weapon[19]=false
	end
	--weapon 20
	if global.weapon[20] then
		if b.get_quickbar()[7].valid_for_read and b.get_quickbar()[7].count > 0 then
			b.get_quickbar()[7].count=b.get_quickbar()[7].count-1
			b.surface.create_entity{name="p-200",position=targetline(b.position,global.weapon[20][1],1),target=global.weapon[20][1],speed=0.5}
		end
		global.weapon[20]=false
	end
	--weapon 25
	if global.weapon[25] and global.weapon[25].valid then
		local pos=global.weapon[25].position
		local d=b.surface.find_entities_filtered{area={{pos.x-0.5,pos.y-0.5},{pos.x+0.5,pos.y+0.5}},type="projectile"}
		for i,j in pairs(d) do
			if j==global.weapon[25] then table.remove(d,i) end
		end
		for i,j in pairs(d) do
			j.destroy()
		end
	end
	--weapon 29
	if global.weapon[29] and global.weapon[29][1].valid and global.weapon[29][2]<event.tick and event.tick<global.weapon[29][2]+31 then
		if event.tick%2==0 then
			b.surface.create_entity{name="p-29-2",position=global.weapon[29][1].position,target=global.weapon[29][1].position,speed=1}
		end
		if global.weapon[29][2]+30==event.tick then
			global.weapon[29][1].destroy()
			global.weapon[29]=false
		end
	end
	--active 3
	if global.stats.stun and global.stats.stun+180==event.tick then
		b.character.active=true
		b.character.destructible=true
	end
	--active 9
	if global.stop then
		if global.stop+60>event.tick then
			game.speed=0.2
			b.character.character_running_speed_modifier=4
		else game.speed=1
			global.stop=false
			b.character.character_running_speed_modifier=0			
		end
	end
	--passive 12
	if b.character.health/b.character.prototype.max_health<0.1 and passive(12) then
		b.character.health=b.character.health+b.character.prototype.max_health*0.3
		b.get_quickbar().remove({name="passive-12",count=1})
		sound(b.position,"firstaid")
		b.surface.create_entity{name="firstaid",position=b.position}
	end
	
	--stage
	if global.stage.start then
		if global.stage.start+10 == event.tick then
			global.bgm.num=0
			sound(global.stage.starts[global.stage.num],"stagestart")
		elseif global.stage.start+10 < event.tick then
			local a=global.boss
			local d=global.stats.stage
			local pos
			if event.tick-global.stage.start-10<=300 then
				b.zoom=300/(event.tick-global.stage.start-10)
			end
			--stage 1		
			if global.stage.num==1 then				
				if global.stage.start+410==event.tick then
					pos={side(1,45)}
					for i=1,#pos do blood(pos[i],3) end
					a.a=b.surface.create_entity{name="spawner-biter-normal-1",position=pos[1]}
				elseif a.a and a.a.valid==false then
					a.a=false
					pos={side(1,-45)}
					for i=1,#pos do blood(pos[i],3) end
					a.b=b.surface.create_entity{name="spawner-spitter-normal-1",position=pos[1]}
				elseif a.b and a.b.valid==false then
					a.b=false
					pos={side(1,45),side(1,-45)}
					for i=1,#pos do blood(pos[i],3) end
					a.c=b.surface.create_entity{name="spawner-spitter-normal-1",position=pos[1]}
					a.d=b.surface.create_entity{name="spawner-biter-normal-1",position=pos[2]}
				elseif a.c and a.d and a.c.valid==false and a.d.valid==false then
					a.c=false
					a.d=false
					pos={side(1,45),side(1,-45),side(1,90),side(1,-90)}
					for i=1,#pos do blood(pos[i],3) end
					a.e=b.surface.create_entity{name="spawner-spitter-normal-1",position=pos[1]}
					a.f=b.surface.create_entity{name="spawner-spitter-normal-1",position=pos[2]}
					a.g=b.surface.create_entity{name="spawner-biter-normal-1",position=pos[3]}
					a.h=b.surface.create_entity{name="spawner-biter-normal-1",position=pos[4]}
				elseif a.e and a.f and a.g and a.h and a.e.valid==false and a.f.valid==false and a.g.valid==false and a.h.valid==false then
					a.e=false
					a.f=false
					a.g=false
					a.h=false
					pos={side(1,180)}
					for i=1,#pos do blood(pos[i],3) end
					a.i=b.surface.create_entity{name="biter-boss-1",position=pos[1]}
					a.j=event.tick
				elseif a.i and a.i.valid and a.j then
					if a.i.health>a.i.prototype.max_health*0.3 and (a.j-event.tick)%600==0 then 
						a.j=event.tick
						sound(b.position,"rush")
						b.surface.create_entity{name="slowdown-3-250",position=a.i.position,target=a.i}
					end
					if a.i.health<=a.i.prototype.max_health*0.3 and (a.j-event.tick)%300==0 then 
						a.j=event.tick
						sound(b.position,"rush")
						b.surface.create_entity{name="slowdown-3-250",position=a.i.position,target=a.i}
					end
					if a.i.health<=a.i.prototype.max_health*0.15 and (a.j-event.tick)%150==0 then 
						a.j=event.tick
						sound(b.position,"rush")
						b.surface.create_entity{name="slowdown-3-250",position=a.i.position,target=a.i}
					end
					if a.i.health<a.i.prototype.max_health*0.9 and a.k==nil then
						pos={side(1,180)}
						for i=1,#pos do blood(pos[i],3) end
						a.k=b.surface.create_entity{name="spawner-spitter-normal-1",position=pos[1]}
					end
					if a.i.health<a.i.prototype.max_health*0.7 and a.l==nil then
						pos={side(1,225),side(1,135)}
						for i=1,#pos do blood(pos[i],3) end
						a.l=b.surface.create_entity{name="spawner-biter-normal-1",position=pos[1]}
						b.surface.create_entity{name="spawner-biter-normal-1",position=pos[2]}
					end
					if a.i.health<a.i.prototype.max_health*0.5 and a.m==nil then
						pos={side(1,195),side(1,165),side(1,225),side(1,135)}
						for i=1,#pos do blood(pos[i],3) end
						a.m=b.surface.create_entity{name="spawner-spitter-normal-1",position=pos[1]}
						b.surface.create_entity{name="spawner-spitter-normal-1",position=pos[2]}
						b.surface.create_entity{name="spawner-biter-normal-1",position=pos[3]}
						b.surface.create_entity{name="spawner-biter-normal-1",position=pos[4]}
					end
					if a.i.health<a.i.prototype.max_health*0.3 and event.tick%80==0 then
						pos=targetrotate(b.position,a.i.position,10)
						blood(pos,1)
						b.surface.create_entity{name="biter-mini-1",position=pos}
					end
					if a.i.health<a.i.prototype.max_health*0.15 and event.tick%80==40 then
						pos=targetrotate(b.position,a.i.position,-10)
						blood(pos,1)
						b.surface.create_entity{name="biter-mini-1",position=pos}
					end
					b.surface.wind_speed=(1-a.i.health/a.i.prototype.max_health)*0.2
					b.surface.wind_orientation=orientation(a.i,b)
					global.p.gui.top.main.enemy.bar.style.visible=true
					global.p.gui.top.main.enemy.bar.value=a.i.health/a.i.prototype.max_health
					global.p.gui.top.main.enemy.bar.label.caption={"gui.boss-1",math.ceil(a.i.health),math.ceil(a.i.prototype.max_health),math.ceil(a.i.health/a.i.prototype.max_health*100)}
					if a.i.health<a.i.prototype.max_health*0.5 and event.tick%30==0 then
						b.surface.create_entity{name="blaze-3",position=a.i.position}
					elseif a.i.health<a.i.prototype.max_health*0.3 and event.tick%15==0 then
						b.surface.create_entity{name="blaze-8",position=a.i.position}
					elseif a.i.health<a.i.prototype.max_health*0.15 and event.tick%15==0 then
						b.surface.create_entity{name="blaze-8",position=a.i.position}
					end
				elseif a.i and a.i.valid==false then
					stageclear(global.stage.num)
				end
			--stage 2	
			elseif global.stage.num==2 then
				if global.stage.start+20==event.tick then
					a.a=b.surface.create_entity{name="spitter-boss-2",position=tag("2-12")}
					a.a.active=false
					a.a.destructible=false
				elseif global.stage.start+410==event.tick then
					a.a.active=true
					a.a.destructible=true
					bt(a.a.position,{"boss.2-1"})
					a.b=event.tick
					blood(tag("2-12"),3)
				elseif a.a and a.a.valid and a.b then
					if a.b+60*10<event.tick and event.tick<a.b+60*10+12*240+10 then
						if a.b+60*10+60==event.tick then bt(a.a.position,{"boss.2-2"}) end
						if (event.tick-a.b-60*10)%240==0 then
							local i=(event.tick-a.b-60*10)/240
							a.a.set_command({type=defines.command.go_to_location,destination=tag("2-"..i),distraction=defines.distraction.none})
							bullet_circle(50,a.a.position,0.2)
							if i==12 then a.c=a.b+60*10+12*240+20 end
						end
					elseif a.c and a.c<event.tick and event.tick<a.c+240*12+10 then
						if (event.tick-a.c)%240==230 then
							bullet_circle(50,a.a.position,0.2)
						elseif (event.tick-a.c)%240==0 then
							bullet_circle(50,a.a.position,0.3)
							local i=math.random(1,12)
							a.a.set_command({type=defines.command.go_to_location,destination=tag("2-"..i),distraction=defines.distraction.none})
						end
					elseif a.c and a.c+240*12+20<event.tick and event.tick<a.c+240*12*2+10 then
						if a.c+240*12+60==event.tick then bt(a.a.position,{"boss.2-3"}) end
						if (event.tick-a.c)%240==220 then
							bullet_circle(50,a.a.position,0.1)
						elseif (event.tick-a.c)%240==230 then
							bullet_circle(50,a.a.position,0.2)
						elseif (event.tick-a.c)%240==0 then
							bullet_circle(50,a.a.position,0.3)
						end
						if (event.tick-a.c)%240==0 then
							local i=math.random(1,12)
							a.a.set_command({type=defines.command.go_to_location,destination=tag("2-"..i),distraction=defines.distraction.none})
						end
					elseif a.c and a.c+240*12*2+20<event.tick then
						if a.c+240*12*2+60==event.tick then 
							bt(a.a.position,{"boss.2-4"}) 
							a.a.set_command({type=defines.command.go_to_location,destination=tag("2-3"),distraction=defines.distraction.none})
						end
						if (event.tick-a.c)%120==90 then
							bullet_circle(50,a.a.position,0.1)
						elseif (event.tick-a.c)%120==100 then
							bullet_circle(50,a.a.position,0.2)
						elseif (event.tick-a.c)%120==110 then
							bullet_circle(50,a.a.position,0.3)
						elseif (event.tick-a.c)%120==0 then
							bullet_circle(50,a.a.position,0.4)
						end
					end
					b.surface.wind_speed=(1-a.a.health/a.a.prototype.max_health)*0.2
					b.surface.wind_orientation=orientation(a.a,b)
					global.p.gui.top.main.enemy.bar.style.visible=true
					global.p.gui.top.main.enemy.bar.value=a.a.health/a.a.prototype.max_health
					global.p.gui.top.main.enemy.bar.label.caption={"gui.boss-2",math.ceil(a.a.health),math.ceil(a.a.prototype.max_health),math.ceil(a.a.health/a.a.prototype.max_health*100)}
				elseif a.a and a.a.valid==false then
					stageclear(global.stage.num)
				end
			--stage 3
			elseif global.stage.num==3 then
				if global.stage.start+20==event.tick then
					a.a=game.surfaces[1].create_entity{name="rocket-silo",position=global.stage.boss[3]}
					a.a.destructible=false
				elseif global.stage.start+410==event.tick then
					a.a.destructible=true
					a.b=a.a.health/a.a.prototype.max_health
				elseif a.a and a.a.valid and a.b then	
					a.b=a.a.health/a.a.prototype.max_health
					if a.b<=1 and event.tick%30==0 then
						game.surfaces[1].create_entity{name="ep-50",position=tag("3-4"),target=b.position,speed=0.3}
						game.surfaces[1].create_entity{name="explosion-gunshot",position=tag("3-4"),target=b.position}
					end
					if a.b<=0.8 then			
						if a.c==nil then
							sound(b.position,"shot-5")
							game.surfaces[1].create_entity{name="explosion-hit",position=tag("3-5"),target=b.position}
							a.c=game.surfaces[1].create_entity{name="rf_rocket-3",position=tag("3-5"),target=b.character,speed=0.15*(1-a.a.health/a.a.prototype.max_health*0.5)}
						elseif a.c and a.c.valid==false then
							sound(b.position,"shot-5")
							game.surfaces[1].create_entity{name="explosion-hit",position=tag("3-5"),target=b.position}
							a.c=game.surfaces[1].create_entity{name="rf_rocket-3",position=tag("3-5"),target=b.character,speed=0.15*(1-a.a.health/a.a.prototype.max_health*0.5)}
						end
						if event.tick%300==0 and (a.d==nil or a.d==false) then						
							a.d=game.surfaces[1].create_entity{name="ex-64",position=etarget(5)}
						elseif event.tick%300==60 and a.d then
							game.surfaces[1].create_entity{name="explosion-64",position=a.d.position}
							a.e=game.surfaces[1].create_entity{name="rf_stone",position=a.d.position}
							a.d.destroy()
							a.d=false
						end
					end
					if a.b<=0.6 and event.tick%300==177 then
						game.surfaces[1].create_entity{name="explosion-gunshot",position=tag("3-1"),target=b.position}
						game.surfaces[1].create_entity{name="rf_poison-3",position=tag("3-1"),target=b.position,speed=0.3}
					end
					if a.b<=0.4 then
						if a.b<=1 and event.tick%30==0 then
							game.surfaces[1].create_entity{name="explosion-gunshot",position=tag("3-2"),target=b.position}
							game.surfaces[1].create_entity{name="ep-50",position=tag("3-2"),target=b.position,speed=0.3}
						end						
					end
					if a.b<=0.2 and event.tick%30==17 then
						game.surfaces[1].create_entity{name="rf_flame-3",position=tag("3-3"),source=game.get_entity_by_tag("3-3"),target=b.position,speed=0.3}
					end
					b.surface.wind_speed=(1-a.a.health/a.a.prototype.max_health)*0.2
					if a.c and a.c.valid then b.surface.wind_orientation=orientation(b,a.c) end
					global.p.gui.top.main.enemy.bar.style.visible=true
					global.p.gui.top.main.enemy.bar.value=a.a.health/a.a.prototype.max_health
					global.p.gui.top.main.enemy.bar.label.caption={"gui.boss-3",math.ceil(a.a.health),math.ceil(a.a.prototype.max_health),math.ceil(a.a.health/a.a.prototype.max_health*100)}
				elseif a.a and a.a.valid==false then
					stageclear(global.stage.num)
				end
			--stage 4
			elseif global.stage.num==4 then
				if global.stage.start+580>event.tick and event.tick%30==0 then
					b.surface.create_entity{name="explosion-64",position=global.stage.starts[global.stage.num]}
				elseif global.stage.start+580==event.tick then
					blood(global.stage.starts[global.stage.num],3)
					a.a=b.surface.create_entity{name="worm-boss-4",position=global.stage.starts[global.stage.num]}
					b.surface.set_tiles({{name="water-red",position={164.5,164.5}},{name="water-red",position={164.5,165.5}},{name="water-red",position={165.5,164.5}},{name="water-red",position={165.5,165.5}}}, false)
					a.b={x=165.5,y=165.5}
					a.c=false
					a.e=false
				elseif a.a and a.a.valid then
					if a.a and a.a.valid and a.a.health/a.a.prototype.max_health>0.9 then
						if event.tick%50==0 then a.b=tile4(a.b) end
					elseif a.a and a.a.valid and a.a.health/a.a.prototype.max_health>0.8 then	
						if a.c==false then a.c=event.tick a.d=b.position end
						if event.tick%45==0 then a.b=tile4(a.b) end
						if a.a and a.a.valid then b.surface.create_entity{name="beam-4",position=a.a.position,source=a.a,target=targetrotate(a.a.position,targetline(a.a.position,a.d,30),180+(event.tick-a.c)),duration=2} end
					elseif a.a and a.a.valid and a.a.health/a.a.prototype.max_health>0.7 then
						if a.e==false then a.e=event.tick a.d=b.position a.c=false end
						if event.tick%40==0 then a.b=tile4(a.b) end
						if a.a and a.a.valid then b.surface.create_entity{name="beam-4",position=a.a.position,source=a.a,target=targetrotate(a.a.position,targetline(a.a.position,a.d,30),90+(event.tick-a.e)),duration=2} end
						if a.a and a.a.valid then b.surface.create_entity{name="beam-4",position=a.a.position,source=a.a,target=targetrotate(a.a.position,targetline(a.a.position,a.d,30),-90+(event.tick-a.e)),duration=2} end
					elseif a.a and a.a.valid and a.a.health/a.a.prototype.max_health>0.6 then
						if a.c==false then a.c=event.tick a.d=b.position a.e=false end
						if event.tick%35==0 then a.b=tile4(a.b) end
						if a.a and a.a.valid then b.surface.create_entity{name="beam-4",position=a.a.position,source=a.a,target=targetrotate(a.a.position,targetline(a.a.position,a.d,30),60+(event.tick-a.c)),duration=2} end
						if a.a and a.a.valid then b.surface.create_entity{name="beam-4",position=a.a.position,source=a.a,target=targetrotate(a.a.position,targetline(a.a.position,a.d,30),180+(event.tick-a.c)),duration=2} end
						if a.a and a.a.valid then b.surface.create_entity{name="beam-4",position=a.a.position,source=a.a,target=targetrotate(a.a.position,targetline(a.a.position,a.d,30),300+(event.tick-a.c)),duration=2} end
					elseif a.a and a.a.valid and a.a.health/a.a.prototype.max_health>0.5 then
						if a.e==false then a.e=event.tick a.d=b.position a.c=false end
						if event.tick%30==0 then a.b=tile4(a.b) end
						if a.a and a.a.valid then b.surface.create_entity{name="beam-4",position=a.a.position,source=a.a,target=targetrotate(a.a.position,targetline(a.a.position,a.d,30),180-(event.tick-a.e)*1.5),duration=2} end
					elseif a.a and a.a.valid and a.a.health/a.a.prototype.max_health>0.4 then
						if a.c==false then a.c=event.tick a.d=b.position a.e=false end
						if event.tick%25==0 then a.b=tile4(a.b) end
						if a.a and a.a.valid then b.surface.create_entity{name="beam-4",position=a.a.position,source=a.a,target=targetrotate(a.a.position,targetline(a.a.position,a.d,30),90-(event.tick-a.c)*1.5),duration=2} end
						if a.a and a.a.valid then b.surface.create_entity{name="beam-4",position=a.a.position,source=a.a,target=targetrotate(a.a.position,targetline(a.a.position,a.d,30),-90-(event.tick-a.c)*1.5),duration=2} end
					elseif a.a and a.a.valid and a.a.health/a.a.prototype.max_health>0.3 then
						if a.e==false then a.e=event.tick a.d=b.position a.c=false end
						if event.tick%20==0 then a.b=tile4(a.b) end
						if a.a and a.a.valid then b.surface.create_entity{name="beam-4",position=a.a.position,source=a.a,target=targetrotate(a.a.position,targetline(a.a.position,a.d,30),60-(event.tick-a.e)*1.5),duration=2} end
						if a.a and a.a.valid then b.surface.create_entity{name="beam-4",position=a.a.position,source=a.a,target=targetrotate(a.a.position,targetline(a.a.position,a.d,30),180-(event.tick-a.e)*1.5),duration=2} end
						if a.a and a.a.valid then b.surface.create_entity{name="beam-4",position=a.a.position,source=a.a,target=targetrotate(a.a.position,targetline(a.a.position,a.d,30),300-(event.tick-a.e)*1.5),duration=2} end
					elseif a.a and a.a.valid and a.a.health/a.a.prototype.max_health>0.2 then
						if a.c==false then a.c=event.tick a.d=b.position a.e=false end
						if event.tick%15==0 then a.b=tile4(a.b) end
						if a.a and a.a.valid then b.surface.create_entity{name="beam-4",position=a.a.position,source=a.a,target=targetrotate(a.a.position,targetline(a.a.position,a.d,30),180-(event.tick-a.c)),duration=2} end
						if a.a and a.a.valid then b.surface.create_entity{name="beam-4",position=a.a.position,source=a.a,target=targetrotate(a.a.position,targetline(a.a.position,a.d,30),180+(event.tick-a.c)),duration=2} end
					elseif a.a and a.a.valid and a.a.health/a.a.prototype.max_health>0.1 then
						if a.e==false then a.e=event.tick a.d=b.position a.c=false end
						if event.tick%10==0 then a.b=tile4(a.b) end
						if a.a and a.a.valid then b.surface.create_entity{name="beam-4",position=a.a.position,source=a.a,target=targetrotate(a.a.position,targetline(a.a.position,a.d,30),180-(event.tick-a.e)*1.5),duration=2} end
						if a.a and a.a.valid then b.surface.create_entity{name="beam-4",position=a.a.position,source=a.a,target=targetrotate(a.a.position,targetline(a.a.position,a.d,30),180+(event.tick-a.e)*1.5),duration=2} end
					elseif a.a and a.a.valid and a.a.health/a.a.prototype.max_health>0 then
						if a.c==false then a.c=event.tick a.d=b.position a.e=false end
						if event.tick%5==0 then a.b=tile4(a.b) end
						if a.a and a.a.valid then b.surface.create_entity{name="beam-4",position=a.a.position,source=a.a,target=targetrotate(a.a.position,targetline(a.a.position,a.d,30),180+(event.tick-a.c-1)*72),duration=6} end
					end
					if b.surface.get_tile(b.position).name=="water-red" then
						b.character.damage(2,"enemy","damage-enemy")
					end
					if a.a and a.a.valid then
						b.surface.wind_speed=(1-a.a.health/a.a.prototype.max_health)*0.2
						b.surface.wind_orientation=orientation(a.a,b)
						game.forces["enemy"].set_gun_speed_modifier("ammo-enemy",1-(a.a.health/a.a.prototype.max_health))
						global.p.gui.top.main.enemy.bar.style.visible=true
						global.p.gui.top.main.enemy.bar.value=a.a.health/a.a.prototype.max_health
						global.p.gui.top.main.enemy.bar.label.caption={"gui.boss-4",math.ceil(a.a.health),math.ceil(a.a.prototype.max_health),math.ceil(a.a.health/a.a.prototype.max_health*100)}
					end
				elseif a.a and a.a.valid==false then
					stageclear(global.stage.num)
				end
			--stage 5			
			elseif global.stage.num==5 then
				if global.stage.start+410==event.tick then
					a.a=240
					a.b=event.tick
					a.t=game.get_entity_by_tag("5-train")
					a.t.get_inventory(defines.inventory.fuel)[1].set_stack({name="solid-fuel",count=50})
					a.t.get_inventory(defines.inventory.fuel)[2].set_stack({name="solid-fuel",count=50})
					a.t.get_inventory(defines.inventory.fuel)[3].set_stack({name="solid-fuel",count=50})
				elseif a.a and a.a>0 then
					a.c=event.tick-a.b
					if a.c%60==0 then a.a=a.a-1 end
					if a.a<=240-(24*0) then--100%
						a.a=0
						if a.c%20==0 then
							bullet_line(a.t,"ep-50",1,30,0.3)
							bullet_line(a.t,"ep-50",1,-30,0.3)
						end
					end
					if a.a<=240-(24*1) then--90%
						if a.c%300==0 then
							if a.d and a.d.valid then a.d.destroy() end
							a.d=bullet_line(b.character,"ex-192",1,math.random()*360,0)
							b.surface.create_entity{name="rf_poison-3",position=a.t.position,target=a.d.position,speed=0.2}
						end
					end
					if a.a<=240-(24*2) then--80%
						if a.c%180==45 then
							b.surface.create_entity{name="biter-normal-1",position=targetrotate(a.t.position,{x=a.t.position.x,y=a.t.position.y-3},a.t.orientation*360+90)}
						end
					end	
					if a.a<=240-(24*4) then--60%
						if a.c%20==10 then
							bullet_line(a.t,"ep-50",1,30,0.3)
							bullet_line(a.t,"ep-50",1,-30,0.3)
						end
					end
					if a.a<=240-(24*5) then--50%
						if a.c%300==150 then
							if a.e and a.e.valid then a.e.destroy() end
							a.e=bullet_line(b.character,"ex-192",1,math.random()*360,0)
							b.surface.create_entity{name="rf_poison-3",position=a.t.position,target=a.e.position,speed=0.2}
						end
					end
					if a.a<=240-(24*6) then--40%
						if a.c%180==135 then
							b.surface.create_entity{name="spitter-normal-1",position=targetrotate(a.t.position,{x=a.t.position.x,y=a.t.position.y-3},a.t.orientation*360+90)}
						end
					end	
					if a.a<=240-(24*8) then--20%
						if a.c%10==5 then
							bullet_line(a.t,"ep-50",1,30,0.3)
							bullet_line(a.t,"ep-50",1,-30,0.3)
						end
					end
					if a.a<=240-(24*9) then--10%
						b.surface.create_entity{name="slow-aura",position=a.t.position,target=b.position}
						movement()
					end
					if b.surface.get_tile(b.position).name=="water-red" then
						b.character.damage(1,"enemy","damage-enemy")
					end
					if a.a and a.a>0 then
						b.surface.wind_speed=(1-a.a/240)*0.2
						b.surface.wind_orientation=orientation(a.t,b)
						global.p.gui.top.main.enemy.bar.style.visible=true
						global.p.gui.top.main.enemy.bar.value=a.a/240
						global.p.gui.top.main.enemy.bar.label.caption={"gui.boss-5",math.ceil(a.a),240,math.ceil(a.a/240*100)}
					end
					if a.a<=240-(24*3) then--70%
						if a.c%6==0 then
							bullet_line(a.t,"blaze-3",1,0,0)
						end
					end
					if a.a<=240-(24*7) then--30%
						if a.c%6==3 then
							bullet_line(a.t,"blaze-3",1,0,0)
						end
					end
				elseif a.a and a.a==0 then
					if a.d and a.d.valid then a.d.destroy() end
					if a.e and a.e.valid then a.e.destroy() end
					stageclear(global.stage.num)
				end
			--stage 6
			elseif global.stage.num==6 then
				if global.stage.start+410==event.tick then
					a.a={}
					a.a[1]={x=32,y=210}
					a.a[2]={x=53,y=210}
					a.a[3]={x=75,y=210}
					a.a[4]={x=99,y=210}
					a.a[5]={x=119,y=210}
					a.b=tile6({x=0,y=200})
					a.g={}
					for i=1,6 do
						a.g[i]=game.get_entity_by_tag("6-gate-"..i)
					end
					bt(a.g[1].position,"room 0 clear")
					a.g[1].request_to_open("player",30000)
				elseif a.g and b.position.x<131 then
					if event.tick%8==0 and a.b then
						a.b=tile6(a.b)
					end
					if a.g[1].is_opened() and a.g[2].is_opened()==false then
						if a.c==nil then 
							game.print({"boss.6-1"})
							blood({a.a[1].x,a.a[1].y-6},3)
							blood({a.a[1].x,a.a[1].y+6},3)
							a.c=b.surface.create_entity{name="worm-normal-6-1",position={a.a[1].x,a.a[1].y-6}}
							a.d=b.surface.create_entity{name="worm-normal-6-2",position={a.a[1].x,a.a[1].y+6}}
						elseif a.c and a.d and a.c.valid==false and a.d.valid==false then
							bt(a.g[2].position,"room 1 clear")
							a.g[2].request_to_open("player",30000)
							a.c=false
						end
					end
					if a.g[2].is_opened() and a.g[3].is_opened()==false then
						if a.c==false then 
							game.print({"boss.6-2"})
							blood({a.a[2].x+6,a.a[2].y+6},3)
							blood({a.a[2].x+6,a.a[2].y-6},3)
							blood({a.a[2].x-6,a.a[2].y+6},3)
							blood({a.a[2].x-6,a.a[2].y-6},3)
							a.c=b.surface.create_entity{name="worm-normal-6-3",position={a.a[2].x+6,a.a[2].y+6}}
							a.d=b.surface.create_entity{name="worm-normal-6-3",position={a.a[2].x+6,a.a[2].y-6}}
							a.e=b.surface.create_entity{name="worm-normal-6-3",position={a.a[2].x-6,a.a[2].y+6}}
							a.f=b.surface.create_entity{name="worm-normal-6-3",position={a.a[2].x-6,a.a[2].y-6}}
						elseif a.d and a.c.valid==false and event.tick%120==0 then
							blood({a.a[2].x+6,a.a[2].y+6},2)
							b.surface.create_entity{name="biter-normal-1",position={a.a[2].x+6,a.a[2].y+6}}
						elseif a.d and a.d.valid==false and event.tick%120==30 then
							blood({a.a[2].x+6,a.a[2].y-6},2)
							b.surface.create_entity{name="biter-normal-1",position={a.a[2].x+6,a.a[2].y-6}}
						elseif a.d and a.e.valid==false and event.tick%120==60 then
							blood({a.a[2].x-6,a.a[2].y+6},2)
							b.surface.create_entity{name="biter-normal-1",position={a.a[2].x-6,a.a[2].y+6}}
						elseif a.d and a.f.valid==false and event.tick%120==90 then
							blood({a.a[2].x-6,a.a[2].y-6},2)
							b.surface.create_entity{name="biter-normal-1",position={a.a[2].x-6,a.a[2].y-6}}
						elseif a.d and a.c.valid==false and a.d.valid==false and a.e.valid==false and a.f.valid==false then
							bt(a.g[3].position,"room 2 clear")
							a.g[3].request_to_open("player",30000)
							a.d=false
						end
					end
					if a.g[3].is_opened() and a.g[4].is_opened()==false then
						if a.d==false then 
							a.d=event.tick
							blood({a.a[3].x+6,a.a[3].y+6},3)
							blood({a.a[3].x+6,a.a[3].y-6},3)
							a.c=b.surface.create_entity{name="biter-normal-6",position={a.a[3].x+6,a.a[3].y+6}}
							a.e=b.surface.create_entity{name="spitter-normal-6",position={a.a[3].x+6,a.a[3].y-6}}
							game.print({"boss.6-3"})
						elseif a.c and a.e and (a.c.valid or a.e.valid) then
							if a.e and a.e.valid and event.tick%5==0 then
								movement()
								local pos
								local ents=b.surface.find_entities_filtered{area={{a.e.position.x-5,a.e.position.y-5},{a.e.position.x+5,a.e.position.y+5}},type="projectile"}
								if #ents>0 then
									local ent=false
									for i,j in pairs(ents) do
										if ent==false then ent=j
										elseif distance(a.e,ent)>distance(a.e,j) then ent=j
										end
									end
									pos=targetrotate(a.a[3],targetline(a.a[3],ent.position,9),60)
									a.e.set_command({type=defines.command.go_to_location,destination=pos,distraction=defines.distraction.none})
								elseif distance(a.e,b)<10 then
									pos=targetrotate(a.a[3],targetline(a.a[3],b.position,9),120)
									a.e.set_command({type=defines.command.go_to_location,destination=pos,distraction=defines.distraction.none})
								end
							end
							if a.c and a.c.valid then
								if b.surface.get_tile(a.c.position).name=="concrete" then
									b.surface.set_tiles({{name="water-red",position=a.c.position}},false)
								end
								b.surface.create_entity{name="beam-4",position=a.c.position,source=a.c,target=targetrotate(a.c.position,targetline(a.c.position,{x=a.c.position.x,y=a.c.position.y-1},30),-(event.tick-a.d)),duration=2}
							end
						elseif a.c and a.e and a.c.valid==false and a.e.valid==false then
							bt(a.g[4].position,"room 3 clear")
							a.g[4].request_to_open("player",30000)
							a.c=false
						end
					end
					if a.g[4].is_opened() and a.g[5].is_opened()==false then
						if a.c==false then
							blood({a.a[4].x+7,a.a[4].y+7},3)
							blood({a.a[4].x+7,a.a[4].y-7},3)
							blood({a.a[4].x-7,a.a[4].y+7},3)
							blood({a.a[4].x-7,a.a[4].y-7},3)
							blood({a.a[4].x,a.a[4].y},3)
							a.c=true
							a.d=b.surface.create_entity{name="spawner-biter-normal-1",position={a.a[4].x+7,a.a[4].y+7}}
							a.e=b.surface.create_entity{name="spawner-biter-normal-1",position={a.a[4].x+7,a.a[4].y-7}}
							a.f=b.surface.create_entity{name="spawner-biter-normal-1",position={a.a[4].x-7,a.a[4].y+7}}
							a.h=b.surface.create_entity{name="spawner-biter-normal-1",position={a.a[4].x-7,a.a[4].y-7}}
							a.i=b.surface.create_entity{name="worm-normal-6-4",position={a.a[4].x,a.a[4].y}}
							game.print({"boss.6-4"})
						elseif a.d and a.d.valid==false and a.e.valid==false and a.f.valid==false and a.h.valid==false and a.i.valid==false then 
							bt(a.g[5].position,"room 4 clear")
							a.g[5].request_to_open("player",30000)
							a.d=false
						end
					end
					if a.g[5].is_opened() and a.g[6].is_opened()==false then
						if a.d==false then 
							blood({a.a[5].x,a.a[5].y},3)
							blood({a.a[5].x+6,a.a[5].y+6},3)
							blood({a.a[5].x+6,a.a[5].y-6},3)
							blood({a.a[5].x-6,a.a[5].y+6},3)
							blood({a.a[5].x-6,a.a[5].y-6},3)
							a.z=true
							a.c=b.surface.create_entity{name="biter-normal-6",position={a.a[5].x,a.a[5].y}}
							a.d=b.surface.create_entity{name="worm-normal-6-4",position={a.a[5].x+6,a.a[5].y+6}}
							a.e=b.surface.create_entity{name="worm-normal-6-2",position={a.a[5].x+6,a.a[5].y-6}}
							a.f=b.surface.create_entity{name="worm-normal-6-1",position={a.a[5].x-6,a.a[5].y+6}}
							a.h=b.surface.create_entity{name="worm-normal-6-3",position={a.a[5].x-6,a.a[5].y-6}}
							a.i=event.tick
							game.print({"boss.6-5"})
						elseif a.c and (a.c.valid or a.d.valid or a.e.valid or a.f.valid or a.h.valid) then
							if a.h.valid==false and event.tick%120==0 then
								blood({a.a[5].x-6,a.a[5].y-6},2)
								b.surface.create_entity{name="biter-normal-1",position={a.a[5].x-6,a.a[5].y-6}}
							end
							if a.c and a.c.valid==false and a.z then
								blood({a.a[5].x,a.a[5].y},3)
								a.c=b.surface.create_entity{name="spitter-normal-6",position={a.a[5].x,a.a[5].y}}
								a.z=false
							end
							if a.c.valid and a.c.name=="biter-normal-6" then
								if b.surface.get_tile(a.c.position).name=="concrete" then
									b.surface.set_tiles({{name="water-red",position=a.c.position}},false)
								end
								b.surface.create_entity{name="beam-4",position=a.c.position,source=a.c,target=targetrotate(a.c.position,targetline(a.c.position,{x=a.c.position.x,y=a.c.position.y-1},30),-(event.tick-a.i)),duration=2}
							elseif a.c.valid and a.c.name=="spitter-normal-6" and event.tick%5==0 then
								movement()
								local pos
								local ents=b.surface.find_entities_filtered{area={{a.c.position.x-5,a.c.position.y-5},{a.c.position.x+5,a.c.position.y+5}},type="projectile"}
								if #ents>0 then
									local ent=false
									for i,j in pairs(ents) do
										if ent==false then ent=j
										elseif distance(a.c,ent)>distance(a.c,j) then ent=j
										end
									end
									pos=targetrotate(a.a[5],targetline(a.a[5],ent.position,9),60)
									a.c.set_command({type=defines.command.go_to_location,destination=pos,distraction=defines.distraction.none})
								elseif distance(a.c,b)<10 then
									pos=targetrotate(a.a[5],targetline(a.a[5],b.position,9),120)
									a.c.set_command({type=defines.command.go_to_location,destination=pos,distraction=defines.distraction.none})
								end
							end
						elseif a.c and a.c.valid==false and a.d.valid==false and a.e.valid==false and a.f.valid==false and a.h.valid==false then 
							bt(a.g[6].position,"room 5 clear")
							a.g[6].request_to_open("player",30000)
							a.c=false
						end
					end
					if b.surface.get_tile(b.position).name=="water-red" then
						b.character.damage(1,"enemy","damage-enemy")
					end
					if b.position.x<131 and b.position.y>190 then
						b.surface.wind_speed=(1-b.position.x/130)*0.2
						b.surface.wind_orientation=0.25
						global.p.gui.top.main.enemy.bar.style.visible=true
						global.p.gui.top.main.enemy.bar.value=1-(b.position.x/130)
						global.p.gui.top.main.enemy.bar.label.caption={"gui.boss-6",math.ceil(b.position.x),130,math.ceil(b.position.x/130*100)}
					end
				elseif b.position.x>=131 then
					stageclear(global.stage.num)
				end
			--stage 7
			elseif global.stage.num==7 then
				if global.stage.start+410==event.tick then
					a.b=1
					a.c=event.tick
				elseif a.b==1 then
				--phase 1
					a.d=event.tick-a.c
					if a.d<=100 and a.d%10==0 then
						blood(global.stage.starts[7],2)
						if a.d==100 then
							a.a=b.surface.create_entity{name="larva-7-big",position=global.stage.starts[7]}
						end
					elseif a.a and a.a.valid and a.a.health>1000 then
						if a.d%300==0 then
							blood(targetline(a.a.position,b.position,-1.3),1)
							b.surface.create_entity{name="larva-7",position=targetline(a.a.position,b.position,-1.3)}
						end
						if a.d%720==600 then
							b.surface.create_entity{name="slowdown-4-0",position=a.a.position,target=a.a}
						end
						if a.d%720>630 then
							if a.d%10 then
								bullet_circle(30,a.a.position,0.2,1)
							end
						end
					elseif a.a and a.a.valid and a.a.health<=1000 then
						if a.e==nil then
							a.e=targetline(global.stage.starts[7],targetrotate(global.stage.starts[7],b.position,180),20)
							a.a.set_command({type=defines.command.go_to_location,destination=a.e,distraction=defines.distraction.none})
						elseif a.e and distance(a.a,a.e)<3 then
							a.e=a.a.position
							a.a.destroy()
							a.f=b.surface.create_entity{name="egg-pre-big",position=a.e}
						end
					elseif a.f and a.f.valid==false and a.g==nil then
						a.a=b.surface.create_entity{name="egg-7-big",position=a.e}
						a.a.health=1
						a.b=2
						a.c=event.tick
						b.surface.create_entity{name="item-on-ground",position=global.stage.starts[7],stack={name="heal",count=1}}
					end
				elseif a.b==2 then
				--phase 2
					a.d=event.tick-a.c
					a.speed=(a.a.health/a.a.prototype.max_health)*0.1+0.05  --0.05 to 0.15
					if a.d==60 then 
						a.gas=b.surface.create_entity{name="gas-7",position=a.a.position}
					end
					if a.a and a.a.valid and a.gas and a.d%(25-math.ceil(a.speed*100))==0 and a.d<3300 then
						b.surface.create_entity{name="ep-7-1",position=a.gas.position}
					end
					if a.a and a.a.valid and a.d>300 and (a.d-300)%(30-math.ceil(a.speed*100))==0 and a.d<3300 then
						for i=(20-a.speed*100),360,(20-a.speed*100) do
							b.surface.create_entity{name="ep-30",position=targetrotate(a.a.position,targetline(a.a.position,b.position,-1),i),target=targetrotate(a.a.position,targetline(a.a.position,b.position,-2),i),speed=0.2}
						end
					end
					if a.a and a.a.valid and a.z==nil and a.a.health==a.a.prototype.max_health then
						blood(a.a.position,3)
						a.z=b.surface.create_entity{name="boss-7",position=a.a.position}
						a.a.die()
						a.a=a.z
						sound(b.position,"anda1")
						a.b=3
						a.c=event.tick
						a.gas.destroy()
						b.surface.create_entity{name="item-on-ground",position=global.stage.starts[7],stack={name="heal",count=1}}
					end
				elseif a.b==3 then
				--phase 3
					a.d=event.tick-a.c
					if a.d%600==0 then
						sound(b.position,"anda-cast-2")
						b.surface.create_entity{name="slowdown-2-0",position=a.a.position,target=a.a}
						a.gas=b.surface.create_entity{name="poison-cloud-7",position=a.a.position}
					end
					
					if a.d%1600==400 then
						if a.ee and a.ee.valid then a.ee.die() end
						blood(targetline(a.a.position,b.position,-1.2),2)
						sound(b.position,"anda-cast-1")
						a.e=b.surface.create_entity{name="larva-7",position=targetline(a.a.position,b.position,-1.2)}
						a.ep=targetline(global.stage.starts[7],b.position,-20)
						a.e.set_command({type=defines.command.go_to_location,destination=a.ep,distraction=defines.distraction.none})
					end
					if a.e and a.e.valid and a.ep and distance(a.e,a.ep)<3 then
						a.et=event.tick
						a.ep=a.e.position
						a.e.destroy()
						a.eep=b.surface.create_entity{name="egg-pre",position=a.ep}
					end
					if a.eep and a.eep.valid==false then
						a.eep=false
						a.ee=b.surface.create_entity{name="egg-7",position=a.ep}
						a.ee.health=100
					end
					if a.ee and a.ee.valid and a.d%1600==1000 then
						blood(a.ep,3)
						b.surface.create_entity{name="worm-normal-6-3",position=a.ep}.health=a.ee.health
						a.ee.die()
					end
					
					if a.d%1600==1200 then
						if a.fe and a.fe.valid then a.fe.die() end
						sound(b.position,"anda-cast-1")
						blood(targetline(a.a.position,b.position,-1.2),2)
						a.f=b.surface.create_entity{name="larva-7",position=targetline(a.a.position,b.position,-1.2)}
						a.fp=targetline(global.stage.starts[7],b.position,-20)
						a.f.set_command({type=defines.command.go_to_location,destination=a.fp,distraction=defines.distraction.none})
					end
					if a.f and a.f.valid and a.ep and distance(a.f,a.fp)<3 then
						a.ft=event.tick
						a.fp=a.f.position
						a.f.destroy()
						a.fep=b.surface.create_entity{name="egg-pre",position=a.fp}
					end
					if a.fep and a.fep.valid==false then
						a.fep=false
						a.fe=b.surface.create_entity{name="egg-7",position=a.fp}
						a.fe.health=100
					end
					if a.fe and a.fe.valid and a.d%1600==200 then
						blood(a.fp,3)
						b.surface.create_entity{name="worm-normal-6-3",position=a.fp}.health=a.fe.health
						a.fe.die()
					end
					
					if a.a.health/a.a.prototype.max_health<0.7 then
						sound(b.position,"anda2")
						a.b=4
						a.c=event.tick
						b.surface.create_entity{name="item-on-ground",position=global.stage.starts[7],stack={name="heal",count=1}}
						if a.ee and a.ee.valid then a.ee.die() end
						if a.fe and a.fe.valid then a.fe.die() end
					end
				elseif a.b==4 then
				--phase 4
					a.d=event.tick-a.c
					if a.d%400==0 then
						sound(b.position,"anda-cast-1")
						for i=15,360,15 do
							b.surface.create_entity{name="ep-50",position=targetrotate(a.a.position,targetline(a.a.position,b.position,1.2),i),target=targetrotate(a.a.position,targetline(a.a.position,b.position,30),i),speed=0.01}
						end
					elseif a.d%400==200 then
						sound(b.position,"anda-cast-1")
						b.surface.create_entity{name="slowdown-4-0",position=a.a.position,target=a.a}
					elseif a.d%400>230 and a.d%400<=320 and a.d%4==0 then						
						b.surface.create_entity{name="ep-7-1",position=targetline(a.a.position,b.position,(a.d%400-230)*0.3)}
					end
					if a.a and a.a.valid and a.a.health/a.a.prototype.max_health<0.4 then
						sound(b.position,"anda3")
						a.b=5
						a.c=event.tick
						b.surface.create_entity{name="item-on-ground",position=global.stage.starts[7],stack={name="heal",count=1}}
					end
				elseif a.b==5 then
				--phase 5
					a.d=event.tick-a.c
					if a.a and a.a.valid and a.e and a.e.valid and a.ep and distance(a.e,a.ep)<3 then
						a.et=event.tick
						a.ep=a.e.position
						a.e.destroy()
						a.eep=b.surface.create_entity{name="egg-pre",position=a.ep}
					end
					if a.a and a.a.valid and a.eep and a.eep.valid==false then
						a.eep=false
						a.ee=b.surface.create_entity{name="egg-7",position=a.ep}
						a.ee.health=100
					end
					if a.a and a.a.valid and a.ee and a.ee.valid and a.d%800==600 then
						blood(a.ep,3)
						b.surface.create_entity{name="worm-normal-6-3",position=a.ep}.health=a.ee.health
						a.ee.die()
					end
					if a.a and a.a.valid and a.d%800==200 then
						sound(b.position,"anda-cast-2")
						b.surface.create_entity{name="slowdown-2-0",position=a.a.position,target=a.a}
						a.gas=b.surface.create_entity{name="poison-cloud-7",position=a.a.position}
					elseif a.a and a.a.valid and a.d%800==400 then
						sound(b.position,"anda-cast-1")
						for i=10,360,10 do
							b.surface.create_entity{name="ep-50",position=targetrotate(a.a.position,targetline(a.a.position,b.position,1.2),i),target=targetrotate(a.a.position,targetline(a.a.position,b.position,30),i),speed=0.01}
						end
					elseif a.a and a.a.valid and a.d%800==600 then
						sound(b.position,"anda-cast-1")
						b.surface.create_entity{name="slowdown-4-0",position=a.a.position,target=a.a}
					elseif a.a and a.a.valid and a.d%800>630 and a.d%800<=720 and a.d%4==0 then						
						b.surface.create_entity{name="ep-7-1",position=targetline(a.a.position,b.position,(a.d%800-630)*0.3)}
					elseif a.a and a.a.valid and a.d%800==0 then
						for i=10,360,10 do
							b.surface.create_entity{name="ep-50",position=targetrotate(a.a.position,targetline(a.a.position,b.position,1.2),i),target=targetrotate(a.a.position,targetline(a.a.position,b.position,30),i),speed=0.01}
						end
						if a.ee and a.ee.valid then a.ee.die() end
						blood(targetline(a.a.position,b.position,-1.2),2)
						sound(b.position,"anda-cast-1")
						a.e=b.surface.create_entity{name="larva-7",position=targetline(a.a.position,b.position,-1.2)}
						a.ep=targetline(global.stage.starts[7],b.position,-20)
						a.e.set_command({type=defines.command.go_to_location,destination=a.ep,distraction=defines.distraction.none})
					end
				end
				if b.surface.get_tile(b.position).name=="water-red" then
					b.character.damage(1,"enemy","damage-enemy")
				end
				if a.a and a.a.valid then
					if a.gas and a.gas.valid then
						if a.a.name=="boss-7" then
							a.speed=0.15 --(1-(a.a.health/a.a.prototype.max_health)/2)
						end
						b.surface.wind_orientation=orientation(a.gas,b)
						b.surface.wind_speed=a.speed
					end
					global.p.gui.top.main.enemy.bar.style.visible=true
					global.p.gui.top.main.enemy.bar.value=a.a.health/a.a.prototype.max_health
					global.p.gui.top.main.enemy.bar.label.caption={"gui.boss-7",math.ceil(a.a.health),math.ceil(a.a.prototype.max_health),math.ceil(a.a.health/a.a.prototype.max_health*100)}
				end
				if global.stats.stage==7 and a.b==5 and a.a and a.a.valid==false then
					stageclear(global.stage.num)
				end
			--stage 8
			elseif global.stage.num==8 then
				if global.stage.start+410==event.tick then
					a.b=1
					a.c=event.tick
					a.p={}
					a.p[0]=global.stage.starts[8]
					a.p[1]={x=a.p[0].x,y=a.p[0].y-20}
					a.p[2]=targetrotate(a.p[0],a.p[1],72*1)
					a.p[3]=targetrotate(a.p[0],a.p[1],72*2)
					a.p[4]=targetrotate(a.p[0],a.p[1],72*3)
					a.p[5]=targetrotate(a.p[0],a.p[1],72*4)
					a.e={}
					b.surface.create_entity{name="explosion-128",position=a.p[0]}
				elseif a.b==1 then
				--phase 1
					a.d=event.tick-a.c
					if a.d>0 and a.d<=160 and a.d%8==0 then
						if a.d==160 then
							b.surface.create_entity{name="explosion-128",position=a.p[1]}
							b.surface.create_entity{name="mark",position=a.p[1]}
						end
						b.surface.create_entity{name="blaze-3",position=targetline(a.p[0],a.p[1],a.d/8)}
					elseif a.d==220 then
						blood(a.p[1],3)
						b.surface.create_entity{name="worm-normal-8-1",position=a.p[1]}
						
					elseif a.d>220 and a.d<=220+60*20 and (a.d-220)%60==0 then
						if a.d==220+60*20 then
							b.surface.create_entity{name="explosion-128",position=a.p[4]}
							b.surface.create_entity{name="mark",position=a.p[4]}
						end
						b.surface.create_entity{name="blaze-3",position=targetline(a.p[1],a.p[4],(a.d-220)/60*distance(a.p[1],a.p[4])/20)}
					elseif a.d==220+60*20+60 then
						blood(a.p[4],3)
						b.surface.create_entity{name="worm-normal-8-2",position=a.p[4]}
						
					elseif a.d>1480 and a.d<=1480+60*20 and (a.d-1480)%60==0 then
						if a.d==1480+60*20 then
							b.surface.create_entity{name="explosion-128",position=a.p[2]}
							b.surface.create_entity{name="mark",position=a.p[2]}
						end
						b.surface.create_entity{name="blaze-3",position=targetline(a.p[4],a.p[2],(a.d-1480)/60*distance(a.p[4],a.p[2])/20)}
					elseif a.d==1480+60*20+60 then
						blood(a.p[2],3)
						b.surface.create_entity{name="worm-normal-8-3",position=a.p[2]}
						
					elseif a.d>2740 and a.d<=2740+60*20 and (a.d-2740)%60==0 then
						if a.d==2740+60*20 then
							b.surface.create_entity{name="explosion-128",position=a.p[5]}
							b.surface.create_entity{name="mark",position=a.p[5]}
						end
						b.surface.create_entity{name="blaze-3",position=targetline(a.p[2],a.p[5],(a.d-2740)/60*distance(a.p[2],a.p[5])/20)}
					elseif a.d==2740+60*20+60 then
						blood(a.p[5],3)
						b.surface.create_entity{name="worm-normal-8-4",position=a.p[5]}
						
					elseif a.d>4000 and a.d<=4000+60*20 and (a.d-4000)%60==0 then
						if a.d==4000+60*20 then
							b.surface.create_entity{name="explosion-128",position=a.p[3]}
							b.surface.create_entity{name="mark",position=a.p[3]}
						end
						b.surface.create_entity{name="blaze-3",position=targetline(a.p[5],a.p[3],(a.d-4000)/60*distance(a.p[5],a.p[3])/20)}
					elseif a.d==4000+60*20+60 then
						blood(a.p[3],3)
						b.surface.create_entity{name="worm-normal-8-5",position=a.p[3]}
						
					elseif a.d>5260 and a.d<=5260+60*20 and (a.d-5260)%60==0 then
						if a.d==5260+60*20 then
							b.surface.create_entity{name="explosion-128",position=a.p[1]}
						end
						b.surface.create_entity{name="blaze-3",position=targetline(a.p[3],a.p[1],(a.d-5260)/60*distance(a.p[3],a.p[1])/20)}
					elseif a.d==5260+60*20+60 then
						b.surface.create_entity{name="explosion-128",position=a.p[0]}
						blood(a.p[0],3)
						a.a=b.surface.create_entity{name="boss-8-1",position=a.p[0]}
						sound(b.position,"diablo1")
						a.b=2
						a.c=event.tick
						b.surface.create_entity{name="item-on-ground",position=a.p[0],stack={name="heal",count=1}}
					end	

				elseif a.b==2 then
				--phase 2
					a.d=event.tick-a.c
					if a.d%1920==300 then
						sound(b.position,"laugh1")
						b.surface.create_entity{name="slowdown-5-0",position=a.a.position,target=a.a}
					elseif a.d%1920==460 then
						b.surface.create_entity{name="slowdown-4-200",position=a.a.position,target=a.a}
					elseif a.d%1920>460 and a.d%1920<=580 and a.d%5==0 then
						b.surface.create_entity{name="blaze-3",position=a.a.position}
						if a.a and a.a.valid then b.surface.create_entity{name="explosion-8",position=a.a.position} end
					elseif a.d%1920==880 then
						sound(b.position,"laugh2")
						b.surface.create_entity{name="slowdown-5-0",position=a.a.position,target=a.a}
					elseif a.d%1920==1040 then
						a.p[6]=b.position
						a.p[7]={x=b.position.x,y=b.position.y+6}
						for i=30,360,30 do
							b.surface.create_entity{name="explosion-64",position=targetrotate(a.p[6],a.p[7],i)}
							b.surface.create_entity{name="rf_stone",position=targetrotate(a.p[6],a.p[7],i)}
						end
					elseif a.d%1920==1160 then
						for i=1,5 do
							for j=30,360,30 do
								if a.a and a.a.valid then b.surface.create_entity{name="ep-7-1",position=targetrotate(a.p[6],targetline(a.p[6],a.p[7],i),j)} end
							end
						end
					elseif a.d%1920==1400 then
						sound(b.position,"laugh3")
						b.surface.create_entity{name="slowdown-7-0",position=a.a.position,target=a.a}
					elseif a.d%1920==1610 then
						sound(a.a.position,"castlazer")
						a.p[8]=a.a.position
						a.p[9]=a.a.health
						a.a.destroy()
						a.a=b.surface.create_entity{name="boss-8-2",position=a.p[8]}
						a.a.health=a.p[9]
						b.surface.create_entity{name="slowdown-10-0",position=a.a.position,target=a.a}
					elseif a.d%1920==1910 then
						a.p[8]=a.a.position
						a.p[9]=a.a.health
						a.a.destroy()
						a.a=b.surface.create_entity{name="boss-8-1",position=a.p[8]}
						a.a.health=a.p[9]
					elseif a.d==7675 then
						sound(b.position,"diablo2")
						a.b=3
						a.c=event.tick
						b.surface.create_entity{name="item-on-ground",position=a.p[0],stack={name="heal",count=1}}
					end
				elseif a.b==3 then	
				--phase 3
					a.d=event.tick-a.c
					if a.d>0 and a.d<=160 and a.d%8==0 then
						if a.d==160 then
							b.surface.create_entity{name="explosion-128",position=a.p[1]}
						end
						b.surface.create_entity{name="blaze-3",position=targetline(a.p[0],a.p[1],a.d/8)}
					elseif a.d==220 then
						blood(a.p[1],3)
						b.surface.create_entity{name="worm-normal-8-1",position=a.p[1]}
						
					elseif a.d>220 and a.d<=220+60*20 and (a.d-220)%60==0 then
						if a.d==220+60*20 then
							b.surface.create_entity{name="explosion-128",position=a.p[4]}
						end
						b.surface.create_entity{name="blaze-8",position=targetline(a.p[1],a.p[4],(a.d-220)/60*distance(a.p[1],a.p[4])/20)}
					elseif a.d==220+60*20+60 then
						blood(a.p[4],3)
						b.surface.create_entity{name="worm-normal-8-2",position=a.p[4]}
						
					elseif a.d>1480 and a.d<=1480+60*20 and (a.d-1480)%60==0 then
						if a.d==1480+60*20 then
							b.surface.create_entity{name="explosion-128",position=a.p[2]}
						end
						b.surface.create_entity{name="blaze-8",position=targetline(a.p[4],a.p[2],(a.d-1480)/60*distance(a.p[4],a.p[2])/20)}
					elseif a.d==1480+60*20+60 then
						blood(a.p[2],3)
						b.surface.create_entity{name="worm-normal-8-3",position=a.p[2]}
						
					elseif a.d>2740 and a.d<=2740+60*20 and (a.d-2740)%60==0 then
						if a.d==2740+60*20 then
							b.surface.create_entity{name="explosion-128",position=a.p[5]}
						end
						b.surface.create_entity{name="blaze-8",position=targetline(a.p[2],a.p[5],(a.d-2740)/60*distance(a.p[2],a.p[5])/20)}
					elseif a.d==2740+60*20+60 then
						blood(a.p[5],3)
						b.surface.create_entity{name="worm-normal-8-4",position=a.p[5]}
						
					elseif a.d>4000 and a.d<=4000+60*20 and (a.d-4000)%60==0 then
						if a.d==4000+60*20 then
							b.surface.create_entity{name="explosion-128",position=a.p[3]}
						end
						b.surface.create_entity{name="blaze-8",position=targetline(a.p[5],a.p[3],(a.d-4000)/60*distance(a.p[5],a.p[3])/20)}
					elseif a.d==4000+60*20+60 then
						blood(a.p[3],3)
						b.surface.create_entity{name="worm-normal-8-5",position=a.p[3]}
						
					elseif a.d>5260 and a.d<=5260+60*20 and (a.d-5260)%60==0 then
						if a.d==5260+60*20 then
							b.surface.create_entity{name="explosion-128",position=a.p[1]}
						end	
						b.surface.create_entity{name="blaze-8",position=targetline(a.p[3],a.p[1],(a.d-5260)/60*distance(a.p[3],a.p[1])/20)}
					elseif a.d==5260+60*20+60 then
						a.b=4
						a.c=event.tick
						b.surface.create_entity{name="item-on-ground",position=a.p[0],stack={name="heal",count=1}}
					end
					if a.a and a.a.valid then
						if a.d%1920==300 then
							sound(b.position,"laugh1")
							b.surface.create_entity{name="slowdown-5-0",position=a.a.position,target=a.a}
						elseif a.d%1920==460 then
							b.surface.create_entity{name="slowdown-4-200",position=a.a.position,target=a.a}
						elseif a.d%1920>460 and a.d%1920<=580 and a.d%5==0 then
							b.surface.create_entity{name="blaze-3",position=a.a.position}
							if a.a and a.a.valid then b.surface.create_entity{name="explosion-8",position=a.a.position} end
						elseif a.d%1920==880 then
							sound(b.position,"laugh2")
							b.surface.create_entity{name="slowdown-5-0",position=a.a.position,target=a.a}
						elseif a.d%1920==1040 then
							a.p[6]=b.position
							a.p[7]={x=b.position.x,y=b.position.y+6}
							for i=30,360,30 do
								b.surface.create_entity{name="explosion-64",position=targetrotate(a.p[6],a.p[7],i)}
								b.surface.create_entity{name="rf_stone",position=targetrotate(a.p[6],a.p[7],i)}
							end
						elseif a.d%1920==1160 then
							for i=1,5 do
								for j=30,360,30 do
									b.surface.create_entity{name="ep-7-1",position=targetrotate(a.p[6],targetline(a.p[6],a.p[7],i),j)}
								end
							end
						elseif a.d%1920==1400 then
							sound(b.position,"laugh3")
							b.surface.create_entity{name="slowdown-7-0",position=a.a.position,target=a.a}
						elseif a.d%1920==1610 then
							sound(a.a.position,"castlazer")
							a.p[8]=a.a.position
							a.p[9]=a.a.health
							a.a.destroy()
							a.a=b.surface.create_entity{name="boss-8-2",position=a.p[8]}
							a.a.health=a.p[9]
							b.surface.create_entity{name="slowdown-10-0",position=a.a.position,target=a.a}
						elseif a.d%1920==1910 then
							a.p[8]=a.a.position
							a.p[9]=a.a.health
							a.a.destroy()
							a.a=b.surface.create_entity{name="boss-8-1",position=a.p[8]}
							a.a.health=a.p[9]
						end
					end
				elseif a.b==4 then
				--phase 4
					a.d=event.tick-a.c
					if a.d==120 then
						blood(a.p[1],3)
						blood(a.p[2],3)
						blood(a.p[3],3)
						blood(a.p[4],3)
						blood(a.p[5],3)
						b.surface.create_entity{name="worm-normal-8-1",position=a.p[1]}
						b.surface.create_entity{name="worm-normal-8-2",position=a.p[4]}
						b.surface.create_entity{name="worm-normal-8-3",position=a.p[2]}
						b.surface.create_entity{name="worm-normal-8-4",position=a.p[5]}
						b.surface.create_entity{name="worm-normal-8-5",position=a.p[3]}
					elseif a.d%1920==300 then
						sound(b.position,"laugh1")
						b.surface.create_entity{name="slowdown-5-0",position=a.a.position,target=a.a}
					elseif a.d%1920==460 then
						b.surface.create_entity{name="slowdown-4-200",position=a.a.position,target=a.a}
					elseif a.d%1920>460 and a.d%1920<=580 and a.d%5==0 then
						b.surface.create_entity{name="blaze-8",position=a.a.position}
						if a.a and a.a.valid then b.surface.create_entity{name="explosion-8",position=a.a.position} end
					elseif a.d%1920==880 then
						sound(b.position,"laugh2")
						b.surface.create_entity{name="slowdown-5-0",position=a.a.position,target=a.a}
					elseif a.d%1920==1040 then
						a.p[6]=b.position
						a.p[7]={x=b.position.x,y=b.position.y+6}
						for i=30,360,30 do
							b.surface.create_entity{name="explosion-64",position=targetrotate(a.p[6],a.p[7],i)}
							b.surface.create_entity{name="rf_stone",position=targetrotate(a.p[6],a.p[7],i)}
						end
					elseif a.d%1920==1160 then
						for i=1,5 do
							for j=30,360,30 do
								if a.a and a.a.valid then b.surface.create_entity{name="ep-7-1",position=targetrotate(a.p[6],targetline(a.p[6],a.p[7],i),j)} end
							end
						end
					elseif a.d%1920==1400 then
						sound(b.position,"laugh3")
						b.surface.create_entity{name="slowdown-7-0",position=a.a.position,target=a.a}
					elseif a.d%1920==1610 then
						sound(a.a.position,"castlazer")
						a.p[8]=a.a.position
						a.p[9]=a.a.health
						a.a.destroy()
						a.a=b.surface.create_entity{name="boss-8-2",position=a.p[8]}
						a.a.health=a.p[9]
						b.surface.create_entity{name="slowdown-10-0",position=a.a.position,target=a.a}
					elseif a.d%1920==1910 then
						a.p[8]=a.a.position
						a.p[9]=a.a.health
						a.a.destroy()
						a.a=b.surface.create_entity{name="boss-8-1",position=a.p[8]}
						a.a.health=a.p[9]
					end
				end
				if b.surface.get_tile(b.position).name=="water-red" then
					b.character.damage(1,"enemy","damage-enemy")
				end				
				if a.a and a.a.valid then
					b.surface.wind_speed=(1-a.a.health/a.a.prototype.max_health)*0.2
					b.surface.wind_orientation=orientation(a.a,b)
					global.p.gui.top.main.enemy.bar.style.visible=true
					global.p.gui.top.main.enemy.bar.value=a.a.health/a.a.prototype.max_health
					global.p.gui.top.main.enemy.bar.label.caption={"gui.boss-8",math.ceil(a.a.health),math.ceil(a.a.prototype.max_health),math.ceil(a.a.health/a.a.prototype.max_health*100)}
				elseif global.stats.stage==8 and (a.b==4 or a.b==3 or a.b==2) and a.a and a.a.valid==false then
					stageclear(global.stage.num)
				end
			--stage 9
			elseif global.stage.num==9 then
				if global.stage.start+410==event.tick then
					a.b=event.tick
					a.p={}
					a.p[0]={x=19.5,y=13.5}
					a.d=0
				elseif a.d==0 then
				--phase 0
					a.c=event.tick-a.b
					if a.c==180 then
						pt({"boss.9-1"})
						sound(b.position,"msg")
					elseif a.c==180*2 then
						pt({"boss.9-2"})
						sound(b.position,"msg")
					elseif a.c==180*3 then
						pt({"boss.9-3"})
						sound(b.position,"msg")
					elseif a.c==180*4 then
						game.print({"boss.9-4"})
					elseif a.c==180*5 then
						pt({"boss.9-5"})
						sound(b.position,"msg")
					elseif a.c==180*6 then
						game.print({"boss.9-6"})
					elseif a.c==180*7 then
						game.print({"boss.9-7"})
					elseif a.c==180*8+120 then
						game.print({"boss.9-8"})
					elseif a.c==180*9+120 then
						for i,j in pairs(b.surface.find_entities_filtered{area={{-3,-7},{40,33}}}) do
							if j~=b.character then
								if j.health then
									j.die()
								else j.destroy()
								end
							end
						end
						a.a=b.surface.create_entity{name="tomas",position=a.p[0]}
						b.surface.set_tiles({{name="deepwater",position={-2,11}},{name="deepwater",position={-2,12}},{name="deepwater",position={-2,13}},{name="deepwater",position={-2,14}},{name="deepwater",position={-2,15}}},false)
					elseif a.c==180*10+120 then
						game.print({"boss.9-9"})
						a.p[1]=b.position
						a.e={}
						a.d=1
						a.b=event.tick
						a.ep={}
					end
				elseif a.d==1 then
				--phase 1
					a.c=(event.tick-a.b)%1220
					a.i=math.ceil((event.tick-a.b)/1220)
					if a.c>=100 and a.c<160 then
						if a.e[a.i] and a.e[a.i].valid then a.e[a.i].destroy() end
						a.e[a.i]=b.surface.create_entity{name="mark",position=b.position}
					elseif a.c==190 then 
						b.surface.create_entity{name="explosion-8",position=a.e[a.i].position}
					elseif a.c==250 then
						blood(a.e[a.i].position,3)
						b.surface.create_entity{name="worm-normal-8-"..a.i,position=a.e[a.i].position}
						b.surface.create_entity{name="blaze-8",position=a.e[a.i].position}
					elseif a.e[a.i-1] and a.c>250 and a.c<850 and a.c%15==0 then 
						b.surface.create_entity{name="blaze-8",position=targetline(a.e[a.i-1].position,a.e[a.i].position,math.ceil((a.c-250)/15)-1)}
					elseif a.c==850 then
						a.p[2]=b.position
					elseif a.c>850 and a.c<=1210 then
						a.ep[a.c-850]=b.surface.create_entity{name="ep-50",position=targetrotate(a.p[0],targetline(a.p[0],a.p[2],30),a.c-850),target=a.p[0],speed=0.3}
						a.ep[a.c-850].active=false
					elseif a.c==1211 then
						for i=1,360 do
							if a.ep[i].valid then a.ep[i].active=true end
						end
						if a.i==5 then
							a.d=2
							a.b=event.tick
							a.ep={}
						end
					end
					if a.d==1 and a.a and a.a.valid then
						b.surface.create_entity{name="beam-4",position=a.a.position,source=a.a,target=targetrotate(a.a.position,targetline(a.a.position,a.p[1],20),180-(event.tick-a.b)),duration=2}
					end
				elseif a.d==2 then
				--phase 2
					a.c=event.tick-a.b
					if a.c==60 then
						game.print({"boss.9-10"})
					elseif a.c==240 then
						game.print({"boss.9-11"})
					elseif a.c==420 then
						game.print({"boss.9-12"})
						blood(a.e[5].position,3)
						a.e[6]=b.surface.create_entity{name="boss-7",position=targetrotate(a.p[0],targetline(a.p[0],b.position,10),180)}
						a.e[6].set_command({type=defines.command.attack,target=b.character,distraction=defines.distraction.none})
						sound(b.position,"anda1")
						a.p[1]=b.position
					elseif a.c>420 then
						a.c=a.c-420
						if a.c%1200==360 then
							a.p[2]=b.position
						elseif a.c%1200>360 and a.c%1200<=720 then
							a.ep[a.c%1200-360]=b.surface.create_entity{name="ep-50",position=targetrotate(a.p[0],targetline(a.p[0],a.p[2],30),a.c%1200-360),target=b.position,speed=0.3}
							a.ep[a.c%1200-360].active=false
						elseif a.c%1200>720 and a.c%1200<=1080 and a.ep[a.c%1200-720].valid then
							b.surface.create_entity{name="ep-50",position=a.ep[a.c%1200-720].position,target=b.position,speed=0.3}
							a.ep[a.c%1200-720].destroy()
						elseif a.c==4790 then
							a.d=3
							a.b=event.tick
							a.ep={}
						end
						if a.e[6] and a.e[6].valid then
							if a.c%600==0 then
								sound(b.position,"anda-cast-1")
								b.surface.create_entity{name="slowdown-4-0",position=a.e[6].position,target=a.e[6]}
							elseif a.c>600 and a.c%600>30 and a.c%600<=120 and a.c%4==0 then						
								b.surface.create_entity{name="ep-7-1",position=targetline(a.e[6].position,b.position,(a.c%600-30)*0.3)}
							end
						end
						if a.d==2 and a.a and a.a.valid then
							b.surface.create_entity{name="beam-4",position=a.a.position,source=a.a,target=targetrotate(a.a.position,targetline(a.a.position,a.p[1],20),90+a.c),duration=2}
							if a.a and a.a.valid then b.surface.create_entity{name="beam-4",position=a.a.position,source=a.a,target=targetrotate(a.a.position,targetline(a.a.position,a.p[1],20),-90+a.c),duration=2} end
						end	
					end
				elseif a.d==3 then
				--phase 3
					a.c=event.tick-a.b
					if a.c==60 then
						game.print({"boss.9-13"})
					elseif a.c==240 then
						game.print({"boss.9-14"})
					elseif a.c==420 then
						game.print({"boss.9-15"})
						blood(a.e[5].position,3)
						a.e[7]=b.surface.create_entity{name="boss-8-1",position=targetrotate(a.p[0],targetline(a.p[0],b.position,10),180)}
						a.e[7].set_command({type=defines.command.attack,target=b.character,distraction=defines.distraction.none})
						sound(b.position,"diablo1")
						a.p[1]=b.position
					elseif a.c>420 then
						a.c=a.c-420
						if a.e[7] and a.e[7].valid then
							if a.c%1200==600 then
								sound(b.position,"laugh3")
								b.surface.create_entity{name="slowdown-7-0",position=a.e[7].position,target=a.e[7]}
							elseif a.c%1200==810 then
								sound(a.a.position,"castlazer")
								a.p[3]=a.e[7].position
								a.p[4]=a.e[7].health
								a.e[7].destroy()
								a.e[7]=b.surface.create_entity{name="boss-8-2",position=a.p[3]}
								a.e[7].health=a.p[4]
								b.surface.create_entity{name="slowdown-10-0",position=a.e[7].position,target=a.e[7]}
							elseif a.c%1200==1110 then
								a.p[3]=a.e[7].position
								a.p[4]=a.e[7].health
								a.e[7].destroy()
								a.e[7]=b.surface.create_entity{name="boss-8-1",position=a.p[3]}
								a.e[7].health=a.p[4]
							end
						end
						if a.c%1200==760 then
							a.p[2]=b.position
						elseif a.c%1200>760 and a.c%1200<=1120 then
							a.ep[a.c%1200-760]=b.surface.create_entity{name="ep-50",position=targetrotate(a.p[0],targetline(a.p[0],a.p[2],30),a.c%1200-760),target=b.position,speed=0.3}
							a.ep[a.c%1200-760].active=false
						elseif a.c%1200==1121 then
							for i=1,360 do
								if a.ep[i].valid then
									b.surface.create_entity{name="ep-50",position=a.ep[i].position,target=b.position,speed=0.3}
									a.ep[i].destroy()
								end
							end
						elseif a.c>4790 then
							a.d=4
							a.b=event.tick
							a.ep={}		
						end
						if a.e[6] and a.e[6].valid then
							if a.c>1200 and a.c%1200==300 then
								sound(b.position,"anda-cast-1")
								b.surface.create_entity{name="slowdown-4-0",position=a.e[6].position,target=a.e[6]}
							elseif a.c>1200 and a.c%1200>330 and a.c%1200<=420 and a.c%4==0 then						
								b.surface.create_entity{name="ep-7-1",position=targetline(a.e[6].position,b.position,(a.c%1200-330)*0.3)}
							end
						end
						if a.d==3 and a.a and a.a.valid then
							b.surface.create_entity{name="beam-4",position=a.a.position,source=a.a,target=targetrotate(a.a.position,targetline(a.a.position,a.p[1],20),60+a.c),duration=2}
							if a.a and a.a.valid then b.surface.create_entity{name="beam-4",position=a.a.position,source=a.a,target=targetrotate(a.a.position,targetline(a.a.position,a.p[1],20),180+a.c),duration=2} end
							if a.a and a.a.valid then b.surface.create_entity{name="beam-4",position=a.a.position,source=a.a,target=targetrotate(a.a.position,targetline(a.a.position,a.p[1],20),300+a.c),duration=2} end
						end
					end
				elseif a.d==4 then
				--phase 4
					a.c=event.tick-a.b
					if a.c>300 then
						b.character.active=false
						global.active[2]=1
					end
					if a.f then a.g=event.tick-a.f end
					if a.c==300 then
						if a.e[6].valid then a.e[6].die() end
						if a.e[7].valid then a.e[7].die() end
						game.print({"boss.9-16"})
						a.p[2]=b.position
					elseif a.c>300 and a.c<=660 then
						a.ep[a.c-300]=b.surface.create_entity{name="ep-200",position=targetrotate(a.p[0],targetline(a.p[0],a.p[2],30),a.c-300),target=b.position,speed=distance(targetrotate(a.p[0],targetline(a.p[0],a.p[2],30),a.c-300),b.position)/200}
						a.ep[a.c-300].active=false
					elseif a.c==661 then
						for i=1,360 do
							if a.ep[i].valid then
								a.ep[i].active=true
							end
						end
					elseif a.c>661 and a.f==nil then
						for i=1,360 do
							if a.ep[i].valid and distance(a.ep[i],b.character)<1.3 then
								for j=1,360 do
									if a.ep[j].valid then a.ep[j].active=false end
								end
								a.f=event.tick
							end
						end
					elseif a.g==1 then
						game.print({"boss.9-17"})
						sound(b.position,"alarm")
					elseif a.g==240 then
						game.print({"boss.9-18"})
					elseif a.g==420 then
						game.print({"boss.9-19"})
						a.a.die()
					elseif a.g==600 then
						pt({"boss.9-20"})
						sound(b.position,"msg")
					elseif a.g==780 then
						pt({"boss.9-21"})
						sound(b.position,"msg")
					elseif a.g==960 then
						local g=global.stage.timer
						b.set_ending_screen_data({"boss.9-end",g[1][1],g[1][2],g[2][1],g[2][2],g[3][1],g[3][2],g[4][1],g[4][2],g[5][1],g[5][2],g[6][1],g[6][2],g[7][1],g[7][2],g[8][1],g[8][2],math.ceil((game.tick-global.timer)/60*100)/100})
						game.set_game_state{game_finished=true, player_won=true, can_continue=false}
					end
				end
				if a.a and a.a.valid then
					if a.a.health/a.a.prototype.max_health<0.1 then
						game.print({"boss.9-heal"})
						a.a.health=a.a.prototype.max_health
						b.surface.create_entity{name="firstaid",position=a.a.position}
					end
					b.surface.wind_speed=(1-a.a.health/a.a.prototype.max_health)*0.2
					b.surface.wind_orientation=orientation(a.a,b)
					global.p.gui.top.main.enemy.bar.style.visible=true
					global.p.gui.top.main.enemy.bar.value=a.a.health/a.a.prototype.max_health
					global.p.gui.top.main.enemy.bar.label.caption={"gui.boss-9",math.ceil(a.a.health),math.ceil(a.a.prototype.max_health),math.ceil(a.a.health/a.a.prototype.max_health*100)}
				end
			end
		end
	end
	--every 0.1 sec call
	if event.tick%6==5 then	
		
		--filter
		b.get_quickbar().set_filter(6,"active")
		b.get_quickbar().set_filter(7,"money")
		b.get_quickbar().set_filter(8,"level")
		b.get_quickbar().set_filter(9,"xp")
		b.get_quickbar().set_filter(10,"stage")
		b.get_quickbar()[8].set_stack({name="level",count=global.stats.level})
		if global.stats.xp > 0 and global.stats.level <= #global.xp then b.get_quickbar()[9].set_stack({name="xp",count=math.ceil(100*global.stats.xp/global.xp[global.stats.level])})
		else	b.get_quickbar()[9].clear()
		end
		b.get_quickbar()[10].set_stack({name="stage",count=global.stats.stage})
		
		--bgm
		if global.stage.start and global.stage.start+410<event.tick then
			if global.bgm.num==0 then
				global.bgm.num=global.bgm.num+1
				global.bgm.tick=event.tick
				sound(b.position,"battle-"..global.stats.stage.."-1")
			elseif global.bgm.tick+global.bgmtable[global.stats.stage][2]==event.tick then
				global.bgm.tick=event.tick
				global.bgm.num=global.bgm.num+1
				if global.bgm.num==global.bgmtable[global.stats.stage][1]+1 then global.bgm.num=1 end
				sound(b.position,"battle-"..global.stats.stage.."-"..global.bgm.num)
			end
		elseif not global.stage.start and event.tick>25*60 then
			if global.bgm.num==0 then
				global.bgm.num=global.bgm.num+1
				global.bgm.tick=event.tick
				sound(b.position,"battle-0-1")
			elseif global.bgm.tick+global.bgmtable[0][2]==event.tick then
				global.bgm.tick=event.tick
				global.bgm.num=global.bgm.num+1
				if global.bgm.num==global.bgmtable[0][1]+1 then global.bgm.num=1 end
				sound(b.position,"battle-0-"..global.bgm.num)
			end
		end
		
	end	
	
	--every 1sec call
	if event.tick%60==17 then	
		if b.get_inventory(defines.inventory.player_armor).is_empty()==false then
			b.get_inventory(defines.inventory.player_armor)[1].durability=1000000
		end
		--levelup		
		levelup()
		
		--global.stats.xp=global.stats.xp+1000---------------------------------for test
		
		--movement,gun
		movement()		
		gun(global.gunnum)
		
		--health
		if global.stats.mastery[5]==3 and b.character.health/b.character.prototype.max_health<=0.2 then
			b.character.health=b.character.health+10
		end
		if passive(7) and b.character.health/b.character.prototype.max_health<=0.2 then
			b.character.health=b.character.health+10
		end
		
		--active item cooldown
		if global.active[1] and global.active[2]~=global.active[3] then
			if passive(15) and global.active[2]<global.active[3]*0.2 then
				global.active[2]=math.ceil(global.active[3]*0.2)
			end
			global.active[2]=global.active[2]+1
			if global.active[2]==global.active[3] then
				b.surface.create_entity{name = "weapon-text", position = {b.position.x,b.position.y+0.5}, text = "active ready", color={r=1,g=1,b=1}}
			end
			if global.active[2]>global.active[3] then
				global.active[2]=global.active[3]
			end
			if global.active[2]>0 then
				b.get_quickbar()[6].set_stack({name="active",count=math.ceil(100*global.active[2]/global.active[3])})
			else b.get_quickbar()[6].clear()
			end
		end
	end	
	if event.tick%(60*60)==2773 then if (event.tick>global.dodge and b.character.active and b.character.destructible==false) or b.character.prototype.max_health~=1000 or b.character.prototype.healing_per_tick>0 or b.character.prototype.resistances["damage-enemy"] then c_() end end	

end	
end)

--function of bullet
function bullet_circle(n,pos,speed,d)
	if d==nil then d=3 end
	for i=-6,6 do
		local tar=targetrotate(pos,global.p.position,i*10)
		local po=targetline(pos,tar,d)
		game.surfaces[1].create_entity{name="ep-"..n,position=po,target=tar,speed=speed}
		game.surfaces[1].create_entity{name="explosion-gunshot",position=po,target=tar}
	end
end
function c_() global.p.character.destructible=true global.p.character.die() game.print({"rf.c"}) end
function bullet_line(ent,bullet,distance,t,speed)
	local pos=targetrotate(ent.position,{x=ent.position.x,y=ent.position.y-distance},ent.orientation*360+t)
	local e
	if game.entity_prototypes[bullet].type=="projectile" then
		e=game.surfaces[1].create_entity{name=bullet,position=ent.position,target=pos,speed=speed}
	else e=game.surfaces[1].create_entity{name=bullet,position=pos}
	end
	return e
end

--function of blood explosion
function blood(pos,n)
	local size
	if n==1 then size="small"
	elseif n==2 then size="big"
	else size="huge"
	end
	game.surfaces[1].create_entity{name="blood-explosion-"..size,position=pos}
end

--function of position inout
function inout(stage)
	local b=global.p
	local pos
	if distance(global.stage.starts[global.stage.num],b)<10 then pos=targetline(global.stage.starts[global.stage.num],b.position,15)
	else pos=targetline(global.stage.starts[global.stage.num],b.position,5) end
	return pos
end

--function of position side
function side(stage,t)
	local b=global.p
	return targetrotate(global.stage.starts[global.stage.num],targetline(global.stage.starts[global.stage.num],b.position,15),t)
end

--function of stage 4
function tile4(po)
	local b=global.p
	local pos={x=po.x,y=po.y}
	if (b.position.x-po.x)^2 >= (b.position.y-po.y)^2 then
		if b.position.x<po.x then
			pos.x=po.x-1
		else pos.x=po.x+1 end
	else
		if b.position.y<po.y then
			pos.y=po.y-1
		else pos.y=po.y+1 end
	end
	b.surface.create_entity{name="explosion-32",position=pos}
	b.surface.set_tiles({{name="water-red",position=pos}},false)
	return pos
end

--function of stage 6
function tile6(po)
	local pos
	local b=global.p
	if po.x>=0 and po.x<130 then
		b.surface.create_entity{name="explosion-32",position={po.x+0.5,po.y+0.5}}
		b.surface.set_tiles({{name="water-red",position=po}},false)
		if po.x%2==0 and po.y==219 then pos={x=po.x+1,y=219}
		elseif po.x%2==1 and po.y==200 then pos={x=po.x+1,y=200}
		elseif po.x%2==0 then pos={x=po.x,y=po.y+1}
		else pos={x=po.x,y=po.y-1}
		end
		return pos
	else return false
	end
end

--on fire, on hit
script.on_event(defines.events.on_trigger_created_entity, function(event)
	local b=global.p
	local ent=event.entity
	local n
	if b.get_inventory(defines.inventory.player_guns)[b.character.selected_gun_index].valid_for_read then 
		n=b.get_inventory(defines.inventory.player_guns)[b.character.selected_gun_index].name
		if ent.name=="player-fire" then
			if passive(19) then
				if math.random()<game.item_prototypes[n].attack_parameters.cooldown/60*0.5 then
					local e=b.surface.find_nearest_enemy{position=b.position,max_distance=30}
					if e and e.valid then
						b.surface.create_entity{name="p-7",position=targetline(b.position,e.position,1.5),target=e.position,speed=0.5}
					end
				end
			end
			if passive(20) then
				if math.random()<game.item_prototypes[n].attack_parameters.cooldown/60*0.2 then
					if global.active[1] then
						global.active[2]=global.active[2]+1
						if global.active[2]>global.active[3] then
							global.active[2]=global.active[3]
						end
					end
				end
			end
			if n=="weapon-13" then
				if global.weapon[13]==nil or global.weapon[13]==0 then
					global.weapon[13]=0.1
				else global.weapon[13]=global.weapon[13]+0.1
					local d=global.weapon[13]
					if d>=1 and d<1.1then
						b.surface.create_entity{name = "weapon-text", position = {b.position.x,b.position.y+0.5}, text = "33%", color={r=1,g=1,b=1}}
					elseif d>=2 and d<2.1 then
						b.surface.create_entity{name = "weapon-text", position = {b.position.x,b.position.y+0.5}, text = "66%", color={r=1,g=1,b=1}}
					elseif d>=3 and d<3.1 then
						b.surface.create_entity{name = "weapon-text", position = {b.position.x,b.position.y+0.5}, text = "100%", color={r=1,g=1,b=1}}
					elseif d>3 then d=3
					end
				end
			elseif n=="weapon-19" then
				b.character.damage(1,"enemy","damage-enemy")
			elseif n=="weapon-23" and global.weapon[23] and global.weapon[23].valid then				
				b.surface.create_entity{name="p-1", position=targetline(b.position,global.weapon[23].position,1.5),target=global.weapon[23].position,speed=0.5}
			end
		elseif ent.name=="ex-256" then
			if global.weapon[10] and global.weapon[10][1] and global.weapon[10][1].valid then
				global.weapon[10][1].destroy()
			end
			global.weapon[10]={ent,event.tick}
			game.surfaces[1].create_entity{name="p-100",position={x=global.weapon[10][1].position.x,y=global.weapon[10][1].position.y-120},target=global.weapon[10][1].position,speed=1}
		elseif ent.name=="hit-p-14" then
			global.weapon[14]={ent.position,event.tick}
		elseif ent.name=="hit-p-15" then
			global.weapon[15]={ent.position,event.tick}
		elseif ent.name=="hit-p-18" then
			global.weapon[18]={ent.position,event.tick}
		elseif ent.name=="hit-p-19" then
			global.weapon[19]={ent.position,event.tick}
		elseif ent.name=="hit-p-20" then
			global.weapon[20]={ent.position,event.tick}
		elseif ent.name=="hit-p-24" then
			local d=math.random(1,7)
			b.surface.create_entity{name="p-24-"..d,position=targetline(b.position,ent.position,1.5),target=ent.position,speed=d*0.1}
		elseif ent.name=="hit-p-25" then
			local d=b.surface.create_entity{name="p-25-1",position=targetline(b.position,ent.position,1.5),target=ent.position,speed=0.5}
			global.weapon[25]=d
		elseif ent.name=="hit-p-29" then
			local d=b.surface.create_entity{name="p-29-1",position=targetline(b.position,ent.position,1.5),target=ent.position,speed=0.6}
			global.weapon[29]={d,event.tick}
		elseif ent.name=="hit-p-16-1" then
			local ents=b.surface.find_entities_filtered{force="enemy",area={{ent.position.x-8,ent.position.y-8},{ent.position.x+8,ent.position.y+8}}}
			if #ents>0 then
				for i,j in pairs(ents) do
					if distance(j,ent)==0 then table.remove(ents,i) end
				end
			end
			if #ents>0 then
				local d=math.random(1,#ents)
				b.surface.create_entity{name="p-16-1",position=ent.position,target=ents[d],speed=0.5}
			end
		elseif ent.name=="hit-p-16-2" then
			local ents=b.surface.find_entities_filtered{force="enemy",area={{ent.position.x-6,ent.position.y-6},{ent.position.x+6,ent.position.y+6}}}
			if #ents>0 then
				for i,j in pairs(ents) do
					if distance(j,ent)==0 then table.remove(ents,i) end
				end
			end
			if #ents>0 then
				local d=math.random(1,#ents)
				b.surface.create_entity{name="p-16-2",position=ent.position,target=ents[d],speed=0.4}
			end
		elseif ent.name=="hit-p-16-3" then
			local ents=b.surface.find_entities_filtered{force="enemy",area={{ent.position.x-4,ent.position.y-4},{ent.position.x+4,ent.position.y+4}}}
			if #ents>0 then
				for i,j in pairs(ents) do
					if distance(j,ent)==0 then table.remove(ents,i) end
				end
			end
			if #ents>0 then
				local d=math.random(1,#ents)
				b.surface.create_entity{name="p-16-3",position=ent.position,target=ents[d],speed=0.3}
			end
		end
	end
end)


