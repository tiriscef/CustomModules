data:extend(
	{
		{
			type = "recipe",
			name = "module-assembler",
			enabled = false,
			icon = "__CustomModules__/graphics/icons/entities/module-assembler.png",
			icon_size = 32,
			category = "crafting",
			energy_required = 3.0,
			ingredients = {
				{type = "item", name = "assembling-machine-1", amount = 5},
				{type = "item", name = "electronic-circuit", amount = 20},
				{type = "item", name = "steel-plate", amount = 30},
				{type = "item", name = "stone-brick", amount = 50},
			},
			results = {
				{type = "item", name = "module-assembler", amount = 1}
			}
		},
		{
			type = "recipe",
			name = "module-assembler-2",
			enabled = false,
			icon = "__CustomModules__/graphics/icons/entities/module-assembler-2.png",
			icon_size = 32,
			category = "crafting",
			energy_required = 4.0,
			ingredients = {
				{type = "item", name = "module-assembler", amount = 2},
				{type = "item", name = "advanced-circuit", amount = 10},
				{type = "item", name = "steel-plate", amount = 30}
			},
			results = {
				{type = "item", name = "module-assembler-2", amount = 1}
			}
		},
		{
			type = "recipe",
			name = "module-assembler-3",
			enabled = false,
			icon = "__CustomModules__/graphics/icons/entities/module-assembler-3.png",
			icon_size = 32,
			category = "crafting",
			energy_required = 6.0,
			ingredients = {
				{type = "item", name = "module-assembler-2", amount = 3},
				{type = "item", name = "module-CC", amount = 6},
				{type = "item", name = "concrete", amount = 300}
			},
			results = {
				{type = "item", name = "module-assembler-3", amount = 1}
			}
		}
	}
)
