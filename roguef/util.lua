-- WIP

local module = {}

-- TODO: rename!
function targetrotate(po,pos,t)
	local a=pos.x-po.x
	local b=pos.y-po.y
	local i=0
	local j=0
	i=a*math.cos(math.rad(t))-b*math.sin(math.rad(t))+po.x
	j=b*math.cos(math.rad(t))+a*math.sin(math.rad(t))+po.y
	return {x=i,y=j}
end

--function of find entity by tag
function tag(n)
	return game.get_entity_by_tag(n).position
end

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

function orientation(a,b)
	local ax=a.position.x
	local ay=a.position.y
	local bx=b.position.x
	local by=b.position.y
	local r=180+180*math.atan2(ax-bx, by-ay)/math.pi
	return r/360
end

function etarget(n)
	local b=global.p
	local d=b.walking_state.direction*45
	local pos={x=b.position.x,y=b.position.y-n}
	return targetrotate(b.position,pos,d)
end

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
			if j.name~="character" then
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
		b.surface.create_entity{name= areaeffect , position = pos}
	else
		b.surface.create_entity{name= areaeffect , position = pos, target = pos, speed = 1}
	end
end

--unlock
function unlock()
	local l=global.stats.level
	global.p.gui.left.main.mt[l.."-1"].visible=true
	global.p.gui.left.main.mt[l.."-2"].visible=true
	global.p.gui.left.main.mt[l.."-3"].visible=true
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

--function of bullet
module.bullet_circle = function(n,pos,speed,d)
	if d==nil then d=3 end
	for i=-6,6 do
		local tar=targetrotate(pos,global.p.position,i*10)
		local po=targetline(pos,tar,d)
		game.surfaces[1].create_entity{name="ep-"..n,position=po,target=tar,speed=speed}
		game.surfaces[1].create_entity{name="explosion-gunshot",position=po,target=tar}
	end
end
module.bullet_line = function(ent,bullet,distance,t,speed)
	local po s= targetrotate(ent.position, {x=ent.position.x,y=ent.position.y-distance}, ent.orientation*360+t)
	if game.entity_prototypes[bullet].type=="projectile" then
		return game.surfaces[1].create_entity{name=bullet,position=ent.position,target=pos,speed=speed}
		else
				return game.surfaces[1].create_entity{name=bullet,position=pos}
		end
end

return module
