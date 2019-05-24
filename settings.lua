local prototype_minvalue = -100
local prototype_maxvalue = 100

data:extend({
	{
        type = "bool-setting",
        name = "custom-modules-half-slots",
        order = "aaa",
        setting_type = "startup",
        default_value = true
    },
    {
        type = "bool-setting",
        name = "custom-modules-legacy",
        order = "aab",
        setting_type = "startup", 
        default_value = false
    },    
    {
        type = "double-setting",
        name = "custom-modules-multiplier-consumption",
        order = "aba",
        setting_type = "startup",
        default_value = 1,
		minimum_value = 0.1,
		maximum_value = 40
    },
	{
        type = "double-setting",
        name = "custom-modules-multiplier-speed",
        order = "abb",
        setting_type = "startup",
        default_value = 1,
		minimum_value = 0.1,
		maximum_value = 40
    },
	{
        type = "double-setting",
        name = "custom-modules-multiplier-productivity",
        order = "abc",
        setting_type = "startup",
        default_value = 1,
		minimum_value = 0.1,
		maximum_value = 40
    },
	{
        type = "double-setting",
        name = "custom-modules-multiplier-pollution",
        order = "abd",
        setting_type = "startup",
        default_value = 1,
		minimum_value = 0.1,
		maximum_value = 40
    },
    {
        type = "double-setting",
        name = "custom-modules-tier-base",
        order = "abf",
        setting_type = "startup",
        default_value = 1.25,
		minimum_value = 0.1,
		maximum_value = 40
    },
    

-- prototype module effects
    --red
    {
        type = "double-setting",
        name = "custom-modules-prototype-red-consumption",
        order = "aca",
        setting_type = "startup",
        default_value = 0.4,
		minimum_value = prototype_minvalue,
		maximum_value = prototype_maxvalue
    },
    {
        type = "double-setting",
        name = "custom-modules-prototype-red-speed",
        order = "acb",
        setting_type = "startup",
        default_value = -0.1,
		minimum_value = prototype_minvalue,
        maximum_value = prototype_maxvalue
    },	
    {
        type = "double-setting",
        name = "custom-modules-prototype-red-productivity",
        order = "acc",
        setting_type = "startup",
        default_value = 0.03,
		minimum_value = prototype_minvalue,
        maximum_value = prototype_maxvalue
    },
    {
        type = "double-setting",
        name = "custom-modules-prototype-red-pollution",
        order = "acd",
        setting_type = "startup",
        default_value = 0.15,
		minimum_value = prototype_minvalue,
		maximum_value = prototype_maxvalue
    },

    --blue
    {
        type = "double-setting",
        name = "custom-modules-prototype-blue-consumption",
        order = "ada",
        setting_type = "startup",
        default_value = 0.5,
		minimum_value = prototype_minvalue,
		maximum_value = prototype_maxvalue
    },
    {
        type = "double-setting",
        name = "custom-modules-prototype-blue-speed",
        order = "adb",
        setting_type = "startup",
        default_value = 0.2,
		minimum_value = prototype_minvalue,
		maximum_value = prototype_maxvalue
    },
    {
        type = "double-setting",
        name = "custom-modules-prototype-blue-pollution",
        order = "adc",
        setting_type = "startup",
        default_value = 0.1,
		minimum_value = prototype_minvalue,
		maximum_value = prototype_maxvalue
    },

    --green
    {
        type = "double-setting",
        name = "custom-modules-prototype-green-consumption",
        order = "aea",
        setting_type = "startup",
        default_value = -0.4,
		minimum_value = prototype_minvalue,
		maximum_value = prototype_maxvalue
    },
    {
        type = "double-setting",
        name = "custom-modules-prototype-green-speed",
        order = "aeb",
        setting_type = "startup",
        default_value = 0.05,
		minimum_value = prototype_minvalue,
		maximum_value = prototype_maxvalue
    },	
    {
        type = "double-setting",
        name = "custom-modules-prototype-green-pollution",
        order = "aec",
        setting_type = "startup",
        default_value = -0.15,
		minimum_value = prototype_minvalue,
		maximum_value = prototype_maxvalue
    },

--buffing mixed modules
--[[    {
        type = "string-setting",
        name = "custom-modules-mixed-buff",
        order = "afa",
        setting_type = "startup", 
        default_value = "none",
        allowed_values = {"none", "buff minority"}
    },--]]
})