require("lib.init")

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
for name, recipe in Tirislib_Recipe.pairs() do
	-- hide vanilla recipes
	if vanilla_recipes[name] then
		recipe:set_field("hidden", true)
	end

	recipe:replace_ingredient("speed-module", "module-B0")
	recipe:replace_ingredient("speed-module-2", "module-B")
	recipe:replace_ingredient("speed-module-3", "module-BB")
	recipe:replace_ingredient("effectivity-module", "module-G0")
	recipe:replace_ingredient("effectivity-module-2", "module-G")
	recipe:replace_ingredient("effectivity-module-3", "module-GG")
	recipe:replace_ingredient("productivity-module", "module-R0")
	recipe:replace_ingredient("productivity-module-2", "module-R")
	recipe:replace_ingredient("productivity-module-3", "module-RR")
end

for _, t in pairs(data.raw.technology) do
	if t.prerequisites then
		local m1 = 0
		local m2 = 0
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
		for _, p in pairs(t.effects) do
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

local function get_module_slot_number(module_specification)
	return module_specification.module_slots or 0
end

local function entity_allowes_modules(entity)
	if entity.module_specification then
		if get_module_slot_number(entity.module_specification) > 0 then
			return true
		end
	end

	return false
end

local function is_nil_or_empty(value)
	if value == nil then
		return true
	end

	if type(value) == "table" then
		for _ in pairs(value) do
			return false
		end
		return true
	end

	return false
end

local all_effects = {"consumption",	"speed", "productivity", "pollution"}

local function adjust_module_slots_of_entity(entity, value)
	if entity_allowes_modules(entity) then
		local number_slots = get_module_slot_number(entity.module_specification)
		number_slots = math.min(math.max(number_slots + value, 0), 65535)
		entity.module_specification.module_slots = number_slots
	else
		if allow_modules and value > 0 then
			entity.module_specification = entity.module_specification or {}
			entity.module_specification.module_slots = value

			if is_nil_or_empty(entity.allowed_effects) then
				entity.allowed_effects = all_effects
			end
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

Tirislib_Prototype.finish()