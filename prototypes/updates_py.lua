local h = 1
if settings.startup["custom-modules-half-slots"].value then
	h = 2
end

--prototype recipes
local recipe_red = RECIPE("module-R0"):clear_ingredients()
local recipe_green = RECIPE("module-G0"):clear_ingredients()
local recipe_blue = RECIPE("module-B0"):clear_ingredients()

recipe_red:add_ingredient({type = "item", name = "equipment-chassi", amount = 1 * h})
recipe_red:add_ingredient({type = "item", name = "lens", amount = 5 * h})
recipe_red:add_ingredient({type = "item", name = "iron-gear-wheel", amount = 20 * h})
recipe_red:add_ingredient({type = "item", name = "engine-unit", amount = 2 * h})

recipe_green:add_ingredient({type = "item", name = "equipment-chassi", amount = 1 * h})
recipe_green:add_ingredient({type = "item", name = "ralesia", amount = 30 * h})
recipe_green:add_ingredient({type = "item", name = "log", amount = 5 * h})
recipe_green:add_ingredient({type = "item", name = "fawogae", amount = 10 * h})
recipe_green:add_ingredient({type = "item", name = "pure-sand", amount = 10 * h})

recipe_blue:add_ingredient({type = "item", name = "equipment-chassi", amount = 1 * h})
recipe_blue:add_ingredient({type = "item", name = "drill-head", amount = 5 * h})
recipe_blue:add_ingredient({type = "item", name = "lubricant-barrel", amount = 2 * h})
recipe_blue:add_ingredient({type = "item", name = "copper-cable", amount = 20 * h})
recipe_blue:add_ingredient({type = "item", name = "engine-unit", amount = 2 * h})

--module assemblers
local recipe_assembler1 = RECIPE("module-assembler"):clear_ingredients()
local recipe_assembler2 = RECIPE("module-assembler-2"):clear_ingredients()
local recipe_assembler3 = RECIPE("module-assembler-3"):clear_ingredients()

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

if mods["pyfusionenergy"] then
    recipe_red:add_ingredient({type = "fluid", name = "vacuum", amount = 100 * h})
    recipe_red:change_category("crafting-with-fluid")

    recipe_assembler2:replace_ingredient("advanced-circuit", "control-unit")
    recipe_assembler3:add_ingredient({type = "fluid", name = "vacuum", amount = 500})
    recipe_assembler3:change_category("crafting-with-fluid")
end

if mods["pyhightech"] then
    recipe_red:add_ingredient({type = "item", name = "pcb1", amount = 1 * h})
    recipe_green:add_ingredient({type = "item", name = "urea", amount = 10 * h})

    recipe_assembler1:add_ingredient({type = "item", name = "chipshooter", amount = 1})
    recipe_assembler3:replace_ingredient("processing-unit", "intelligent-unit")
end

if mods["pypetroleumhandling"] then
    recipe_red:replace_ingredient("iron-gear-wheel", "small-parts-01")
    recipe_blue:add_ingredient({type = "item", name = "belt", amount = 20 * h})
    recipe_blue:add_ingredient({type = "fluid", name = "hot-air", amount = 100 * h})
    recipe_blue:change_category("crafting-with-fluid")

    recipe_assembler1:replace_ingredient("iron-gear-wheel", "small-parts-01")
    recipe_assembler2:add_ingredient({type = "item", name = "small-parts-02", amount = 15})
    recipe_assembler3:add_ingredient({type = "item", name = "small-parts-03", amount = 15})
end

if mods["pyrawores"] then
    recipe_red:add_ingredient({type = "item", name = "tinned-cable", amount = 10 * h})
    recipe_red:add_ingredient({type = "item", name = "aluminium-plate", amount = 10 * h})

    recipe_assembler1:add_ingredient({type = "item", name = "titanium-plate", amount = 10})
    recipe_assembler3:add_ingredient({type = "item", name = "super-steel", amount = 10})

    --tier1 modules
    for _, recipe_module in pairs(custom_modules_module_recipes[1]) do
        RECIPE(recipe_module):add_ingredient({type = "item", name = "solder", amount = 10})
        RECIPE(recipe_module):add_ingredient({type = "item", name = "tinned-cable", amount = 10})
        RECIPE(recipe_module):remove_ingredient("copper-plate")
        RECIPE(recipe_module):remove_ingredient("copper-cable")
    end
end
