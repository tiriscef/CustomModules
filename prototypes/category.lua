data:extend(
  {
    {
      type = "item-group",
      name = "custom-modules",
      order = "q",
      inventory_order = "q",
      icon = "__CustomModules__/graphics/icons/custom-modules.png",
      icon_size = 128
    },
    {
      type = "item-subgroup",
      name = "module-assembler",
      group = "custom-modules",
      order = "q"
    }
  }
)

for i = 0, 3, 1 do
  data:extend(
    {
      {
        type = "item-subgroup",
        name = "custom-modules-" .. i,
        group = "custom-modules",
        order = "q-" .. i
      },
      {
        type = "recipe-category",
        name = "module-assembling-" .. i
      }
    }
  )
end

Tirislib_RecipeCategory("custom-modules-0"):make_hand_craftable()