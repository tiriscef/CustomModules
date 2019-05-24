require("__stdlib__/stdlib/data/data").Util.create_data_globals()

if settings.startup["custom-modules-legacy"].value then
    require("prototypes.legacy.legacy")
    return
end

require("prototypes.recipe")
require("prototypes.entity")
require("prototypes.technology")
require("prototypes.category")
require("prototypes.item")
require("prototypes.modules")
require("prototypes.updates")