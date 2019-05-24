data:extend(
{

  {
    type = "assembling-machine",
    name = "module-assembler",
    icon = "__CustomModules__/graphics/icons/entities/module-assembler.png",
    icon_size = 32,
    flags = {"placeable-neutral", "placeable-player", "player-creation", "not-rotatable"},
    minable = {hardness = 0.5, mining_time = 3, result = "module-assembler"},
    max_health = 600,
    resistances =
    {
      {
        type = "acid",
        percent = 60
      },
	  {
        type = "fire",
        percent = 50
      }
    },    
    selection_box = {{-2.25, -2.25}, {2.25, 2.25}}, 
    collision_box = {{-2.25, -2.25}, {2.25, 2.25}},    
	collision_mask = {"item-layer", "object-layer", "water-tile", "player-layer"},
	animation = {
        layers = {
          {            
              filename = "__CustomModules__/graphics/entity/module-assembler.png",
              frame_count = 32,
              height = 218,
              line_length = 8,
			  scale = 0.9,
              priority = "high",
              shift = {
                0,
                0.125
              },
              width = 214            
          },
          {            
              draw_as_shadow = true,
              filename = "__base__/graphics/entity/assembling-machine-2/hr-assembling-machine-2-shadow.png",
              frame_count = 32,
              height = 163,
              line_length = 8,
			  scale = 0.9,
              priority = "high",
              shift = {
                0.375,
                0.1484375
              },
              width = 196            
          }
        }
      },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 1 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 1 },
    working_sound =
    {
      sound = {
        {
          filename = "__base__/sound/assembling-machine-t2-1.ogg",
          volume = 1
        }
      },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 1},
      apparent_volume = 4,
    },
    crafting_categories = {"module-assembling-1"},
    crafting_speed = 1,
	energy_source =
    {
		type = "electric",
		usage_priority = "secondary-input",
		emissions = 0.02,
    },
    energy_usage = "600kW",
    ingredient_count = 6,
    module_specification =
    {
      module_slots = 3,
      module_info_icon_shift = {0, 0.5},
      module_info_multi_row_initial_height_modifier = -0.3
    },
    order = "q",
    allowed_effects = { "speed", "consumption", "pollution", "productivity"}
  },
  {
    type = "assembling-machine",
    name = "module-assembler-2",
    icon = "__CustomModules__/graphics/icons/entities/module-assembler-2.png",
    icon_size = 32,
    flags = {"placeable-neutral", "placeable-player", "player-creation", "not-rotatable"},
    minable = {hardness = 0.5, mining_time = 4, result = "module-assembler-2"},
    max_health = 800,
    resistances =
    {
      {
        type = "acid",
        percent = 60
      },
	  {
        type = "fire",
        percent = 50
      }
    },    
    selection_box = {{-2.25, -2.25}, {2.25, 2.25}}, 
    collision_box = {{-2.25, -2.25}, {2.25, 2.25}},   
	collision_mask = {"item-layer", "object-layer", "water-tile", "player-layer"},
	animation = {
        layers = {
          {            
              filename = "__CustomModules__/graphics/entity/module-assembler-2.png",
              frame_count = 32,
              height = 218,
              line_length = 8,
			  scale = 0.9,
              priority = "high",
              shift = {
                0,
                0.125
              },
              width = 214            
          },
          {            
              draw_as_shadow = true,
              filename = "__base__/graphics/entity/assembling-machine-2/hr-assembling-machine-2-shadow.png",
              frame_count = 32,
              height = 163,
              line_length = 8,
			  scale = 0.9,
              priority = "high",
              shift = {
                0.375,
                0.1484375
              },
              width = 196            
          }
        }
      },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 1 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 1 },
    working_sound =
    {
      sound = {
        {
          filename = "__base__/sound/assembling-machine-t2-1.ogg",
          volume = 1
        }
      },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 1},
      apparent_volume = 4,
    },
    crafting_categories = {"module-assembling-1","module-assembling-2"},
    crafting_speed = 1.5,
	energy_source =
    {
		type = "electric",
		usage_priority = "secondary-input",
		emissions = 0.012,
    },
    energy_usage = "800kW",
    ingredient_count = 6,
    module_specification =
    {
      module_slots = 3,
      module_info_icon_shift = {0, 0.5},
      module_info_multi_row_initial_height_modifier = -0.3
    },
    order = "q",
    allowed_effects = { "speed", "consumption", "pollution", "productivity"}
  },
  {
    type = "assembling-machine",
    name = "module-assembler-3",
    icon = "__CustomModules__/graphics/icons/entities/module-assembler-3.png",
    icon_size = 32,
    flags = {"placeable-neutral", "placeable-player", "player-creation", "not-rotatable"},
    minable = {hardness = 0.5, mining_time = 6, result = "module-assembler-3"},
    max_health = 1200,
    resistances =
    {
      {
        type = "acid",
        percent = 60
      },
	  {
        type = "fire",
        percent = 50
      }
    },    
	selection_box = {{-2.25, -2.25}, {2.25, 2.25}}, 
    collision_box = {{-2.25, -2.25}, {2.25, 2.25}},  
	collision_mask = {"item-layer", "object-layer", "water-tile", "player-layer"},
	animation = {
        layers = {
          {            
              filename = "__CustomModules__/graphics/entity/module-assembler-3.png",
              frame_count = 32,
              height = 218,
              line_length = 8,
			  scale = 0.9,
              priority = "high",
              shift = {
                0,
                0.125
              },
              width = 214            
          },
          {            
              draw_as_shadow = true,
              filename = "__base__/graphics/entity/assembling-machine-2/hr-assembling-machine-2-shadow.png",
              frame_count = 32,
              height = 163,
              line_length = 8,
			  scale = 0.9,
              priority = "high",
              shift = {
                0.375,
                0.1484375
              },
              width = 196            
          }
        }
      },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 1 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 1 },
    working_sound =
    {
      sound = {
        {
          filename = "__base__/sound/assembling-machine-t2-1.ogg",
          volume = 1
        }
      },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 1},
      apparent_volume = 4,
    },
    crafting_categories = {"module-assembling-1","module-assembling-2","module-assembling-3",},
    crafting_speed = 2.25,
	energy_source =
    {
		type = "electric",
		usage_priority = "secondary-input",
		emissions = 0.005,
    },
    energy_usage = "1200kW",
    ingredient_count = 6,
    module_specification =
    {
      module_slots = 5,
      module_info_icon_shift = {0, 0.5},
      module_info_multi_row_initial_height_modifier = -0.3
    },
    order = "q",
    allowed_effects = { "speed", "consumption", "pollution", "productivity"}
  },
})