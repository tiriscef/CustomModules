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
    ingredients =
    {
		{"assembling-machine-2", 5},
		{"advanced-circuit", 4},
		{"steel-plate", 30},
    },
      results = 
	{
		{"module-assembler", 1}
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
    ingredients =
    {
		{"module-assembler", 1},
		{"assembling-machine-3", 2}
    },
      results = 
	{
		{"module-assembler-2", 1}
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
    ingredients =
    {
		{"module-assembler-2", 3},
		{"module-CC", 6},
		{"concrete", 300},
    },
      results = 
	{
		{"module-assembler-3", 1}
	}
    },
})