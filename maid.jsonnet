local config = import "config.jsonnet";

function(modules)
  std.flattenArrays(
    std.filterMap(
      function(module) module.enabled,
      function(module) module.actions,
      config(modules)
    )
  )
