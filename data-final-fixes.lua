if settings.startup["custom-modules-legacy"].value then
	require("prototypes.legacy.modules")
end

--replace vanilla modules in recipes
for i, r in pairs(data.raw.recipe) do	
	if r.ingredients then
		for j, n in pairs(r.ingredients) do
			if n.name and n.name == "speed-module" then
				n.name = "module-B0"				
			end	
			if n[1] and n[1] == "speed-module" then
				n[1] = "module-B0"
			end
			if n.name and n.name == "effectivity-module" then
				n.name = "module-G0"				
			end	
			if n[1] and n[1] == "effectivity-module" then
				n[1] = "module-G0"
			end
			if n.name and n.name == "productivity-module" then
				n.name = "module-R0"				
			end	
			if n[1] and n[1] == "productivity-module" then
				n[1] = "module-R0"
			end
			if n.name and n.name == "speed-module-2" then
				n.name = "module-B"				
			end	
			if n[1] and n[1] == "speed-module-2" then
				n[1] = "module-B"
			end
			if n.name and n.name == "effectivity-module-2" then
				n.name = "module-G"				
			end	
			if n[1] and n[1] == "effectivity-module-2" then
				n[1] = "module-G"
			end
			if n.name and n.name == "productivity-module-2" then
				n.name = "module-R"				
			end	
			if n[1] and n[1] == "productivity-module-2" then
				n[1] = "module-R"
			end
			if n.name and n.name == "speed-module-3" then
				n.name = "module-BB"				
			end	
			if n[1] and n[1] == "speed-module-3" then
				n[1] = "module-BB"
			end
			if n.name and n.name == "effectivity-module-3" then
				n.name = "module-GG"				
			end	
			if n[1] and n[1] == "effectivity-module-3" then
				n[1] = "module-GG"
			end
			if n.name and n.name == "productivity-module-3" then
				n.name = "module-RR"				
			end	
			if n[1] and n[1] == "productivity-module-3" then
				n[1] = "module-RR"
			end
		end
	end

	--remove vanilla module recipes
	if r.name == "speed-module" then
		data.raw.recipe[i] = nil
	elseif r.name == "productivity-module" then
		data.raw.recipe[i] = nil
	elseif r.name == "effectivity-module" then
		data.raw.recipe[i] = nil
	elseif r.name == "speed-module-2" then
		data.raw.recipe[i] = nil
	elseif r.name == "productivity-module-2" then
		data.raw.recipe[i] = nil
	elseif r.name == "effectivity-module-2" then
		data.raw.recipe[i] = nil
	elseif r.name == "speed-module-3" then
		data.raw.recipe[i] = nil
	elseif r.name == "productivity-module-3" then
		data.raw.recipe[i] = nil
	elseif r.name == "effectivity-module-3" then
		data.raw.recipe[i] = nil
	end
end

for i, t in pairs(data.raw.technology) do
	if t.prerequisites then
		m = 0
		m1 = 0
		m2 = 0
		for j, p in pairs(t.prerequisites) do
			if p == "speed-module-3" then
				m2 = m2+1
				if m2 == 1 then
					t.prerequisites[j] = "custom-m-2"
				else
					t.prerequisites[j] = nil
				end
			elseif p == "effectivity-module-3" then
				m2 = m2+1
				if m2 == 1 then
					t.prerequisites[j] = "custom-m-2"
				else
					t.prerequisites[j] = nil
				end
			elseif p == "productivity-module-3" then
				m2 = m2+1
				if m2 == 1 then
					t.prerequisites[j] = "custom-m-2"
				else
					t.prerequisites[j] = nil
				end
			elseif p == "speed-module-2" then
				m1 = m1+1
				if m1 == 1 then
					t.prerequisites[j] = "custom-m"
				else
					t.prerequisites[j] = nil
				end
			elseif p == "effectivity-module-2" then
				m1 = m1+1
				if m1 == 1 then
					t.prerequisites[j] = "custom-m"
				else
					t.prerequisites[j] = nil
				end
			elseif p == "productivity-module-2" then
				m1 = m1+1
				if m1 == 1 then
					t.prerequisites[j] = "custom-m"
				else
					t.prerequisites[j] = nil
				end
			elseif p == "speed-module" then
				t.prerequisites[j] = "speed-m"
			elseif p == "effectivity-module" then
				t.prerequisites[j] = "eco-m"
			elseif p == "productivity-module" then
				t.prerequisites[j] = "productivity-m"
			end
		end
	end
	if t.name == "modules" then
		
	elseif t.name == "speed-module" then
		data.raw.technology[t.name] = nil
	elseif t.name == "productivity-module" then
		data.raw.technology[t.name] = nil
	elseif t.name == "effectivity-module" then
		data.raw.technology[t.name] = nil
	elseif t.name == "speed-module-2" then
		data.raw.technology[t.name] = nil
	elseif t.name == "productivity-module-2" then
		data.raw.technology[t.name] = nil
	elseif t.name == "effectivity-module-2" then
		data.raw.technology[t.name] = nil
	elseif t.name == "speed-module-3" then
		data.raw.technology[t.name] = nil
	elseif t.name == "productivity-module-3" then
		data.raw.technology[t.name] = nil
	elseif t.name == "effectivity-module-3" then
		data.raw.technology[t.name] = nil
	end
	if t.effects then
		for j, p in pairs(t.effects) do
			if p.type == "unlock-recipe" then
				if p.recipe == "speed-module" then
					p = nil
				elseif p.recipe == "speed-module-2" then
					p = nil
				elseif p.recipe == "speed-module-3" then
					p = nil
				elseif p.recipe == "effectivity-module" then
					p = nil
				elseif p.recipe == "effectivity-module-2" then
					p = nil
				elseif p.recipe == "effectivity-module-3" then
					p = nil
				elseif p.recipe == "productivity-module" then
					p = nil
				elseif p.recipe == "productivity-module-2" then
					p = nil
				elseif p.recipe == "productivity-module-3" then
					p = nil
				end
			end
		end
	end
end

if settings.startup["custom-modules-half-slots"].value then
	for i,e in pairs(data.raw.beacon) do
		if e.module_specification and e.module_specification.module_slots and e.module_specification.module_slots > 0 then
			e.module_specification.module_slots = math.floor(e.module_specification.module_slots/2)
		end
	end
	for i,e in pairs(data.raw["assembling-machine"]) do
		if e.module_specification and e.module_specification.module_slots and e.module_specification.module_slots > 0 then
			e.module_specification.module_slots = math.floor(e.module_specification.module_slots/2)
		end
	end
	for i,e in pairs(data.raw.furnace) do
		if e.module_specification and e.module_specification.module_slots and e.module_specification.module_slots > 0 then
			e.module_specification.module_slots = math.floor(e.module_specification.module_slots/2)
		end
	end
	for i,e in pairs(data.raw["mining-drill"]) do
		if e.module_specification and e.module_specification.module_slots and e.module_specification.module_slots > 0 then
			e.module_specification.module_slots = math.floor(e.module_specification.module_slots/2)
		end
	end
	for i,e in pairs(data.raw["lab"]) do
		if e.module_specification and e.module_specification.module_slots and e.module_specification.module_slots > 0 then
			e.module_specification.module_slots = math.floor(e.module_specification.module_slots/2)
		end
	end
end

