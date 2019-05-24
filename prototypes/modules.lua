-----------------------------------------------------------------------------------------------------------------------------------------------------------------
----- VARIABLES -----
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

local current = {0, 0, 0}

local red = 0
local green = 0
local blue = 0
local cyan = 0
local magenta = 0
local yellow = 0

local s = ""

local d = {
	{"R0", "G0", "B0"},
	{},
	{},
	{}
}

local t = {
	{{1, 0, 0}, {0, 1, 0}, {0, 0, 1}},
	{},
	{},
	{}
}

local h = 1
if settings.startup["custom-modules-half-slots"].value then
	h = 2
end

local multiplier_consumption = settings.startup["custom-modules-multiplier-consumption"].value * h
local multiplier_speed = settings.startup["custom-modules-multiplier-speed"].value * h
local multiplier_productivity = settings.startup["custom-modules-multiplier-productivity"].value * h
local multiplier_pollution = settings.startup["custom-modules-multiplier-pollution"].value * h

local tier_base = settings.startup["custom-modules-tier-base"].value

local red_consumption = settings.startup["custom-modules-prototype-red-consumption"].value
local red_speed = settings.startup["custom-modules-prototype-red-speed"].value
local red_pollution = settings.startup["custom-modules-prototype-red-pollution"].value
local red_productivity = settings.startup["custom-modules-prototype-red-productivity"].value

local blue_consumption = settings.startup["custom-modules-prototype-blue-consumption"].value
local blue_speed = settings.startup["custom-modules-prototype-blue-speed"].value
local blue_pollution = settings.startup["custom-modules-prototype-blue-pollution"].value

local green_consumption = settings.startup["custom-modules-prototype-green-consumption"].value
local green_speed = settings.startup["custom-modules-prototype-green-speed"].value
local green_pollution = settings.startup["custom-modules-prototype-green-pollution"].value

--adjustable--
local ingredients = {
	{
		{type = "item", name = "electronic-circuit", amount = 10 * h},
		{type = "item", name = "copper-cable", amount = 10 * h}
	},
	{
		{type = "item", name = "electronic-circuit", amount = 30 * h},
		{type = "item", name = "copper-cable", amount = 30 * h},
		{type = "item", name = "copper-plate", amount = 40}
	},
	{
		{type = "item", name = "advanced-circuit", amount = 100 * h}, 
		{type = "item", name = "plastic-bar", amount = 50 * h}
	},
	{
		{type = "item", name = "processing-unit", amount = 150 * h}, 
		{type = "item", name = "nuclear-fuel", amount = 1 * h}
	}
}

local number_of_previous_tier = {
	{2, 2},
	{4, 4},
	{5, 40}
}

local required_energies = {
	10 * h,
	40 * h,
	100 * h
}

--I don't understand this yet
local composition = {
	{1, 1},
	{2, 2},
	{3, 2}
}

--table with a table for each tier, will be filled with their names by this script
custom_modules_module_recipes = {[0] = {}, {}, {}, {}}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
----- FUNCTIONS -----
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

function add(A, B)
	return {A[1] + B[1], A[2] + B[2], A[3] + B[3]}
end

function apply(X)
	R = X[1]
	G = X[2]
	B = X[3]

	red = 0
	green = 0
	blue = 0
	cyan = 0
	magenta = 0
	yellow = 0

	s = ""

	if R + G + B == 1 then
		if R == 1 then
			red = 1
			s = d[1][1]
		elseif G == 1 then
			green = 1
			s = d[1][2]
		elseif B == 1 then
			blue = 1
			s = d[1][3]
		end
	else
		while R + G + B > 0 do
			if R == G and G == B then
				R = 0
				G = 0
				B = 0
				red = 1
				green = 1
				blue = 1
				s = "RGB"
			elseif R > G and R > B then
				R = R - 2
				red = red + 1
				s = s .. "R"
			elseif G > R and G > B then
				G = G - 2
				green = green + 1
				s = s .. "G"
			elseif B > G and B > R then
				B = B - 2
				blue = blue + 1
				s = s .. "B"
			elseif R == G then
				R = R - 1
				G = G - 1
				yellow = yellow + 1
				s = s .. "Y"
			elseif B == G then
				B = B - 1
				G = G - 1
				cyan = cyan + 1
				s = s .. "C"
			elseif R == B then
				R = R - 1
				B = B - 1
				magenta = magenta + 1
				s = s .. "M"
			else
				R = 0
				G = 0
				B = 0
			end
		end

		if s ~= "RGB" then
			if string.sub(s, 1, 2) == "RG" then
				s = "YY" .. string.sub(s, 3, 3)
			elseif string.sub(s, 1, 2) == "GR" then
				s = "YY" .. string.sub(s, 3, 3)
			elseif string.sub(s, 1, 2) == "GB" then
				s = "CC" .. string.sub(s, 3, 3)
			elseif string.sub(s, 1, 2) == "BG" then
				s = "CC" .. string.sub(s, 3, 3)
			elseif string.sub(s, 1, 2) == "BR" then
				s = "MM" .. string.sub(s, 3, 3)
			elseif string.sub(s, 1, 2) == "RB" then
				s = "MM" .. string.sub(s, 3, 3)
			end
		end

		if string.sub(s, 3, 3) == string.sub(s, 2, 2) then
			s = string.sub(s, 2, 3) .. string.sub(s, 1, 1)
		end
	end
end

function get_ingredients(tier, j, k)
	if tier == 0 then
		return ingredients[1]
	end

	J = d[composition[tier][1]][j]
	K = d[composition[tier][2]][k]

	local ret = {}
	for _, ingredient in pairs(ingredients[tier + 1]) do
		table.insert(ret, ingredient)
	end

	if J == K then
		table.insert(ret, {type = "item", name = "module-" .. J, amount = number_of_previous_tier[tier][1] + number_of_previous_tier[tier][2]})
	else
		table.insert(ret, {type = "item", name = "module-" .. J, amount = number_of_previous_tier[tier][1]})
		table.insert(ret, {type = "item", name = "module-" .. K, amount = number_of_previous_tier[tier][2]})
	end

	return ret
end

function get_effect(tier)
	red_portion = 2 * red + magenta + yellow
	green_portion = 2 * green + yellow + cyan
	blue_portion = 2 * blue + cyan + magenta

	prod_effect = red_productivity * red_portion * multiplier_productivity * tier_base ^ tier
	speed_effect =
		(red_speed * red_portion + blue_speed * blue_portion + green_speed * green_portion) * multiplier_speed *
		tier_base ^ tier
	consumption_effect =
		(red_consumption * red_portion + blue_consumption * blue_portion + green_consumption * green_portion) *
		multiplier_consumption *
		tier_base ^ tier
	pollution_effect =
		(red_pollution * red_portion + blue_pollution * blue_portion + green_pollution * green_portion) * multiplier_pollution *
		tier_base ^ tier

	return {
		productivity = {bonus = prod_effect},
		speed = {bonus = speed_effect},
		consumption = {bonus = consumption_effect},
		pollution = {bonus = pollution_effect}
	}
end

function get_category()
	if red > 0 or magenta > 0 or yellow > 0 then
		return "productivity"
	elseif blue > 0 or cyan > 0 then
		return "speed"
	else
		return "effectivity"
	end
end

function get_tint(L)
	R = 2 * red + magenta + yellow + L
	G = 2 * green + cyan + yellow + L
	B = 2 * blue + cyan + magenta + L

	D = math.max(R, G, B)

	return {r = R / D, g = G / D, b = B / D, a = 1}
end

function get_order()
	P = math.min(2 * red + magenta + yellow, 2 * green + cyan + yellow, 2 * blue + cyan + magenta)
	R = (2 * red + magenta + yellow) / 6
	G = (2 * green + cyan + yellow) / 6
	B = (2 * blue + cyan + magenta) / 6
	Hmin = math.min(R, G, B)
	Hmax = math.max(R, G, B)

	if Hmin == Hmax then
		return P .. "-" .. "z"
	end

	S = 0

	if R == Hmax then
		S = 2 + (G - B) / (Hmax - Hmin)
	elseif G == Hmax then
		S = 4 + (B - R) / (Hmax - Hmin)
	elseif B == Hmax then
		S = 6 + (R - G) / (Hmax - Hmin)
	end

	if R == Hmax and B > G then
		S = S + 6
	end

	return P .. "-" .. S
end

function create_module(tier, j, k)
	C = composition[tier]

	current = add(t[C[1]][j], t[C[2]][k])
	apply(current)
	table.insert(t[tier + 1], current)
	table.insert(d[tier + 1], s)

	local recipe_name = "module-" .. d[C[1]][j] .. d[C[2]][k]
	local technologies = {"custom-m", "custom-m-2", "custom-m-3"}

	RECIPE {
		type = "recipe",
		name = recipe_name,
		enabled = false,
		icons = {
			{
				icon = "__CustomModules__/graphics/icons/items/back.png",
				tint = get_tint(1)
			},
			{
				icon = "__CustomModules__/graphics/icons/items/wires.png"
			},
			{
				icon = "__CustomModules__/graphics/icons/items/1/light-" .. string.sub(s, 1, 1) .. ".png"
			},
			{
				icon = "__CustomModules__/graphics/icons/items/2/light-" .. string.sub(s, 2, 2) .. ".png"
			},
			{
				icon = "__CustomModules__/graphics/icons/items/3/light-" .. string.sub(s, 3, 3) .. ".png"
			}
		},
		icon_size = 32,
		category = "module-assembling-" .. tier,
		energy_required = required_energies[tier],
		ingredients = get_ingredients(tier, j, k),
		results = {
			{type = "item", name = "module-" .. s, amount = 1}
		}
	}:add_unlock(technologies[tier])

	table.insert(custom_modules_module_recipes[tier], recipe_name)

	ITEM {
		type = "module",
		name = "module-" .. s,
		icons = {
			{
				icon = "__CustomModules__/graphics/icons/items/back.png",
				tint = get_tint(1)
			},
			{
				icon = "__CustomModules__/graphics/icons/items/wires.png"
			},
			{
				icon = "__CustomModules__/graphics/icons/items/1/light-" .. string.sub(s, 1, 1) .. ".png"
			},
			{
				icon = "__CustomModules__/graphics/icons/items/2/light-" .. string.sub(s, 2, 2) .. ".png"
			},
			{
				icon = "__CustomModules__/graphics/icons/items/3/light-" .. string.sub(s, 3, 3) .. ".png"
			}
		},
		icon_size = 32,
		subgroup = "custom-modules-" .. tier,
		category = get_category(),
		tier = tier,
		order = "q-b-" .. get_order(),
		order_in_inventory = get_order(),
		stack_size = 50,
		default_request_amount = 10,
		effect = get_effect(tier)
	}

	if get_category() == "productivity" then
		data.raw.module["module-" .. s].limitation = data.raw.module["productivity-module"].limitation
		data.raw.module["module-" .. s].limitation_message_key = data.raw.module["productivity-module"].limitation_message_key
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
----- RECIPE LOOP -----
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Tier 0
for j = 1, 3 do
	current = t[1][j]
	apply(current)

	local recipe_name = "module-" .. d[1][j]
	data:extend(
		{
			{
				type = "recipe",
				name = recipe_name,
				enabled = false,
				icons = {
					{
						icon = "__CustomModules__/graphics/icons/items/back.png",
						tint = get_tint(2)
					},
					{
						icon = "__CustomModules__/graphics/icons/items/wires.png"
					}
				},
				icon_size = 32,
				category = "crafting",
				energy_required = 5.0,
				ingredients = get_ingredients(0, j, 0),
				results = {
					{type = "item", name = "module-" .. d[1][j], amount = 1}
				}
			}
		}
	)
	table.insert(custom_modules_module_recipes[0], recipe_name)
end

-- Tier 1
for j = 1, 3 do
	for k = 1, j do
		create_module(1, j, k)
	end
end

-- Tier 2
for j = 1, 6 do
	for k = 1, j do
		create_module(2, j, k)
	end
end

-- Tier 3
for j = 1, 21 do
	for k = 1, 6 do
		create_module(3, j, k)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
----- TIER 0 ITEMS -----
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

data:extend(
	{
		{
			type = "module",
			name = "module-R0",
			icons = {
				{
					icon = "__CustomModules__/graphics/icons/items/back.png",
					tint = {r = 1, g = 0.5, b = 0.5, a = 1}
				},
				{
					icon = "__CustomModules__/graphics/icons/items/wires.png"
				}
			},
			icon_size = 32,
			subgroup = "custom-modules-0",
			category = "productivity",
			tier = 0,
			order = "q-a1",
			order_in_inventory = "q-a1",
			stack_size = 50,
			default_request_amount = 10,
			effect = {
				productivity = {bonus = red_productivity * multiplier_productivity},
				speed = {bonus = red_speed * multiplier_speed},
				consumption = {bonus = red_consumption * multiplier_consumption},
				pollution = {bonus = red_pollution * multiplier_pollution}
			},
			limitation = data.raw.module["productivity-module"].limitation,
			limitation_message_key = data.raw.module["productivity-module"].limitation_message_key
		},
		{
			type = "module",
			name = "module-G0",
			icons = {
				{
					icon = "__CustomModules__/graphics/icons/items/back.png",
					tint = {r = 0.5, g = 1, b = 0.5, a = 1}
				},
				{
					icon = "__CustomModules__/graphics/icons/items/wires.png"
				}
			},
			icon_size = 32,
			subgroup = "custom-modules-0",
			category = "effectivity",
			tier = 0,
			order = "q-a2",
			order_in_inventory = "q-a2",
			stack_size = 50,
			default_request_amount = 10,
			effect = {
				productivity = {bonus = 0},
				speed = {bonus = green_speed * multiplier_speed},
				consumption = {bonus = green_consumption * multiplier_consumption},
				pollution = {bonus = green_pollution * multiplier_pollution}
			}
		},
		{
			type = "module",
			name = "module-B0",
			icons = {
				{
					icon = "__CustomModules__/graphics/icons/items/back.png",
					tint = {r = 0.5, g = 0.5, b = 1, a = 1}
				},
				{
					icon = "__CustomModules__/graphics/icons/items/wires.png"
				}
			},
			icon_size = 32,
			subgroup = "custom-modules-0",
			category = "speed",
			tier = 0,
			order = "q-a3",
			order_in_inventory = "q-a3",
			stack_size = 50,
			default_request_amount = 10,
			effect = {
				productivity = {bonus = 0},
				speed = {bonus = blue_speed * multiplier_speed},
				consumption = {bonus = blue_consumption * multiplier_consumption},
				pollution = {bonus = blue_pollution * multiplier_pollution}
			}
		}
	}
)
