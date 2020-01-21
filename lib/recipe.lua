---------------------------------------------------------------------------------------------------
-- << static class for Recipe Entries >>
-- those tables that the wiki calls ItemProductPrototype or FluidProductPrototype or IngredientPrototype
Tirislib_RecipeEntry = {}
local Entries = Tirislib_RecipeEntry

function Tirislib_RecipeEntry.convert_to_named_keys(entry)
    if entry[1] then
        entry.name = entry[1]
        entry[1] = nil
    end
    if entry[2] then
        entry.amount = entry[2]
        entry[2] = nil
    end
end

function Tirislib_RecipeEntry.get_name(entry)
    return entry.name or entry[1]
end

function Tirislib_RecipeEntry.set_name(entry, name)
    if entry.name then
        entry.name = name
    end
    if entry[1] then
        entry[1] = name
    end
end

function Tirislib_RecipeEntry.yields_item(entry)
    if entry.type then
        return entry.type == "item"
    end
    return true
end

function Tirislib_RecipeEntry.yields_fluid(entry)
    return (entry.type ~= nil) and (entry.type == "fluid")
end

function Tirislib_RecipeEntry.get_type(entry)
    return entry.type or "item"
end

function Tirislib_RecipeEntry.specify_same_stuff(entry1, entry2)
    return (Entries.get_name(entry1) == Entries.get_name(entry2)) and
        (Entries.get_type(entry1) == Entries.get_type(entry2))
end

function Tirislib_RecipeEntry.has_catalyst(entry)
    return entry.catalyst_amount ~= nil
end

function Tirislib_RecipeEntry.get_ingredient_amount(entry)
    local ret = entry.amount or entry[2]
    if not ret then
        error("Sosciencity found a IngredientPrototype without a valid amount:\n" .. serpent.block(entry))
    end
    return ret
end

function Tirislib_RecipeEntry.add_result_amount(entry, min, max)
    if not max or min == max then
        if entry.amount_min then
            entry.amount_min = entry.amount_min + min
            entry.amount_max = entry.amount_max + min
        elseif entry.amount then
            entry.amount = entry.amount + min
        elseif entry[2] then
            entry[2] = entry[2] + min
        else
            -- I don't actually know if ResultPrototypes without a specified amount are valid
            -- I will just asume they default to 1
            Entries.convert_to_named_keys(entry)
            entry.amount = min + 1
        end
    else
        Entries.convert_to_named_keys(entry)
        entry.amount_min = (entry.amount_min or entry.amount) + min
        entry.amount_max = (entry.amount_max or entry.amount) + max
        entry.amount = nil
    end
end

function Tirislib_RecipeEntry.add_ingredient_amount(entry, amount)
    if entry.amount then
        entry.amount = entry.amount + amount
    elseif entry[2] then
        entry[2] = entry[2] + amount
    else
        error("Sosciencity found a IngredientPrototype without a valid amount:\n" .. serpent.block(entry))
    end
end

function Tirislib_RecipeEntry.multiply_ingredient_amount(entry, multiplier)
    if entry.amount then
        entry.amount = entry.amount * multiplier
    elseif entry[2] then
        entry[2] = entry[2] * multiplier
    else
        error("Sosciencity found a IngredientPrototype without a valid amount:\n" .. serpent.block(entry))
    end
end

function Tirislib_RecipeEntry.add_catalyst_amount(entry, amount)
    entry.catalyst_amount = (entry.catalyst_amount or 0) + amount

    if entry[2] then
        entry.amount = entry[2]
        entry[2] = nil
    end
end

function Tirislib_RecipeEntry.get_average_yield(entry)
    local probability = entry.probability or 1

    if entry.amount_min then
        return (entry.amount_min + entry.amount_max) * 0.5 * probability
    end

    local amount = entry.amount or entry[2] or 1
    return amount * probability
end

function Tirislib_RecipeEntry.get_probability(entry)
    return entry.probability or 1
end

function Tirislib_RecipeEntry.can_be_merged(entry1, entry2)
    return Entries.specify_same_stuff(entry1, entry2) and
        Entries.get_probability(entry1) == Entries.get_probability(entry2)
end

function Tirislib_RecipeEntry.merge_results(entry1, entry2)
    local min = entry2.amount_min or entry2.amount or entry2[2]
    local max = entry2.amount_max or entry2.amount or entry2[2]

    Entries.add_result_amount(entry1, min, max)
end

---------------------------------------------------------------------------------------------------
-- << class for recipes >>
Tirislib_Recipe = {}

-- this makes an object of this class call the class methods (if it has no own method)
-- lua is weird
Tirislib_Recipe.__index = Tirislib_Recipe

-- << getter functions >>
function Tirislib_Recipe.get_by_name(name)
    local new = Tirislib_Prototype.get("recipe", name)
    setmetatable(new, Tirislib_Recipe)
    return new
end

function Tirislib_Recipe.get_from_prototype(prototype)
    setmetatable(prototype, Tirislib_Recipe)
    return prototype
end

function Tirislib_Recipe.get(name)
    if type(name) == "string" then
        return Tirislib_Recipe.get_by_name(name)
    else
        return Tirislib_Recipe.get_from_prototype(name)
    end
end

function Tirislib_Recipe.pairs()
    local index, value

    local function _next()
        index, value = next(data.raw["recipe"], index)

        if index then
            setmetatable(value, Tirislib_Recipe)
            return index, value
        end
    end

    return _next, index, value
end

-- << creation >>
local function add_ingredient_table(prototype)
    local difficulties = false
    if prototype.normal then
        prototype.normal.ingredients = prototype.normal.ingredients or {}
        difficulties = true
    end
    if prototype.expensive then
        prototype.expensive.ingredients = prototype.expensive.ingredients or {}
        difficulties = true
    end

    if not difficulties then
        prototype.ingredients = prototype.ingredients or {}
    end
end

function Tirislib_Recipe.create(prototype)
    if not prototype.type then
        prototype.type = "recipe"
    end

    add_ingredient_table(prototype)

    data:extend {prototype}
    return Tirislib_Recipe.get(prototype)
end

-- << manipulation >>
function Tirislib_Recipe:has_normal_difficulty()
    return self.normal
end

function Tirislib_Recipe:has_expensive_difficulty()
    return self.expensive
end

function Tirislib_Recipe:has_difficulties()
    return self:has_normal_difficulty() or self:has_expensive_difficulty()
end

local default_values = {
    category = "crafting",
    result_count = 1,
    energy_required = 0.5,
    emissions_multiplier = 1,
    requester_paste_multiplier = 30,
    overload_multiplier = 0,
    enabled = true,
    hidden = false,
    hide_from_stats = false,
    hide_from_player_crafting = false,
    allow_decomposition = true,
    allow_as_intermediate = true,
    allow_intermediates = true,
    always_show_made_in = false,
    show_amount_in_title = true,
    always_show_products = false
}

-- the prototype fields that the wiki calls "recipe data"
local recipe_data_fields = {
    ingredients = true,
    result = true,
    result_count = true,
    results = true,
    energy_required = true,
    emissions_multiplier = true,
    requester_paste_multiplier = true,
    overload_multiplier = true,
    enabled = true,
    hidden = true,
    hide_from_stats = true,
    hide_from_player_crafting = true,
    allow_decomposition = true,
    allow_as_intermediate = true,
    allow_intermediates = true,
    always_show_made_in = true,
    show_amount_in_title = true,
    always_show_products = true,
    main_product = true
}

function Tirislib_Recipe:set_field(key, value)
    if recipe_data_fields[key] then
        if not self:has_difficulties() then
            self[key] = value
        end
        if self:has_normal_difficulty() then
            self.normal[key] = value
        end
        if self:has_expensive_difficulty() then
            self.expensive[key] = value
        end
    else
        self[key] = value
    end

    return self
end

function Tirislib_Recipe:get_field(field, mode)
    if mode then
        return self[mode][field] or default_values[field]
    else
        return self[field] or default_values[field]
    end
end

function Tirislib_Recipe:multiply_field(field, normal_multiplier, expensive_multiplier)
    -- use the normal multiplier if no expensive one is given
    expensive_multiplier = expensive_multiplier or normal_multiplier

    if not self:has_difficulties() then
        self.energy_required = self:get_field(field) * normal_multiplier
    else
        if self:has_normal_difficulty() then
            self.normal.energy_required = self:get_field(field, "normal") * normal_multiplier
        end
        if self:has_expensive_difficulty() then
            self.expensive.energy_required = self:get_field(field, "expensive") * expensive_multiplier
        end
    end

    return self
end

function Tirislib_Recipe:multiply_expensive_field(field, multiplier)
    if self:has_expensive_difficulty() then
        self.expensive[field] = self:get_field(field, "expensive") * multiplier
    end
    return self
end

function Tirislib_Recipe:create_difficulties()
    -- silently do nothing if they already exist
    if self:has_difficulties() then
        return self
    end

    self.normal = {}
    self.expensive = {}

    -- copy the data that the wiki calls "recipe data" and which need to be set for both difficulty modes
    for field, _ in pairs(recipe_data_fields) do
        if type(self[field]) == "table" then
            self.normal[field] = Tirislib_Tables.recursive_copy(self[field])
            self.expensive[field] = Tirislib_Tables.recursive_copy(self[field])
        else
            self.normal[field] = self[field]
            self.expensive[field] = self[field]
        end

        self[field] = nil
    end

    return self
end

local function recipe_results_contain_item(recipe, item_name)
    if recipe.result then
        return recipe.result == item_name
    elseif recipe.results then
        for _, result in pairs(recipe.results) do
            if result.type == "item" and (result.name == item_name or result[1] == item_name) then
                return true
            end
        end
        return false
    end
end

function Tirislib_Recipe:results_contain_item(item_name)
    if self:has_normal_difficulty() then
        return recipe_results_contain_item(self.normal, item_name)
    elseif self:has_expensive_difficulty() then
        return recipe_results_contain_item(self.expensive, item_name)
    else
        return recipe_results_contain_item(self, item_name)
    end
end

local function recipe_result_count(recipe, name)
    if recipe.result then
        if recipe.result == name then
            return recipe.result_count or 1 -- factorio defaults to 1 if no result_count is specified
        else
            return 0
        end
    elseif recipe.results then
        for _, result in pairs(recipe.results) do
            if Tirislib_RecipeEntry.get_name(result) == name and Tirislib_RecipeEntry.get_type(result) then
                return Tirislib_RecipeEntry.get_average_yield(result)
            end
        end
        return 0 -- item doesn't occur in this table
    end
    error("Sosciencity found a recipe without a valid result:\n" .. serpent.block(recipe))
end

function Tirislib_Recipe:get_result_item_count(item_name)
    if self:has_difficulties() then
        local normal_count, expensive_count
        if self:has_normal_difficulty() then
            normal_count = recipe_result_count(self.normal, item_name)
        end
        if self:has_expensive_difficulty() then
            expensive_count = recipe_result_count(self.expensive, item_name)
        end
        return normal_count, expensive_count
    else
        return recipe_result_count(self, item_name)
    end
end

local function add_ingredient(recipe, ingredient_prototype)
    -- check if the recipe already has an entry for this ingredient
    for _, ingredient in pairs(recipe.ingredients) do
        if Tirislib_RecipeEntry.specify_same_stuff(ingredient, ingredient_prototype) then
            local ingredient_amount = Tirislib_RecipeEntry.get_ingredient_amount(ingredient_prototype)
            Tirislib_RecipeEntry.add_ingredient_amount(ingredient, ingredient_amount)

            if Tirislib_RecipeEntry.has_catalyst(ingredient) and Tirislib_Recipe:has_catalyst(ingredient_prototype) then
                Tirislib_RecipeEntry.add_catalyst_amount(ingredient, ingredient_prototype.catalyst_amount)
            end
            return
        end
    end

    -- create a copy to avoid reference bugs
    table.insert(recipe.ingredients, Tirislib_Tables.copy(ingredient_prototype))
end

function Tirislib_Recipe:add_ingredient(ingredient_prototype_normal, ingredient_prototype_expensive)
    -- figuring out if this recipe has difficulties defined
    if not self:has_difficulties() then
        add_ingredient(self, ingredient_prototype_normal)
    else
        if ingredient_prototype_normal and self:has_normal_difficulty() then
            add_ingredient(self.normal, ingredient_prototype_normal)
        end
        if self:has_expensive_difficulty() then
            local ingredient_to_add = ingredient_prototype_expensive or ingredient_prototype_normal
            add_ingredient(self.expensive, ingredient_to_add)
        end
    end

    return self
end

function Tirislib_Recipe:add_ingredient_range(ingredient_prototypes_normal, ingredient_prototypes_expensive)
    if ingredient_prototypes_normal == nil and ingredient_prototypes_expensive == nil then
        return self
    end

    if not self:has_difficulties() then
        if ingredient_prototypes_normal then
            for _, entry in pairs(ingredient_prototypes_normal) do
                add_ingredient(self, entry)
            end
        end
    else
        if ingredient_prototypes_normal and self:has_normal_difficulty() then
            for _, entry in pairs(ingredient_prototypes_normal) do
                add_ingredient(self.normal, entry)
            end
        end
        if self:has_expensive_difficulty() then
            local ingredients = ingredient_prototypes_expensive or ingredient_prototypes_normal

            for _, entry in pairs(ingredients) do
                add_ingredient(self.expensive, entry)
            end
        end
    end

    return self
end

local function remove_ingredient(recipe, ingredient_name, ingredient_type)
    for index, ingredient in pairs(recipe.ingredients) do
        if
            Tirislib_RecipeEntry.get_name(ingredient) == ingredient_name and
                Tirislib_RecipeEntry.get_type(ingredient) == ingredient_type
         then
            recipe.ingredients[index] = nil
        end
    end
end

function Tirislib_Recipe:remove_ingredient(ingredient_name, ingredient_type)
    -- default to item if no type is given
    if not ingredient_type then
        ingredient_type = "item"
    end

    if not self:has_difficulties() then
        remove_ingredient(self, ingredient_name, ingredient_type)
    else
        if self:has_normal_difficulty() then
            remove_ingredient(self.normal, ingredient_name, ingredient_type)
        end
        if self.has_expensive_difficulty() then
            remove_ingredient(self.expensive, ingredient_name, ingredient_type)
        end
    end

    return self
end

local function replace_ingredient(recipe, ingredient_name, replacement_name)
    for _, ingredient in pairs(recipe.ingredients) do
        if Tirislib_RecipeEntry.get_name(ingredient) == ingredient_name then
            Tirislib_RecipeEntry.set_name(ingredient, replacement_name)
        end
    end
end

function Tirislib_Recipe:replace_ingredient(ingredient_name, replacement_name)
    if not self:has_difficulties() then
        replace_ingredient(self, ingredient_name, replacement_name)
    else
        if self:has_normal_difficulty() then
            replace_ingredient(self.normal, ingredient_name, replacement_name)
        end
        if self:has_expensive_difficulty() then
            replace_ingredient(self.expensive, ingredient_name, replacement_name)
        end
    end

    return self
end

function Tirislib_Recipe:clear_ingredients()
    if not self:has_difficulties() then
        self.ingredients = {}
    else
        if self:has_normal_difficulty() then
            self.normal.ingredients = {}
        end
        if self:has_expensive_difficulty() then
            self.expensive.ingredients = {}
        end
    end

    return self
end

function Tirislib_Recipe:set_enabled(normal, expensive)
    if not expensive then
        self.enabled = normal
        expensive = normal
    else
        self.enabled = nil
    end

    if self.normal then
        self.normal.enabled = normal
    end
    if self.expensive then
        self.expensive.enabled = expensive
    end
end

function Tirislib_Recipe:add_unlock(technology_name)
    if not technology_name then
        return self
    end

    self:set_enabled(false)
    local tech = Tirislib_Technology.get_by_name(technology_name)

    if tech then
        tech:add_unlock(self.name)
    else
        Tirislib_Prototype.postpone {
            recipe = self,
            technology = technology_name,
            execute = function(self)
                self.recipe:add_unlock(self.technology)
            end
        }
    end

    return self
end

local function multiply_ingredient_table_amounts(table, multiplier)
    for _, ingredient in pairs(table) do
        Tirislib_RecipeEntry.multiply_ingredient_amount(ingredient, multiplier)
    end
end

function Tirislib_Recipe:multiply_ingredients(normal_multiplier, expensive_multiplier)
    if not self:has_difficulties() then
        multiply_ingredient_table_amounts(self.ingredients, normal_multiplier)
    else
        if self:has_normal_difficulty() then
            multiply_ingredient_table_amounts(self.normal.ingredients, normal_multiplier)
        end
        if self:has_expensive_difficulty() then
            multiply_ingredient_table_amounts(self.expensive.ingredients, expensive_multiplier or normal_multiplier)
        end
    end

    return self
end

function Tirislib_Recipe:multiply_expensive_ingredients(multiplier)
    if self:has_expensive_difficulty() then
        multiply_ingredient_table_amounts(self.expensive.ingredients, multiplier)
    end

    return self
end

function Tirislib_Recipe:allow_productivity_modules()
    Tirislib_Prototype.add_recipe_to_productivity_modules(self.name)

    return self
end

local meta = {}

function meta:__call(name)
    return Tirislib_Recipe.get(name)
end

setmetatable(Tirislib_Recipe, meta)
