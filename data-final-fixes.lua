local vanilla_recipes = {
	["speed-module"] = true,
	["speed-module-2"] = true,
	["speed-module-3"] = true,
	["effectivity-module"] = true,
	["effectivity-module-2"] = true,
	["effectivity-module-3"] = true,
	["productivity-module"] = true,
	["productivity-module-2"] = true,
	["productivity-module-3"] = true,
}

--replace vanilla modules in recipes
for _, r in pairs(data.raw.recipe) do
	-- hide vanilla recipes
	if vanilla_recipes[r.name] then
		r.hidden = true

		if type(r.normal) == "table" then
			r.normal.hidden = true
		end
		if type(r.expensive) == "table" then
			r.expensive.hidden = true
		end
	end

	if r.ingredients then
		for _, n in pairs(r.ingredients) do
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
end

for _, t in pairs(data.raw.technology) do
	if t.prerequisites then
		m = 0
		m1 = 0
		m2 = 0
		for j, p in pairs(t.prerequisites) do
			if p == "speed-module-3" then
				m2 = m2 + 1
				if m2 == 1 then
					t.prerequisites[j] = "custom-m-2"
				else
					t.prerequisites[j] = nil
				end
			elseif p == "effectivity-module-3" then
				m2 = m2 + 1
				if m2 == 1 then
					t.prerequisites[j] = "custom-m-2"
				else
					t.prerequisites[j] = nil
				end
			elseif p == "productivity-module-3" then
				m2 = m2 + 1
				if m2 == 1 then
					t.prerequisites[j] = "custom-m-2"
				else
					t.prerequisites[j] = nil
				end
			elseif p == "speed-module-2" then
				m1 = m1 + 1
				if m1 == 1 then
					t.prerequisites[j] = "custom-m"
				else
					t.prerequisites[j] = nil
				end
			elseif p == "effectivity-module-2" then
				m1 = m1 + 1
				if m1 == 1 then
					t.prerequisites[j] = "custom-m"
				else
					t.prerequisites[j] = nil
				end
			elseif p == "productivity-module-2" then
				m1 = m1 + 1
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

--halve module slots
local subgroups = {"assembling-machine", "furnace", "beacon", "mining-drill", "lab", "rocket-silo"}

local function halve_module_slots_of_subgroup(group)
	for _, entity in pairs(data.raw[group]) do
		if entity.module_specification and entity.module_specification.module_slots then
			entity.module_specification.module_slots = math.ceil(entity.module_specification.module_slots / 2)
		end
	end
end

if settings.startup["custom-modules-half-slots"].value then
	for _, group in pairs(subgroups) do
		halve_module_slots_of_subgroup(group)
	end
end

--add or substract module slots
local adjust_values = {
	["assembling-machine"] = settings.startup["custom-modules-slots-assembling-machine"].value,
	["furnace"] = settings.startup["custom-modules-slots-furnace"].value,
	["beacon"] = settings.startup["custom-modules-slots-beacon"].value,
	["mining-drill"] = settings.startup["custom-modules-slots-mining-drill"].value,
	["lab"] = settings.startup["custom-modules-slots-lab"].value,
	["rocket-silo"] = settings.startup["custom-modules-slots-rocket-silo"].value
}
local allow_modules = settings.startup["custom-modules-slots-permission"].value

local function adjust_module_slots_of_entity(entity, value)
	if entity.module_specification then
		local number_slots = entity.module_specification.module_slots
		if not number_slots then
			number_slots = 0
		end

		number_slots = math.min(math.max(number_slots + value, 0), 65535)
		entity.module_specification.module_slots = number_slots
	else
		if allow_modules and value > 0 then
			entity.module_specification = {
				module_slots = value
			}
			entity.allowed_effects = {
				"consumption",
				"speed",
				"productivity",
				"pollution"
			}
		end
	end
end

local function adjust_module_slots_of_subgroup(group, value)
	for _, entity in pairs(data.raw[group]) do
		adjust_module_slots_of_entity(entity, value)
	end
end

for group, value in pairs(adjust_values) do
	if value ~= 0 then
		adjust_module_slots_of_subgroup(group, value)
	end
end
