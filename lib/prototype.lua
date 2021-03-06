Tirislib_Prototype = {}

--- Removes all of my metatables so other mods don't call them accidentally.
local function remove_metatables()
    for _, prototypes in pairs(data.raw) do
        for _, prototype in pairs(prototypes) do
            setmetatable(prototype, nil)
        end
    end
end

local function nothing()
end

local dummy_metatable = {
    __index = function()
        return nothing
    end
}

local dummy_prototype = {}
setmetatable(dummy_prototype, dummy_metatable)

function Tirislib_Prototype.is_dummy(prototype)
    return prototype == dummy_prototype
end

--- Gets the prototype of the specified type (or one of the specified types) out of data.raw.
--- Returns a dummy prototype if no one was found, so that I can manipulate prototypes without
--- checking if they exist.
function Tirislib_Prototype.get(prototype_type, name, mt)
    local res
    if type(prototype_type) == "string" then
        res = data.raw[prototype_type][name]
    elseif type(prototype_type) == "table" then
        for _, ctype in pairs(prototype_type) do
            res = data.raw[ctype][name]
            if res then
                break
            end
        end
    end

    if res then
        setmetatable(res, mt)
        return res
    else
        return dummy_prototype
    end
end

function Tirislib_Prototype.create(prototype)
    data:extend {prototype}

    return Tirislib_Prototype.get(prototype.type, prototype.name)
end

--- Some functions (mainly those who make changes to another prototype which might not
--- yet be created) might postpone their execution.
--- So they will add a table with all the necessary data and a execute-function to the
--- Prototype.postpones_functions table.
--- A call to finish_postponed will iterate repeatedly over the table and execute the
--- stored functions.
Tirislib_Prototype.postponed_functions = {}

function Tirislib_Prototype.postpone(func)
    table.insert(Tirislib_Prototype.postponed_functions, func)
end

-- This assumes that a 'successful' call to a postponed function will not result in
-- another postponed function
function Tirislib_Prototype.finish_postponed()
    local to_do = Tirislib_Prototype.postponed_functions
    local to_do_count = table_size(to_do)
    local last_to_do_count = to_do_count + 1 -- bogus value to ensure that the while loop gets executed

    while to_do_count < last_to_do_count do
        Tirislib_Prototype.postponed_functions = {}
        for _, func in pairs(to_do) do
            func:execute()
        end

        to_do = Tirislib_Prototype.postponed_functions
        last_to_do_count = to_do_count
        to_do_count = table_size(to_do)
    end

    return to_do_count == 0 -- return true if there are no more things to do
end

-- A table with all the recipes which should be added to productivity modules
Tirislib_Prototype.productivity_recipes = {}

function Tirislib_Prototype.add_recipe_to_productivity_modules(recipe_name)
    table.insert(Tirislib_Prototype.productivity_recipes, recipe_name)
end

function Tirislib_Prototype.finish_productivity_modules()
    for _, _module in Tirislib_Item.pairs("module") do
        if _module.category == "productivity" and _module.limitation then
            Tirislib_Tables.merge(_module.limitation, Tirislib_Prototype.productivity_recipes)
        end
    end
end

function Tirislib_Prototype.finish()
    Tirislib_Prototype.finish_postponed()
    Tirislib_Prototype.finish_productivity_modules()

    remove_metatables()
end

function Tirislib_Prototype.get_unique_name(name, _type)
    if not data.raw[_type][name] then
        return name
    end

    local i = 1
    while true do
        if not data.raw[_type][name .. "-" .. i] then
            return name .. "-" .. i
        end
        i = i + 1
    end
end

Tirislib_PrototypeArray = {}

Tirislib_PrototypeArray.__index = function(array, method)
    return function(array, ...)
        for _, entry in pairs(array) do
            entry[method](entry, ...)
        end
    end
end

function Tirislib_PrototypeArray:for_all(method, ...)
    for _, entry in pairs(self) do
        entry[method](entry, ...)
    end
end
