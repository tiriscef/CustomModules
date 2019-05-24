data:extend(
{
  
  {
    type = "technology",
    name = "modules",
    icon = "__CustomModules__/graphics/technology/modules.png",
    icon_size = 128,
    prerequisites =
    {
      "advanced-electronics",
    },
    effects =
    {      
    },
    unit =
    {
      time = 30,
      count = 100,
      ingredients =
      {
        {"automation-science-pack", 1},
		    {"logistic-science-pack", 1}
      },
    },
    order = "q-1"
  },
  {
    type = "technology",
    name = "speed-m",
    icon = "__CustomModules__/graphics/technology/speed-m.png",
    icon_size = 128,
    prerequisites =
    {
      "modules",
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "module-B0"
      }
    },
    unit =
    {
      time = 10,
      count = 30,
      ingredients =
      {
        {"automation-science-pack", 1},
		    {"logistic-science-pack", 1}
      },
    },
    order = "q-2"
  },
  {
    type = "technology",
    name = "productivity-m",
    icon = "__CustomModules__/graphics/technology/productivity-m.png",
    icon_size = 128,
    prerequisites =
    {
      "modules",
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "module-R0"
      }
    },
    unit =
    {
      time = 10,
      count = 30,
      ingredients =
      {
        {"automation-science-pack", 1},
		    {"logistic-science-pack", 1}
      },
    },
    order = "q-2"
  },
  {
    type = "technology",
    name = "eco-m",
    icon = "__CustomModules__/graphics/technology/eco-m.png",
    icon_size = 128,
    prerequisites =
    {
      "modules",
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "module-G0"
      }
    },
    unit =
    {
      time = 10,
      count = 30,
      ingredients =
      {
        {"automation-science-pack", 1},
		    {"logistic-science-pack", 1}
      },
    },
    order = "q-2"
  },
  {
    type = "technology",
    name = "custom-m",
    icon = "__CustomModules__/graphics/technology/custom-m.png",
    icon_size = 128,
    prerequisites =
    {
      "speed-m","productivity-m","eco-m"
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "module-assembler"
      }
    },
    unit =
    {
      time = 90,
      count = 75,
      ingredients =
      {
        {"automation-science-pack", 1},
		    {"logistic-science-pack", 1}
      },
    },
    order = "q-3"
  },
  {
    type = "technology",
    name = "custom-m-2",
    icon = "__CustomModules__/graphics/technology/custom-m.png",
    icon_size = 128,
    prerequisites =
    {
      "custom-m","advanced-electronics-2"
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "module-assembler-2"
      }
    },
    unit =
    {
      time = 150,
      count = 100,
      ingredients =
      {
        {"automation-science-pack", 4},
		    {"logistic-science-pack", 3},
		    {"chemical-science-pack", 2}
      },
    },
    order = "q-4"
  },
  {
    type = "technology",
    name = "custom-m-3",
    icon = "__CustomModules__/graphics/technology/custom-m.png",
    icon_size = 128,
    prerequisites =
    {
      "custom-m-2","concrete", "nuclear-power"
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "module-assembler-3"
      }
    },
    unit =
    {
      time = 210,
      count = 600,
      ingredients =
      {
        {"automation-science-pack", 2},
		    {"logistic-science-pack", 2},
		    {"chemical-science-pack", 2},
		    {"utility-science-pack",2}
      },
    },
    order = "q-5"
  },
  }
)