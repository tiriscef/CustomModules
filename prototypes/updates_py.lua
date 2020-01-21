local halve_multiplier = 1
if settings.startup["custom-modules-half-slots"].value then
	halve_multiplier = 2
end

Tirislib_Technology.get_by_name("modules"):remove_prerequisite("advanced-electronics"):add_prerequisite("coal-processing-2")

--prototype recipes
local recipe_red = Tirislib_Recipe.get_by_name("module-R0"):clear_ingredients()
local recipe_green = Tirislib_Recipe.get_by_name("module-G0"):clear_ingredients()
local recipe_blue = Tirislib_Recipe.get_by_name("module-B0"):clear_ingredients()

recipe_red:add_ingredient({type = "item", name = "equipment-chassi", amount = 1 * halve_multiplier})
recipe_red:add_ingredient({type = "item", name = "lens", amount = 5 * halve_multiplier})
recipe_red:add_ingredient({type = "item", name = "iron-gear-wheel", amount = 20 * halve_multiplier})
recipe_red:add_ingredient({type = "item", name = "engine-unit", amount = 2 * halve_multiplier})

recipe_green:add_ingredient({type = "item", name = "equipment-chassi", amount = 1 * halve_multiplier})
recipe_green:add_ingredient({type = "item", name = "ralesia", amount = 30 * halve_multiplier})
recipe_green:add_ingredient({type = "item", name = "log", amount = 5 * halve_multiplier})
recipe_green:add_ingredient({type = "item", name = "fawogae-substrate", amount = 10 * halve_multiplier})
recipe_green:add_ingredient({type = "item", name = "pure-sand", amount = 10 * halve_multiplier})
recipe_green:add_ingredient({type = "item", name = "calcium-carbide", amount = 10 * halve_multiplier})

recipe_blue:add_ingredient({type = "item", name = "equipment-chassi", amount = 1 * halve_multiplier})
recipe_blue:add_ingredient({type = "item", name = "drill-head", amount = 5 * halve_multiplier})
recipe_blue:add_ingredient({type = "item", name = "lubricant-barrel", amount = 2 * halve_multiplier})
recipe_blue:add_ingredient({type = "item", name = "copper-cable", amount = 20 * halve_multiplier})
recipe_blue:add_ingredient({type = "item", name = "engine-unit", amount = 2 * halve_multiplier})

--module assemblers
local recipe_assembler1 = Tirislib_Recipe.get_by_name("module-assembler"):clear_ingredients()
local recipe_assembler2 = Tirislib_Recipe.get_by_name("module-assembler-2"):clear_ingredients()
local recipe_assembler3 = Tirislib_Recipe.get_by_name("module-assembler-3"):clear_ingredients()

recipe_assembler1:add_ingredient({type = "item", name = "automated-factory-mk01", amount = 2})
recipe_assembler1:add_ingredient({type = "item", name = "iron-gear-wheel", amount = 25})
recipe_assembler1:add_ingredient({type = "item", name = "steel-plate", amount = 30})
recipe_assembler1:add_ingredient({type = "item", name = "stone-brick", amount = 50})

recipe_assembler2:add_ingredient({type = "item", name = "module-assembler", amount = 2})
recipe_assembler2:add_ingredient({type = "item", name = "concrete", amount = 100})
recipe_assembler2:add_ingredient({type = "item", name = "advanced-circuit", amount = 10})
recipe_assembler2:add_ingredient({type = "item", name = "nexelit-plate", amount = 10})

recipe_assembler3:add_ingredient({type = "item", name = "module-assembler-2", amount = 3})
recipe_assembler3:add_ingredient({type = "item", name = "processing-unit", amount = 10})
recipe_assembler3:add_ingredient({type = "item", name = "module-CC", amount = 6})

for _, recipe_module in pairs(CustomModules_recipes[2]) do
    local recipe = Tirislib_Recipe.get_by_name(recipe_module)
    recipe:add_ingredient({type = "item", name = "optical-fiber", amount = 10 * halve_multiplier})

    if string.find(recipe_module, "[RYM]") then
        recipe:add_ingredient({type = "item", name = "nexelit-plate", amount = 10 * halve_multiplier})
    end

    if string.find(recipe_module, "[YGC]") then
        recipe:add_ingredient({type = "item", name = "filtration-media", amount = 2 * halve_multiplier})
    end

    if string.find(recipe_module, "[BCM]") then
        recipe:add_ingredient({type = "item", name = "medium-electric-pole", amount = 2 * halve_multiplier})
    end
end

for _, recipe_module in pairs(CustomModules_recipes[3]) do
    local recipe = Tirislib_Recipe.get_by_name(recipe_module)
    recipe:add_ingredient({type = "item", name = "optical-fiber", amount = 50 * halve_multiplier})
    recipe:replace_ingredient("nuclear-fuel", "fuelrod-mk01")

    if string.find(recipe_module, "[RYM]") then
        if mods["pyindustry"] then
            recipe:add_ingredient({type = "item", name = "py-construction-robot-01", amount = 5 * halve_multiplier})
        else
            recipe:add_ingredient({type = "item", name = "construction-robot", amount = 5 * halve_multiplier})
        end
    end

    if string.find(recipe_module, "[YGC]") then
        recipe:add_ingredient({type = "item", name = "filtration-media", amount = 10 * halve_multiplier})
    end

    if string.find(recipe_module, "[BCM]") then
        recipe:add_ingredient({type = "item", name = "substation", amount = 2 * halve_multiplier})
    end
end

if mods["pyfusionenergy"] then
    recipe_red:add_ingredient({type = "fluid", name = "vacuum", amount = 100 * halve_multiplier})
    recipe_red:change_category("crafting-with-fluid")

    recipe_assembler2:replace_ingredient("advanced-circuit", "control-unit")
    recipe_assembler3:add_ingredient({type = "fluid", name = "vacuum", amount = 500})
    recipe_assembler3:change_category("crafting-with-fluid")
end

if mods["pyhightech"] then
    recipe_red:add_ingredient({type = "item", name = "pcb1", amount = 2 * halve_multiplier})
    recipe_green:add_ingredient({type = "item", name = "urea", amount = 10 * halve_multiplier})

    recipe_assembler1:add_ingredient({type = "item", name = "chipshooter", amount = 1})
    recipe_assembler3:replace_ingredient("processing-unit", "intelligent-unit")

    for _, recipe_module in pairs(CustomModules_recipes[1]) do
        local recipe = Tirislib_Recipe.get_by_name(recipe_module)
        recipe:add_ingredient({type = "item", name = "pcb1", amount = 2 * halve_multiplier})
    end

    for _, recipe_module in pairs(CustomModules_recipes[2]) do
        local recipe = Tirislib_Recipe.get_by_name(recipe_module)
        recipe:add_ingredient({type = "item", name = "pcb2", amount = 2 * halve_multiplier})
    end

    for _, recipe_module in pairs(CustomModules_recipes[3]) do
        local recipe = Tirislib_Recipe.get_by_name(recipe_module)
        recipe:add_ingredient({type = "item", name = "pcb3-2", amount = 2 * halve_multiplier})
        recipe:add_ingredient({type = "item", name = "intelligent-unit", amount = 50 * halve_multiplier})
    end
end

if mods["pypetroleumhandling"] then
    recipe_red:replace_ingredient("iron-gear-wheel", "small-parts-01")
    recipe_blue:add_ingredient({type = "item", name = "belt", amount = 20 * halve_multiplier})
    recipe_blue:add_ingredient({type = "fluid", name = "hot-air", amount = 100 * halve_multiplier})
    recipe_blue:change_category("crafting-with-fluid")

    recipe_assembler1:replace_ingredient("iron-gear-wheel", "small-parts-01")
    recipe_assembler2:add_ingredient({type = "item", name = "small-parts-02", amount = 15})
    recipe_assembler3:add_ingredient({type = "item", name = "small-parts-03", amount = 15})
end

if mods["pyrawores"] then
    recipe_red:add_ingredient({type = "item", name = "tinned-cable", amount = 10 * halve_multiplier})
    recipe_red:add_ingredient({type = "item", name = "aluminium-plate", amount = 10 * halve_multiplier})

    recipe_assembler1:add_ingredient({type = "item", name = "titanium-plate", amount = 10})
    recipe_assembler3:add_ingredient({type = "item", name = "super-steel", amount = 10})

    for _, recipe_module in pairs(CustomModules_recipes[1]) do
        local recipe = Tirislib_Recipe.get_by_name(recipe_module)
        recipe:add_ingredient({type = "item", name = "solder", amount = 10 * halve_multiplier})
        recipe:add_ingredient({type = "item", name = "tinned-cable", amount = 10 * halve_multiplier})
        recipe:remove_ingredient("copper-plate")
        recipe:remove_ingredient("copper-cable")
    end

    for _, recipe_module in pairs(CustomModules_recipes[2]) do
        local recipe = Tirislib_Recipe.get_by_name(recipe_module)
        recipe:add_ingredient({type = "item", name = "solder", amount = 30 * halve_multiplier})
    end

    for _, recipe_module in pairs(CustomModules_recipes[3]) do
        local recipe = Tirislib_Recipe.get_by_name(recipe_module)
        recipe:add_ingredient({type = "item", name = "solder", amount = 100 * halve_multiplier})
    end
end
