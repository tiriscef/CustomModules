
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
 ----- VARIABLES -----
 -----------------------------------------------------------------------------------------------------------------------------------------------------------------
require("__stdlib__/stdlib/data/data").Util.create_data_globals()

local current= {0,0,0}

local r=0
local g=0
local b=0
local c=0
local m=0
local y=0

local s=""

local d = {
{"R0", "G0", "B0"},
{},
{},
{}
}

local t = {
{{1,0,0}, {0,1,0}, {0,0,1}},
{},
{},
{}
}

local h=1
if settings.startup["custom-modules-half-slots"].value then
	h=2
end

--adjustable--

local ingredients = {
{{"electronic-circuit", 5}, {"advanced-circuit", 3}},
{{"advanced-circuit", 1*h}, {"processing-unit", 1*h}},
{{"advanced-circuit", 16*h}, {"processing-unit", 8*h}},
{{"electronic-circuit", 150*h}, {"nuclear-fuel", 1*h}},
}

local composition = {
{1, 1, 1*h, 1*h, 10*h},
{2, 2, 4, 4, 40*h},
{3, 2, 5, 20, 100*h}
}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
 ----- FUNCTIONS -----
 -----------------------------------------------------------------------------------------------------------------------------------------------------------------

function add(A,B)
	return {A[1]+B[1],A[2]+B[2],A[3]+B[3]}
end

function apply(X)
	R = X[1]
	G = X[2]
	B = X[3]
	
	r=0
	g=0
	b=0
	c=0
	m=0
	y=0
	
	s=""
	
	if R+G+B == 1 then
		if R == 1 then
			r = 1
			s = d[1][1]
		elseif G == 1 then
			g = 1
			s = d[1][2]
		elseif B == 1 then
			b = 1
			s = d[1][3]
		end
	else
		while R+G+B > 0 do
			if R == G and G == B then
				R = 0
				G = 0
				B = 0
				r = 1
				g = 1
				b = 1
				s = "RGB"
			elseif R > G and R > B then
				R = R-2
				r = r+1
				s = s.."R"
			elseif G > R and G > B then
				G = G-2
				g = g+1
				s = s.."G"
			elseif B > G and B > R then
				B = B-2
				b = b+1
				s = s.."B"
			elseif R == G then
				R = R-1
				G = G-1
				y = y+1
				s = s.."Y"
			elseif B == G then
				B = B-1
				G = G-1
				c = c+1
				s = s.."C"
			elseif R == B then
				R = R-1
				B = B-1
				m = m+1
				s = s.."M"
			else
				R = 0
				G = 0
				B = 0
			end		
		end
		
		if s ~= "RGB" then
			if string.sub(s,1,2) == "RG" then
				s = "YY"..string.sub(s,3,3)
			elseif string.sub(s,1,2) == "GR" then
				s = "YY"..string.sub(s,3,3)
			elseif string.sub(s,1,2) == "GB" then
				s = "CC"..string.sub(s,3,3)
			elseif string.sub(s,1,2) == "BG" then
				s = "CC"..string.sub(s,3,3)
			elseif string.sub(s,1,2) == "BR" then
				s = "MM"..string.sub(s,3,3)
			elseif string.sub(s,1,2) == "RB" then
				s = "MM"..string.sub(s,3,3)
			end
		end
		
		if string.sub(s,3,3) == string.sub(s,2,2) then
			s = string.sub(s,2,3)..string.sub(s,1,1)
		end
	end
	
end

function get_ingredients(i,j,k)

	if i == 0 then
		return ingredients[i+1]
	end
	
	J = d[composition[i][1]][j]
	K = d[composition[i][2]][k]	
	
	if J == K then
		return {{"module-"..J, composition[i][3] + composition[i][4]}, ingredients[i+1][1], ingredients[i+1][2]}
	else
		return {{"module-"..J, composition[i][3]}, {"module-"..K, composition[i][4]}, ingredients[i+1][1], ingredients[i+1][2]}
	end
end


function get_effect(i)
	R = r + 0.5*(m+y)
	G = g + 0.5*(y+c)
	B = b + 0.5*(c+m)
	P = 0.06*R*settings.startup["custom-modules-multiplier-productivity"].value
	S = (-0.05 + 0.05*i - 0.16*R + 0.30*B - 0.06*G)*settings.startup["custom-modules-multiplier-speed"].value
	K = (0.60*R + 0.90*B - 0.70*G*i)*settings.startup["custom-modules-multiplier-consumption"].value
	E = (0.16*R + 0.04*B - 0.20*G)*settings.startup["custom-modules-multiplier-pollution"].value
	if P ~= 0 then
		P = P + (P/math.abs(P))*0.0001
	end
	if S ~= 0 then
		S = S + (S/math.abs(S))*0.0001
	end
	if K ~= 0 then
		K = K + (K/math.abs(K))*0.0001
	end
	if E ~= 0 then
		E = E + (E/math.abs(E))*0.0001
	end
	
	if settings.startup["custom-modules-half-slots"].value then
		return { productivity = {bonus = P*2}, speed = {bonus = S*2}, consumption = {bonus = K*2}, pollution = {bonus = E*2}}
	else
		return { productivity = {bonus = P}, speed = {bonus = S}, consumption = {bonus = K}, pollution = {bonus = E}}
	end
end
 
function get_category()
	if r > 0 or m > 0 or y > 0 then
		return "productivity"
	elseif b > 0 or c > 0 then
		return "speed"
	else
		return "effectivity"
	end
end

function get_tint(L)
	
	R = 2 * r + m + y + L
	G = 2 * g + c + y + L
	B = 2 * b + c + m + L
	
	D = math.max(R, G, B)	
	
	return {r = R/D, g = G/D, b = B/D, a = 1}
end

function get_order()	
	
	P = math.min(2*r+m+y,2*g+c+y,2*b+c+m)
	R=(2*r+m+y)/6
	G=(2*g+c+y)/6
	B=(2*b+c+m)/6
	Hmin = math.min(R,G,B)
	Hmax = math.max(R,G,B)
	
	if Hmin == Hmax then
		return P.."-".."z"
	end
	
	S=0
	
	if R == Hmax then
		S = 2+(G-B)/(Hmax-Hmin)
	elseif G == Hmax then
		S = 4+(B-R)/(Hmax-Hmin)
	elseif B == Hmax then
		S = 6+(R-G)/(Hmax-Hmin)
	end 
	
	if R == Hmax and B > G then
		S = S + 6
	end
	
	return P.."-"..S
	
end



function add_item(i)	
	if i == 0 then
		return
	end
	data:extend({
		{
			type = "module",
			name = "module-"..s,
			icons = {
				{													
					icon = "__CustomModules__/graphics/icons/items/back.png",
					tint = get_tint(1)
				},
				{
					icon = "__CustomModules__/graphics/icons/items/wires.png"
				},
				{
					icon = "__CustomModules__/graphics/icons/items/1/light-"..string.sub(s,1,1)..".png",
				},
				{
					icon = "__CustomModules__/graphics/icons/items/2/light-"..string.sub(s,2,2)..".png",
				},
				{
					icon = "__CustomModules__/graphics/icons/items/3/light-"..string.sub(s,3,3)..".png",
				},
			},
			icon_size = 32,
	
			subgroup = "custom-modules-"..i,
			category = get_category(),
			tier = i,
			order = "q-b-"..get_order(),
			order_in_inventory = get_order(),
			stack_size = 50,
			default_request_amount = 10,
			effect = get_effect(i),
		}
	})
	if get_category() == "productivity" then
		data.raw.module["module-"..s].limitation = data.raw.module["productivity-module"].limitation
		data.raw.module["module-"..s].limitation_message_key = data.raw.module["productivity-module"].limitation_message_key
	end
end



function create_module(i,j,k)
	
	if i == 0 then
		return
	end
	
	C = composition[i]
	
	current = add(t[C[1]][j],t[C[2]][k])
	apply(current)
	table.insert(t[i+1],current)
	table.insert(d[i+1],s)

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
		category = "module-assembling-" .. i,
		energy_required = C[5],
		ingredients = get_ingredients(i, j, k),
		results = {
			{"module-" .. s, 1}
		}
	}:add_unlock(technologies[i])

	add_item(i)
end 
 
 -----------------------------------------------------------------------------------------------------------------------------------------------------------------
 ----- RECIPE LOOP -----
 -----------------------------------------------------------------------------------------------------------------------------------------------------------------
 
for i=0, 3 do
	if i == 0 then
		for j=1, 3 do
			current = t[1][j]
			apply(current)
			data:extend({
				{
					type = "recipe",
					name = "module-"..d[1][j],
					enabled = false,
					icons = {
						{													
							icon = "__CustomModules__/graphics/icons/items/back.png",
							tint = get_tint(2)
						},
						{
							icon = "__CustomModules__/graphics/icons/items/wires.png"
						},
					},
					icon_size = 32,
					category = "crafting",
					energy_required = 5.0,
					ingredients = get_ingredients(i,j,0),
					results = 
					{
						{"module-"..d[1][j], 1}
					}			
				}
			})
		end
	elseif i == 1 then
		for j=1, 3 do
			for k=1, j do
				create_module(i,j,k)
			end
		end
	elseif i == 2 then
		for j=1, 6 do
			for k=1, j do
				create_module(i,j,k)
			end
		end
	elseif i == 3 then
		for j=1, 21 do
			for k=1, 6 do
				create_module(i,j,k)
			end
		end
	end
end
 
 -----------------------------------------------------------------------------------------------------------------------------------------------------------------
 ----- TIER 0 ITEMS -----
 -----------------------------------------------------------------------------------------------------------------------------------------------------------------
 
data:extend({
	{
		type = "module",
		name = "module-".."R0",
		icons = {
			{													
				icon = "__CustomModules__/graphics/icons/items/back.png",
				tint = {r=1, g=0.5, b=0.5, a=1}
			},
			{
				icon = "__CustomModules__/graphics/icons/items/wires.png"
			},
		},
		icon_size = 32,

		subgroup = "custom-modules-".."0",
		category = "productivity",
		tier = 0,
		order = "q-a1",
		order_in_inventory = "q-a1",
		stack_size = 50,
		default_request_amount = 10,
		effect = { 
		productivity = {bonus = 0.03 * settings.startup["custom-modules-multiplier-productivity"].value * h},
		speed = {bonus = -0.1 * settings.startup["custom-modules-multiplier-speed"].value * h}, 
		consumption = {bonus = 0.4 * settings.startup["custom-modules-multiplier-consumption"].value * h},	
		pollution = {bonus = 0.1 * settings.startup["custom-modules-multiplier-pollution"].value * h},				
		},
		limitation = data.raw.module["productivity-module"].limitation,
		limitation_message_key = data.raw.module["productivity-module"].limitation_message_key
	},
	{
		type = "module",
		name = "module-".."G0",
		icons = {
			{													
				icon = "__CustomModules__/graphics/icons/items/back.png",
				tint = {r=0.5, g=1, b=0.5, a=1}
			},
			{
				icon = "__CustomModules__/graphics/icons/items/wires.png"
			},
		},
		icon_size = 32,

		subgroup = "custom-modules-".."0",
		category = "effectivity",
		tier = 0,
		order = "q-a2",
		order_in_inventory = "q-a2",
		stack_size = 50,
		default_request_amount = 10,
		effect = { 
		productivity = {bonus = 0},
		speed = {bonus = -0.04 * settings.startup["custom-modules-multiplier-speed"].value * h}, 
		consumption = {bonus = -0.3 * settings.startup["custom-modules-multiplier-consumption"].value * h},	
		pollution = {bonus = -0.1 * settings.startup["custom-modules-multiplier-pollution"].value * h},
		}
	},
	{
		type = "module",
		name = "module-".."B0",
		icons = {
			{													
				icon = "__CustomModules__/graphics/icons/items/back.png",
				tint = {r=0.5, g=0.5, b=1, a=1}
			},
			{
				icon = "__CustomModules__/graphics/icons/items/wires.png"
			},
		},
		icon_size = 32,

		subgroup = "custom-modules-".."0",
		category = "speed",
		tier = 0,
		order = "q-a3",
		order_in_inventory = "q-a3",
		stack_size = 50,
		default_request_amount = 10,
		effect = { 
		productivity = {bonus = 0},
		speed = {bonus = 0.2 * settings.startup["custom-modules-multiplier-speed"].value * h}, 
		consumption = {bonus = 0.6 * settings.startup["custom-modules-multiplier-consumption"].value * h},	
		pollution = {bonus = 0.02 * settings.startup["custom-modules-multiplier-pollution"].value * h},
		}
	},
})